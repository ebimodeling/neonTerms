#' input a data publication workbook into the db
#' @description Based on a standard template, input a data publication workbook
#' @export
#' @import dplyr
inputDataPub <- function(datapub,db){
  ### Create terms dataframe
  tdfname <- c("fieldName","description")
  termDF <- datapub[,colnames(datapub)%in%tdfname]
  ## Strip out duplicates
  termDF <- termDF[!duplicated(termDF$fieldName),]
  colnames(termDF) <- c("termName","termDefinition")
  addTermDef(termDF,db)
  
  
  ### Add to the table description
  tbdfname <- c("table","tableDescription")
  tabledescDF <- datapub[,colnames(datapub)%in%tbdfname]
  ### the order is important and must match the expectation of the table, this mapping will have to change if the spreadsheet input changes
  colnames(tabledescDF) <- c("tableName","tableDesc")
  tabledescDF <- tabledescDF[!duplicated(tabledescDF$tableName),]
  addTblDesc(tabledescDF,db)
  
  ### Add to the link table
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  
  tlinkname <- c("table","DPNumber") 
  tlinkDF <- datapub[,colnames(datapub)%in%tlinkname]
  
  tlinkDF <- tlinkDF[!duplicated(tlinkDF$table),]
  tableID <- unlist(sapply(tlinkDF$table,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  tlinkDF$table <- tableID
  colnames(tlinkDF) <- c("tableID","dpID")
  addTDPL(tlinkDF)
  
  
  
  
  ### Now the hard part!  Let's add to the table definition table
  ### First we'll grab our term ID's

  termID <- unlist(sapply(datapub$fieldName,function(x){q <-paste("SELECT termID FROM TermDefinition WHERE termName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  tableID <- unlist(sapply(datapub$table,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  ## Add column ID's
  datapub <- datapub %.% group_by(table) %.% mutate(columnID = 1:length(table))
  
  tabledefDF <- as.data.frame(cbind(unname(termID),unname(tableID),datapub$columnID))  
  colnames(tabledefDF) <- c("termID","tableID","columnID")
  addTblDef(tabledefDF,db)
  
}