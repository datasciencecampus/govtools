
govtools
========

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active) [![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()

The idea of this R package is to provide the user with the ability to add common files to their repository such as the `README`, `CODE OF CONDUCT`, `CONTRIBUTING` and `LICENSE`, which are suitable to use for the UK government.

Installation
============

``` r
# install.packages("devtools")
devtools::install_github("govtools")
```

Usage
=====

In a similar vein to the [`devtools`](https://github.com/hadley/devtools) package, `govtools` provides the user with a series of `use_*` functions. For example, to add the Open Government License 3 file:

``` r
govtools::use_ogl_license()
```

Code of Conduct
===============

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
