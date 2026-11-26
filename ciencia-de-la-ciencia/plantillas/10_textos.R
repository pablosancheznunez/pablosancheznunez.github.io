# Capítulo 10. Minería de textos, modelos de temas y modelos de lenguaje
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
# Ejemplo resuelto: términos más característicos de los títulos
# ----------------------------------------------------------------------
d <- jsonlite::fromJSON("datos/metaciencia_openalex.json")$trabajos
vacias <- c("the","of","and","a","in","to","for","on","with","an","is","are","from","by","at","as","how","what","do","can","its","we","not","be","or","their","does","why","using")
tokens <- lapply(tolower(d$titulo), function(t) {
  w <- unlist(strsplit(gsub("[^a-z ]", " ", t), " +"))
  w[nchar(w) > 2 & !w %in% vacias]
})
df <- table(unlist(lapply(tokens, unique)))     # en cuántos títulos aparece cada término
head(sort(df, decreasing = TRUE), 12)


# ----------------------------------------------------------------------
# Ejercicio 10.1 · tf-idf
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
tf <- 3; N <- 1000; df <- 5
round(tf * ______(N / df), 2)


# ----------------------------------------------------------------------
# Ejercicio 10.2 · Validar un clasificador
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
verdaderos_positivos <- 30; marcados <- 40; reales <- 50
precision <- verdaderos_positivos / marcados
exhaustividad <- verdaderos_positivos / ______
exhaustividad
