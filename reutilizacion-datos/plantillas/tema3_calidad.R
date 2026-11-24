# Tema 3. Gestión documental y open data
# Reutilización de datos abiertos y documentos: tutoriales interactivos en R
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24500934
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/reutilizacion-datos/
#
# Script limpio con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Paquete necesario (solo la primera vez):
# install.packages("jsonlite")

# Descarga del CSV de práctica a la carpeta datos/
url_csv <- "https://pablosancheznunez.com/reutilizacion-datos/datos/prestamos_bibliotecas_practica.csv"
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/prestamos_bibliotecas_practica.csv")) {
  download.file(url_csv, "datos/prestamos_bibliotecas_practica.csv", mode = "wb")
}


# ----------------------------------------------------------------------
# Paso 1. Leer todo como texto
# ----------------------------------------------------------------------
bruto <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
dim(bruto)
head(bruto, 8)


# ----------------------------------------------------------------------
# Paso 2. Valores ausentes y completitud
# ----------------------------------------------------------------------
ausente <- bruto == "" | bruto == "n/d"
colSums(ausente)          # ausentes por columna
sum(ausente)              # total de celdas ausentes


# ----------------------------------------------------------------------
# Ejercicio 3.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bruto <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
ausente <- bruto == "" | bruto == "n/d"

# EJERCICIO: completa los huecos ______
celdas_totales <- nrow(bruto) * ncol(bruto)
celdas_completas <- celdas_totales - ______
round(100 * celdas_completas / celdas_totales, 2)


# ----------------------------------------------------------------------
# Ejercicio 3.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bruto <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
ausente <- bruto == "" | bruto == "n/d"

# EJERCICIO: completa los huecos ______
fila_con_ausente <- rowSums(ausente) > 0
filas_completas <- sum(______)
round(100 * filas_completas / nrow(bruto), 2)


# ----------------------------------------------------------------------
# Paso 3. Filas duplicadas
# ----------------------------------------------------------------------
duplicated(bruto)


# ----------------------------------------------------------------------
# Ejercicio 3.3
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bruto <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")

# EJERCICIO: completa los huecos ______
n_dup <- sum(duplicated(bruto))
sin_dup <- bruto[______, ]
c(duplicadas = n_dup, filas_restantes = nrow(sin_dup))


# ----------------------------------------------------------------------
# Paso 4. Normalizar los municipios
# ----------------------------------------------------------------------
sin_dup <- bruto[!duplicated(bruto), ]
table(sin_dup$municipio)

clave <- function(x) {
  x <- trimws(x)
  x <- tolower(x)
  chartr("áéíóúüñ", "aeiouun", x)
}
table(clave(sin_dup$municipio))

forma_correcta <- c(getafe = "Getafe", leganes = "Leganés", alcorcon = "Alcorcón",
                    mostoles = "Móstoles", fuenlabrada = "Fuenlabrada")
sin_dup$municipio <- unname(forma_correcta[clave(sin_dup$municipio)])
table(sin_dup$municipio)


# ----------------------------------------------------------------------
# Ejercicio 3.4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bruto <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
clave <- function(x) chartr("áéíóúüñ", "aeiouun", tolower(trimws(x)))

# EJERCICIO: completa los huecos ______
c(variantes  = length(unique(bruto$municipio)),
  municipios = length(unique(______)))


# ----------------------------------------------------------------------
# Paso 5. Unificar las fechas
# ----------------------------------------------------------------------
table(grepl("/", sin_dup$fecha))   # TRUE = formato dd/mm/aaaa

es_dmy <- grepl("/", sin_dup$fecha)
fecha <- as.Date(sin_dup$fecha, format = "%Y-%m-%d")
fecha[es_dmy] <- as.Date(sin_dup$fecha[es_dmy], format = "%d/%m/%Y")
sin_dup$fecha <- fecha
sum(is.na(sin_dup$fecha))   # ninguna fecha sin convertir
range(sin_dup$fecha)


# ----------------------------------------------------------------------
# Paso 6. Valores numéricos
# ----------------------------------------------------------------------
num <- function(x) as.numeric(ifelse(x %in% c("", "n/d"), NA, x))
sin_dup$prestamos <- num(sin_dup$prestamos)
sin_dup$usuarios_activos <- num(sin_dup$usuarios_activos)
summary(sin_dup$prestamos)
subset(sin_dup, prestamos < 0)

sin_dup$prestamos[which(sin_dup$prestamos < 0)] <- NA
limpio <- sin_dup
str(limpio)


# ----------------------------------------------------------------------
# Ejercicio 3.5
# ----------------------------------------------------------------------
# (preparación del ejercicio)
b <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
limpio <- b[!duplicated(b), ]
clave <- function(x) chartr("áéíóúüñ", "aeiouun", tolower(trimws(x)))
forma_correcta <- c(getafe = "Getafe", leganes = "Leganés", alcorcon = "Alcorcón",
                    mostoles = "Móstoles", fuenlabrada = "Fuenlabrada")
limpio$municipio <- unname(forma_correcta[clave(limpio$municipio)])
num <- function(x) as.numeric(ifelse(x %in% c("", "n/d"), NA, x))
limpio$prestamos <- num(limpio$prestamos)
limpio$prestamos[!is.na(limpio$prestamos) & limpio$prestamos < 0] <- NA

# EJERCICIO: completa los huecos ______
getafe <- subset(limpio, municipio == ______)
sum(getafe$prestamos, na.rm = ______)


# ----------------------------------------------------------------------
# Ejercicio 3.6
# ----------------------------------------------------------------------
# (preparación del ejercicio)
b <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
limpio <- b[!duplicated(b), ]
clave <- function(x) chartr("áéíóúüñ", "aeiouun", tolower(trimws(x)))
forma_correcta <- c(getafe = "Getafe", leganes = "Leganés", alcorcon = "Alcorcón",
                    mostoles = "Móstoles", fuenlabrada = "Fuenlabrada")
limpio$municipio <- unname(forma_correcta[clave(limpio$municipio)])
num <- function(x) as.numeric(ifelse(x %in% c("", "n/d"), NA, x))
limpio$prestamos <- num(limpio$prestamos)
limpio$usuarios_activos <- num(limpio$usuarios_activos)
limpio$prestamos[!is.na(limpio$prestamos) & limpio$prestamos < 0] <- NA

# EJERCICIO: completa los huecos ______
# Solo filas con ambos valores, para que numerador y denominador sean comparables
completas <- subset(limpio, !is.na(prestamos) & !is.na(usuarios_activos))
por_muni <- aggregate(cbind(prestamos, usuarios_activos) ~ municipio, data = completas, FUN = sum)
por_muni$ratio <- round(por_muni$prestamos / por_muni$usuarios_activos, 2)
por_muni[order(por_muni$ratio, decreasing = TRUE), ]


# ----------------------------------------------------------------------
# Explora los datos limpios
# ----------------------------------------------------------------------
b <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
b <- b[!duplicated(b), ]
k <- chartr("áéíóúüñ", "aeiouun", tolower(trimws(b$municipio)))
b$municipio <- unname(c(getafe = "Getafe", leganes = "Leganés", alcorcon = "Alcorcón",
                        mostoles = "Móstoles", fuenlabrada = "Fuenlabrada")[k])
b$mes <- as.integer(ifelse(grepl("/", b$fecha), substr(b$fecha, 4, 5), substr(b$fecha, 6, 7)))
b$prestamos <- suppressWarnings(as.numeric(b$prestamos))
b$prestamos[which(b$prestamos < 0)] <- NA
colores <- c(Getafe = "#2a78d6", "Leganés" = "#eb6834", "Alcorcón" = "#1baf7a",
             "Móstoles" = "#eda100", Fuenlabrada = "#e87ba4")
sel <- unlist(municipios_sel)
if (length(sel) == 0) {
  plot.new(); text(0.5, 0.5, "Marca al menos un municipio")
} else {
  fun <- if (isTRUE(por_biblioteca)) function(x) mean(x) else function(x) sum(x)
  tabla <- aggregate(prestamos ~ municipio + mes, data = b[b$municipio %in% sel, ], FUN = fun)
  rango <- range(tabla$prestamos)
  plot(NA, xlim = c(1, 6.8), ylim = rango, xaxt = "n", bty = "l",
       xlab = "", ylab = if (isTRUE(por_biblioteca)) "Préstamos por biblioteca" else "Préstamos")
  axis(1, at = 1:6, labels = c("ene", "feb", "mar", "abr", "may", "jun"))
  for (m in sel) {
    d <- merge(data.frame(mes = 1:6), tabla[tabla$municipio == m, ], all.x = TRUE)
    lines(d$mes, d$prestamos, col = colores[m], lwd = 2)
    points(d$mes, d$prestamos, col = colores[m], pch = 19)
    text(6.1, tail(na.omit(d$prestamos), 1), m, pos = 4, cex = 0.8)
  }
}


# ----------------------------------------------------------------------
# Paso 7. Publicar el resultado con metadatos (apartados 3 y 5)
# ----------------------------------------------------------------------
write.csv(limpio, "prestamos_limpio.csv", row.names = FALSE)

metadatos <- list(
  "@type" = "dcat:Dataset",
  "dct:title" = "Préstamos mensuales de bibliotecas municipales (enero-junio 2025)",
  "dct:description" = "Datos sintéticos para docencia. Versión depurada: municipios normalizados, fechas ISO 8601, duplicados eliminados.",
  "dct:license" = "https://creativecommons.org/licenses/by/4.0/",
  "dct:accrualPeriodicity" = "http://publications.europa.eu/resource/authority/frequency/MONTHLY",
  "dct:temporal" = list(startDate = "2025-01-01", endDate = "2025-06-30"),
  "dct:spatial" = "Comunidad de Madrid",
  "dcat:distribution" = list(
    "@type" = "dcat:Distribution",
    "dcat:downloadURL" = "https://ejemplo.org/datos/prestamos_limpio.csv",
    "dcat:mediaType" = "text/csv",
    "dct:format" = "CSV"
  )
)
cat(jsonlite::toJSON(metadatos, auto_unbox = TRUE, pretty = TRUE))


# ----------------------------------------------------------------------
# Ejercicio 3.7
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
distribucion <- list(
  "@type" = "dcat:Distribution",
  "dcat:downloadURL" = "https://ejemplo.org/datos/prestamos_limpio.json",
  "dcat:mediaType" = "______",
  "dct:license" = "______"
)
distribucion


# ----------------------------------------------------------------------
# Paso 8. Comprobar la integridad de los ficheros (apartado 6)
# ----------------------------------------------------------------------
write.csv(limpio, "prestamos_limpio.csv", row.names = FALSE)
sumas <- tools::md5sum(c("datos/prestamos_bibliotecas_practica.csv", "prestamos_limpio.csv"))
sumas

versiones <- data.frame(
  version = c("1.0", "1.1"),
  fecha = as.Date(c("2025-07-01", Sys.Date())),
  cambio = c("Publicación inicial (fichero original)",
             "Depuración: duplicados, municipios, fechas y valores negativos"),
  md5 = unname(sumas)
)
versiones


# ----------------------------------------------------------------------
# Ejercicio 3.8
# ----------------------------------------------------------------------
# (preparación del ejercicio)
suma_publicada <- unname(tools::md5sum("datos/prestamos_bibliotecas_practica.csv"))

# EJERCICIO: completa los huecos ______
suma_descarga <- unname(tools::md5sum("______"))
suma_descarga ______ suma_publicada
