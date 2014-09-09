#' get full query
#' @export
#' 

qFull <- function(dpID,db) {
  
  drv <- dbDriver("SQLite")
dbC <- dbConnect(drv, dbname = db)


q <- paste("SELECT TableDPLink.dpID, TableDefinition.rowid, TableDefinition.termID, TableDefinition.tableID, TermDefinition.termName,
SpatialIndex.spatialInd,SpatialIndex.spatialDesc,TemporalIndex.timeInd,TemporalIndex.timeDesc, TableDPLink.tableNum
FROM TableDPLink
INNER JOIN TableDefinition
ON TableDPLink.dpID = '",dpID,"' AND TableDPLink.tableID = TableDefinition.tableID
INNER JOIN TableDescription
ON TableDPLink.tableID = TableDescription.tableID
INNER JOIN TermDefinition 
ON TermDefinition.termID = TableDefinition.termID
INNER JOIN SpatialIndex
ON TableDPLink.dpID = SpatialIndex.dpID
INNER JOIN TemporalIndex
ON TableDPLink.dpID = TemporalIndex.dpID
ORDER BY TableDefinition.tableID,SpatialIndex.spatialInd,TemporalIndex.timeInd,TableDefinition.rowid",sep = "")
out <- dbGetQuery(conn = dbC, q)

return(out)

}