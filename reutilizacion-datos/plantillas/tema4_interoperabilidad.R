# Tema 4. Normalización e interoperabilidad
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
# Paso 1. Generar XML (apartado 4)
# ----------------------------------------------------------------------
cargar_limpio <- function() {
  b <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
  b <- b[!duplicated(b), ]
  clave <- chartr("áéíóúüñ", "aeiouun", tolower(trimws(b$municipio)))
  b$municipio <- unname(c(getafe = "Getafe", leganes = "Leganés", alcorcon = "Alcorcón",
                          mostoles = "Móstoles", fuenlabrada = "Fuenlabrada")[clave])
  es_dmy <- grepl("/", b$fecha)
  f <- as.Date(b$fecha, "%Y-%m-%d"); f[es_dmy] <- as.Date(b$fecha[es_dmy], "%d/%m/%Y")
  b$fecha <- format(f)
  for (v in c("prestamos", "usuarios_activos"))
    b[[v]] <- as.numeric(ifelse(b[[v]] %in% c("", "n/d"), NA, b[[v]]))
  b$prestamos[which(b$prestamos < 0)] <- NA
  b
}
limpio <- cargar_limpio()

a_xml <- function(d) {
  filas <- sprintf(
    '  <registro>\n    <biblioteca>%s</biblioteca>\n    <municipio>%s</municipio>\n    <fecha>%s</fecha>\n    <prestamos>%s</prestamos>\n  </registro>',
    d$biblioteca, d$municipio, d$fecha, ifelse(is.na(d$prestamos), "", d$prestamos))
  paste0('<?xml version="1.0" encoding="UTF-8"?>\n<prestamos_bibliotecas>\n',
         paste(filas, collapse = "\n"), '\n</prestamos_bibliotecas>')
}
xml <- a_xml(limpio)
cat(substr(xml, 1, 520))

contar <- function(texto, patron) lengths(regmatches(texto, gregexpr(patron, texto, fixed = TRUE)))
c(abren = contar(xml, "<registro>"), cierran = contar(xml, "</registro>"))


# ----------------------------------------------------------------------
# Ejercicio 4.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
b <- read.csv("datos/prestamos_bibliotecas_practica.csv", colClasses = "character")
b <- b[!duplicated(b), ]
p <- suppressWarnings(as.numeric(ifelse(b$prestamos %in% c("", "n/d"), NA, b$prestamos)))
p[which(p < 0)] <- NA
xml <- paste0("<prestamos_bibliotecas>",
              paste0("<registro><prestamos>", ifelse(is.na(p), "", p), "</prestamos></registro>", collapse = ""),
              "</prestamos_bibliotecas>")
contar <- function(texto, patron) lengths(regmatches(texto, gregexpr(patron, texto, fixed = TRUE)))

# EJERCICIO: completa los huecos ______
contar(xml, "______")


# ----------------------------------------------------------------------
# Paso 2. De CSV a JSON (apartado 4)
# ----------------------------------------------------------------------
cat(jsonlite::toJSON(head(limpio, 2), pretty = TRUE))


# ----------------------------------------------------------------------
# Paso 3. JSON-LD con schema.org (apartados 4 y 6)
# ----------------------------------------------------------------------
wikidata <- c(Getafe = "Q8802", "Leganés" = "Q77433", "Alcorcón" = "Q10372",
              "Móstoles" = "Q187826", Fuenlabrada = "Q54902")

bibliotecas <- unique(limpio[, c("biblioteca", "municipio")])
bibliotecas$id <- paste0("https://ejemplo.org/biblioteca/",
                         gsub(" ", "-", tolower(sub("Biblioteca Municipal ", "", bibliotecas$biblioteca))))
bibliotecas

a_jsonld <- function(fila) {
  list(
    "@context" = "https://schema.org/",
    "@type" = "Library",
    "@id" = fila$id,
    "name" = fila$biblioteca,
    "containedInPlace" = list(
      "@id" = paste0("http://www.wikidata.org/entity/", wikidata[[fila$municipio]]),
      "name" = fila$municipio
    )
  )
}
cat(jsonlite::toJSON(a_jsonld(bibliotecas[1, ]), auto_unbox = TRUE, pretty = TRUE))


# ----------------------------------------------------------------------
# Paso 4. Turtle (apartado 5)
# ----------------------------------------------------------------------
plantilla <- '@prefix schema: <https://schema.org/> .
@prefix wd: <http://www.wikidata.org/entity/> .

<%s> a schema:Library ;
    schema:name "%s"@es ;
    schema:containedInPlace wd:%s .'

b <- bibliotecas[1, ]
cat(sprintf(plantilla, b$id, b$biblioteca, wikidata[[b$municipio]]))


# ----------------------------------------------------------------------
# Ejercicio 4.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
wikidata <- c(Getafe = "Q8802", "Leganés" = "Q77433", "Alcorcón" = "Q10372",
              "Móstoles" = "Q187826", Fuenlabrada = "Q54902")

# EJERCICIO: completa los huecos ______
ttl <- '@prefix schema: <https://schema.org/> .
@prefix wd: <http://www.wikidata.org/entity/> .

<https://ejemplo.org/biblioteca/norte> a schema:______ ;
    schema:name "Biblioteca Municipal Norte"@es ;
    schema:containedInPlace wd:______ .'
cat(ttl)
ttl


# ----------------------------------------------------------------------
# Paso 5. Consultas sobre un grafo (apartado 5)
# ----------------------------------------------------------------------
grafo <- read.table(header = TRUE, stringsAsFactors = FALSE, text = '
s                p                          o
ex:centro        rdf:type                   schema:Library
ex:centro        schema:containedInPlace    wd:Q8802
ex:sur           rdf:type                   schema:Library
ex:sur           schema:containedInPlace    wd:Q8802
ex:norte         rdf:type                   schema:Library
ex:norte         schema:containedInPlace    wd:Q77433
ex:parque        rdf:type                   schema:Library
ex:parque        schema:containedInPlace    wd:Q10372
ex:act1          rdf:type                   schema:Event
ex:act1          schema:location            ex:centro
ex:act1          schema:about               "Club de lectura"
ex:act2          rdf:type                   schema:Event
ex:act2          schema:location            ex:centro
ex:act2          schema:about               "Taller de datos abiertos"
ex:act3          rdf:type                   schema:Event
ex:act3          schema:location            ex:sur
ex:act3          schema:about               "Cuentacuentos"
ex:act4          rdf:type                   schema:Event
ex:act4          schema:location            ex:norte
ex:act4          schema:about               "Club de lectura"
ex:act5          rdf:type                   schema:Event
ex:act5          schema:location            ex:centro
ex:act5          schema:about               "Alfabetización digital"
ex:act6          rdf:type                   schema:Event
ex:act6          schema:location            ex:parque
ex:act6          schema:about               "Taller de datos abiertos"
')
grafo

subset(grafo, p == "schema:containedInPlace" & o == "wd:Q8802")$s

lugar <- subset(grafo, p == "schema:location")[, c("s", "o")]
names(lugar) <- c("actividad", "biblioteca")
tema <- subset(grafo, p == "schema:about")[, c("s", "o")]
names(tema) <- c("actividad", "tema")
en_getafe <- data.frame(biblioteca = subset(grafo, p == "schema:containedInPlace" & o == "wd:Q8802")$s)

resultado <- merge(merge(lugar, tema), en_getafe)
resultado


# ----------------------------------------------------------------------
# Ejercicio 4.3
# ----------------------------------------------------------------------
# (preparación del ejercicio)
grafo <- read.table(header = TRUE, stringsAsFactors = FALSE, text = '
s p o
ex:centro rdf:type schema:Library
ex:centro schema:containedInPlace wd:Q8802
ex:sur rdf:type schema:Library
ex:sur schema:containedInPlace wd:Q8802
ex:norte rdf:type schema:Library
ex:norte schema:containedInPlace wd:Q77433
ex:parque rdf:type schema:Library
ex:parque schema:containedInPlace wd:Q10372
ex:act1 rdf:type schema:Event
ex:act1 schema:location ex:centro
ex:act1 schema:about "Club de lectura"
ex:act2 rdf:type schema:Event
ex:act2 schema:location ex:centro
ex:act2 schema:about "Taller de datos abiertos"
ex:act3 rdf:type schema:Event
ex:act3 schema:location ex:sur
ex:act3 schema:about "Cuentacuentos"
ex:act4 rdf:type schema:Event
ex:act4 schema:location ex:norte
ex:act4 schema:about "Club de lectura"
ex:act5 rdf:type schema:Event
ex:act5 schema:location ex:centro
ex:act5 schema:about "Alfabetización digital"
ex:act6 rdf:type schema:Event
ex:act6 schema:location ex:parque
ex:act6 schema:about "Taller de datos abiertos"
')

# EJERCICIO: completa los huecos ______
nrow(subset(grafo, p == "______" & o == "______"))


# ----------------------------------------------------------------------
# Ejercicio 4.4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
grafo <- read.table(header = TRUE, stringsAsFactors = FALSE, text = '
s p o
ex:centro schema:containedInPlace wd:Q8802
ex:sur schema:containedInPlace wd:Q8802
ex:norte schema:containedInPlace wd:Q77433
ex:parque schema:containedInPlace wd:Q10372
ex:act1 schema:location ex:centro
ex:act1 schema:about "Club de lectura"
ex:act2 schema:location ex:centro
ex:act2 schema:about "Taller de datos abiertos"
ex:act3 schema:location ex:sur
ex:act3 schema:about "Cuentacuentos"
ex:act4 schema:location ex:norte
ex:act4 schema:about "Club de lectura"
ex:act5 schema:location ex:centro
ex:act5 schema:about "Alfabetización digital"
ex:act6 schema:location ex:parque
ex:act6 schema:about "Taller de datos abiertos"
')
lugar <- subset(grafo, p == "schema:location")[, c("s", "o")]
names(lugar) <- c("actividad", "biblioteca")
tema <- subset(grafo, p == "schema:about")[, c("s", "o")]
names(tema) <- c("actividad", "tema")

# EJERCICIO: completa los huecos ______
actividades <- merge(lugar, tema)
talleres <- subset(actividades, tema == "______")
length(unique(talleres$______))


# ----------------------------------------------------------------------
# Paso 6. Un vocabulario controlado en SKOS (apartado 6)
# ----------------------------------------------------------------------
skos <- read.table(header = TRUE, stringsAsFactors = FALSE, text = '
concepto                 propiedad        valor
ex:actividades           skos:prefLabel   "Actividades culturales"
ex:fomento_lectura       skos:prefLabel   "Fomento de la lectura"
ex:fomento_lectura       skos:broader     ex:actividades
ex:club_lectura          skos:prefLabel   "Club de lectura"
ex:club_lectura          skos:broader     ex:fomento_lectura
ex:cuentacuentos         skos:prefLabel   "Cuentacuentos"
ex:cuentacuentos         skos:broader     ex:fomento_lectura
ex:formacion             skos:prefLabel   "Formación"
ex:formacion             skos:broader     ex:actividades
ex:alfabetizacion        skos:prefLabel   "Alfabetización digital"
ex:alfabetizacion        skos:broader     ex:formacion
ex:taller_datos          skos:prefLabel   "Taller de datos abiertos"
ex:taller_datos          skos:broader     ex:formacion
ex:taller_datos          skos:related     ex:alfabetizacion
')
subset(skos, propiedad == "skos:broader")


# ----------------------------------------------------------------------
# Ejercicio 4.5
# ----------------------------------------------------------------------
# (preparación del ejercicio)
skos <- read.table(header = TRUE, stringsAsFactors = FALSE, text = '
concepto propiedad valor
ex:actividades skos:prefLabel "Actividades culturales"
ex:fomento_lectura skos:prefLabel "Fomento de la lectura"
ex:fomento_lectura skos:broader ex:actividades
ex:club_lectura skos:prefLabel "Club de lectura"
ex:club_lectura skos:broader ex:fomento_lectura
ex:cuentacuentos skos:prefLabel "Cuentacuentos"
ex:cuentacuentos skos:broader ex:fomento_lectura
ex:formacion skos:prefLabel "Formación"
ex:formacion skos:broader ex:actividades
ex:alfabetizacion skos:prefLabel "Alfabetización digital"
ex:alfabetizacion skos:broader ex:formacion
ex:taller_datos skos:prefLabel "Taller de datos abiertos"
ex:taller_datos skos:broader ex:formacion
ex:taller_datos skos:related ex:alfabetizacion
')

# EJERCICIO: completa los huecos ______
especificos <- subset(skos, propiedad == "skos:broader" & valor == "______")$concepto
subset(skos, propiedad == "skos:prefLabel" & concepto %in% ______)$valor
