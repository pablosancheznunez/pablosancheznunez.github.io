# Tema 7. Composición y proporción en pantalla
# Diseño e interacción en prototipos de alta fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-alta-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: medidas de la composición
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
attr(rejilla(1440, 12, 24, 80), "ancho_columna")
ancho_bloque(8, 1440, 12, 24, 80)   # módulo principal
ancho_bloque(4, 1440, 12, 24, 80)   # lateral


# ----------------------------------------------------------------------
# Ejercicio 7.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
ancho_bloque(n = ______, ancho = 1024, columnas = 8, medianil = 24, margen = 32)
