% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/addDTTbl.R
\name{addDTTbl}
\alias{addDTTbl}
\title{add linkage between DP and data type Table}
\usage{
addDTTbl(df, db = NULL, overwrite = F, dcheck = T)
}
\arguments{
\item{df}{a dataframe that adheres to the standard of a spatial resolution table}

\item{db}{The database to add terms to.  Alternatively you can set this as an option termDB with options(termDB = "myDB.sqlite") and leave the this parameter out}

\item{overwrite}{If TRUE, overwrite the underlying table.  This may be a very bad idea.  So be careful!}

\item{dcheck}{If FALSE, no duplicate checking is done!  This may be a bad idea!}
}
\description{
This will add to the linkage between data products, terms, and units
}
\details{
units are defined at the intersection of term and data product - e.g. "mean" can be the mean of anything. A given term must have the same definition throughout a given data product.
}

