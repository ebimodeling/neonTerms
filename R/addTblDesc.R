#' add to table descriptiion
#' @description This will add to a table of table descriptions
#' @param df a dataframe that adheres to the standard of a spatial resolution table
#' @param db The database to add terms to.  Alternatively you can set this as an option termDB with options(termDB = "myDB.sqlite") and leave the this parameter out
#' @param overwrite If TRUE, overwrite the underlying table.  This may be a very bad idea.  So be careful!
#' @param dcheck If FALSE, no duplicate checking is done!  This may be a bad idea!
#' @details a terms table is made up of the following headings, please consult the database definitional document for details.
#' @export
#' @import RSQLite

addTblDesc <- function(df, db = NULL,overwrite = F){
  tbl <- "TableDescription"
  drv <- dbDriver("SQLite")
  namelist <- c("tableID","tableName","tableDesc","tableNum")
  if(is.null(db)){
    db <- getOption("termDB")
    if(is.null(db)){stop("You must specify a database. This can be done in the function call or with options(termDB = 'myDB.sqlite')")}
  }
  
  #Check if the table exists

  if(!testTbl(tbl,db)){
    types <- c("INT","TEXT","TEXT","INT")
    createTbl(tbl,db,namelist,types)
  }

  tableID <- createID(dim(df)[1],tbl,db)
  df <- cbind(tableID,df)

  ### Now I'll need to add the ids within data products...
  ## First I'll assign them based on unique ids in the dataframe
  tnum <- df %.% group_by(tableName) %.% mutate(count <- 1:length(tableID))
  tnum <- tnum[,4]
  ## Now check if any numbers are in 
  q <- paste("SELECT","tableName","FROM",tbl,sep=" ")
  dbC <- dbConnect(drv, dbname = db)
  out <- unlist(dbGetQuery(conn = dbC, q))
  ## Check against database
  u <- unique(df$tableName)
  for(i in 1:length(u) ){
    if(u[i]%in%out){
      q <- paste("SELECT tableNum","FROM",tbl," WHERE tableName = '",u,"'",sep=" ")
      dbC <- dbConnect(drv, dbname = db)
      intids <- unlist(dbGetQuery(conn = dbC, q))
      upids <- tnum[which(df$tableName==u[i])]+max(intids)
      tnum[which(df$tableName==u[i])] <- upids
    }
  }
  
  df$tableNum <- tnum

  writeTable(df,tbl,namelist,db,overwrite)
  print(paste("Successfully wrote ",dim(df)[1]," rows to the ",tbl," table in your database ",db,sep="" ))


}
