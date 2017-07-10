
govtools
========

The idea of this R package is to provide the user with the ability to add common files to their repository such as the `README`, `CODE OF CONDUCT`, `CONTRIBUTING` and `LICENSE` files.

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
