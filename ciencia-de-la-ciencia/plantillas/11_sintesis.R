# Capítulo 11. Síntesis de la evidencia y detección de sesgos
# Investigación sobre la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24528120
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/ciencia-de-la-ciencia/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Ejercicio 11.1 · Efectos fijos
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
d  <- c(0.45, 0.10, 0.30)
ee <- c(0.20, 0.08, 0.15)
w  <- 1 / ee^2
round(sum(w * d) / ______(w), 3)


# ----------------------------------------------------------------------
# Ejercicio 11.2 · La prueba GRIM
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
n <- 21; media <- 3.47
totales <- 0:(7 * n)
any(round(totales / n, 2) == ______)
