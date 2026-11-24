# Funciones y datos simulados de los libros de prototipado del Máster UX (UC3M).
# Licencia MIT. Autor: Pablo Sánchez-Núñez.
# Para usarlas en tu ordenador: source("funciones_ux.R")

# ---- color.R ----
# Admite colores hexadecimales abreviados (#fff) además de los de seis cifras.
.hex <- function(color) {
  corto <- grepl("^#[0-9A-Fa-f]{3}$", color)
  color[corto] <- sub("^#(.)(.)(.)$", "#\\1\\1\\2\\2\\3\\3", color[corto])
  color
}

luminancia_relativa <- function(color) {
  rgb <- grDevices::col2rgb(.hex(color)) / 255
  lineal <- ifelse(rgb <= 0.04045, rgb / 12.92, ((rgb + 0.055) / 1.055)^2.4)
  as.numeric(c(0.2126, 0.7152, 0.0722) %*% lineal)
}

contraste <- function(texto, fondo) {
  l1 <- luminancia_relativa(texto)
  l2 <- luminancia_relativa(fondo)
  (pmax(l1, l2) + 0.05) / (pmin(l1, l2) + 0.05)
}

cumple_wcag <- function(texto, fondo, nivel = c("AA", "AAA"),
                        tipo = c("normal", "grande", "componente")) {
  nivel <- match.arg(nivel)
  tipo <- match.arg(tipo)
  if (tipo == "componente" && nivel == "AAA") {
    stop("Las WCAG 2.1 solo fijan un m\u00ednimo AA (3:1) para componentes.", call. = FALSE)
  }
  minimo <- switch(paste(nivel, tipo),
                   "AA normal" = 4.5, "AA grande" = 3, "AA componente" = 3,
                   "AAA normal" = 7, "AAA grande" = 4.5)
  contraste(texto, fondo) >= minimo
}

revisar_paleta <- function(colores, fondo = "#ffffff") {
  r <- contraste(colores, fondo)
  data.frame(
    nombre = if (is.null(names(colores))) colores else names(colores),
    color = unname(colores),
    contraste = round(r, 2),
    texto_normal_AA = r >= 4.5,
    texto_grande_AA = r >= 3,
    componente_AA = r >= 3,
    row.names = NULL
  )
}

# Matrices de Machado, Oliveira y Fernandes (2009) para severidad 1,0,
# aplicadas sobre RGB lineal.
.matrices_cvd <- list(
  protan = matrix(c(0.152286, 1.052583, -0.204868,
                    0.114503, 0.786281, 0.099216,
                    -0.003882, -0.048116, 1.051998), 3, byrow = TRUE),
  deutan = matrix(c(0.367322, 0.860646, -0.227968,
                    0.280085, 0.672501, 0.047413,
                    -0.011820, 0.042940, 0.968881), 3, byrow = TRUE),
  tritan = matrix(c(1.255528, -0.076749, -0.178779,
                    -0.078411, 0.930809, 0.147602,
                    0.004733, 0.691367, 0.303900), 3, byrow = TRUE)
)

simular_daltonismo <- function(color, tipo = c("protan", "deutan", "tritan"), severidad = 1) {
  tipo <- match.arg(tipo)
  if (severidad < 0 || severidad > 1) stop("La severidad va de 0 a 1.", call. = FALSE)
  m <- severidad * .matrices_cvd[[tipo]] + (1 - severidad) * diag(3)
  rgb <- grDevices::col2rgb(.hex(color)) / 255
  lineal <- ifelse(rgb <= 0.04045, rgb / 12.92, ((rgb + 0.055) / 1.055)^2.4)
  sim <- pmin(pmax(m %*% lineal, 0), 1)
  srgb <- ifelse(sim <= 0.0031308, 12.92 * sim, 1.055 * sim^(1 / 2.4) - 0.055)
  out <- grDevices::rgb(srgb[1, ], srgb[2, ], srgb[3, ])
  names(out) <- names(color)
  out
}

distinguibles <- function(a, b) contraste(a, b)

# ---- composicion.R ----
escala_tipografica <- function(base = 16, razon = 1.25, pasos = -2:5, interlineado = 1.5) {
  px <- base * razon^pasos
  factor <- pmax(1.1, interlineado - 0.1 * pmax(pasos, 0))
  data.frame(paso = pasos, px = round(px, 1), rem = round(px / 16, 3),
             altura_linea = round(px * factor))
}

rejilla <- function(ancho = 1440, columnas = 12, medianil = 24, margen = 80) {
  columna <- (ancho - 2 * margen - (columnas - 1) * medianil) / columnas
  if (columna <= 0) stop("Con esos m\u00e1rgenes y medianiles no caben las columnas.", call. = FALSE)
  i <- seq_len(columnas)
  inicio <- margen + (i - 1) * (columna + medianil)
  r <- data.frame(columna = i, x_inicio = round(inicio, 1), x_fin = round(inicio + columna, 1))
  attr(r, "ancho_columna") <- columna
  r
}

ancho_bloque <- function(n, ancho = 1440, columnas = 12, medianil = 24, margen = 80) {
  col <- attr(rejilla(ancho, columnas, medianil, margen), "ancho_columna")
  n * col + (n - 1) * medianil
}

caracteres_por_linea <- function(ancho, tamano = 16, em_por_caracter = 0.5) {
  floor(ancho / (tamano * em_por_caracter))
}

# ---- pruebas.R ----
puntuacion_sus <- function(respuestas) {
  r <- as.matrix(respuestas)
  if (is.null(dim(r)) || ncol(r) == 1) r <- matrix(as.numeric(respuestas), nrow = 1)
  if (ncol(r) != 10) stop("El SUS tiene diez \u00edtems: hacen falta diez columnas.", call. = FALSE)
  if (any(r < 1 | r > 5, na.rm = TRUE)) stop("Las respuestas del SUS van de 1 a 5.", call. = FALSE)
  impares <- r[, c(1, 3, 5, 7, 9), drop = FALSE] - 1
  pares <- 5 - r[, c(2, 4, 6, 8, 10), drop = FALSE]
  (rowSums(impares) + rowSums(pares)) * 2.5
}

aceptabilidad_sus <- function(puntuacion) {
  cut(puntuacion, c(-Inf, 50, 70, Inf), right = FALSE,
      labels = c("no aceptable", "marginal", "aceptable"))
}

tasa_exito <- function(exitos, n, confianza = 0.95) {
  if (exitos > n) stop("No puede haber m\u00e1s \u00e9xitos que participantes.", call. = FALSE)
  z <- stats::qnorm(1 - (1 - confianza) / 2)
  n_aj <- n + z^2
  p_aj <- (exitos + z^2 / 2) / n_aj
  margen <- z * sqrt(p_aj * (1 - p_aj) / n_aj)
  c(tasa = exitos / n, inferior = max(0, p_aj - margen), superior = min(1, p_aj + margen))
}

tiempo_tipico <- function(tiempos) {
  tiempos <- tiempos[!is.na(tiempos)]
  if (any(tiempos <= 0)) stop("Los tiempos deben ser positivos.", call. = FALSE)
  exp(mean(log(tiempos)))
}

embudo <- function(pasos, usuarios) {
  if (length(pasos) != length(usuarios)) stop("Hace falta un n\u00famero de usuarios por paso.", call. = FALSE)
  anterior <- c(usuarios[1], utils::head(usuarios, -1))
  data.frame(paso = pasos, usuarios = usuarios,
             continua = round(100 * usuarios / anterior, 1),
             acumulado = round(100 * usuarios / usuarios[1], 1))
}

priorizar_hallazgos <- function(hallazgos) {
  faltan <- setdiff(c("problema", "evaluador", "severidad"), names(hallazgos))
  if (length(faltan)) stop("Faltan columnas: ", paste(faltan, collapse = ", "), call. = FALSE)
  media <- tapply(hallazgos$severidad, hallazgos$problema, mean)
  n <- tapply(hallazgos$evaluador, hallazgos$problema, function(x) length(unique(x)))
  r <- data.frame(problema = names(media), severidad_media = round(as.numeric(media), 2),
                  evaluadores = as.integer(n), row.names = NULL)
  r$prioridad <- cut(r$severidad_media, c(-Inf, 2, 3, Inf), right = FALSE,
                     labels = c("baja", "media", "alta"))
  r[order(-r$severidad_media, -r$evaluadores), , drop = FALSE]
}

# ---- datos ----
flujo_registro <- structure(list(paso = c("Pantalla de inicio", "Crear cuenta", 
"Datos personales", "Verificar correo", "Elegir intereses", "Cuenta activa"
), usuarios = c(1200, 840, 610, 430, 395, 380)), row.names = c(NA, 
-6L), class = "data.frame")

hallazgos_heuristicos <- structure(list(problema = c("El botón «Atrás» borra el formulario", 
"El botón «Atrás» borra el formulario", "El botón «Atrás» borra el formulario", 
"No se indica en qué paso del registro está el usuario", "No se indica en qué paso del registro está el usuario", 
"No se indica en qué paso del registro está el usuario", "Iconos sin etiqueta en la barra inferior", 
"Iconos sin etiqueta en la barra inferior", "Iconos sin etiqueta en la barra inferior", 
"Mensajes de error genéricos («Error 42»)", "Mensajes de error genéricos («Error 42»)", 
"Mensajes de error genéricos («Error 42»)", "La búsqueda no tolera tildes", 
"La búsqueda no tolera tildes", "Tipografía de 12 px en los avisos legales", 
"Tipografía de 12 px en los avisos legales"), heuristica = c(3, 
3, 3, 1, 1, 1, 6, 6, 6, 9, 9, 9, 5, 5, 8, 8), evaluador = c("E1", 
"E2", "E3", "E1", "E2", "E3", "E1", "E2", "E3", "E1", "E2", "E3", 
"E1", "E2", "E1", "E2"), severidad = c(4, 3, 4, 3, 3, 2, 2, 3, 
2, 3, 4, 3, 2, 2, 1, 2)), row.names = c(NA, -16L), class = "data.frame")

heuristicas_nielsen <- structure(list(numero = 1:10, heuristica = c("Visibilidad del estado del sistema", 
"Correspondencia entre el sistema y el mundo real", "Control y libertad del usuario", 
"Consistencia y estándares", "Prevención de errores", "Reconocer mejor que recordar", 
"Flexibilidad y eficiencia de uso", "Diseño estético y minimalista", 
"Ayudar a reconocer, diagnosticar y recuperarse de errores", 
"Ayuda y documentación")), row.names = c(NA, -10L), class = "data.frame")

paleta_ejemplo <- c(primario = "#1a73e8", primario_oscuro = "#174ea6", acento = "#f29900", 
exito = "#188038", error = "#d93025", texto = "#202124", texto_secundario = "#5f6368", 
borde = "#dadce0", fondo = "#ffffff")

patrones_enganosos <- structure(list(fuente = c("Gray et al. (2018)", "Gray et al. (2018)", 
"Gray et al. (2018)", "Gray et al. (2018)", "Gray et al. (2018)", 
"Mathur et al. (2019)", "Mathur et al. (2019)", "Mathur et al. (2019)", 
"Mathur et al. (2019)", "Mathur et al. (2019)", "Mathur et al. (2019)", 
"Mathur et al. (2019)"), categoria = c("Insistencia", "Obstrucción", 
"Ocultación", "Interferencia en la interfaz", "Acción forzada", 
"Ocultación", "Urgencia", "Desvío", "Prueba social", "Escasez", 
"Obstrucción", "Acción forzada"), original = c("Nagging", "Obstruction", 
"Sneaking", "Interface Interference", "Forced Action", "Sneaking", 
"Urgency", "Misdirection", "Social Proof", "Scarcity", "Obstruction", 
"Forced Action"), ejemplo = c("Ventanas que piden activar notificaciones cada vez que se abre la aplicación", 
"Darse de baja exige llamar por teléfono, aunque el alta fue en línea", 
"Un seguro añadido al carrito sin que el usuario lo pida", "El botón «Aceptar todo» destaca y «Rechazar» parece texto", 
"Hay que crear una cuenta para consultar un horario", "Costes que solo aparecen en el último paso del pago", 
"Un contador que reinicia la «oferta» al recargar la página", 
"«No, gracias, prefiero pagar más» como texto del botón de rechazo", 
"«23 personas están viendo este producto» sin fuente verificable", 
"«¡Solo quedan 2!» en todos los productos", "La opción de cancelar está escondida en varios menús", 
"Aceptar el boletín es condición para continuar")), row.names = c(NA, 
-12L), class = "data.frame")

respuestas_sus <- structure(list(participante = c("P01", "P02", "P03", "P04", "P05", 
"P06", "P07", "P08", "P09", "P10", "P11", "P12"), item1 = c(4, 
5, 4, 4, 5, 4, 3, 3, 3, 4, 5, 3), item2 = c(2, 2, 2, 2, 2, 3, 
2, 3, 3, 2, 3, 2), item3 = c(4, 4, 4, 5, 4, 4, 5, 4, 5, 4, 4, 
5), item4 = c(1, 2, 3, 3, 2, 3, 2, 1, 2, 2, 3, 3), item5 = c(3, 
3, 4, 5, 5, 4, 3, 5, 5, 4, 4, 5), item6 = c(2, 1, 2, 3, 2, 2, 
2, 1, 3, 1, 2, 2), item7 = c(4, 4, 5, 3, 5, 4, 4, 4, 3, 3, 4, 
3), item8 = c(1, 2, 3, 2, 2, 2, 2, 2, 2, 2, 1, 3), item9 = c(4, 
4, 3, 4, 4, 5, 4, 5, 4, 3, 4, 3), item10 = c(1, 2, 3, 2, 2, 1, 
2, 1, 2, 1, 1, 2)), class = "data.frame", row.names = c(NA, -12L
))

sesiones_prueba <- structure(list(participante = c("P01", "P02", "P03", "P04", "P05", 
"P06", "P07", "P08", "P01", "P02", "P03", "P04", "P05", "P06", 
"P07", "P08", "P01", "P02", "P03", "P04", "P05", "P06", "P07", 
"P08", "P01", "P02", "P03", "P04", "P05", "P06", "P07", "P08", 
"P01", "P02", "P03", "P04", "P05", "P06", "P07", "P08", "P01", 
"P02", "P03", "P04", "P05", "P06", "P07", "P08"), prototipo = c("papel", 
"papel", "papel", "papel", "papel", "papel", "papel", "papel", 
"papel", "papel", "papel", "papel", "papel", "papel", "papel", 
"papel", "papel", "papel", "papel", "papel", "papel", "papel", 
"papel", "papel", "digital", "digital", "digital", "digital", 
"digital", "digital", "digital", "digital", "digital", "digital", 
"digital", "digital", "digital", "digital", "digital", "digital", 
"digital", "digital", "digital", "digital", "digital", "digital", 
"digital", "digital"), tarea = c("Buscar un libro", "Buscar un libro", 
"Buscar un libro", "Buscar un libro", "Buscar un libro", "Buscar un libro", 
"Buscar un libro", "Buscar un libro", "Reservar una sala", "Reservar una sala", 
"Reservar una sala", "Reservar una sala", "Reservar una sala", 
"Reservar una sala", "Reservar una sala", "Reservar una sala", 
"Renovar un préstamo", "Renovar un préstamo", "Renovar un préstamo", 
"Renovar un préstamo", "Renovar un préstamo", "Renovar un préstamo", 
"Renovar un préstamo", "Renovar un préstamo", "Buscar un libro", 
"Buscar un libro", "Buscar un libro", "Buscar un libro", "Buscar un libro", 
"Buscar un libro", "Buscar un libro", "Buscar un libro", "Reservar una sala", 
"Reservar una sala", "Reservar una sala", "Reservar una sala", 
"Reservar una sala", "Reservar una sala", "Reservar una sala", 
"Reservar una sala", "Renovar un préstamo", "Renovar un préstamo", 
"Renovar un préstamo", "Renovar un préstamo", "Renovar un préstamo", 
"Renovar un préstamo", "Renovar un préstamo", "Renovar un préstamo"
), exito = c(FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, 
FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, 
TRUE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, 
TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, 
TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE), 
    tiempo_s = c(42, 52, 40, 44, 31, 40, 35, 46, 120, 180, 155, 
    114, 70, 95, 87, 54, 78, 92, 72, 49, 63, 74, 45, 58, 42, 
    55, 26, 30, 42, 37, 29, 30, 103, 130, 109, 73, 102, 107, 
    84, 56, 73, 81, 62, 37, 38, 35, 43, 52), errores = c(4L, 
    1L, 0L, 2L, 1L, 1L, 0L, 0L, 3L, 0L, 0L, 0L, 1L, 2L, 0L, 0L, 
    0L, 0L, 0L, 3L, 0L, 0L, 4L, 1L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 
    0L, 0L, 1L, 2L, 0L, 0L, 1L, 1L, 1L, 1L, 1L, 0L, 0L, 0L, 2L, 
    1L, 0L)), row.names = c(NA, -48L), class = "data.frame")
