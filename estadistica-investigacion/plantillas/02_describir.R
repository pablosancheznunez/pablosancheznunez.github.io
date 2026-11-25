# Capítulo 2. Describir y visualizar
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
# 1. Centro y dispersión
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
summary(d$nota)
c(media = mean(d$nota), desv_tipica = sd(d$nota), IQR = IQR(d$nota))
tapply(d$nota, d$grupo, median)   # mediana por grupo


# ----------------------------------------------------------------------
# 2. Mostrar los datos, no solo las medias
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
stripchart(nota ~ grupo, data = d, vertical = TRUE, method = "jitter", pch = 19,
           col = c("#eb6834", "#2a78d6"), ylab = "Nota", main = "Cada punto, una persona")
boxplot(nota ~ grupo, data = d, add = TRUE, outline = FALSE, col = NA, border = "grey40")


# ----------------------------------------------------------------------
# 3. Relaciones entre dos variables
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
plot(d$horas, d$nota, pch = 19, col = "#2a78d6", xlab = "Horas de estudio a la semana", ylab = "Nota")
cor(d$horas, d$nota)


# ----------------------------------------------------------------------
# Ejercicio 2.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")

# EJERCICIO: completa los huecos ______
tapply(d$horas, d$grupo, ______)


# ----------------------------------------------------------------------
# Ejercicio 2.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")

# EJERCICIO: completa los huecos ______
cor(d$ansiedad, d$______)
