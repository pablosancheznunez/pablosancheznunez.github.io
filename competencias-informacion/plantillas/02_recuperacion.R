# Unidad 2. Recuperación de información
# Competencias digitales para el uso de la información
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/competencias-informacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: los operadores booleanos por dentro
# ----------------------------------------------------------------------
movil      <- c(1, 2, 3, 5, 8, 13, 21)     # documentos que contienen «móvil»
smartphone <- c(2, 4, 8, 16, 32)           # los que contienen «smartphone»
rendimiento <- c(1, 2, 4, 8, 13, 16, 40)  # los que contienen «rendimiento»

union(movil, smartphone)                   # móvil OR smartphone
intersect(union(movil, smartphone), rendimiento)   # (móvil OR smartphone) AND rendimiento


# ----------------------------------------------------------------------
# Ejercicio 2.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
movil      <- c(1, 2, 3, 5, 8, 13, 21)
smartphone <- c(2, 4, 8, 16, 32)
rendimiento <- c(1, 2, 4, 8, 13, 16, 40)

# EJERCICIO: completa los huecos ______
r <- intersect(union(movil, smartphone), ______)
length(r)


# ----------------------------------------------------------------------
# Ejercicio 2.2
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
pertinentes <- 4
resultados <- 6
pertinentes / ______
