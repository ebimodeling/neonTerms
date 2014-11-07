# Packages needed - you only need to run these once to install them:
install.packages("devtools")
install.packages("dplyr")
install.packages("Rcpp")
install.packages("roxygen2")
install.packages("RSQLite")
################################


# The commands in this file will generate data product numbers for data
# products that have been ingested into the database. If the products
# haven't been ingested yet, add the ingest commands to DB_generation_commands,
# run them, and come back.



library(RSQLite)
library(devtools)
library(roxygen2)
install_github("NEONdps/neonTerms")
library(neonTerms)
setwd("/Users/clunch/neonTerms")
roxygenise(".")

options(stringsAsFactors=F, strip.white=T)

db <- "november.sqlite"
options(termDB="november.sqlite")


#TOS:
#herbaceous clip level 1:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/hbp_datapub_NEONDOC001931_termIngest.csv")
out <- qFull("NEON.DOM.SITE.DP1.10023",db)
DPNumber <- genFieldUID(out,db)
DPout <- cbind(DPNumber,datapub)
write.table(DPout, "/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/hbp_L1.csv", 
            row.names=F, quote=F, sep=",")


# TIS:
# PAR:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/PAR_IS_termIngest.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00024",db)
DPNumber <- genISID(out,db)
DPout <- cbind(DPNumber,datapub)
write.csv(DPout,"/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/PAR_IS_termIngest_num.csv",
          row.names=F)

