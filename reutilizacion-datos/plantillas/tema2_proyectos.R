# Tema 2. Proyectos relevantes de reutilización de datos abiertos
# Reutilización de datos abiertos y documentos: tutoriales interactivos en R
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24500934
# Licencia del código: MIT · Libro: https://pablosancheznunez.com/reutilizacion-datos/
#
# Script limpio con todo el código del capítulo, para ejecutarlo en RStudio o Positron.
# Los ejercicios tienen huecos (______): complétalos y compara con el libro.

# Paquete necesario (solo la primera vez):
# install.packages("jsonlite")

# Descarga del CSV de práctica a la carpeta datos/
url_csv <- "https://pablosancheznunez.com/reutilizacion-datos/datos/prestamos_bibliotecas_practica.csv"
dir.create("datos", showWarnings = FALSE)
if (!file.exists("datos/prestamos_bibliotecas_practica.csv")) {
  download.file(url_csv, "datos/prestamos_bibliotecas_practica.csv", mode = "wb")
}


# ----------------------------------------------------------------------
# Paso 1. Clasificar casos de reutilización (apartado 4)
# ----------------------------------------------------------------------
casos <- data.frame(
  caso = c("App de horarios de bibliotecas", "Mapa de wifi público", "Visor de presupuestos municipales",
           "Recomendador de lecturas", "Estudio de brecha digital", "Alertas de calidad del aire",
           "Buscador de ayudas públicas", "Reportaje sobre contratos", "Panel de préstamos regionales",
           "Planificador de rutas accesibles", "Análisis de citas a datasets", "Catálogo enriquecido con Wikidata"),
  usuario = c("Desarrolladores", "Empresas", "Ciudadanía", "Empresas", "Investigadores", "Desarrolladores",
              "Empresas", "Periodistas", "Administraciones", "Ciudadanía", "Investigadores", "Administraciones"),
  utilizacion = c("Servicio", "Servicio", "Visualización", "Servicio", "Análisis", "Servicio",
                  "Servicio", "Fiscalización", "Visualización", "Servicio", "Análisis", "Servicio"),
  efecto = c("Social", "Económico", "Buen gobierno", "Económico", "Social", "Social",
             "Económico", "Buen gobierno", "Buen gobierno", "Social", "Social", "Social"),
  ambito = c("Local", "Local", "Local", "Nacional", "Nacional", "Local",
             "Nacional", "Nacional", "Autonómico", "Local", "Europeo", "Autonómico")
)
casos[, c("caso", "usuario", "efecto")]


# ----------------------------------------------------------------------
# Paso 2. Contar con `table()`
# ----------------------------------------------------------------------
table(casos$efecto)
round(100 * prop.table(table(casos$efecto)), 1)

table(casos$usuario, casos$efecto)

barplot(sort(table(casos$usuario), decreasing = TRUE),
        las = 2, col = "#000e78", ylab = "Casos", cex.names = 0.8,
        main = "Casos por tipo de usuario")


# ----------------------------------------------------------------------
# Ejercicio 2.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
casos <- data.frame(
  usuario = c("Desarrolladores", "Empresas", "Ciudadanía", "Empresas", "Investigadores", "Desarrolladores",
              "Empresas", "Periodistas", "Administraciones", "Ciudadanía", "Investigadores", "Administraciones"),
  efecto = c("Social", "Económico", "Buen gobierno", "Económico", "Social", "Social",
             "Económico", "Buen gobierno", "Buen gobierno", "Social", "Social", "Social")
)

# EJERCICIO: completa los huecos ______
porcentajes <- round(100 * prop.table(table(casos$efecto)), 1)
porcentajes[______]


# ----------------------------------------------------------------------
# Ejercicio 2.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
casos <- data.frame(
  usuario = c("Desarrolladores", "Empresas", "Ciudadanía", "Empresas", "Investigadores", "Desarrolladores",
              "Empresas", "Periodistas", "Administraciones", "Ciudadanía", "Investigadores", "Administraciones"),
  efecto = c("Social", "Económico", "Buen gobierno", "Económico", "Social", "Social",
             "Económico", "Buen gobierno", "Buen gobierno", "Social", "Social", "Social")
)

# EJERCICIO: completa los huecos ______
nrow(subset(casos, usuario == "Empresas" ______ efecto == "Económico"))


# ----------------------------------------------------------------------
# Ejercicio 2.3 (sin corrección automática, apartado 2)
# ----------------------------------------------------------------------
dimensiones <- c("Políticas", "Impacto", "Portal", "Calidad")
espana <- c(NA, NA, NA, NA)   # escribe aquí las puntuaciones de España (en %)
media  <- c(NA, NA, NA, NA)   # y aquí las de la media de los 36 países
diferencia <- espana - media
data.frame(dimensiones, espana, media, diferencia)


# ----------------------------------------------------------------------
# Paso 3. Autoevaluación FAIR de un registro de datos (apartado 6)
# ----------------------------------------------------------------------
evaluar_fair <- function(registro) {
  c(F = registro$identificador_persistente && registro$metadatos_descriptivos,
    A = registro$acceso_por_protocolo_abierto,
    I = registro$formato_abierto && registro$vocabulario_comun,
    R = registro$licencia_declarada && registro$procedencia_documentada)
}

registro_zenodo <- list(
  identificador_persistente = TRUE,   # DOI
  metadatos_descriptivos = TRUE,
  acceso_por_protocolo_abierto = TRUE, # HTTPS
  formato_abierto = TRUE,              # CSV
  vocabulario_comun = FALSE,           # columnas sin definir con un vocabulario
  licencia_declarada = TRUE,           # CC BY 4.0
  procedencia_documentada = TRUE       # README con método de obtención
)
evaluar_fair(registro_zenodo)


# ----------------------------------------------------------------------
# Ejercicio 2.4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
evaluar_fair <- function(registro) {
  c(F = registro$identificador_persistente && registro$metadatos_descriptivos,
    A = registro$acceso_por_protocolo_abierto,
    I = registro$formato_abierto && registro$vocabulario_comun,
    R = registro$licencia_declarada && registro$procedencia_documentada)
}

# EJERCICIO: completa los huecos ______
registro_web <- list(
  identificador_persistente = ______,
  metadatos_descriptivos = TRUE,
  acceso_por_protocolo_abierto = TRUE,
  formato_abierto = TRUE,
  vocabulario_comun = TRUE,
  licencia_declarada = ______,
  procedencia_documentada = ______
)
sum(evaluar_fair(registro_web))


# ----------------------------------------------------------------------
# Ejercicio 2.5
# ----------------------------------------------------------------------
# (preparación del ejercicio)
casos <- data.frame(
  usuario = c("Desarrolladores", "Empresas", "Ciudadanía", "Empresas", "Investigadores", "Desarrolladores",
              "Empresas", "Periodistas", "Administraciones", "Ciudadanía", "Investigadores", "Administraciones"),
  ambito = c("Local", "Local", "Local", "Nacional", "Nacional", "Local",
             "Nacional", "Nacional", "Autonómico", "Local", "Europeo", "Autonómico")
)

# EJERCICIO: completa los huecos ______
names(which.max(table(casos$______)))


# ----------------------------------------------------------------------
# Paso 4. Consultar el catálogo nacional en directo (apartado 1)
# ----------------------------------------------------------------------
url_api <- "https://datos.gob.es/apidata/catalog/dataset/title/bibliotecas.json?_pageSize=50"
respuesta <- tryCatch({
  con <- url(url_api, encoding = "UTF-8")
  texto <- paste(readLines(con, warn = FALSE), collapse = "\n")
  close(con)
  jsonlite::fromJSON(texto, simplifyVector = FALSE)
}, error = function(e) NULL)
if (is.null(respuesta)) {
  message("Sin conexión con datos.gob.es: uso la copia del 24/11/2026.")
  respuesta <- jsonlite::fromJSON("datos/datosgob_bibliotecas.json", simplifyVector = FALSE)
}
items <- respuesta$result$items
length(items)
str(items[[1]][c("title", "publisher")], max.level = 2)

source("datos/datareuseR.R")
tabla <- tabla_datosgob(items)
head(tabla[, c("titulo", "formatos")], 8)
sort(table(unlist(lapply(items, formatos_de))), decreasing = TRUE)


# ----------------------------------------------------------------------
# Ejercicio 2.6
# ----------------------------------------------------------------------
# (preparación del ejercicio)
source("datos/datareuseR.R")
items <- consultar_datosgob("bibliotecas", n = 50)

# EJERCICIO: completa los huecos ______
tiene_csv <- sapply(items, function(it) "______" %in% formatos_de(it))
sum(tiene_csv)


# ----------------------------------------------------------------------
# Reto del Tema 2 · Radiografía de un tema en el catálogo nacional
# ----------------------------------------------------------------------
source("datos/datareuseR.R")
palabra <- "archivos"   # cámbiala por tu tema
items <- consultar_datosgob(palabra, n = 50, copia = FALSE)
tabla <- tabla_datosgob(items)
length(items)
head(sort(table(tabla$publicador), decreasing = TRUE))
formatos <- sort(table(unlist(lapply(items, formatos_de))), decreasing = TRUE)
barplot(formatos, las = 2, col = "#2a78d6", border = NA, ylab = "Conjuntos")
