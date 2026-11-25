# Tema 7. Esquemas de página en papel y en pantalla
# Esquemas de página y prototipos de baja fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24515131
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-baja-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: calcular una rejilla
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
r <- rejilla(ancho = 1440, columnas = 12, medianil = 24, margen = 80)
attr(r, "ancho_columna")
ancho_bloque(8)                               # el contenido de la figura
caracteres_por_linea(ancho_bloque(8), tamano = 18)


# ----------------------------------------------------------------------
# Ejercicio 7.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
r <- rejilla(ancho = 375, columnas = ______, medianil = 16, margen = 16)
attr(r, "ancho_columna")
