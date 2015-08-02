#' Generate full ID's for L1's
#' @export

genISID <- function(out,db){
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname = db)
  #q <- paste("SELECT rev FROM DataProductDescription WHERE dpID = ","'",out$dpID[1],"'",sep="")
  #rev <-  dbGetQuery(conn = dbC, q)
  s <- dim(out)[1]
  #rev <- rep(addBuff(3,rev),s)
  hor <- sapply(out$horInd,addBuff,buf=3)
  ver <- sapply(out$verInd,addBuff,buf=3)
  tmp <- sapply(out$timeInd,addBuff,buf=3)
  terms <- sapply(out$termID,addBuff,buf=5)
  fullIDs <- cbind(out$dpID,terms,hor,ver,tmp)
  ret <- apply(fullIDs,1,paste,collapse=".")
  hooks <- which(out$termName %in% c("date","addDate","collectDate","startDate","endDate","domainID",
                                     "siteID","plotID","stationID","samplingProtocol"))
  ret[hooks] <- rep("", length(hooks))
  return(ret)
}
