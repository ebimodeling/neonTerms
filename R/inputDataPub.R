#' input a data publication workbook into the db
#' @description Based on a standard template, input a data publication workbook
#' @export
#' @import dplyr
inputDataPub <- function(datapub,db){
  ### Create terms dataframe
  tdfname <- c("fieldName","description","units")
  termDF <- datapub[,colnames(datapub)%in%tdfname]
  ## Strip out duplicates
  termDF <- termDF[!duplicated(termDF$fieldName),]
  colnames(termDF) <- c("termName","termDefinition","units")
  addTermDef(termDF,db)
  
  
  ### Add to the table description
  tbdfname <- c("DPNumber","table","tableDescription")
  tabledescDF <- datapub[,colnames(datapub)%in%tbdfname]
  ### the order is important and must match the expectation of the table, this mapping will have to change if the spreadsheet input changes
  tabledescOrd <- c(3,1,2)
  tabledescDF <- tabledescDF[,tabledescOrd]  
  colnames(tabledescDF) <- c("dpID","tableName","tableDesc")
  tabledescDF <- tabledescDF[!duplicated(tabledescDF$tableName),]
  addTblDesc(tabledescDF,db)
  
  
  ### Now the hard part!  Let's add to the table definition table
  ### First we'll grab our term ID's
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  termID <- unlist(sapply(datapub$fieldName,function(x){q <-paste("SELECT termID FROM TermDefinition WHERE termName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  tableID <- unlist(sapply(datapub$table,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  ## Add column ID's
  datapub <- datapub %.% group_by(table) %.% mutate(columnID = 1:length(table))
  
  tabledefDF <- as.data.frame(cbind(unname(termID),unname(tableID)))
  tabledefDF <- cbind(tabledefDF,datapub$DPNumber,datapub$columnID)  
  colnames(tabledefDF) <- c("termID","tableID","dpID","columnID")
  addTblDef(tabledefDF,db)
  
}