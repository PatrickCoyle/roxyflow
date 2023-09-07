#' Title
#'
#' @export
format.rd_section_diagram <- function(x, ...) {
  paste0(
    "\n",
    "\\section{Diagrams}{\n",
    "\\if{html}{\\figure{",
    x$value,
    "}{options: width='500'}}\n",
    "\\if{latex}{\\figure{",
    x$value, 
    "}{options: width=30cm}}\n",
    "}\n"
  )
}

#' Title
#'
#' @export
roxy_tag_diagram <- function(x, block, env, import_only = FALSE) {
  UseMethod("roxy_tag_diagram")
}

#' Title
#'
#' @exportS3Method roxygen2::roxy_tag_parse
roxy_tag_parse.roxy_tag_diagram <- function(x) {
  x$val <- list(
    header = x$raw,
    message = x$raw
  )
  return(x)
}

#' Title
#'
#' @exportS3Method roxygen2::roxy_tag_rd
roxy_tag_rd.roxy_tag_diagram <- function(x, base_path, env) {
  roxygen2::rd_section("diagram", x$val)
}
