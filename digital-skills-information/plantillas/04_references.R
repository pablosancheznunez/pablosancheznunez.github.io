# Units 4 and 5. References
# Digital Skills for Information Use
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24550050
# Code licence: MIT · Book: https://pablosancheznunez.com/digital-skills-information/
#
# Script with all the code in the chapter, to run in RStudio or Positron.
# The exercises have blanks (______): fill them in and compare with the book.


# ----------------------------------------------------------------------
# R practice: building and ordering references
# ----------------------------------------------------------------------
authors <- "Bates, M. J."
year <- 1989
title <- "The design of browsing and berrypicking techniques for the online search interface"
journal <- "Online Review"; volume <- 13; issue <- 5; pages <- "407-424"
doi <- "10.1108/eb024320"
paste0(authors, " (", year, "). ", title, ". ", journal, ", ", volume, "(", issue, "), ",
       pages, ". https://doi.org/", doi)


# ----------------------------------------------------------------------
# Exercise 4.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
refs <- c("Pennycook, G., & Rand, D. G. (2021). The psychology of fake news.",
          "Bates, M. J. (1989). The design of browsing and berrypicking techniques.",
          "Metzger, M. J., & Flanagin, A. J. (2013). Credibility and trust of information.",
          "Bawden, D., & Robinson, L. (2009). The dark side of information.")

# EJERCICIO: completa los huecos ______
sorted_refs <- ______(refs)
sorted_refs[1]
