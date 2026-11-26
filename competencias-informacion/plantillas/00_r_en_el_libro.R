# Usar R en este libro
# Competencias digitales para el uso de la información
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/competencias-informacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Cómo funcionan las celdas
# ----------------------------------------------------------------------
resultados <- 1250          # documentos que devuelve una búsqueda
pertinentes <- 37           # los que de verdad te sirven
pertinentes / resultados    # proporción

fuentes <- c("Dialnet", "Google Académico", "Scopus", "Wikipedia")
length(fuentes)                  # cuántos hay
"Scopus" %in% fuentes            # ¿está Scopus?
toupper(fuentes)                 # en mayúsculas


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
fuentes <- c("Dialnet", "Google Académico", "Scopus", "Wikipedia")

# EJERCICIO: completa los huecos ______
"______" %in% fuentes
