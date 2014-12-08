# Packages needed - you only need to run these once to install them:
install.packages("devtools")
install.packages("dplyr")
install.packages("Rcpp")
install.packages("roxygen2")
install.packages("RSQLite")
################################


# The commands in this file will re-populate the database with all data products
# that have been ingested to date.
# NEVER DELETE THE TERM DEFINITION TABLE
# NEVER DELETE THE TERM DEFINITION TABLE
# If you need to regenerate the database using these commands, first take the
# existing database, create a copy that will become the new database, and
# manually delete every table in it other than the term definition table.
# This is necessary to avoid any inadvertent re-numbering of term IDs.


library(RSQLite)
library(devtools)
library(roxygen2)
install_github("NEONdps/neonTerms")
library(neonTerms)
setwd("/Users/clunch/neonTerms")
roxygenise(".")

options(stringsAsFactors=F, strip.white=T)

# STOP. Do you need to do this step? if a data base with this name already exists,
# skip this step
createDB("november.sqlite") 

# carry on
db <- "november.sqlite"
options(termDB="november.sqlite")


# TOS

#small mammal level 0:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/mam_dataingest_NEONDOC001406_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#small mammal level 1:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/mam_datapub_NEONDOC001417_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#beetles level 0:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/bet_dataingest_NEONDOC001400_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#beetles level 1:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/bet_datapub_NEONDOC001411_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#phenology level 0:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/pheFieldSummary_PDA_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#phenology level 1:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/phe_datapub_NEONDOC001420_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#plant diversity level 0:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/div_dataingest_v3_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#plant diversity level 1:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/div_datapub_v3_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#herbaceous clip level 0:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/hbp_dataingest_NEONDOC001920_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#herbaceous clip level 1:
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/hbp_datapub_NEONDOC001931_termIngest.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


# TIS

# PAR
datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/IS_PAR_1_min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/dataPubPAR30min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])



