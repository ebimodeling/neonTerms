#' add linkage between DP and data type Table
#' @description This will add to the linkage between data products, terms, and units
#' @param df a dataframe that adheres to the standard of a spatial resolution table
#' @param db The database to add terms to.  Alternatively you can set this as an option termDB with options(termDB = "myDB.sqlite") and leave the this parameter out
#' @param overwrite If TRUE, overwrite the underlying table.  This may be a very bad idea.  So be careful!
#' @param dcheck If FALSE, no duplicate checking is done!  This may be a bad idea!
#' @details units are defined at the intersection of term and data product - e.g. "mean" can be the mean of anything. A given term must have the same definition throughout a given data product. 
#' @export
#' @import RSQLite

addDTTbl <- function(df, db=NULL, overwrite=F, dcheck=T){
  tbl <- "DataTypeTable"
  drv <- dbDriver("SQLite")
  namelist <- c("dataTypeID","dataTypeDesc")
  if(is.null(db)){
    db <- getOption("termDB")
    if(is.null(db)){stop("You must specify a database. This can be done in the function call or with options(termDB = 'myDB.sqlite')")}
  }
  
  #Check if the table exists
  if(!testTbl(tbl,db)){
    types <- c("INT","TEXT")
    createTbl(tbl,db,namelist,types)
  }
  
  #Check for duplicates
  if(dcheck && overwrite == FALSE){
    df <- data.frame(df[stripDupes(df$dataType,tbl,db,"dataTypeDesc"),])
  } 
  
  dataTypeID <- createID(dim(df)[1],tbl,db)
  df <- cbind(dataTypeID,df)
  colnames(df) <- c("dataTypeID","dataTypeDesc")
  
  writeTable(df,tbl,namelist,db,overwrite)
  print(paste("Successfully wrote ",dim(df)[1]," rows to the ",tbl," table in your database ",db,sep="" ))
  
}
