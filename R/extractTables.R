#' extract DPD, TempRes, and SpRes tables from input ingest or publication worksheet
#' @export
#' @import RSQLite


extractTables <- function(tab) {
  dpd <- tab[1,c("dpID","DPName","DPDescription","dpID")]
  dpd[,4] <- substr(tab$dpID[1],17,17)
  colnames(dpd) <- c("dpID","name","description","level")
  dpd$rev <- 1
  
  num.times <- length(unique(tab$timeDescription))
  temporal <- data.frame(matrix(data=NA,ncol=3,nrow=num.times))
  for(i in 1:num.times) {
    temporal[i,1] <- tab[which(tab$timeDescription==unique(tab$timeDescription)[i])[1],
                         "dpID"]
    temporal[i,2] <- i
    temporal[i,3] <- tab[which(tab$timeDescription==unique(tab$timeDescription)[i])[1],
                         "timeDescription"]
  }
  colnames(temporal) <- c("dpID","timeInd","timeDesc")
  
  num.space <- length(unique(tab$spatialDescription))
  space <- data.frame(matrix(data=NA,ncol=3,nrow=num.space))
  for(i in 1:num.space) {
    space[i,1] <- tab[which(tab$spatialDescription==unique(tab$spatialDescription)[i])[1],
                         "dpID"]
    space[i,2] <- i
    space[i,3] <- tab[which(tab$spatialDescription==unique(tab$spatialDescription)[i])[1],
                         "spatialDescription"]
  }
  colnames(space) <- c("dpID","spatialInd","spatialDesc")
  
  return(list(dpd, temporal, space))
}
