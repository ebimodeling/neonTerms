#' Generate full ID's for L1's
#' @export

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
  fullIDs <- cbind(out$dpID,rev,tmp,spat,terms,tbl)
  return(apply(fullIDs,1,paste,collapse="."))
  
}
