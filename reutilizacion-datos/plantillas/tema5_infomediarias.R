# Tema 5. Empresas infomediarias y oportunidades de negocio
# Reutilización de datos abiertos y documentos: tutoriales interactivos en R
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24500934
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/reutilizacion-datos/
#
# Script limpio con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Descarga del CSV de práctica a la carpeta datos/
url_csv <- "https://pablosancheznunez.com/reutilizacion-datos/datos/prestamos_bibliotecas_practica.csv"
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/prestamos_bibliotecas_practica.csv")) {
  download.file(url_csv, "datos/prestamos_bibliotecas_practica.csv", mode = "wb")
}


# ----------------------------------------------------------------------
# Paso 1. Un servicio de valor añadido: enriquecer los préstamos (apartado 3)
# ----------------------------------------------------------------------
b <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
b <- b[!duplicated(b), ]
clave <- chartr("áéíóúüñ", "aeiouun", tolower(trimws(b$municipio)))
b$municipio <- unname(c(getafe = "Getafe", leganes = "Leganés", alcorcon = "Alcorcón",
                        mostoles = "Móstoles", fuenlabrada = "Fuenlabrada")[clave])
b$prestamos <- as.numeric(ifelse(b$prestamos %in% c("", "n/d"), NA, b$prestamos))
b$prestamos[which(b$prestamos < 0)] <- NA
limpio <- b

poblacion <- data.frame(
  municipio = c("Getafe", "Leganés", "Alcorcón", "Móstoles", "Fuenlabrada"),
  habitantes = c(185000, 190000, 170000, 210000, 190000)   # ficticias
)

por_muni <- aggregate(prestamos ~ municipio, data = limpio, FUN = sum)
enriquecido <- merge(por_muni, poblacion)
enriquecido


# ----------------------------------------------------------------------
# Ejercicio 5.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
b <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
b <- b[!duplicated(b), ]
clave <- chartr("áéíóúüñ", "aeiouun", tolower(trimws(b$municipio)))
b$municipio <- unname(c(getafe = "Getafe", leganes = "Leganés", alcorcon = "Alcorcón",
                        mostoles = "Móstoles", fuenlabrada = "Fuenlabrada")[clave])
b$prestamos <- as.numeric(ifelse(b$prestamos %in% c("", "n/d"), NA, b$prestamos))
b$prestamos[which(b$prestamos < 0)] <- NA
poblacion <- data.frame(
  municipio = c("Getafe", "Leganés", "Alcorcón", "Móstoles", "Fuenlabrada"),
  habitantes = c(185000, 190000, 170000, 210000, 190000)
)
enriquecido <- merge(aggregate(prestamos ~ municipio, data = b, FUN = sum), poblacion)

# EJERCICIO: completa los huecos ______
enriquecido$por_mil <- round(enriquecido$prestamos / enriquecido$habitantes * ______, 1)
enriquecido[order(enriquecido$por_mil, decreasing = TRUE), ]


# ----------------------------------------------------------------------
# Paso 2. ¿Es viable un servicio *freemium*? (apartados 2 y 4)
# ----------------------------------------------------------------------
ingresos_mensuales <- function(usuarios, conversion, precio) {
  usuarios * conversion * precio
}
usuarios   <- 5000    # bibliotecas y profesionales que usan la versión gratuita
conversion <- 0.04    # 4 % pasa a la versión de pago
precio     <- 9       # euros al mes
costes_fijos <- 2700  # euros al mes (servidores, mantenimiento, actualización de datos)

ingresos <- ingresos_mensuales(usuarios, conversion, precio)
c(ingresos = ingresos, costes = costes_fijos, resultado = ingresos - costes_fijos)

u <- seq(0, 12000, by = 500)
plot(u, ingresos_mensuales(u, conversion, precio), type = "l", lwd = 2, col = "#000e78",
     xlab = "Usuarios de la versión gratuita", ylab = "Euros al mes",
     main = "Ingresos frente a costes fijos")
abline(h = costes_fijos, lty = 2, col = "firebrick")
legend("topleft", c("Ingresos", "Costes fijos"), lty = c(1, 2), col = c("#000e78", "firebrick"), bty = "n")


# ----------------------------------------------------------------------
# Ejercicio 5.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
conversion <- 0.04
precio <- 9
costes_fijos <- 2700

# EJERCICIO: completa los huecos ______
costes_fijos / (______ * ______)


# ----------------------------------------------------------------------
# Ejercicio 5.3
# ----------------------------------------------------------------------
# (preparación del ejercicio)
ingresos_mensuales <- function(usuarios, conversion, precio) usuarios * conversion * precio
costes_fijos <- 2700

# EJERCICIO: completa los huecos ______
ingresos_mensuales(usuarios = 5000, conversion = ______, precio = 9) - costes_fijos


# ----------------------------------------------------------------------
# Paso 3. Obligaciones al combinar licencias (apartado 4)
# ----------------------------------------------------------------------
licencias <- data.frame(
  licencia        = c("CC0 1.0", "CC BY 4.0", "CC BY-SA 4.0", "ODbL 1.0", "CC BY-NC 4.0"),
  atribucion      = c(FALSE, TRUE, TRUE, TRUE, TRUE),
  compartir_igual = c(FALSE, FALSE, TRUE, TRUE, FALSE),
  uso_comercial   = c(TRUE, TRUE, TRUE, TRUE, FALSE)
)

obligaciones <- function(fuentes) {
  l <- licencias[licencias$licencia %in% fuentes, ]
  c(atribucion      = any(l$atribucion),
    compartir_igual = any(l$compartir_igual),
    uso_comercial   = all(l$uso_comercial))
}

obligaciones(c("CC0 1.0", "CC BY 4.0"))


# ----------------------------------------------------------------------
# Ejercicio 5.4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
licencias <- data.frame(
  licencia        = c("CC0 1.0", "CC BY 4.0", "CC BY-SA 4.0", "ODbL 1.0", "CC BY-NC 4.0"),
  atribucion      = c(FALSE, TRUE, TRUE, TRUE, TRUE),
  compartir_igual = c(FALSE, FALSE, TRUE, TRUE, FALSE),
  uso_comercial   = c(TRUE, TRUE, TRUE, TRUE, FALSE)
)
obligaciones <- function(fuentes) {
  l <- licencias[licencias$licencia %in% fuentes, ]
  c(atribucion = any(l$atribucion), compartir_igual = any(l$compartir_igual), uso_comercial = all(l$uso_comercial))
}

# EJERCICIO: completa los huecos ______
obligaciones(c("______", "______"))


# ----------------------------------------------------------------------
# Ejercicio 5.5
# ----------------------------------------------------------------------
# (preparación del ejercicio)
licencias <- data.frame(
  licencia        = c("CC0 1.0", "CC BY 4.0", "CC BY-SA 4.0", "ODbL 1.0", "CC BY-NC 4.0"),
  atribucion      = c(FALSE, TRUE, TRUE, TRUE, TRUE),
  compartir_igual = c(FALSE, FALSE, TRUE, TRUE, FALSE),
  uso_comercial   = c(TRUE, TRUE, TRUE, TRUE, FALSE)
)
obligaciones <- function(fuentes) {
  l <- licencias[licencias$licencia %in% fuentes, ]
  c(atribucion = any(l$atribucion), compartir_igual = any(l$compartir_igual), uso_comercial = all(l$uso_comercial))
}

# EJERCICIO: completa los huecos ______
o <- obligaciones(c("CC BY 4.0", "ODbL 1.0", ______))
o[["______"]]
