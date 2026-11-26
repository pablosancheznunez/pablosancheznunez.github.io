# Capítulo 7. Introducción a la inferencia bayesiana
# Estadística para la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/estadistica-investigacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Descarga de los datos del capítulo a la carpeta datos/
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/estudio.csv")) download.file("https://pablosancheznunez.com/estadistica-investigacion/datos/estudio.csv", "datos/estudio.csv", mode = "wb")


# ----------------------------------------------------------------------
# 2. Un caso que se calcula a mano: una proporción
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
k <- sum(d$nota >= 5); n <- nrow(d)
a <- 1; b <- 1                                  # previa plana
qbeta(c(0.025, 0.975), a + k, b + n - k)       # intervalo de credibilidad del 95 %
curve(dbeta(x, a + k, b + n - k), 0.5, 1, col = "#2a78d6", lwd = 2, xlab = "Proporción de aprobados", ylab = "Densidad")
curve(dbeta(x, a, b), add = TRUE, col = "grey50", lty = 2)


# ----------------------------------------------------------------------
# Ejercicio 7.1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
a <- 1; b <- 1; k <- 15; n <- 20
(a + k) / (a + b + ______)


# ----------------------------------------------------------------------
# Ejercicio 7.2
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
qbeta(c(0.025, ______), 16, 6)
