# Capítulo 3. ETL: extraer, transformar y cargar
# Programación para la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/programacion-investigacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Descarga de los datos del capítulo a la carpeta datos/
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/openalex_muestra.json")) download.file("https://pablosancheznunez.com/programacion-investigacion/datos/openalex_muestra.json", "datos/openalex_muestra.json", mode = "wb")
if (!file.exists("datos/publicaciones.csv")) download.file("https://pablosancheznunez.com/programacion-investigacion/datos/publicaciones.csv", "datos/publicaciones.csv", mode = "wb")


# ----------------------------------------------------------------------
# Ejercicio 3.4 · Aplanar JSON (R)
# ----------------------------------------------------------------------
# (preparación del ejercicio)
library(jsonlite)
oa <- fromJSON("datos/openalex_muestra.json")

# EJERCICIO: completa los huecos ______
trabajos <- oa$results
sum(trabajos$open_access$______)
