# Unidad 3. Uso ético de la información y plagio
# Competencias digitales para el uso de la información
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/competencias-informacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: así detecta coincidencias un programa
# ----------------------------------------------------------------------
trigramas <- function(texto) {
  p <- strsplit(tolower(gsub("[[:punct:]]", "", texto)), "\\s+")[[1]]
  unique(paste(p[-c(length(p) - 1, length(p))], p[-c(1, length(p))], p[-(1:2)]))
}
similitud <- function(a, b) {
  ta <- trigramas(a); tb <- trigramas(b)
  length(intersect(ta, tb)) / length(union(ta, tb))
}
original <- "La lectura lateral consiste en salir de la página para comprobar qué dicen otras fuentes sobre ella"
mosaico  <- "La lectura lateral consiste en salir de la web para comprobar lo que dicen otras fuentes sobre ella"
parafrasis <- "Para verificar una web, conviene consultar qué opinan de ella fuentes distintas en lugar de analizarla por dentro"
c(mosaico = similitud(original, mosaico), parafrasis = similitud(original, parafrasis))


# ----------------------------------------------------------------------
# Ejercicio 3.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
trigramas <- function(texto) {
  p <- strsplit(tolower(gsub("[[:punct:]]", "", texto)), "\\s+")[[1]]
  unique(paste(p[-c(length(p) - 1, length(p))], p[-c(1, length(p))], p[-(1:2)]))
}
similitud <- function(a, b) {
  ta <- trigramas(a); tb <- trigramas(b)
  length(intersect(ta, tb)) / length(union(ta, tb))
}
original <- "La lectura lateral consiste en salir de la página para comprobar qué dicen otras fuentes sobre ella"

# EJERCICIO: completa los huecos ______
copia <- original
similitud(original, ______)
