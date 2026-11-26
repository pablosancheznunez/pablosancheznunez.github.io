# Using R in this book
# Digital Skills for Information Use
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.XXXXXXXX
# Code licence: MIT · Book: https://pablosancheznunez.com/digital-skills-information/
#
# Script with all the code in the chapter, to run in RStudio or Positron.
# The exercises have blanks (______): fill them in and compare with the book.


# ----------------------------------------------------------------------
# How the code cells work
# ----------------------------------------------------------------------
results <- 1250          # documents returned by a search
relevant <- 37           # the ones that are actually useful
relevant / results       # proportion

sources <- c("Dialnet", "Google Scholar", "Scopus", "Wikipedia")
length(sources)                  # how many there are
"Scopus" %in% sources            # is Scopus there?
toupper(sources)                 # in capitals


# ----------------------------------------------------------------------
# Exercise 1
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
relevant <- 24
results <- ______
relevant / results


# ----------------------------------------------------------------------
# Exercise 2
# ----------------------------------------------------------------------
# (preparación del ejercicio)
sources <- c("Dialnet", "Google Scholar", "Scopus", "Wikipedia")

# EJERCICIO: completa los huecos ______
"______" %in% sources
