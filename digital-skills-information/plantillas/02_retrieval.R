# Unit 2. Information retrieval
# Digital Skills for Information Use
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24550050
# Code licence: MIT · Book: https://pablosancheznunez.com/digital-skills-information/
#
# Script with all the code in the chapter, to run in RStudio or Positron.
# The exercises have blanks (______): fill them in and compare with the book.


# ----------------------------------------------------------------------
# R practice: Boolean operators from the inside
# ----------------------------------------------------------------------
mobile      <- c(1, 2, 3, 5, 8, 13, 21)     # documents containing "mobile"
smartphone  <- c(2, 4, 8, 16, 32)           # those containing "smartphone"
performance <- c(1, 2, 4, 8, 13, 16, 40)    # those containing "performance"

union(mobile, smartphone)                          # mobile OR smartphone
intersect(union(mobile, smartphone), performance)  # (mobile OR smartphone) AND performance


# ----------------------------------------------------------------------
# Exercise 2.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
mobile      <- c(1, 2, 3, 5, 8, 13, 21)
smartphone  <- c(2, 4, 8, 16, 32)
performance <- c(1, 2, 4, 8, 13, 16, 40)

# EJERCICIO: completa los huecos ______
r <- intersect(union(mobile, smartphone), ______)
length(r)


# ----------------------------------------------------------------------
# Exercise 2.2
# ----------------------------------------------------------------------
# EJERCICIO: completa los huecos ______
relevant <- 4
results <- 6
relevant / ______
