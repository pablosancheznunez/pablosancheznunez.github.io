# Capítulo 5. Crear paquetes de R y de Python
# Programación para la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/programacion-investigacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Ejercicio 5.1 · Validar las entradas (R)
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
indice_h <- function(citas) {
  stopifnot(is.numeric(citas), all(citas ______ 0, na.rm = TRUE))
  citas <- sort(citas[!is.na(citas)], decreasing = TRUE)
  sum(citas >= seq_along(citas))
}
indice_h(c(12, 0, 45, 7, 3, 10, 28, 1))
