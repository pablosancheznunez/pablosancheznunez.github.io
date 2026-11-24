# Tema 12. Diseño equitativo, inclusivo y accesible
# Esquemas de página y prototipos de baja fidelidad
# Pablo Sánchez-Núñez (UC3M)
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-baja-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: comprobar los colores
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
revisar_paleta(paleta_ejemplo)[, c("nombre", "contraste", "texto_normal_AA", "componente_AA")]


# ----------------------------------------------------------------------
# Ejercicio 12.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
cumple_wcag("#f29900", "#ffffff", tipo = "______")


# ----------------------------------------------------------------------
# Ejercicio 12.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")

# EJERCICIO: completa los huecos ______
d <- simular_daltonismo(paleta_ejemplo[c("error", "exito")], tipo = "______")
d
distinguibles(d[1], d[2])
