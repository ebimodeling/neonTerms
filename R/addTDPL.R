#' add linkage between DP and TableDef
#' @description This will add to the linkage between data products and table definitions
#' @param df a dataframe that adheres to the standard of a spatial resolution table
#' @param db The database to add terms to.  Alternatively you can set this as an option termDB with options(termDB = "myDB.sqlite") and leave the this parameter out
#' @param overwrite If TRUE, overwrite the underlying table.  This may be a very bad idea.  So be careful!
#' @param dcheck If FALSE, no duplicate checking is done!  This may be a bad idea!
#' @details a terms table is made up of the following headings, please consult the database definitional document for details. 
#' @export
#' @import RSQLite

addTDPL <- function(df, db = NULL,overwrite = F){
  tbl <- "TableDPLink"
  drv <- dbDriver("SQLite")
  namelist <- c("tdpID","tableID","dpID")
  if(is.null(db)){
    db <- getOption("termDB")
    if(is.null(db)){stop("You must specify a database. This can be done in the function call or with options(termDB = 'myDB.sqlite')")}
  }
  
  #Check if the table exists
  
  if(!testTbl(tbl,db)){
    types <- c("INT","INT","TEXT")
    createTbl(tbl,db,namelist,types)
  }
  
  tdpID <- createID(dim(df)[1],tbl,db)
  df <- cbind(tdpID,df)
  
  writeTable(df,tbl,namelist,db,overwrite)
  print(paste("Successfully wrote ",dim(df)[1]," rows to the ",tbl," table in your database ",db,sep="" ))
  
  
}