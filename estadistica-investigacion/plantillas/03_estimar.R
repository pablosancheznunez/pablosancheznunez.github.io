# Capítulo 3. Estimar con incertidumbre
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
# Interpretaciones erróneas frecuentes
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
t.test(d$nota)$conf.int                       # IC 95 % de la nota media
t.test(nota ~ grupo, data = d)$conf.int       # IC 95 % de la diferencia (control − tutoría)


# ----------------------------------------------------------------------
# 3. Remuestreo: el *bootstrap*
# ----------------------------------------------------------------------
d <- read.csv("datos/estudio.csv")
set.seed(1)
medianas <- replicate(2000, median(sample(d$nota, replace = TRUE)))
quantile(medianas, c(0.025, 0.975))    # IC 95 % bootstrap de la mediana


# ----------------------------------------------------------------------
# Ejercicio 3.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")

# EJERCICIO: completa los huecos ______
sd(d$nota) / ______(nrow(d))


# ----------------------------------------------------------------------
# Ejercicio 3.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- read.csv("datos/estudio.csv")

# EJERCICIO: completa los huecos ______
t.test(d$nota, conf.level = ______)$conf.int
