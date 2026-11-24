# Tema 5. Uso accesible del color
# Diseño e interacción en prototipos de alta fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-alta-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: revisar una paleta
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
revisar_paleta(paleta_ejemplo)[, c("nombre", "color", "contraste", "texto_normal_AA", "componente_AA")]


# ----------------------------------------------------------------------
# Ejercicio 5.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
contraste("______", "#f1f3f4")


# ----------------------------------------------------------------------
# Ejercicio 5.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
d <- simular_daltonismo(paleta_ejemplo[c("acento", "error")], tipo = "______")
d
distinguibles(d[1], d[2])
