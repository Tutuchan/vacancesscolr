% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/holidays.R
\name{is_it_holidays}
\alias{is_it_holidays}
\title{are we on holidays?}
\usage{
is_it_holidays(zone = NULL, quiet = FALSE)
}
\arguments{
\item{zone}{a character, either "A", "B" or "C"}

\item{quiet}{whether or not to return a message}
}
\value{
a logical, TRUE if we are on holidays, FALSE otherwise.
}
\description{
are we on holidays somewhere in France?
Check for your zone using the \code{zone} param.
}
\examples{
is_it_holidays()
}
