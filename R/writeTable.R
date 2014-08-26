#' write table
#' @description This is a generic fxn to write to tables.  
#' @param df a dataframe that adheres to the standard of a terms table
#' @param tbl the name of the table towrite to.  This should be passed from the wrapper fxn.
#' @param namelist the proper names of headers.  This should be passed from the wrapper fxn
#' @param db The database to add terms to.  Alternatively you can set this as an option termDB with options(termDB = "myDB.sqlite") and leave the this parameter out
#' @param overwrite If T, overwrite the underlying table.  This may be a very bad idea.  So be careful!
#' @param append if T, no duplicate checking is done!  This may be a bad idea!
#' @details a terms table is made up of the following headings, please consult the database definitional document for details. "fieldName","description","category","units"
#' @export
#' @import RSQLite

writeTable <- function(df,tbl,namelist, db,overwrite){
  
  drv <- dbDriver("SQLite")
  # some error handling
  if(is.null(db)){
    db <- getOption("termDB")
    if(is.null(db)){stop("You must specify a database. This can be done in the function call or with options(termDB = 'myDB.sqlite')")}
  }
  
  if(!checkNames(namelist,names(df))){stop("Your dataframe is not a valid dataframe for the table you wish to insert data into")}
  
  dbC <- dbConnect(drv, dbname=db)
  
    ## Write new data to DB
    dbWriteTable(conn = dbC, name = tbl, value = df, row.names = FALSE,append=T)
    

  
  if(overwrite){
    dbWriteTable(conn = dbC, name = tbl, value = df, row.names = FALSE,overwrite = T)
    
  }
  
  
}
