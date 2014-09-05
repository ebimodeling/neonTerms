#' get full query
#' @export
#' 

qFull <- function(dpID,db) {
  
  drv <- dbDriver("SQLite")
dbC <- dbConnect(drv, dbname = db)


q <- paste("SELECT TableDPLink.dpID, TableDefinition.rowid, TableDefinition.termID, TableDefinition.tableID, TermDefinition.termName,
SpatialResolution.spatialRes,SpatialResolution.spatialDesc,TemporalResolution.timeRes,TemporalResolution.timeDesc, TableDPLink.tableNum
FROM TableDPLink
INNER JOIN TableDefinition
ON TableDPLink.dpID = '",dpID,"' AND TableDPLink.tableID = TableDefinition.tableID
INNER JOIN TableDescription
ON TableDPLink.tableID = TableDescription.tableID
INNER JOIN TermDefinition 
ON TermDefinition.termID = TableDefinition.termID
INNER JOIN SpatialResolution
ON TableDPLink.dpID = SpatialResolution.dpID
INNER JOIN TemporalResolution
ON TableDPLink.dpID = TemporalResolution.dpID
ORDER BY TableDefinition.tableID,SpatialResolution.spatialRes,TemporalResolution.timeRes,TableDefinition.rowid",sep = "")
out <- dbGetQuery(conn = dbC, q)

return(out)

}