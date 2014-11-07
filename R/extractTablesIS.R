#' extract DPD, TempRes, and SpRes tables from input ingest or publication worksheet
#' @export
#' @import RSQLite


extractTablesIS <- function(tab) {
  dpd <- tab[1,c("dpID","DPName","DPDescription","dpID")]
  dpd[,4] <- substr(tab$dpID[1],17,17)
  colnames(dpd) <- c("dpID","name","description","level")
  dpd$rev <- 1
    
  num.times <- length(unique(tab$timeIndex))
  temporal <- data.frame(matrix(data=NA,ncol=3,nrow=num.times))
  for(i in 1:num.times) {
    temporal[i,1] <- tab[which(tab$timeIndex==unique(tab$timeIndex)[i])[1],
                         "dpID"]
    temporal[i,2] <- tab[which(tab$timeIndex==unique(tab$timeIndex)[i])[1],
                         "timeIndex"]
    temporal[i,3] <- tab[which(tab$timeIndex==unique(tab$timeIndex)[i])[1],
                         "timeDescription"]
  }
  colnames(temporal) <- c("dpID","timeInd","timeDesc")
  
  num.hor <- length(unique(tab$horIndex))
  horizontal <- data.frame(matrix(data=NA,ncol=3,nrow=num.hor))
  for(i in 1:num.hor) {
    horizontal[i,1] <- tab[which(tab$horIndex==unique(tab$horIndex)[i])[1],
                         "dpID"]
    horizontal[i,2] <- tab[which(tab$horIndex==unique(tab$horIndex)[i])[1],
                         "horIndex"]
    horizontal[i,3] <- tab[which(tab$horIndex==unique(tab$horIndex)[i])[1],
                         "horDescription"]
  }
  colnames(horizontal) <- c("dpID","horInd","horDesc")

  num.vert <- length(unique(tab$vertIndex))
  vertical <- data.frame(matrix(data=NA,ncol=3,nrow=num.vert))
  for(i in 1:num.vert) {
    vertical[i,1] <- tab[which(tab$vertIndex==unique(tab$vertIndex)[i])[1],
                           "dpID"]
    vertical[i,2] <- tab[which(tab$vertIndex==unique(tab$vertIndex)[i])[1],
                           "vertIndex"]
    vertical[i,3] <- tab[which(tab$vertIndex==unique(tab$vertIndex)[i])[1],
                           "vertDescription"]
  }
  colnames(vertical) <- c("dpID","verInd","verDesc")
  
  return(list(dpd, temporal, horizontal, vertical))
}
