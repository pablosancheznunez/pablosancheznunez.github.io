# Units 6 and 7. Generative artificial intelligence: foundations and applications
# Digital Skills for Information Use
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24550050
# Code licence: MIT · Book: https://pablosancheznunez.com/digital-skills-information/
#
# Script with all the code in the chapter, to run in RStudio or Positron.
# The exercises have blanks (______): fill them in and compare with the book.


# ----------------------------------------------------------------------
# R practice: checking references against a database
# ----------------------------------------------------------------------
ai_dois <- c("10.1108/eb024320", "10.1016/j.ipm.2019.102041", "10.1038/s41598-023-41032-5",
             "10.1177/0165551508095781", "10.1093/jis/abc123")
database <- c("10.1108/eb024320", "10.1038/s41598-023-41032-5", "10.1177/0165551508095781",
              "10.1016/j.pragma.2013.07.012", "10.1145/1121949.1121979")
ai_dois %in% database


# ----------------------------------------------------------------------
# Exercise 6.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
ai_dois <- c("10.1108/eb024320", "10.1016/j.ipm.2019.102041", "10.1038/s41598-023-41032-5",
             "10.1177/0165551508095781", "10.1093/jis/abc123")
database <- c("10.1108/eb024320", "10.1038/s41598-023-41032-5", "10.1177/0165551508095781",
              "10.1016/j.pragma.2013.07.012", "10.1145/1121949.1121979")

# EJERCICIO: completa los huecos ______
mean(!(ai_dois %in% ______))
