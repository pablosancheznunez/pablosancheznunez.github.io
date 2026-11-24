# Primeros pasos con R
# Reutilización de datos abiertos y documentos: tutoriales interactivos en R
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24500934
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/reutilizacion-datos/
#
# Script limpio con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Descarga del CSV de práctica a la carpeta datos/
url_csv <- "https://pablosancheznunez.com/reutilizacion-datos/datos/prestamos_bibliotecas_practica.csv"
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/prestamos_bibliotecas_practica.csv")) {
  download.file(url_csv, "datos/prestamos_bibliotecas_practica.csv", mode = "wb")
}


# ----------------------------------------------------------------------
# R como calculadora
# ----------------------------------------------------------------------
2637 + 2626 + 2374


# ----------------------------------------------------------------------
# Objetos: guardar un valor con un nombre
# ----------------------------------------------------------------------
prestamos_enero <- 2637
prestamos_febrero <- 2626
prestamos_enero + prestamos_febrero


# ----------------------------------------------------------------------
# Vectores: varios valores del mismo tipo
# ----------------------------------------------------------------------
prestamos <- c(2637, 2626, 2374, 2227, 2656, 2319)
sum(prestamos)
mean(prestamos)
length(prestamos)

municipios <- c("Getafe", "Leganés", "Alcorcón")
toupper(municipios)


# ----------------------------------------------------------------------
# Ejercicio 1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
prestamos <- c(2637, 2626, 2374, 2227, 2656, 2319)

# EJERCICIO: completa los huecos ______
______(prestamos)


# ----------------------------------------------------------------------
# Comparaciones y valores lógicos
# ----------------------------------------------------------------------
prestamos > 2500
sum(prestamos > 2500)

licencias <- c("CC BY 4.0", "CC BY-NC 4.0", "CC0 1.0")
licencias %in% c("CC BY 4.0", "CC0 1.0")


# ----------------------------------------------------------------------
# Ejercicio 2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
prestamos <- c(2637, 2626, 2374, 2227, 2656, 2319)

# EJERCICIO: completa los huecos ______
sum(prestamos ______ 2400)


# ----------------------------------------------------------------------
# Tablas de datos (*data frames*)
# ----------------------------------------------------------------------
bibliotecas <- data.frame(
  nombre = c("Centro", "Sur", "Norte"),
  municipio = c("Getafe", "Getafe", "Leganés"),
  prestamos = c(14839, 15319, 7547)
)
bibliotecas
bibliotecas$prestamos
nrow(bibliotecas)

subset(bibliotecas, municipio == "Getafe")


# ----------------------------------------------------------------------
# Ejercicio 4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
bibliotecas <- data.frame(
  nombre = c("Centro", "Sur", "Norte"),
  municipio = c("Getafe", "Getafe", "Leganés"),
  prestamos = c(14839, 15319, 7547)
)

# EJERCICIO: completa los huecos ______
sum(subset(bibliotecas, municipio == ______)$prestamos)


# ----------------------------------------------------------------------
# Leer un fichero CSV
# ----------------------------------------------------------------------
prestamos_df <- read.csv("datos/prestamos_bibliotecas_practica.csv")
head(prestamos_df)
str(prestamos_df)


# ----------------------------------------------------------------------
# Ejercicio 3
# ----------------------------------------------------------------------
# (preparación del ejercicio)
prestamos_df <- read.csv("datos/prestamos_bibliotecas_practica.csv")

# EJERCICIO: completa los huecos ______
______(prestamos_df)


# ----------------------------------------------------------------------
# Ejercicio 5
# ----------------------------------------------------------------------
# (preparación del ejercicio)
prestamos_df <- read.csv("datos/prestamos_bibliotecas_practica.csv")

# EJERCICIO: completa los huecos ______
______(unique(prestamos_df$biblioteca))
