# Capítulo 3. La crisis de reproducibilidad
# Ciencia de la ciencia y metaciencia
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/ciencia-de-la-ciencia/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# 5. Calcular con R
# ----------------------------------------------------------------------
vpp <- function(R, potencia, alfa = 0.05) (potencia * R) / (potencia * R + alfa)
vpp(R = 0.1 / 0.9, potencia = 0.8)   # 10 % de hipótesis verdaderas, potencia alta
vpp(R = 0.1 / 0.9, potencia = 0.2)   # la misma probabilidad previa, potencia baja


# ----------------------------------------------------------------------
# Ejercicio 3.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
vpp <- function(R, potencia, alfa = 0.05) (potencia * R) / (potencia * R + alfa)

# EJERCICIO: completa los huecos ______
vpp(R = 1 / 19, potencia = ______)


# ----------------------------------------------------------------------
# Ejercicio 3.2: la maldición del ganador
# ----------------------------------------------------------------------
# (preparación del ejercicio)
set.seed(42)
n <- 20; d_real <- 0.2
estudios <- replicate(2000, {
  a <- rnorm(n, 0, 1); b <- rnorm(n, d_real, 1)
  c(d = (mean(b) - mean(a)) / sqrt((var(a) + var(b)) / 2), p = t.test(b, a)$p.value)
})
estudios <- as.data.frame(t(estudios))

# EJERCICIO: completa los huecos ______
significativos <- estudios[estudios$p < 0.05, ]
nrow(significativos) / nrow(estudios)    # potencia observada
mean(significativos$______)              # efecto medio publicado
