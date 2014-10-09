#' extract DPD, TempRes, and SpRes tables from input ingest or publication worksheet
#' @export
#' @import RSQLite


extractTablesIS <- function(tab) {
  dpd <- tab[1,c("DPNumber","DPName","Dpdescription","DPNumber","Protocol.C3")]
  dpd[,4] <- substr(tab$DPNumber[1],17,17)
  colnames(dpd) <- c("dpID","name","description","level","specDoc")
  dpd$rev <- 1
  
  num.times <- length(unique(tab$timeIndex))
  temporal <- data.frame(matrix(data=NA,ncol=3,nrow=num.times))
  for(i in 1:num.times) {
    temporal[i,1] <- tab[which(tab$timeIndex==unique(tab$timeIndex))[i],
                         "DPNumber"]
    temporal[i,2] <- tab[which(tab$timeIndex==unique(tab$timeIndex))[i],
                         "timeIndex"]
    temporal[i,3] <- tab[which(tab$timeIndex==unique(tab$timeIndex))[i],
                         "timeDescription"]
  }
  colnames(temporal) <- c("dpID","timeInd","timeDesc")
  
  num.hor <- length(unique(tab$horIndex))
  horizontal <- data.frame(matrix(data=NA,ncol=3,nrow=num.hor))
  for(i in 1:num.hor) {
    horizontal[i,1] <- tab[which(tab$horIndex==unique(tab$horIndex))[i],
                         "DPNumber"]
    horizontal[i,2] <- tab[which(tab$horIndex==unique(tab$horIndex))[i],
                         "horIndex"]
    horizontal[i,3] <- tab[which(tab$horIndex==unique(tab$horIndex))[i],
                         "horDescription"]
  }
  colnames(horizontal) <- c("dpID","horInd","horDesc")

  num.vert <- length(unique(tab$vertIndex))
  vertical <- data.frame(matrix(data=NA,ncol=3,nrow=num.vert))
  for(i in 1:num.vert) {
    vertical[i,1] <- tab[which(tab$vertIndex==unique(tab$vertIndex))[i],
                           "DPNumber"]
    vertical[i,2] <- tab[which(tab$vertIndex==unique(tab$vertIndex))[i],
                           "vertIndex"]
    vertical[i,3] <- tab[which(tab$vertIndex==unique(tab$vertIndex))[i],
                           "vertDescription"]
  }
  colnames(vertical) <- c("dpID","verInd","verDesc")
  
  return(list(dpd, temporal, horizontal, vertical))
}
