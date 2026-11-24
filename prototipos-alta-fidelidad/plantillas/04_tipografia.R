# Tema 4. La tipografía en el diseño de interfaces
# Diseño e interacción en prototipos de alta fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-alta-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: escalas tipográficas
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
escala_tipografica(base = 16, razon = 1.25, pasos = -1:5)


# ----------------------------------------------------------------------
# Ejercicio 4.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
e <- escala_tipografica(base = 16, razon = ______, pasos = 0:3)
e$px[e$paso == 3]


# ----------------------------------------------------------------------
# Ejercicio 4.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
caracteres_por_linea(ancho = ______, tamano = 18)
