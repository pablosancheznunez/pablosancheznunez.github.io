# Tema 9. Prototipos en papel: técnicas y validación temprana
# Esquemas de página y prototipos de baja fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24515131
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-baja-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: comparar dos prototipos
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
aggregate(exito ~ prototipo + tarea, data = sesiones_prueba, FUN = sum)


# ----------------------------------------------------------------------
# Ejercicio 9.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
d <- subset(sesiones_prueba, prototipo == "______" & tarea == "Reservar una sala")
tasa_exito(sum(d$exito), nrow(d))


# ----------------------------------------------------------------------
# Ejercicio 9.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
d <- subset(sesiones_prueba, prototipo == "papel" & tarea == "Renovar un préstamo")
______(d$tiempo_s)
