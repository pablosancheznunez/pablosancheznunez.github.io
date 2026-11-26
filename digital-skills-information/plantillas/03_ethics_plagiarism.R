# Unit 3. Ethical use of information and plagiarism
# Digital Skills for Information Use
# Pablo Sánchez-Núñez (UC3M) · https://doi.org/10.5281/zenodo.24550050
# Code licence: MIT · Book: https://pablosancheznunez.com/digital-skills-information/
#
# Script with all the code in the chapter, to run in RStudio or Positron.
# The exercises have blanks (______): fill them in and compare with the book.


# ----------------------------------------------------------------------
# R practice: how software detects overlaps
# ----------------------------------------------------------------------
trigrams <- function(text) {
  p <- strsplit(tolower(gsub("[[:punct:]]", "", text)), "\\s+")[[1]]
  unique(paste(p[-c(length(p) - 1, length(p))], p[-c(1, length(p))], p[-(1:2)]))
}
similarity <- function(a, b) {
  ta <- trigrams(a); tb <- trigrams(b)
  length(intersect(ta, tb)) / length(union(ta, tb))
}
original    <- "Lateral reading means leaving the page to check what other sources say about it"
patchwork   <- "Lateral reading means leaving the website to check what other sources say about it"
paraphrase  <- "To verify a website it is better to consult what different sources think of it than to analyse it from the inside"
c(patchwork = similarity(original, patchwork), paraphrase = similarity(original, paraphrase))


# ----------------------------------------------------------------------
# Exercise 3.1
# ----------------------------------------------------------------------
# (preparación del ejercicio)
trigrams <- function(text) {
  p <- strsplit(tolower(gsub("[[:punct:]]", "", text)), "\\s+")[[1]]
  unique(paste(p[-c(length(p) - 1, length(p))], p[-c(1, length(p))], p[-(1:2)]))
}
similarity <- function(a, b) {
  ta <- trigrams(a); tb <- trigrams(b)
  length(intersect(ta, tb)) / length(union(ta, tb))
}
original <- "Lateral reading means leaving the page to check what other sources say about it"

# EJERCICIO: completa los huecos ______
copy <- original
similarity(original, ______)
