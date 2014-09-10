#' input a data publication workbook into the db
#' @description Based on a standard template, input a data publication workbook
#' @param datapub the dataframe to input that has all the necessary fields
#' @param mapping a list with valid mappings of field names in the datapub to field names in the database
#' @param db the database to add to.  If NULL, looks for it in the options
#' @export
#' @import dplyr
inputDataPub <- function(datapub,mapping,db=NULL){
  ### Create terms dataframe
  if(is.null(db)){
    db <- getOption("termDB")
    if(is.null(db)){stop("You must specify a database. This can be done in the function call or with options(termDB = 'myDB.sqlite')")}
  }
  
  tdfname <-  c("termName","termDefinition")
  termDF <- datapub[,unlist(mapping[tdfname])]
  
  colnames(termDF) <- c("termName","termDefinition")
  
  addTermDef(termDF,db)
  
  
  ### Add to the table description
  tbdfname <-  c("tableName","tableDesc")
  tabledescDF <- datapub[,unlist(mapping[tbdfname])]
  ### the order is important and must match the expectation of the table, this mapping will have to change if the spreadsheet input changes
  colnames(tabledescDF) <- c("tableName","tableDesc")
  tabledescDF <- tabledescDF[!duplicated(tabledescDF$tableName),]
  addTblDesc(tabledescDF,db)
  
  ### Add to the link table
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  
  tlinkname <- c("tableID","dpID")
  tlinkDF <- datapub[,unlist(mapping[tlinkname])]
  
  tlinkDF <- tlinkDF[!duplicated(tlinkDF$table),]
  tableID <- unlist(sapply(tlinkDF$table,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  tlinkDF$table <- tableID
  colnames(tlinkDF) <- c("tableID","dpID")
  addTDPL(tlinkDF)
  
  
  
  
  ### Now the hard part!  Let's add to the table definition table
  ### First we'll grab our term ID's
  
  termID <- unlist(sapply(datapub[,mapping$termName],function(x){q <-paste("SELECT termID FROM TermDefinition WHERE termName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  tableID <- unlist(sapply(datapub$table,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  ## Add column ID's
  datapub <- datapub %.% group_by(table) %.% mutate(columnID = 1:length(table))
  
  tabledefDF <- as.data.frame(cbind(unname(termID),unname(tableID),datapub$columnID))  
  colnames(tabledefDF) <- c("termID","tableID","columnID")
  addTblDef(tabledefDF,db)
  
}