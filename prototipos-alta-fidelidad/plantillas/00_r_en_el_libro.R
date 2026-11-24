# Usar R en este libro
# Diseño e interacción en prototipos de alta fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-alta-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Cómo funcionan las celdas
# ----------------------------------------------------------------------
2 + 3
participantes <- 5
exitos <- 4
exitos / participantes

tiempos <- c(32, 41, 38, 45, 120)   # segundos que tardó cada participante en una tarea
mean(tiempos)                        # media
median(tiempos)                      # mediana
length(tiempos)                      # cuántos valores hay


# ----------------------------------------------------------------------
# Ejercicio 1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
exitos <- 7
participantes <- ______
exitos / participantes


# ----------------------------------------------------------------------
# Las funciones del libro
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
contraste("#767676", "#ffffff")   # gris sobre blanco
contraste("#999999", "#ffffff")


# ----------------------------------------------------------------------
# Ejercicio 2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
contraste("#999999", "#ffffff") >= ______


# ----------------------------------------------------------------------
# Ejercicio 3
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
head(sesiones_prueba, 3)
______(sesiones_prueba)
