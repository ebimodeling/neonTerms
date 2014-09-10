#' extract DPD, TempRes, and SpRes tables from input ingest or publication worksheet
#' @export
#' @import RSQLite


extractTables <- function(tab) {
  dpd <- tab[1,c("DPNumber","DPName","Dpdescription","DPNumber","Protocol.C3")]
  dpd[,4] <- substr(tab$DPNumber[1],17,17)
  colnames(dpd) <- c("dpID","name","description","level","specDoc")
  dpd$rev <- 1
  
  num.times <- length(unique(tab$sampleFrequency))
  temporal <- data.frame(matrix(data=NA,ncol=3,nrow=num.times))
  for(i in 1:num.times) {
    temporal[i,1] <- tab[which(tab$sampleFrequency==unique(tab$sampleFrequency))[i],
                         "DPNumber"]
    temporal[i,2] <- i
    temporal[i,3] <- tab[which(tab$sampleFrequency==unique(tab$sampleFrequency))[i],
                         "sampleFrequency"]
  }
  colnames(temporal) <- c("dpID","timeInd","timeDesc")
  
  # TEMPORARY SOLUTION FOR OS DATA ONLY: auto-populate spatial index as 001 for all L1s, PLT for all L0s
  space <- tab[1,c("DPNumber","DPName","Dpdescription")]
  space[,2] <- ifelse(substr(tab$DPNumber[1],17,17)==0, "PLT", 1)
  space[,3] <- ifelse(substr(tab$DPNumber[1],17,17)==0, "Plot", "Variable")
  colnames(space) <- c("dpID","spatialInd","spatialDesc")
  
  return(list(dpd, temporal, space))
}
