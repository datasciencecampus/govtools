# Code of Conduct --------------------------------------------------------------

#' Add a code of conduct file
#'
#' Add the Contributor Covenant version 1.4 code of conduct
#'
#' @param pkg package description, can be path or package name. See
#'   \code{\link{as.package}} for more information.
#' @param email String. An email address to act as a point of contact for the
#'   project.
#'
#' @export
use_code_of_conduct <- function(pkg = ".", email = NULL) {
  if (is.null(email)) {
    stop("Please provide an email address")
  }

  pkg <- devtools::as.package(pkg)

  coc_template <- system.file(
    "templates", "CODE_OF_CONDUCT.Rmd",
    package = "govtools",
    mustWork = TRUE
  )

  rmarkdown::render(
    coc_template,
    output_dir = pkg$path,
    params = list(email = email)
  )

  message("* Don't forget to describe the code of conduct in your README.md:")
  message(
    "Please note that this project is released with a ",
    "[Contributor Code of Conduct](CODE_OF_CONDUCT.md). ",
    "By participating in this ",
    "project you agree to abide by its terms."
  )
}

# License files ----------------------------------------------------------------

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

# Utilities --------------------------------------------------------------------

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
