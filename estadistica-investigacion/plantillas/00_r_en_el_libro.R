# Usar R en este libro
# Estadística para la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/estadistica-investigacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Descarga de los datos del capítulo a la carpeta datos/
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/estudio.csv")) download.file("https://pablosancheznunez.com/estadistica-investigacion/datos/estudio.csv", "datos/estudio.csv", mode = "wb")


# ----------------------------------------------------------------------
# Cómo funcionan las celdas
# ----------------------------------------------------------------------
notas <- c(7.5, 6, 8.2, 4.9, 9.1)  # cinco notas
sum(notas)                          # total
mean(notas)                         # media
median(notas)                       # mediana

d <- read.csv("datos/estudio.csv")   # el conjunto de datos del libro
head(d)                               # primeras filas
d$nota[1:5]                           # una columna con $
nrow(d)                               # número de filas


# ----------------------------------------------------------------------
# Ejercicio 1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
pertinentes <- 24
resultados <- ______
pertinentes / resultados


# ----------------------------------------------------------------------
# Ejercicio 2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")

# EJERCICIO: completa los huecos ______
______(d)
