# Tema 0. Introducción a los datos abiertos y la reutilización de la información
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
# Paso 1. Cargar y describir el fichero
# ----------------------------------------------------------------------
prestamos_df <- read.csv("datos/prestamos_bibliotecas_practica.csv")
dim(prestamos_df)        # filas y columnas
names(prestamos_df)      # nombres de las columnas
head(prestamos_df, 3)


# ----------------------------------------------------------------------
# Paso 2. Comprobar la licencia
# ----------------------------------------------------------------------
licencias_abiertas <- c("CC0 1.0", "CC BY 4.0", "CC BY-SA 4.0", "ODbL 1.0", "ODC-BY 1.0", "PDDL 1.0")
licencia_csv <- "CC BY 4.0"
licencia_csv %in% licencias_abiertas


# ----------------------------------------------------------------------
# Paso 3. Calcular las estrellas
# ----------------------------------------------------------------------
estrellas <- function(licencia_abierta, estructurado, no_propietario, usa_uri, enlazado) {
  criterios <- c(licencia_abierta, estructurado, no_propietario, usa_uri, enlazado)
  if (!criterios[1]) return(0)
  # cuenta los TRUE consecutivos desde el principio
  sum(cumprod(criterios))
}

# Un Excel con licencia abierta:
estrellas(TRUE, TRUE, FALSE, FALSE, FALSE)


# ----------------------------------------------------------------------
# Ejercicio 0.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
estrellas <- function(licencia_abierta, estructurado, no_propietario, usa_uri, enlazado) {
  criterios <- c(licencia_abierta, estructurado, no_propietario, usa_uri, enlazado)
  if (!criterios[1]) return(0)
  sum(cumprod(criterios))
}

# EJERCICIO: completa los huecos ______
estrellas(
  licencia_abierta = ______,
  estructurado     = ______,
  no_propietario   = ______,
  usa_uri          = ______,
  enlazado         = ______
)


# ----------------------------------------------------------------------
# Paso 4. Auditar un catálogo
# ----------------------------------------------------------------------
catalogo <- data.frame(
  conjunto = c("Préstamos mensuales", "Horarios", "Memoria anual", "Catálogo de fondos",
               "Visitas por sede", "Encuestas de satisfacción", "Agenda cultural", "Sedes"),
  formato  = c("CSV", "XLSX", "PDF", "RDF", "CSV", "XLSX", "JSON", "RDF"),
  licencia = c("CC BY 4.0", "CC BY-NC 4.0", "CC BY 4.0", "CC0 1.0",
               "Sin licencia", "CC BY-ND 4.0", "CC BY 4.0", "ODbL 1.0")
)
catalogo


# ----------------------------------------------------------------------
# Ejercicio 0.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
licencias_abiertas <- c("CC0 1.0", "CC BY 4.0", "CC BY-SA 4.0", "ODbL 1.0", "ODC-BY 1.0", "PDDL 1.0")
catalogo <- data.frame(
  conjunto = c("Préstamos mensuales", "Horarios", "Memoria anual", "Catálogo de fondos",
               "Visitas por sede", "Encuestas de satisfacción", "Agenda cultural", "Sedes"),
  formato  = c("CSV", "XLSX", "PDF", "RDF", "CSV", "XLSX", "JSON", "RDF"),
  licencia = c("CC BY 4.0", "CC BY-NC 4.0", "CC BY 4.0", "CC0 1.0",
               "Sin licencia", "CC BY-ND 4.0", "CC BY 4.0", "ODbL 1.0")
)

# EJERCICIO: completa los huecos ______
sum(catalogo$licencia ______ licencias_abiertas)


# ----------------------------------------------------------------------
# Ejercicio 0.3
# ----------------------------------------------------------------------
# (preparación del ejercicio)
licencias_abiertas <- c("CC0 1.0", "CC BY 4.0", "CC BY-SA 4.0", "ODbL 1.0", "ODC-BY 1.0", "PDDL 1.0")
catalogo <- data.frame(
  conjunto = c("Préstamos mensuales", "Horarios", "Memoria anual", "Catálogo de fondos",
               "Visitas por sede", "Encuestas de satisfacción", "Agenda cultural", "Sedes"),
  formato  = c("CSV", "XLSX", "PDF", "RDF", "CSV", "XLSX", "JSON", "RDF"),
  licencia = c("CC BY 4.0", "CC BY-NC 4.0", "CC BY 4.0", "CC0 1.0",
               "Sin licencia", "CC BY-ND 4.0", "CC BY 4.0", "ODbL 1.0")
)

# EJERCICIO: completa los huecos ______
seleccion <- subset(catalogo,
                    licencia %in% licencias_abiertas & formato %in% ______)
seleccion$conjunto


# ----------------------------------------------------------------------
# Paso 5. Formatos abiertos y propietarios
# ----------------------------------------------------------------------
formatos <- data.frame(
  formato = c("CSV", "JSON", "XML", "RDF", "ODS", "XLSX", "XLS", "PDF", "DOCX"),
  abierto = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, NA),
  legible_maquina = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)
)
formatos


# ----------------------------------------------------------------------
# Ejercicio 0.4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
formatos <- data.frame(
  formato = c("CSV", "JSON", "XML", "RDF", "ODS", "XLSX", "XLS", "PDF", "DOCX"),
  abierto = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, NA),
  legible_maquina = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)
)

# EJERCICIO: completa los huecos ______
subset(formatos, abierto ______ legible_maquina)$formato


# ----------------------------------------------------------------------
# Ejercicio 0.5
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
casos <- c(
  "Horarios de la red municipal de bibliotecas en CSV con CC BY 4.0",
  "Listado de socios con nombre y domicilio que custodia la biblioteca",
  "Mapa colaborativo OpenStreetMap (ODbL)",
  "Estadísticas internas de ventas de una distribuidora de libros"
)
respuesta <- c(______, ______, ______, ______)
respuesta


# ----------------------------------------------------------------------
# Reto del Tema 0 · Auditoría de apertura
# ----------------------------------------------------------------------
source("datos/datareuseR.R")
auditoria <- data.frame(
  conjunto         = c("", "", ""),
  url              = c("", "", ""),
  licencia_abierta = c(NA, NA, NA),
  estructurado     = c(NA, NA, NA),
  no_propietario   = c(NA, NA, NA),
  usa_uri          = c(NA, NA, NA),
  enlazado         = c(NA, NA, NA)
)
# Cuando completes la tabla con TRUE y FALSE, quita los # de las líneas siguientes:
# auditoria$estrellas <- mapply(estrellas, auditoria$licencia_abierta, auditoria$estructurado,
#                               auditoria$no_propietario, auditoria$usa_uri, auditoria$enlazado)
# auditoria[, c("conjunto", "estrellas")]
