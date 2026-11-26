# Capítulo 2. Medir la ciencia
# Investigación sobre la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24528120
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/ciencia-de-la-ciencia/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# 4. Calcular con R
# ----------------------------------------------------------------------
citas <- c(120, 45, 30, 22, 15, 12, 9, 8, 6, 5, 3, 2, 1, 0, 0)
ordenadas <- sort(citas, decreasing = TRUE)
h <- sum(ordenadas >= seq_along(ordenadas))
h
c(media = mean(citas), mediana = median(citas))


# ----------------------------------------------------------------------
# Ejercicio 2.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
perfil <- c(4, 25, 0, 9, 7, 1, 15, 3, 8, 2)

# EJERCICIO: completa los huecos ______
ord <- sort(perfil, decreasing = TRUE)
sum(ord >= ______(ord))


# ----------------------------------------------------------------------
# Ejercicio 2.2
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
12 / ______
