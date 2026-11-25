# Capítulo 4. Consumir API académicas
# Programación para la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/programacion-investigacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Descarga de los datos del capítulo a la carpeta datos/
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/openalex_muestra.json")) download.file("https://pablosancheznunez.com/programacion-investigacion/datos/openalex_muestra.json", "datos/openalex_muestra.json", mode = "wb")


# ----------------------------------------------------------------------
# Ejercicio 4.3 · Autores por país (R)
# ----------------------------------------------------------------------
# (preparación del ejercicio)
oa <- jsonlite::fromJSON("datos/openalex_muestra.json", simplifyVector = FALSE)

# EJERCICIO: completa los huecos ______
tiene_pais <- function(trabajo, codigo) {
  paises <- unlist(lapply(trabajo$authorships, function(a) a$countries))
  codigo %in% paises
}
sum(sapply(oa$results, tiene_pais, codigo = "______"))
