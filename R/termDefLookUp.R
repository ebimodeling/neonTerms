#' checks terms in an input workbook against existing terms in the database
#' returns a data frame of termName, description given in the workbook, and 
#' description in the database if the descriptions don't match
#' @export
#' @import RSQLite

termDefLookUp <- function(wk) {
  
  termsIn <- wk[,colnames(wk) %in% c("fieldName","description")]
  termsIn <- termsIn[!duplicated(termsIn$fieldName),]
  
  q <- "SELECT TermDefinition.termName, TermDefinition.termDefinition FROM TermDefinition"
  out <- dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)
  
  termsUsed <- termsIn[termsIn$fieldName %in% out[,1],]
  
  defs <- vector("character", nrow(termsUsed))
  for(i in 1:nrow(termsUsed)) {
    defs[i] <- ifelse(termsUsed$description[i] %in% out[,2], "", 
                      out[which(out[,1]==termsUsed$fieldName[i]),2])
  }
  
  termsUsed <- cbind(termsUsed,defs)
  colnames(termsUsed) <- c("termName","description","databaseDefinition")
  return(termsUsed)
  
}
