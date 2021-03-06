% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/stripDupes.R
\name{stripDupes}
\alias{stripDupes}
\title{check duplicates}
\usage{
stripDupes(input, tbl, db, field)
}
\arguments{
\item{input}{a vector from a dataframe that you want to strip duplicates from}

\item{tbl}{the table to check for duplicates in.}

\item{db}{the database name}

\item{the}{field in the table}
}
\value{
a vector of true and false indicating which rows of potential input should be added to the database (FALSE is already in the db)
}
\description{
strip duplicates from potential database inputs
}

