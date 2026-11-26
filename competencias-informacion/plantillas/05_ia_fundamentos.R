# Unidades 6 y 7. Inteligencia artificial generativa: fundamentos y aplicaciones
# Competencias digitales para el uso de la información
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/competencias-informacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: verificar referencias contra una base de datos
# ----------------------------------------------------------------------
doi_ia <- c("10.1108/eb024320", "10.1016/j.ipm.2019.102041", "10.1038/s41598-023-41032-5",
            "10.1177/0165551508095781", "10.1093/jis/abc123")
base_datos <- c("10.1108/eb024320", "10.1038/s41598-023-41032-5", "10.1177/0165551508095781",
                "10.1016/j.pragma.2013.07.012", "10.1145/1121949.1121979")
doi_ia %in% base_datos


# ----------------------------------------------------------------------
# Ejercicio 6.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
doi_ia <- c("10.1108/eb024320", "10.1016/j.ipm.2019.102041", "10.1038/s41598-023-41032-5",
            "10.1177/0165551508095781", "10.1093/jis/abc123")
base_datos <- c("10.1108/eb024320", "10.1038/s41598-023-41032-5", "10.1177/0165551508095781",
                "10.1016/j.pragma.2013.07.012", "10.1145/1121949.1121979")

# EJERCICIO: completa los huecos ______
mean(!(doi_ia %in% ______))
