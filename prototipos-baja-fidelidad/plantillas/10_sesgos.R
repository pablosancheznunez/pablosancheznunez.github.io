# Tema 10. Sesgos cognitivos y patrones engañosos
# Esquemas de página y prototipos de baja fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24515131
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-baja-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: dos taxonomías
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
patrones_enganosos[, c("fuente", "categoria", "original")]


# ----------------------------------------------------------------------
# Ejercicio 10.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")
g <- patrones_enganosos

# EJERCICIO: completa los huecos ______
gray   <- g$categoria[g$fuente == "Gray et al. (2018)"]
mathur <- g$categoria[g$fuente == "______"]
intersect(gray, mathur)
