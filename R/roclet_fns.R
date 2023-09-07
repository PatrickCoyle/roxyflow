#' Title
#' 
#' @diagram diagram_roclet.png
#' @export
diagram_roclet <- function() {
  roxygen2::roclet("diagram")
}

#' Title
#'
#' @exportS3Method roxygen2::roclet_process
roclet_process.roclet_diagram <- function(x, blocks, env, base_path) {
  results <- blocks_to_prediagrams(blocks)
  return(results)
}

#' Title
#'
blocks_to_prediagrams <- function(blocks) {
  # tmp1 <- purrr::map_chr(blocks, block_to_prediagrams)
  tmp1 <- sapply(blocks, block_to_prediagrams)
  tmp2 <- tmp1[!is.na(tmp1)]
  tmp3 <- list(
    "pkg" = utils::packageName(), 
    "fns" = tmp2
  )
  return(tmp3)
}

#' Title
#'
block_to_prediagrams <- function(block) {
  if (roxygen2::block_has_tags(block, "diagram")) {
    return(block$object$alias)
  } else {
    return(NA_character_)
  }
}

#' Title
#'
#' @importFrom here here
#' @importFrom flow flow_view_deps
#' @importFrom htmlwidgets saveWidget
#' @importFrom webshot2 webshot
#' @exportS3Method roxygen2::roclet_output
roclet_output.roclet_diagram <- function(x, results, base_path, ...) {
  if (!dir.exists(here::here("man/figures"))) {
    dir.create(here::here("man/figures"))
  }
  for(fn in results$fns) {
    file1 <- here::here("out.html")
    file2 <- here::here("man", "figures", paste0(fn, ".png"))
    widget1 <- eval(parse(text = paste0(
      "flow::flow_view_deps(", 
      results$pkg,
      "::",
      fn, 
      ")$widget"
    )))
    htmlwidgets::saveWidget(widget1, file = file1)
    webshot2::webshot(url = file1, file = file2)
    file.remove(file1)
  }
  invisible(NULL)
}
