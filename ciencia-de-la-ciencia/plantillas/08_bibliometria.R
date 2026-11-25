# Capítulo 8. Bibliometría e indicadores
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
# Ejemplo resuelto: recuento fraccionario por país
# ----------------------------------------------------------------------
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json", simplifyVector = FALSE)$trabajos
credito <- list()
for (w in d) {
  autores <- Filter(function(a) length(a$paises) > 0, w$autores)
  for (a in autores) for (p in a$paises)          # cada autor reparte su parte entre sus países
    credito[[p]] <- c(credito[[p]], 1 / length(autores) / length(a$paises))
}
frac <- sort(sapply(credito, sum), decreasing = TRUE)
completo <- sort(table(unlist(lapply(d, function(w) unique(unlist(lapply(w$autores, `[[`, "paises")))))), decreasing = TRUE)
head(round(frac, 1), 6)
head(completo, 6)


# ----------------------------------------------------------------------
# Ejercicio 8.1 · Recuento fraccionario
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
autores <- c("A", "A", "A", "B", "B")
sum(autores == "A") / ______(autores)


# ----------------------------------------------------------------------
# Ejercicio 8.2 · MNCS
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
citas <- c(12, 30, 5)
media_campo <- c(4, 40, 10)
mean(citas / ______)


# ----------------------------------------------------------------------
# Ejercicio 8.3 · Percentiles con datos reales
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json")$trabajos

# EJERCICIO: completa los huecos ______
unname(quantile(d$citas, ______))
