# datareuseR para webR: generado por herramientas/datareuser_webr.py.
# No editar: el código fuente está en datareuseR/R/.
# En tu ordenador, instala el paquete y usa library(datareuseR).

# ---- apertura.R ----
estrellas <- function(licencia_abierta, estructurado, no_propietario,
                      usa_uri, enlazado) {
  criterios <- c(licencia_abierta, estructurado, no_propietario, usa_uri, enlazado)
  if (!criterios[1]) return(0)
  sum(cumprod(criterios))
}

evaluar_fair <- function(registro) {
  campos <- c("identificador_persistente", "metadatos_descriptivos",
              "acceso_por_protocolo_abierto", "formato_abierto",
              "vocabulario_comun", "licencia_declarada",
              "procedencia_documentada")
  faltan <- setdiff(campos, names(registro))
  if (length(faltan)) {
    stop("Faltan elementos en el registro: ", paste(faltan, collapse = ", "),
         call. = FALSE)
  }
  c(F = registro$identificador_persistente && registro$metadatos_descriptivos,
    A = registro$acceso_por_protocolo_abierto,
    I = registro$formato_abierto && registro$vocabulario_comun,
    R = registro$licencia_declarada && registro$procedencia_documentada)
}

sumar_habiles <- function(inicio, n, festivos = NULL) {
  dia <- as.Date(inicio)
  festivos <- as.Date(festivos)
  while (n > 0) {
    dia <- dia + 1
    laborable <- !(as.POSIXlt(dia)$wday %in% c(0, 6))
    if (laborable && !(dia %in% festivos)) n <- n - 1
  }
  dia
}

# ---- calidad.R ----
celda_vacia <- function(x, ausentes = c("n/d", "N/D", "NA")) {
  texto <- trimws(as.character(x))
  is.na(x) | texto == "" | texto %in% ausentes
}

completitud <- function(datos, por = c("total", "columna"), ...) {
  por <- match.arg(por)
  vacias <- vapply(datos, function(col) sum(celda_vacia(col, ...)), numeric(1))
  if (por == "columna") {
    return(100 * (1 - vacias / nrow(datos)))
  }
  100 * (1 - sum(vacias) / (nrow(datos) * ncol(datos)))
}

informe_calidad <- function(datos, ...) {
  por_columna <- completitud(datos, por = "columna", ...)
  informe <- list(
    filas = nrow(datos),
    columnas = ncol(datos),
    duplicadas = sum(duplicated(datos)),
    columnas_vacias = names(por_columna)[por_columna == 0],
    completitud_total = completitud(datos, ...),
    completitud_columnas = por_columna
  )
  class(informe) <- "informe_calidad"
  informe
}

print.informe_calidad <- function(x, ...) {
  cat("Informe de calidad\n")
  cat("  Filas:", x$filas, "| columnas:", x$columnas,
      "| filas duplicadas:", x$duplicadas, "\n")
  cat("  Completitud total:", sprintf("%.2f %%", x$completitud_total), "\n")
  if (length(x$columnas_vacias)) {
    cat("  Columnas vac\u00edas:", paste(x$columnas_vacias, collapse = ", "), "\n")
  }
  incompletas <- x$completitud_columnas[x$completitud_columnas < 100]
  if (length(incompletas)) {
    cat("  Columnas incompletas (%):\n")
    print(round(sort(incompletas), 1))
  }
  invisible(x)
}

clave_agrupacion <- function(x) {
  x <- tolower(trimws(x))
  chartr("\u00e1\u00e9\u00ed\u00f3\u00fa\u00fc\u00f1", "aeiouun", x)
}

# ---- datosgob.R ----
consultar_datosgob <- function(titulo = "bibliotecas", n = 50, copia = TRUE) {
  url <- sprintf(
    "https://datos.gob.es/apidata/catalog/dataset/title/%s.json?_pageSize=%d",
    utils::URLencode(titulo, reserved = TRUE), as.integer(n))
  respuesta <- tryCatch({
    con <- url(url, encoding = "UTF-8")
    on.exit(close(con), add = TRUE)
    jsonlite::fromJSON(paste(readLines(con, warn = FALSE), collapse = "\n"),
                       simplifyVector = FALSE)
  }, error = function(e) NULL, warning = function(w) NULL)
  origen <- "api"
  if (is.null(respuesta)) {
    if (!copia || !identical(titulo, "bibliotecas")) {
      stop("No se ha podido consultar datos.gob.es.", call. = FALSE)
    }
    message("Sin conexi\u00f3n con datos.gob.es: se usa la copia del 24/11/2026.")
    f <- "datos/datosgob_bibliotecas.json"
    respuesta <- jsonlite::fromJSON(f, simplifyVector = FALSE)
    origen <- "copia"
  }
  items <- respuesta$result$items
  attr(items, "origen") <- origen
  items
}

# La API devuelve a veces un objeto y a veces una lista de objetos.
como_lista <- function(x) {
  if (is.null(x)) return(list())
  if (is.list(x) && !is.null(names(x))) list(x) else as.list(x)
}

titulo_es <- function(item) {
  titulos <- como_lista(item$title)
  for (t in titulos) {
    if (is.character(t)) return(t[[1]])
    if (identical(t[["_lang"]], "es")) return(t[["_value"]])
  }
  t <- titulos[[1]]
  if (is.character(t)) t else t[["_value"]]
}

normalizar_formato <- function(formato) {
  if (is.list(formato)) formato <- formato[["value"]]
  mime <- c(
    "text/csv" = "CSV", "application/json" = "JSON", "text/html" = "HTML",
    "application/xml" = "XML", "text/xml" = "XML", "application/pdf" = "PDF",
    "application/vnd.ms-excel" = "XLS",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "XLSX",
    "application/vnd.oasis.opendocument.spreadsheet" = "ODS",
    "text/pc-axis" = "PC-AXIS", "application/rdf+xml" = "RDF_XML",
    "application/geo+json" = "GEOJSON"
  )
  if (formato %in% names(mime)) return(unname(mime[formato]))
  toupper(sub(".*/", "", formato))
}

formatos_de <- function(item) {
  dist <- como_lista(item$distribution)
  unique(vapply(dist, function(d) normalizar_formato(d$format), character(1)))
}

tabla_datosgob <- function(items) {
  data.frame(
    titulo = vapply(items, titulo_es, character(1)),
    publicador = vapply(items, function(it) sub(".*/", "", it$publisher), character(1)),
    n_distribuciones = vapply(items, function(it) length(como_lista(it$distribution)), integer(1)),
    formatos = vapply(items, function(it) paste(formatos_de(it), collapse = ", "), character(1))
  )
}

# ---- lectura.R ----
leer_csv_abierto <- function(archivo, encoding = NULL, sep = NULL, ...) {
  con <- if (grepl("^https?://", archivo)) url(archivo, "rb") else file(archivo, "rb")
  bytes <- tryCatch(readBin(con, "raw", n = 1e8), finally = close(con))
  # Quita la marca de orden de bytes (BOM) de UTF-8, si la hay
  if (length(bytes) >= 3 && identical(bytes[1:3], as.raw(c(0xef, 0xbb, 0xbf)))) {
    bytes <- bytes[-(1:3)]
  }
  texto <- rawToChar(bytes)
  if (is.null(encoding)) {
    encoding <- if (validUTF8(texto)) "UTF-8" else "latin1"
  }
  texto <- iconv(texto, from = encoding, to = "UTF-8")
  Encoding(texto) <- "UTF-8"
  if (is.null(sep)) {
    primera <- sub("[\r\n].*$", "", texto)
    candidatos <- c(";", ",", "\t", "|")
    cuenta <- vapply(candidatos, function(s) {
      lengths(regmatches(primera, gregexpr(s, primera, fixed = TRUE)))
    }, numeric(1))
    sep <- candidatos[which.max(cuenta)]
  }
  datos <- utils::read.csv(text = texto, sep = sep, encoding = "UTF-8",
                           check.names = FALSE, ...)
  attr(datos, "lectura") <- list(encoding = encoding, sep = sep)
  datos
}

# ---- negocio.R ----
ingresos_mensuales <- function(usuarios, conversion, precio) {
  comprobar_conversion(conversion)
  usuarios * conversion * precio
}

punto_equilibrio <- function(costes_mes, conversion, precio) {
  comprobar_conversion(conversion)
  ceiling(costes_mes / (conversion * precio))
}

comprobar_conversion <- function(conversion) {
  if (any(conversion > 1)) {
    stop("La conversi\u00f3n es una proporci\u00f3n: escribe 0.04 para un 4 %.",
         call. = FALSE)
  }
  invisible(conversion)
}

obligaciones <- function(fuentes) {
  desconocidas <- setdiff(fuentes, licencias$licencia)
  if (length(desconocidas)) {
    stop("Licencia no incluida en la tabla: ",
         paste(desconocidas, collapse = ", "), call. = FALSE)
  }
  l <- licencias[licencias$licencia %in% fuentes, ]
  c(atribucion      = any(l$atribucion),
    compartir_igual = any(l$compartir_igual),
    uso_comercial   = all(l$uso_comercial))
}

# ---- tabla de licencias ----
licencias <- data.frame(
  licencia        = c("CC0 1.0", "CC BY 4.0", "CC BY-SA 4.0", "ODbL 1.0", "CC BY-NC 4.0"),
  atribucion      = c(FALSE, TRUE, TRUE, TRUE, TRUE),
  compartir_igual = c(FALSE, FALSE, TRUE, TRUE, FALSE),
  uso_comercial   = c(TRUE, TRUE, TRUE, TRUE, FALSE)
)
