# Capítulo 7. Fuentes de datos e infraestructuras
# Investigación sobre la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24528120
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/ciencia-de-la-ciencia/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Descarga de los datos del capítulo a la carpeta datos/
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/metaciencia_openalex.json")) download.file("https://pablosancheznunez.com/ciencia-de-la-ciencia/datos/metaciencia_openalex.json", "datos/metaciencia_openalex.json", mode = "wb")


# ----------------------------------------------------------------------
# Ejemplo resuelto: explorar una muestra de OpenAlex
# ----------------------------------------------------------------------
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json")$trabajos
nrow(d)
table(d$campo)                      # campo científico principal (clasificación de OpenAlex)
summary(d$citas)                    # distribución de citas: muy asimétrica
n_autores <- sapply(d$autores, nrow)
c(media = mean(n_autores), mediana = median(n_autores))


# ----------------------------------------------------------------------
# Ejercicio 7.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json")$trabajos

# EJERCICIO: completa los huecos ______
tab <- table(d$anio)
names(tab)[which.______(tab)]


# ----------------------------------------------------------------------
# Ejercicio 7.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json", simplifyVector = FALSE)$trabajos

# EJERCICIO: completa los huecos ______
otro_pais <- sapply(d, function(w) {
  paises <- unlist(lapply(w$autores, function(a) a$paises))
  any(paises != "______")
})
round(mean(otro_pais), 2)
