# Caso práctico: las bibliotecas públicas municipales de Madrid
# Reutilización de datos abiertos y documentos: tutoriales interactivos en R
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24500934
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/reutilizacion-datos/
#
# Script limpio con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Paquete necesario (solo la primera vez):
# install.packages("jsonlite")

# Descarga de la copia del conjunto «Bibliotecas de Madrid» (Ayuntamiento de Madrid, CC BY 4.0)
dir.create("datos", showWarnings = FALSE)
f_madrid <- "datos/bibliotecas_madrid_2026-11-24.csv"
if (!file.exists(f_madrid)) {
  download.file("https://pablosancheznunez.com/reutilizacion-datos/datos/bibliotecas_madrid_2026-11-24.csv", f_madrid, mode = "wb")
}


# ----------------------------------------------------------------------
# Leerlo… y fallar
# ----------------------------------------------------------------------
f <- "datos/bibliotecas_madrid_2026-11-24.csv"
mal <- read.csv(f)
dim(mal)
names(mal)[1:3]

bib <- read.csv(f, sep = ";", fileEncoding = "latin1")
dim(bib)
head(bib$NOMBRE, 4)


# ----------------------------------------------------------------------
# Ejercicio C.1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
bib <- read.csv("datos/bibliotecas_madrid_2026-11-24.csv", sep = "______", fileEncoding = "______")
nrow(bib)


# ----------------------------------------------------------------------
# Ejercicio C.4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/datareuseR.R")

# EJERCICIO: completa los huecos ______
bib2 <- leer_csv_abierto("datos/bibliotecas_madrid_2026-11-24.csv")
attr(bib2, "______")$encoding


# ----------------------------------------------------------------------
# Columnas vacías y completitud
# ----------------------------------------------------------------------
vacia <- function(x) is.na(x) | trimws(as.character(x)) == ""
ausentes <- sapply(bib, function(col) sum(vacia(col)))
sort(ausentes[ausentes > 0], decreasing = TRUE)


# ----------------------------------------------------------------------
# Ejercicio C.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bib <- read.csv("datos/bibliotecas_madrid_2026-11-24.csv", sep = ";", fileEncoding = "latin1")
vacia <- function(x) is.na(x) | trimws(as.character(x)) == ""

# EJERCICIO: completa los huecos ______
celdas_vacias <- sum(sapply(bib, function(col) sum(vacia(col))))
celdas_totales <- ______
round(100 * (celdas_totales - celdas_vacias) / celdas_totales, 2)


# ----------------------------------------------------------------------
# Códigos sin explicar
# ----------------------------------------------------------------------
table(bib$ACCESIBILIDAD)


# ----------------------------------------------------------------------
# Bibliotecas por distrito
# ----------------------------------------------------------------------
por_distrito <- sort(table(bib$DISTRITO), decreasing = TRUE)
op <- par(mar = c(4, 11, 1, 1))
barplot(rev(por_distrito), horiz = TRUE, las = 1, col = "#2a78d6", border = NA,
        cex.names = 0.7, xlab = "Bibliotecas públicas municipales")
par(op)


# ----------------------------------------------------------------------
# Ejercicio C.5
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bib <- read.csv("datos/bibliotecas_madrid_2026-11-24.csv", sep = ";", fileEncoding = "latin1")

# EJERCICIO: completa los huecos ______
names(which.max(table(bib$______)))


# ----------------------------------------------------------------------
# Metadatos del conjunto derivado
# ----------------------------------------------------------------------
meta <- list(
  "@type" = "dcat:Dataset",
  "dct:title" = "Bibliotecas públicas municipales de Madrid (versión depurada)",
  "dct:source" = "https://datos.madrid.es/dataset/201747-0-bibliobuses-bibliotecas",
  "dct:license" = "https://creativecommons.org/licenses/by/4.0/",
  "dct:modified" = "2026-11-24",
  "dct:description" = "Selección de columnas, conversión a UTF-8 y eliminación de columnas vacías."
)
cat(jsonlite::toJSON(meta, auto_unbox = TRUE, pretty = TRUE))


# ----------------------------------------------------------------------
# Tema 4. De CSV a datos enlazados
# ----------------------------------------------------------------------
a_jsonld <- function(b) {
  list("@context" = "https://schema.org/", "@type" = "Library",
       "name" = b$NOMBRE,
       "url" = b$CONTENT.URL,
       "address" = list("@type" = "PostalAddress",
                        "streetAddress" = paste(b$CLASE.VIAL, b$NOMBRE.VIA, b$NUM),
                        "postalCode" = as.character(b$CODIGO.POSTAL),
                        "addressLocality" = "Madrid"),
       "geo" = list("@type" = "GeoCoordinates", "latitude" = b$LATITUD, "longitude" = b$LONGITUD))
}
cat(jsonlite::toJSON(a_jsonld(bib[1, ]), auto_unbox = TRUE, pretty = TRUE, digits = NA))

plot(bib$LONGITUD, bib$LATITUD, pch = 19, col = "#2a78d6", asp = 1 / cos(40.4 * pi / 180),
     xlab = "Longitud", ylab = "Latitud", main = "Bibliotecas públicas municipales de Madrid")


# ----------------------------------------------------------------------
# Tema 5. Un servicio de valor añadido
# ----------------------------------------------------------------------
menciona_sabado <- grepl("s[áa]bado", bib$HORARIO, ignore.case = TRUE)
sum(menciona_sabado)
cat(bib$HORARIO[1])


# ----------------------------------------------------------------------
# Ejercicio C.3
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bib <- read.csv("datos/bibliotecas_madrid_2026-11-24.csv", sep = ";", fileEncoding = "latin1")

# EJERCICIO: completa los huecos ______
sum(grepl("______", bib$HORARIO, ignore.case = TRUE))
