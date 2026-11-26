# Capítulo 4. Contrastes y valores *p*
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
# 4. Contrastes básicos en R
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
t.test(nota ~ grupo, data = d)


# ----------------------------------------------------------------------
# 5. Muchas pruebas, muchos falsos positivos
# ----------------------------------------------------------------------
p <- c(0.001, 0.012, 0.03, 0.04, 0.2)
p.adjust(p, method = "holm")
p.adjust(p, method = "BH")   # tasa de falsos descubrimientos


# ----------------------------------------------------------------------
# Ejercicio 4.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")

# EJERCICIO: completa los huecos ______
cor.test(d$ansiedad, d$nota)$______


# ----------------------------------------------------------------------
# Ejercicio 4.2
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
1 - (1 - 0.05)^______
