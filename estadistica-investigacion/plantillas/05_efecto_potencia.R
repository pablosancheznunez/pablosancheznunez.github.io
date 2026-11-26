# Capítulo 5. Tamaño del efecto y potencia
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
# 1. Cuánto, no solo si
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
a <- d$nota[d$grupo == "tutoria"]; b <- d$nota[d$grupo == "control"]
dif <- mean(a) - mean(b)
d_cohen <- dif / sqrt((var(a) + var(b)) / 2)
c(diferencia = dif, d = d_cohen)


# ----------------------------------------------------------------------
# 2. Potencia
# ----------------------------------------------------------------------
# ¿Qué potencia tenía nuestro estudio (60 por grupo) para detectar 0,4 puntos con sd = 1,3?
power.t.test(n = 60, delta = 0.4, sd = 1.3)$power
# ¿Cuántas personas por grupo harían falta para una potencia del 80 %?
power.t.test(delta = 0.4, sd = 1.3, power = 0.8)$n


# ----------------------------------------------------------------------
# Ejercicio 5.1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
power.t.test(delta = 0.5, sd = 1.3, power = ______)$n


# ----------------------------------------------------------------------
# Ejercicio 5.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")
a <- d$horas[d$grupo == "tutoria"]; b <- d$horas[d$grupo == "control"]

# EJERCICIO: completa los huecos ______
(mean(a) - mean(b)) / sqrt((var(a) + ______) / 2)
