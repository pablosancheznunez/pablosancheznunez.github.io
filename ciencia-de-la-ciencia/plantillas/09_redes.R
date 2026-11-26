# Capítulo 9. Redes y mapas de la ciencia
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
# Ejemplo resuelto: acoplamiento con datos reales
# ----------------------------------------------------------------------
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json", simplifyVector = FALSE)$trabajos
refs <- lapply(d, function(w) unlist(w$referencias))
n <- length(refs)
acopl <- matrix(0, n, n)
for (i in 1:(n - 1)) for (j in (i + 1):n)
  acopl[i, j] <- acopl[j, i] <- length(intersect(refs[[i]], refs[[j]]))
par_max <- which(acopl == max(acopl), arr.ind = TRUE)[1, ]
cat("Mayor acoplamiento:", max(acopl), "referencias compartidas\n")
cat(" -", d[[par_max[1]]]$titulo, "\n -", d[[par_max[2]]]$titulo, "\n")
c(densidad = round(mean(acopl[upper.tri(acopl)] > 0), 2))


# ----------------------------------------------------------------------
# Ejercicio 9.1 · Coautoría
# ----------------------------------------------------------------------
# (preparación del ejercicio)
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json", simplifyVector = FALSE)$trabajos

# EJERCICIO: completa los huecos ______
coautores <- list()
for (w in d) {
  ids <- unique(sapply(w$autores, `[[`, "id"))
  for (a in ids) coautores[[a]] <- union(coautores[[a]], setdiff(ids, a))
}
grado <- sapply(coautores, length)
______(grado)


# ----------------------------------------------------------------------
# Ejercicio 9.2 · Similitud del coseno
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
compartidas <- 6; n1 <- 20; n2 <- 45
round(compartidas / ______(n1 * n2), 3)
