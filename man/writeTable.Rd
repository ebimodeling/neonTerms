% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/writeTable.R
\name{writeTable}
\alias{writeTable}
\title{write table}
\usage{
writeTable(df, tbl, namelist, db, overwrite)
}
\arguments{
\item{df}{a dataframe that adheres to the standard of a terms table}

\item{tbl}{the name of the table towrite to.  This should be passed from the wrapper fxn.}

\item{namelist}{the proper names of headers.  This should be passed from the wrapper fxn}

\item{db}{The database to add terms to.  Alternatively you can set this as an option termDB with options(termDB = "myDB.sqlite") and leave the this parameter out}

\item{overwrite}{If T, overwrite the underlying table.  This may be a very bad idea.  So be careful!}
}
\description{
This is a generic fxn to write to tables.
}
\details{
a terms table is made up of the following headings, please consult the database definitional document for details. "fieldName","description","category","units"
}

