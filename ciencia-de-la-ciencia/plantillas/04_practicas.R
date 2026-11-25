# Capítulo 4. Prácticas cuestionables y sesgos
# Investigación sobre la investigación
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24528120
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/ciencia-de-la-ciencia/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Ejercicio 4.1: dos variables dependientes
# ----------------------------------------------------------------------
# (preparación del ejercicio)
set.seed(1)
p_vd1 <- replicate(3000, t.test(rnorm(20), rnorm(20))$p.value)
p_vd2 <- replicate(3000, t.test(rnorm(20), rnorm(20))$p.value)

# EJERCICIO: completa los huecos ______
sale <- p_vd1 < 0.05 | p_vd2 < ______
mean(sale)
