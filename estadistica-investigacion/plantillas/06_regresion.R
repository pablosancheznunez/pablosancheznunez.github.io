# Capítulo 6. Regresión
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
# 1. La recta que mejor se ajusta
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
m1 <- lm(nota ~ horas, data = d)
summary(m1)$coefficients
confint(m1)
plot(d$horas, d$nota, pch = 19, col = "#2a78d6", xlab = "Horas de estudio", ylab = "Nota")
abline(m1, col = "#eb6834", lwd = 2)


# ----------------------------------------------------------------------
# 2. Varios predictores a la vez
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
d$horas_c <- d$horas - mean(d$horas)      # centrar
d$sueno_c <- d$sueno - mean(d$sueno)
d$ansiedad_c <- d$ansiedad - mean(d$ansiedad)
m2 <- lm(nota ~ grupo + horas_c + sueno_c + ansiedad_c, data = d)
round(summary(m2)$coefficients, 3)
summary(m2)$r.squared


# ----------------------------------------------------------------------
# 3. Comprobar los supuestos
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
m1 <- lm(nota ~ horas, data = d)
par(mfrow = c(1, 2))
plot(fitted(m1), resid(m1), pch = 19, col = "#2a78d6", xlab = "Valores ajustados", ylab = "Residuos"); abline(h = 0, lty = 2)
qqnorm(resid(m1), pch = 19, col = "#2a78d6"); qqline(resid(m1))


# ----------------------------------------------------------------------
# Ejercicio 6.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")
m1 <- lm(nota ~ horas, data = d)

# EJERCICIO: completa los huecos ______
predict(m1, newdata = data.frame(horas = ______))


# ----------------------------------------------------------------------
# Ejercicio 6.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")

# EJERCICIO: completa los huecos ______
m <- lm(nota ~ horas + ______, data = d)
summary(m)$r.squared
