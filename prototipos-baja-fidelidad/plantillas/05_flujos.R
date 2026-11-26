# Tema 5. Flujos de usuario: modelado y representación
# Esquemas de página y prototipos de baja fidelidad
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24515131
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/prototipos-baja-fidelidad/
#
# Script con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.


# ----------------------------------------------------------------------
# Práctica en R: el embudo de un flujo de registro
# ----------------------------------------------------------------------
source("datos/funciones_ux.R")
e <- embudo(flujo_registro$paso, flujo_registro$usuarios)
e


# ----------------------------------------------------------------------
# Ejercicio 5.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")
e <- embudo(flujo_registro$paso, flujo_registro$usuarios)

# EJERCICIO: completa los huecos ______
e$paso[which.min(e$______)]


# ----------------------------------------------------------------------
# Ejercicio 5.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/funciones_ux.R")
e <- embudo(flujo_registro$paso, flujo_registro$usuarios)

# EJERCICIO: completa los huecos ______
e$acumulado[nrow(______)]
