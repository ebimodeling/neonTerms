#' output all uses of a given term, in a table of dpID, termID, tableID, termName, DPName
#' @export
#' @import RSQLite

termLookUp <- function(x) {
  
  q <- paste("SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, 
TermDefinition.termName, \nDataProductDescription.name \nFROM TableDPLink\nINNER JOIN 
TableDefinition\nON TermDefinition.termName = '", x, "' AND TableDPLink.tableID = 
TableDefinition.tableID\nINNER JOIN TermDefinition \nON TermDefinition.termID = 
TableDefinition.termID\nINNER JOIN DataProductDescription\nON TableDPLink.dpID = 
DataProductDescription.dpID\nORDER BY TableDefinition.tableID,
TableDefinition.termID", sep="")
  
  return(dbGetQuery(dbConnect(dbDriver("SQLite"),db), q))
  
}