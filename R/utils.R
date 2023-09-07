`%??%` <- function(a, b) if (length(a) == 0) b else a
paste_line <- function(...) paste0(c(...), collapse = "\n")
is_r_file <- function(filename) {
  ext <- toupper(tools::file_ext(trimws(filename)))
  ext == "R" %??% FALSE
}