# Tema 7. Esquemas de página en papel y en pantalla
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
# Práctica en R: calcular una rejilla
# ----------------------------------------------------------------------
r <- rejilla(ancho = 1440, columnas = 12, medianil = 24, margen = 80)
attr(r, "ancho_columna")
ancho_bloque(8)                               # el contenido de la figura
caracteres_por_linea(ancho_bloque(8), tamano = 18)


# ----------------------------------------------------------------------
# Ejercicio 7.1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
r <- rejilla(ancho = 375, columnas = ______, medianil = 16, margen = 16)
attr(r, "ancho_columna")
