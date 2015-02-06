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
datapub <- read.csv("/Users/clunch/organismalIPT/phenology/phe_dataingest_NEONDOC001408.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])


#phenology level 1:
datapub <- read.csv("/Users/clunch/organismalIPT/phenology/phe_datapub_NEONDOC001420.csv")
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


# TIS (Derek in planning to move some stuff around on git, so these file paths
# are probably going to have to change)

# PAR
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PAR/1_min/IS_PAR_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PAR/30_min/IS_PAR_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Precip
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/priPrecip/5_min/IS_Pri_Precip_5_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/priPrecip/15_min/IS_Pri_Precip_15_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/secPrecip/1_min/IS_Sec_Precip_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/secPrecip/30_min/IS_Sec_Precip_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/TFPrecip/IS_TFPrecip_1min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/TFPrecip/IS_TFPrecip_30min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])



# SAAT
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/SAAT/1_min/IS_SAAT_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/SAAT/30_min/IS_SAAT_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# TRAAT
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/TRAAT/1_min/IS_TRAAT_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/TRAAT/30_min/IS_TRAAT_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Line PAR
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/LinePAR/1_min/IS_LinePAR_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/LinePAR/30_min/IS_LinePAR_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# 2D Wind
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/2Dwind/2_min/IS_2DWind_2_min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/2Dwind/30_min/IS_2DWind_30_minute.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Barometric pressure
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/baroPres/1_min/IS_baroPres_1_min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/baroPres/30_min/IS_baroPres_30_minute.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Direct, diffuse, and global radiation
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/DirDifGloRadiation/1_min/dirDifRadiation_1_min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/DirDifGloRadiation/30_min/dirDifRadiation_30_minute.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Relative humidity
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/RH/1_min/IS_RH_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/RH/30_min/IS_RH_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Net radiation
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/NetRadiation/1_min/IS_NetRadiation_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/NetRadiation/30_min/IS_NetRadiation_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Soil temperature
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/SoilTemp/1_min/soilTemp_1_min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/SoilTemp/30_min/soilTemp_30_min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Primary pyranometer
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PriShortwave/1_min/datapub_NEONDOC000810_1min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PriShortwave/30_min/datapub_NEONDOC000810_30min.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Biological temperature
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/bioTemp/IS_bioTemp_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/bioTemp/IS_bioTemp_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


# Soil water and salinity
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/soil_water_and_ion_content/IS_soilWaterIonContent_1_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/soil_water_and_ion_content/IS_soilWaterIonContent_30_min_num.csv")
TSDtables <- extractTablesIS(datapub)
inputDataPubIS(datapub,TSDtables[[2]],TSDtables[[3]],TSDtables[[4]],db)
addDPD(TSDtables[[1]])


#stream water chemistry level 0:
datapub <- read.csv("/Users/clunch/biogeochemistryIPT/StreamWaterChem/NEON.DOC.002291_swc_data ingest_01262015.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])

#aquatic field metadata level 0:
datapub <- read.csv("/Users/clunch/biogeochemistryIPT/AquFieldMetadata/NEON.DOC.001627_afm_dataIngest_12312014.csv")
TSDtables <- extractTables(datapub)
inputDataPub(datapub,TSDtables[[2]],TSDtables[[3]],db)
addDPD(TSDtables[[1]])

