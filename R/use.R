#' @importFrom devtools use_mit_license
#' @export
devtools::use_mit_license

#' Add an OGL-3 license
#'
#' Adds the necessary infrastructure to declare your package as distributed
#' under the OGL-3 license.
#'
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information.
#'
#' @export
use_ogl_license <- function(pkg = ".") {
  pkg <- devtools:::as.package(pkg)

  # Update the DESCRIPTION
  message("* Updating license field in DESCRIPTION.")
  descPath <- file.path(pkg$path, "DESCRIPTION")
  DESCRIPTION <- devtools:::read_dcf(descPath)
  DESCRIPTION$License <- "OGL-3"
  devtools:::write_dcf(descPath, DESCRIPTION)

  use_template(
    "ogl-3-license.txt",
    "LICENSE",
    pkg = pkg
  )
}

# Utilities ---------------------------------------------------------------

use_template <- function(template, save_as = template, data = list(),
                         ignore = FALSE, open = FALSE, pkg = ".") {
  pkg <- devtools:::as.package(pkg)

  path <- file.path(pkg$path, save_as)
  if (!devtools:::can_overwrite(path)) {
    stop("`", save_as, "` already exists.", call. = FALSE)
  }

  template_path <- system.file("templates", template, package = "govtools",
                               mustWork = TRUE)
  template_out <- whisker::whisker.render(readLines(template_path), data)

  message("* Creating `", save_as, "` from template.")
  writeLines(template_out, path)

  if (ignore) {
    message("* Adding `", save_as, "` to `.Rbuildignore`.")
    devtools:::use_build_ignore(save_as, pkg = pkg)
  }

  if (open) {
    message("* Modify `", save_as, "`.")
    devtools:::open_in_rstudio(path)
  }

  invisible(TRUE)
}
