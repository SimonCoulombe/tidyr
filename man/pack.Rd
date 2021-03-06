% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pack.R
\name{pack}
\alias{pack}
\alias{unpack}
\title{Pack and unpack}
\usage{
pack(data, ...)

unpack(data, cols, names_sep = NULL, names_repair = "check_unique")
}
\arguments{
\item{data}{A data frame.}

\item{...}{Name-variable pairs of the form \code{new_col = c(col1, col2, col3)},
that describe how you wish to pack existing columns into new columns.
The right hand side can be any expression supported by tidyselect.}

\item{cols}{Name of column that you wish to unpack.}

\item{names_sep}{If \code{NULL}, the default, the names of new columns will
come directly from the inner data frame.

If a string, the names of the new columns will be formed by pasting
together the outer column name with the inner names, separated by
\code{names_sep}.}

\item{names_repair}{Used to check that output data frame has valid
names. Must be one of the following options:
\itemize{
\item "minimal": No name repair or checks, beyond basic existence,
\item "unique": Make sure names are unique and not empty,
\item "check_unique": (the default), no name repair, but check they are unique,
\item "universal": Make the names unique and syntactic
\item a function: apply custom name repair.
\item a formula: a purrr-style anonymous function (see \code{\link[rlang:as_function]{rlang::as_function()}})
}

See \link[tibble:name-repair]{tibble::name-repair} for more details on these terms and the
strategies used to enforce them.}
}
\description{
Packing and unpacking preserve the length of a data frame, changing its
width. \code{pack()} makes \code{df} narrow by collapsing a set of columns into a
single df-column. \code{unpack()} makes \code{data} wider by expanding df-columns
back out into individual columns.
}
\details{
Generally, unpacking is more useful than packing because it simplifies
a complex data structure. Currently, few functions work with df-cols,
and they are mostly a curiosity, but seem worth exploring further because
they mimic the nested column headers that are so popular in Excel.
}
\examples{
# Packing =============================================================
# It's not currently clear why you would ever want to pack columns
# since few functions work with this sort of data.
df <- tibble(x1 = 1:3, x2 = 4:6, x3 = 7:9, y = 1:3)
df
df \%>\% pack(x = starts_with("x"))
df \%>\% pack(x = c(x1, x2, x3), y = y)

# Unpacking ===========================================================
df <- tibble(
  x = 1:3,
  y = tibble(a = 1:3, b = 3:1),
  z = tibble(X = c("a", "b", "c"), Y = runif(3), Z = c(TRUE, FALSE, NA))
)
df
df \%>\% unpack(y)
df \%>\% unpack(c(y, z))
df \%>\% unpack(c(y, z), names_sep = "_")
}
