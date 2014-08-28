#' add to terms table
#' @description This will add to a table of terms 
#' @param df a dataframe that adheres to the standard of a terms table
#' @param db The database to add terms to.  Alternatively you can set this as an option termDB with options(termDB = "myDB.sqlite") and leave the this parameter out
#' @param overwrite If TRUE, overwrite the underlying table.  This may be a very bad idea.  So be careful!
#' @param dcheck If FALSE, no duplicate checking is done!  This may be a bad idea!
#' @details a terms table is made up of the following headings, please consult the database definitional document for details. "fieldName","description","category","units"
#' 
#' @export
#' @import RSQLite


addTermDef <- function(df, db = NULL,overwrite = F, dcheck = T){
  tbl <- "TermDefinition"
  drv <- dbDriver("SQLite")
  namelist <- c("termID","termName","termDefinition","units")
  if(is.null(db)){
    db <- getOption("termDB")
    if(is.null(db)){stop("You must specify a database. This can be done in the function call or with options(termDB = 'myDB.sqlite')")}
  }
  
  #Check if the table exists

  if(!testTbl(tbl,db)){
    types <- c("INT","TEXT","TEXT","TEXT")
    createTbl(tbl,db,namelist,types)
  }
  
  ### Add ID's
  if(dcheck){
    
    df <- df[stripDupes(df$termName,tbl,db,"termName"),]
    termID <- createID(dim(df)[1],tbl,db)
    df <- cbind(termID,df)
  } else {
    termID <- createID(dim(df)[1],tbl,db)
    df <- cbind(termID,df)
  }
  writeTable(df,tbl,namelist,db,overwrite)
  print(paste("Successfully wrote ",dim(df)[1]," rows to the ",tbl," table in your database ",db,sep="" ))
  
 
}


