# Tema 10. Sesgos cognitivos y patrones engañosos
# Esquemas de página y prototipos de baja fidelidad
# Pablo Sánchez-Núñez (UC3M)
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-baja-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Funciones del paquete UxLearn (instálalo una vez):
# remotes::install_github("pablosancheznunez/UxLearn")
library(UxLearn)


# ----------------------------------------------------------------------
# Práctica en R: dos taxonomías
# ----------------------------------------------------------------------
patrones_enganosos[, c("fuente", "categoria", "original")]


# ----------------------------------------------------------------------
# Ejercicio 10.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
g <- patrones_enganosos

# EJERCICIO: completa los huecos ______
gray   <- g$categoria[g$fuente == "Gray et al. (2018)"]
mathur <- g$categoria[g$fuente == "______"]
intersect(gray, mathur)
