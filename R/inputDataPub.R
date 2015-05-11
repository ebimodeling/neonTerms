#' input a data publication workbook into the db
#' @description Based on a standard template, input a data publication workbook
#' @export
#' @import dplyr
inputDataPub <- function(datapub,temporal,space,db){
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
  
  #tlinkname <- c("table","dpID") 
  #tlinkDF <- datapub[,colnames(datapub)%in%tlinkname]
  tlinkDF <- datapub[,c("table","dpID")]
  
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
  
  
  ### Add to the data type table
  datatypeDF <- data.frame(datapub[,c("dataType")])
  colnames(datatypeDF) <- c("dataType")
  datatypeDF <- data.frame(datatypeDF[!duplicated(datatypeDF$dataType),])
  colnames(datatypeDF) <- c("dataType")
  addDTTbl(datatypeDF,db)
  
  ## Add to the spatial and temporal tables
  addTempInd(temporal)
  addSpInd(space)
  
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
  dataTypeID <- unlist(sapply(datapub$dataType,function(x){
    if(is.na(x)) {
      q <-paste("SELECT dataTypeID FROM DataTypeTable WHERE dataTypeDesc IS NULL",sep="")
    } else {
      q <-paste("SELECT dataTypeID FROM DataTypeTable WHERE dataTypeDesc = ", "'",x,"'",sep="")
    }
    return(dbGetQuery(conn = dbC, q))
  }))
  tableID <- unlist(sapply(datapub$table,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  dpIDtmp <- datapub$dpID[1]
  tempID <- unlist(sapply(datapub$timeDescription,function(x){q <-paste("SELECT tmpID FROM TemporalIndex WHERE dpID = ", "'",dpIDtmp,"'", "AND timeDesc = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  spaceID <- unlist(sapply(datapub$spatialDescription,function(x){q <-paste("SELECT spatialID FROM SpatialIndex WHERE dpID = ", "'",dpIDtmp,"'", "AND spatialDesc = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  horID <- NA
  verID <- NA
  ## Add column ID's
  datapub <- datapub %.% group_by(table) %.% mutate(columnID = 1:length(table))
  
  tabledefDF <- as.data.frame(cbind(unname(termID),unname(unitsID),unname(dataTypeID),unname(tempID),horID,verID,unname(spaceID),unname(tableID),datapub$columnID))  
  colnames(tabledefDF) <- c("termID","unitsID","dataTypeID","tempID","horID","verID","spaceID","tableID","columnID")
  addTblDef(tabledefDF,db)
  
  
}
