% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/R6String.R, R/core.R
\docType{package}
\name{R6String}
\alias{R6String}
\title{R6String}
\usage{
R6String(str = "")
}
\arguments{
\item{str}{[R6StringClass or character] string}
}
\value{
[R6StringClass]
}
\description{
R6 implementation of strings

Quick constructor, just a call to R6StringClass$new
}
\examples{

s   = R6String("Hello world!")
}
\author{
Yoann Robin Maintainer: Yoann Robin <yoann.robin.k@gmail.com>
}
