#' get full query
#' @export
#' 

qFullIS <- function(dpID,db) {
  
drv <- dbDriver("SQLite")
dbC <- dbConnect(drv, dbname = db)


q <- paste("SELECT TableDPLink.dpID, TableDefinition.rowid, TableDefinition.termID, 
TableDefinition.tableID, TermDefinition.termName,HorizontalIndex.horInd,
HorizontalIndex.horDesc,VerticalIndex.verInd,VerticalIndex.verDesc,
TemporalIndex.timeInd,TemporalIndex.timeDesc,TableDPLink.tableNum
FROM TableDefinition
INNER JOIN TableDPLink
ON TableDPLink.dpID = '",dpID,"' AND TableDefinition.tableID = TableDPLink.tableID
INNER JOIN TermDefinition 
ON TermDefinition.termID = TableDefinition.termID
INNER JOIN HorizontalIndex
ON TableDPLink.dpID = HorizontalIndex.dpID
INNER JOIN VerticalIndex
ON TableDPLink.dpID = VerticalIndex.dpID
INNER JOIN TemporalIndex
ON TableDPLink.dpID = TemporalIndex.dpID
ORDER BY TableDefinition.tableID,HorizontalIndex.horInd,VerticalIndex.verInd,TemporalIndex.timeInd,TableDefinition.rowid",sep = "")
out <- dbGetQuery(conn = dbC, q)

return(out)

}
