#' Generate full ID's for L1's
#' @export

genFieldUID <- function(out,db){
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname = db)
  q <- paste("SELECT rev FROM DataProductDescription WHERE dpID = ","'",out$dpID[1],"'",sep="")
  rev <-  dbGetQuery(conn = dbC, q)
  s <- dim(out)[1]
  rev <- rep(addBuff(3,rev),s)
  spat <- sapply(out$spatialInd,addBuff,buf=3)
  tmp <- sapply(out$timeInd,addBuff,buf=3)
  tbl <- sapply(out$tableNum,addBuff,buf=3)
  terms <- sapply(out$termID,addBuff,buf=5)
  fullIDs <- cbind(out$dpID,rev,terms,tbl,spat,tmp)
  ret <- apply(fullIDs,1,paste,collapse=".")
  hooks <- which(out$termName %in% c("date","addDate","collectDate","domainID",
                                     "siteID","plotID","samplingProtocol"))
  ret[hooks] <- rep("", length(hooks))
  return(ret)
}
