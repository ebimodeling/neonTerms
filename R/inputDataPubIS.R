#' input an *IS data publication workbook into the db
#' @description Based on a standard template, input a data publication workbook
#' @export
#' @import dplyr
inputDataPubIS <- function(datapub,db){
  ### Create terms dataframe
  tdfname <- c("fieldName","description")
  termDF <- datapub[,colnames(datapub)%in%tdfname]
  ## Strip out duplicates
  termDF <- termDF[!duplicated(termDF$fieldName),]
  colnames(termDF) <- c("termName","termDefinition")
  addTermDef(termDF,db)
  
  
  ### Add to the table description - NO TABLES in IS, but still need table info to 
  ### join properly - define one table per IS product
  tbdfname <- c("table","tableDescription")
  tabledescDF <- datapub[,c("DPName","Dpdescription")]
  ### the order is important and must match the expectation of the table, this 
  ### mapping will have to change if the spreadsheet input changes
  colnames(tabledescDF) <- c("tableName","tableDesc")
  tabledescDF <- tabledescDF[!duplicated(tabledescDF$tableName),]
  addTblDesc(tabledescDF,db)
  
  ### Add to the link table
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  
  tlinkname <- c("table","DPNumber") 
  tlinkDF <- datapub[,c("DPName","DPNumber")]
  colnames(tlinkDF) <- tlinkname
  
  tlinkDF <- tlinkDF[!duplicated(tlinkDF$table),]
  tableID <- unlist(sapply(tlinkDF$table,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  tlinkDF$table <- tableID
  colnames(tlinkDF) <- c("tableID","dpID")
  addTDPL(tlinkDF)
  
  ### Add to the units table
  unitsDF <- data.frame(datapub[,c("units")])
  colnames(unitsDF) <- c("unitsDesc")
  unitsDF <- data.frame(unitsDF[!duplicated(unitsDF$unitsDesc),])
  colnames(unitsDF) <- c("unitsDesc")
  addUnitsTbl(unitsDF,db)
  
  
  
  ### Now the hard part!  Let's add to the table definition table
  ### First we'll grab our term ID's

  termID <- unlist(sapply(datapub$fieldName,function(x){q <-paste("SELECT termID FROM TermDefinition WHERE termName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  unitsID <- unlist(sapply(datapub$units,function(x){
    if(is.na(x)) {
      q <-paste("SELECT unitsID FROM UnitsTable WHERE unitsDesc IS NULL",sep="")
    } else {
      q <-paste("SELECT unitsID FROM UnitsTable WHERE unitsDesc = ", "'",x,"'",sep="")
    }
    return(dbGetQuery(conn = dbC, q))
  }))
  tableID <- unlist(sapply(datapub$DPName,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  ## Add column ID's
  datapub <- datapub %.% group_by(DPName) %.% mutate(columnID = 1:length(DPName))
  
  tabledefDF <- as.data.frame(cbind(unname(termID),unname(unitsID),unname(tableID),datapub$columnID))  
  colnames(tabledefDF) <- c("termID","unitsID","tableID","columnID")
  addTblDef(tabledefDF,db)
  
}
