% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/recode_to.R
\name{recode_to}
\alias{recode_to}
\alias{recode_to_if}
\title{Recode variable categories into new values}
\usage{
recode_to(x, ..., lowest = 0, highest = -1, append = TRUE, suffix = "_r0")

recode_to_if(
  x,
  predicate,
  lowest = 0,
  highest = -1,
  append = TRUE,
  suffix = "_r0"
)
}
\arguments{
\item{x}{A vector or data frame.}

\item{...}{Optional, unquoted names of variables that should be selected for
further processing. Required, if \code{x} is a data frame (and no
vector) and only selected variables from \code{x} should be processed.
You may also use functions like \code{:} or tidyselect's
\code{\link[tidyselect]{select_helpers}}.
See 'Examples' or \href{../doc/design_philosophy.html}{package-vignette}.}

\item{lowest}{Indicating the lowest category value for recoding. Default is 0, so the new
variable starts with value 0.}

\item{highest}{If specified and greater than \code{lowest}, all category values larger than
\code{highest} will be set to \code{NA}. Default is \code{-1}, i.e. this argument is ignored
and no NA's will be produced.}

\item{append}{Logical, if \code{TRUE} (the default) and \code{x} is a data frame,
\code{x} including the new variables as additional columns is returned;
if \code{FALSE}, only the new variables are returned.}

\item{suffix}{String value, will be appended to variable (column) names of
\code{x}, if \code{x} is a data frame. If \code{x} is not a data
frame, this argument will be ignored. The default value to suffix
column names in a data frame depends on the function call:
\itemize{
  \item recoded variables (\code{rec()}) will be suffixed with \code{"_r"}
  \item recoded variables (\code{recode_to()}) will be suffixed with \code{"_r0"}
  \item dichotomized variables (\code{dicho()}) will be suffixed with \code{"_d"}
  \item grouped variables (\code{split_var()}) will be suffixed with \code{"_g"}
  \item grouped variables (\code{group_var()}) will be suffixed with \code{"_gr"}
  \item standardized variables (\code{std()}) will be suffixed with \code{"_z"}
  \item centered variables (\code{center()}) will be suffixed with \code{"_c"}
  \item de-meaned variables (\code{de_mean()}) will be suffixed with \code{"_dm"}
  \item grouped-meaned variables (\code{de_mean()}) will be suffixed with \code{"_gm"}
}
If \code{suffix = ""} and \code{append = TRUE}, existing variables that
have been recoded/transformed will be overwritten.}

\item{predicate}{A predicate function to be applied to the columns. The
variables for which \code{predicate} returns \code{TRUE} are selected.}
}
\value{
\code{x} with recoded category values, where \code{lowest} indicates
  the lowest value;  If \code{x} is a data frame, for \code{append = TRUE},
  \code{x} including the recoded variables as new columns is returned; if
  \code{append = FALSE}, only the recoded variables will be returned. If
  \code{append = TRUE} and \code{suffix = ""}, recoded variables will replace
  (overwrite) existing variables.
}
\description{
Recodes (or "renumbers") the categories of variables into new
  category values, beginning with the lowest value specified by \code{lowest}.
  Useful when recoding dummy variables with 1/2 values to 0/1 values,  or
  recoding scales from 1-4 to 0-3 etc.
  \code{recode_to_if()} is a scoped variant of \code{recode_to()}, where
  recoding will be applied only to those variables that match the
  logical condition of \code{predicate}.
}
\note{
Value and variable label attributes are preserved.
}
\examples{
# recode 1-4 to 0-3
dummy <- sample(1:4, 10, replace = TRUE)
recode_to(dummy)

# recode 3-6 to 0-3
# note that numeric type is returned
dummy <- as.factor(3:6)
recode_to(dummy)

# lowest value starting with 1
dummy <- sample(11:15, 10, replace = TRUE)
recode_to(dummy, lowest = 1)

# lowest value starting with 1, highest with 3
# all others set to NA
dummy <- sample(11:15, 10, replace = TRUE)
recode_to(dummy, lowest = 1, highest = 3)

# recode multiple variables at once
data(efc)
recode_to(efc, c82cop1, c83cop2, c84cop3, append = FALSE)

library(dplyr)
efc \%>\%
  select(c82cop1, c83cop2, c84cop3) \%>\%
  mutate(
    c82new = recode_to(c83cop2, lowest = 5),
    c83new = recode_to(c84cop3, lowest = 3)
  ) \%>\%
  head()


}
\seealso{
\code{\link{rec}} for general recoding of variables and \code{\link[sjlabelled]{set_na}}
           for setting \code{\link{NA}} values.
}
