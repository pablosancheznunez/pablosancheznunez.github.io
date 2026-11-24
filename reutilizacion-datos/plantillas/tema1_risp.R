# Tema 1. Reutilización de la información del sector público (RISP)
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
# Paso 1. La normativa como datos
# ----------------------------------------------------------------------
normas <- data.frame(
  norma = c("Directiva 2003/98/CE", "Ley 37/2007", "Directiva 2013/37/UE", "Ley 19/2013",
            "Ley 18/2015", "Directiva (UE) 2019/1024", "RDL 24/2021",
            "RD 1495/2011", "NTI-RISP (Resolución 19/02/2013)",
            "Reglamento (UE) 2022/868", "Reglamento de Ejecución (UE) 2023/138",
            "Reglamento (UE) 2023/2854", "Reglamento (UE) 2024/1689"),
  fecha = as.Date(c("2003-11-17", "2007-11-16", "2013-06-26", "2013-12-09",
                    "2015-07-09", "2019-06-20", "2021-11-02",
                    "2011-10-24", "2013-02-19",
                    "2022-05-30", "2022-12-21", "2023-12-13", "2024-06-13")),
  ambito = c("UE", "ES", "UE", "ES", "ES", "UE", "ES", "ES", "ES", "UE", "UE", "UE", "UE")
)
normas


# ----------------------------------------------------------------------
# Paso 2. Ordenar y medir intervalos (apartado 2)
# ----------------------------------------------------------------------
normas <- normas[order(normas$fecha), ]
normas[, c("fecha", "ambito", "norma")]
# Años transcurridos entre la Directiva 2003/98/CE y su transposición
as.numeric(normas$fecha[2] - normas$fecha[1]) / 365.25


# ----------------------------------------------------------------------
# Ejercicio 1.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
normas <- data.frame(
  norma = c("Directiva 2003/98/CE", "Ley 37/2007", "Directiva 2013/37/UE", "Ley 19/2013",
            "Ley 18/2015", "Directiva (UE) 2019/1024", "RDL 24/2021",
            "RD 1495/2011", "NTI-RISP (Resolución 19/02/2013)",
            "Reglamento (UE) 2022/868", "Reglamento de Ejecución (UE) 2023/138",
            "Reglamento (UE) 2023/2854", "Reglamento (UE) 2024/1689"),
  fecha = as.Date(c("2003-11-17", "2007-11-16", "2013-06-26", "2013-12-09",
                    "2015-07-09", "2019-06-20", "2021-11-02",
                    "2011-10-24", "2013-02-19",
                    "2022-05-30", "2022-12-21", "2023-12-13", "2024-06-13")),
  ambito = c("UE", "ES", "UE", "ES", "ES", "UE", "ES", "ES", "ES", "UE", "UE", "UE", "UE")
)

# EJERCICIO: completa los huecos ______
sum(normas$ambito == ______)


# ----------------------------------------------------------------------
# Ejercicio 1.2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
directiva <- as.Date("2019-06-20")

# EJERCICIO: completa los huecos ______
rdl <- as.Date("______")
as.numeric(rdl - directiva)


# ----------------------------------------------------------------------
# Paso 3. Plazos del derecho de acceso (apartado 5)
# ----------------------------------------------------------------------
recepcion <- as.Date("2026-02-16")
fin_plazo <- seq(recepcion, by = "1 month", length.out = 2)[2]
fin_plazo
weekdays(fin_plazo)   # día de la semana (en inglés en webR)


# ----------------------------------------------------------------------
# Ejercicio 1.3
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
recepcion <- as.Date("2026-03-10")
meses <- ______
seq(recepcion, by = "1 month", length.out = meses + 1)[meses + 1]


# ----------------------------------------------------------------------
# Ejercicio 1.4
# ----------------------------------------------------------------------
# (preparación del ejercicio)
candidatas <- c("Geoespaciales", "Préstamos bibliotecarios", "Observación de la Tierra y medio ambiente",
                "Meteorológicos", "Sanitarios", "Estadísticos", "Educativos",
                "Sociedades y propiedad de sociedades", "Movilidad", "Culturales")

# EJERCICIO: completa los huecos ______
candidatas
mis_hvd <- candidatas[c(______)]
mis_hvd


# ----------------------------------------------------------------------
# Paso 4. Plazos de una solicitud de reutilización (apartado 6)
# ----------------------------------------------------------------------
sumar_habiles <- function(inicio, n) {
  dia <- inicio
  while (n > 0) {
    dia <- dia + 1
    # weekdays() devuelve el día en inglés en webR
    if (!weekdays(dia) %in% c("Saturday", "Sunday")) n <- n - 1
  }
  dia
}
sumar_habiles(as.Date("2026-01-09"), 3)   # viernes + 3 días hábiles = miércoles


# ----------------------------------------------------------------------
# Ejercicio 1.5
# ----------------------------------------------------------------------
# (preparación del ejercicio)
sumar_habiles <- function(inicio, n) {
  dia <- inicio
  while (n > 0) {
    dia <- dia + 1
    if (!weekdays(dia) %in% c("Saturday", "Sunday")) n <- n - 1
  }
  dia
}

# EJERCICIO: completa los huecos ______
sumar_habiles(as.Date("2026-03-02"), ______)


# ----------------------------------------------------------------------
# Ejercicio 1.6
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
infraccion <- c(tipo = "______", multa_maxima = "______")
infraccion
