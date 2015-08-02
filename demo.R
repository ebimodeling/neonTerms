library(roxygen2)
roxygenise(".")
library(devtools)

dev_mode()
install(".")
library(neonTerms)
options(stringsAsFactors = F)

createDB("test.sqlite")
db <- "test.sqlite"

options(termDB = "test.sqlite")


dpd <- read.csv("testdata/dpd.csv")
space <- read.csv("testdata/spatial.csv")
temporal <- read.csv("testdata/temporal.csv")
datapub <- read.csv("testdata/mam_datain_test.csv")
genIS <- read.csv("testdata/genericIS_L1.csv")


## Add rev numbers

dpd$rev <- 1

## Ok now let's just add the tables

addDPD(dpd)
addTempRes(temporal)
addSpRes(space)
inputDataPub(datapub,db)
inputDataPub(genIS,db)

## I input a generic table, so we can make extra linkages by adding a new entry to the table description table
toAdd <- data.frame(c("NEON.DOM.SIT.DP1.00002","NEON.DOM.SIT.DP1.00003"))
toAdd <- cbind(c(3,3),toAdd)
colnames(toAdd) <- c("tableID","dpID")
addTDPL(toAdd)


drv <- dbDriver("SQLite")
dbC <- dbConnect(drv, dbname = db)


## Get all tables associated with a dataProduct ID
q <- "SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, TermDefinition.termName,TermDefinition.termDefinition  FROM TableDPLink
INNER JOIN TableDefinition
  ON TableDPLink.dpID = 'NEON.DOM.SIT.DP1.00003' AND TableDPLink.tableID = TableDefinition.tableID
INNER JOIN TermDefinition 
ON TermDefinition.termID = TableDefinition.termID
"

out <- dbGetQuery(conn = dbC, q)


## Try it again on smammal

q <- "SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, TermDefinition.termName  FROM TableDPLink
INNER JOIN TableDefinition
ON TableDPLink.dpID = 'NEON.DOM.SIT.DP0.10001' AND TableDPLink.tableID = TableDefinition.tableID
INNER JOIN TermDefinition 
ON TermDefinition.termID = TableDefinition.termID
"

out <- dbGetQuery(conn = dbC, q)

q <- "SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, TermDefinition.termName,
SpatialResolution.spatialRes,SpatialResolution.spatialDesc,TemporalResolution.timeRes,TemporalResolution.timeDesc
FROM TableDPLink
INNER JOIN TableDefinition
ON TableDPLink.dpID = 'NEON.DOM.SIT.DP0.10001' AND TableDPLink.tableID = TableDefinition.tableID
INNER JOIN TermDefinition 
ON TermDefinition.termID = TableDefinition.termID
INNER JOIN SpatialResolution
ON TableDPLink.dpID = SpatialResolution.dpID
INNER JOIN TemporalResolution
ON TableDPLink.dpID = TemporalResolution.dpID
ORDER BY TableDefinition.tableID,SpatialResolution.spatialRes,TemporalResolution.timeRes,TableDefinition.termID"
out <- dbGetQuery(conn = dbC, q)

###Display unique ID for a given field
out$fullID <- genFieldUID(out,db)
out







genFieldUID <- function(out,db){
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname = db)
  q <- paste("SELECT rev FROM DataProductDescription WHERE dpID = ","'",out$dpID[1],"'",sep="")
  rev <-  dbGetQuery(conn = dbC, q)
  s <- dim(out)[1]
  rev <- rep(addBuff(3,rev),s)
  spat <- sapply(out$spatialRes,addBuff,buf=3) 
  tmp <- sapply(out$timeRes,addBuff,buf=3)
  tbl <- sapply(out$tableID,addBuff,buf=3)
  terms <- sapply(out$termID,addBuff,buf=5)
  fullIDs <- cbind(out$dpID,tmp,spat,rev,terms,tbl)
  return(apply(fullIDs,1,paste,collapse="."))
  
}

addBuff <- function(buf, num){
  num <- as.character(num)
  if(buf-nchar(num) > 0){
   tocat <- paste(rep("0",(buf-nchar(num))),collapse="")
  } else {
    stop("Your buffer character size is too small, make it BIG!")
  }
  return(paste(tocat,num,sep=""))
  
}