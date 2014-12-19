#' input an *IS data publication workbook into the db
#' @description Based on a standard template, input a data publication workbook
#' @export
#' @import dplyr
inputDataPubIS <- function(datapub,temporal,horizontal,vertical,db){
  ### Create terms dataframe
  tdfname <- c("fieldName","description")
  termDF <- datapub[,colnames(datapub)%in%tdfname]
  ## Strip out duplicates
  termDF <- termDF[!duplicated(termDF$fieldName),]
  colnames(termDF) <- c("termName","termDefinition")
  addTermDef(termDF,db)
  
  
  ### Add to the table description - NO TABLES in IS, but still need table info to 
  ### join properly - define one table per spaceXtime combination in an IS product
  tbdfname <- c("table","tableDescription")
  tabletemp <- datapub[,c("dpID","horIndex","vertIndex","timeIndex")]
  tabledescDF <- data.frame(cbind(paste(substr(tabletemp$dpID, 15, 23), "TAB", 
                                        tabletemp$horIndex, tabletemp$vertIndex, 
                                    tabletemp$timeIndex, sep=""),
                   paste("HOR", tabletemp$horIndex, ".VER", tabletemp$vertIndex, 
                         ".TMI", tabletemp$timeIndex, substr(tabletemp$dpID,15,23), sep="")))
  ### the order is important and must match the expectation of the table, this 
  ### mapping will have to change if the spreadsheet input changes
  colnames(tabledescDF) <- c("tableName","tableDesc")
  datapub <- cbind(tabledescDF$tableName, datapub)
  colnames(datapub)[1] <- "tableName"
  tabledescDF <- tabledescDF[!duplicated(tabledescDF$tableName),]
  addTblDesc(tabledescDF,db)
  
  ### Add to the link table
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  
  tlinkname <- c("table","dpID") 
  tlinkDF <- data.frame(cbind(tabledescDF$tableName, datapub$dpID))
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
  
  ### Add to the data type table
  datatypeDF <- data.frame(datapub[,c("dataType")])
  colnames(datatypeDF) <- c("dataType")
  datatypeDF <- data.frame(datatypeDF[!duplicated(datatypeDF$dataType),])
  colnames(datatypeDF) <- c("dataType")
  addDTTbl(datatypeDF,db)
  
  ## Add to the spatial and temporal tables
  addTempInd(temporal)
  addSpIndHor(horizontal)
  addSpIndVer(vertical)
  
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
  tableID <- unlist(sapply(datapub$tableName,function(x){q <-paste("SELECT tableID FROM TableDescription WHERE tableName = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  dpIDtmp <- datapub$dpID[1]
  tempID <- unlist(sapply(datapub$timeDescription,function(x){q <-paste("SELECT tmpID FROM TemporalIndex WHERE dpID = ", "'",dpIDtmp,"'", "AND timeDesc = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  horID <- unlist(sapply(datapub$horDescription,function(x){q <-paste("SELECT spatialID FROM HorizontalIndex WHERE dpID = ", "'",dpIDtmp,"'", "AND horDesc = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  verID <- unlist(sapply(datapub$vertDescription,function(x){q <-paste("SELECT spatialID FROM VerticalIndex WHERE dpID = ", "'",dpIDtmp,"'", "AND verDesc = ", "'",x,"'",sep="");return(dbGetQuery(conn = dbC, q))}))
  spaceID <- NA
  ## Add column ID's
  datapub <- datapub %.% group_by(tableName) %.% mutate(columnID = 1:length(tableName))
  
  tabledefDF <- as.data.frame(cbind(unname(termID),unname(unitsID),unname(dataTypeID),unname(tempID),unname(horID),unname(verID),spaceID,unname(tableID),datapub$columnID))  
  colnames(tabledefDF) <- c("termID","unitsID","dataTypeID","tempID","horID","verID","spaceID","tableID","columnID")
  addTblDef(tabledefDF,db)
  

}
