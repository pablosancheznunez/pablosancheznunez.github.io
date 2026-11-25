# Usar R en este libro
# Ciencia de la ciencia y metaciencia
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/ciencia-de-la-ciencia/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Cómo funcionan las celdas
# ----------------------------------------------------------------------
citas <- c(45, 12, 8, 3, 0)  # citas de cinco artículos
sum(citas)                   # total
mean(citas)                  # media
median(citas)                # mediana: menos sensible a un artículo muy citado

bases <- c("Web of Science", "Scopus", "OpenAlex", "Dimensions")
length(bases)                    # cuántas hay
"OpenAlex" %in% bases            # ¿está OpenAlex?
sort(citas, decreasing = TRUE)   # citas de mayor a menor


# ----------------------------------------------------------------------
# Ejercicio 1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
pertinentes <- 24
resultados <- ______
pertinentes / resultados


# ----------------------------------------------------------------------
# Ejercicio 2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bases <- c("Web of Science", "Scopus", "OpenAlex", "Dimensions")

# EJERCICIO: completa los huecos ______
"______" %in% bases
