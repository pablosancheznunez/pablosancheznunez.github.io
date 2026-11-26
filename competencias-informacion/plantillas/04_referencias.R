# Unidades 4 y 5. Referencias bibliográficas
# Competencias digitales para el uso de la información
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/competencias-informacion/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: componer y ordenar referencias
# ----------------------------------------------------------------------
autores <- "Bates, M. J."
anio <- 1989
titulo <- "The design of browsing and berrypicking techniques for the online search interface"
revista <- "Online Review"; volumen <- 13; numero <- 5; paginas <- "407-424"
doi <- "10.1108/eb024320"
paste0(autores, " (", anio, "). ", titulo, ". ", revista, ", ", volumen, "(", numero, "), ",
       paginas, ". https://doi.org/", doi)


# ----------------------------------------------------------------------
# Ejercicio 4.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
refs <- c("Pennycook, G., & Rand, D. G. (2021). The psychology of fake news.",
          "Bates, M. J. (1989). The design of browsing and berrypicking techniques.",
          "Metzger, M. J., & Flanagin, A. J. (2013). Credibility and trust of information.",
          "Bawden, D., & Robinson, L. (2009). The dark side of information.")

# EJERCICIO: completa los huecos ______
ordenadas <- ______(refs)
ordenadas[1]
