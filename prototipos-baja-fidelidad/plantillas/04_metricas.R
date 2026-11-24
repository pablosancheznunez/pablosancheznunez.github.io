# Tema 4. Hitos, objetivos y métricas
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
# Práctica en R: medir una prueba pequeña
# ----------------------------------------------------------------------
tasa_exito(exitos = 4, n = 5)
tiempos <- c(32, 41, 38, 45, 120)
c(media = mean(tiempos), media_geometrica = tiempo_tipico(tiempos))


# ----------------------------------------------------------------------
# Ejercicio 4.1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
t <- tasa_exito(exitos = 3, n = ______)
t["superior"]


# ----------------------------------------------------------------------
# Ejercicio 4.2
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
sus <- puntuacion_sus(respuestas_sus[, -1])   # [, -1] quita la columna del participante
______(sus)
