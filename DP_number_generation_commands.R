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
DPout$DPNumber[grep("sample",DPout$sampleInfo)] <- rep("", length(grep("sample",DPout$sampleInfo)))
write.table(DPout, "/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/hbp_L1.csv", 
            row.names=F, quote=F, sep=",")


datapub <- read.csv("/Users/clunch/Dropbox/DPS Public/DPS Docs/TermsDB/hbp_dataingest_NEONDOC001920_termIngest.csv")
out <- qFull("NEON.DOM.SITE.DP0.10005",db)
DPNumber <- genFieldUID(out,db)
DPout <- cbind(DPNumber,datapub)



#stream water chemistry level 0:
datapub <- read.csv("/Users/clunch/biogeochemistryIPT/StreamWaterChem/NEON.DOC.002291_swc_data ingest_01262015.csv")
out <- qFull("NEON.DOM.SITE.DP0.20093",db)
DPNumber <- genFieldUID(out,db)
DPout <- datapub
DPout$DPNumber <- DPNumber
DPout$DPNumber[grep("sample",DPout$sampleInfo,ignore.case=T)] <- 
  rep("", length(grep("sample",DPout$sampleInfo,ignore.case=T)))
write.table(DPout, "/Users/clunch/biogeochemistryIPT/StreamWaterChem/NEON.DOC.002291_swc_data ingest_01262015.csv", 
            row.names=F, quote=F, sep=",")


#aquatic field metadata level 0:
datapub <- read.csv("/Users/clunch/biogeochemistryIPT/AquFieldMetadata/NEON.DOC.001627_afm_dataIngest_12312014.csv")
out <- qFull("NEON.DOM.SITE.DP0.20000",db)
DPNumber <- genFieldUID(out,db)
DPout <- datapub
DPout$DPNumber <- DPNumber
DPout$DPNumber[grep("sample",DPout$sampleInfo,ignore.case=T)] <- 
  rep("", length(grep("sample",DPout$sampleInfo,ignore.case=T)))
write.table(DPout, "/Users/clunch/biogeochemistryIPT/AquFieldMetadata/NEON.DOC.001627_afm_dataIngest_12312014.csv", 
            row.names=F, quote=F, sep=",")




# TIS:
# PAR:
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PAR/1_min/IS_PAR_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00024",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PAR/1_min/IS_PAR_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PAR/30_min/IS_PAR_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00024",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PAR/30_min/IS_PAR_30_min_num.csv",
          row.names=F)

# Precip
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/priPrecip/5_min/IS_Pri_Precip_5_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00006",db)
out <- out[which(out$timeInd==5),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/priPrecip/5_min/IS_Pri_Precip_5_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/priPrecip/15_min/IS_Pri_Precip_15_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00006",db)
out <- out[which(out$timeInd==15),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/priPrecip/15_min/IS_Pri_Precip_15_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/secPrecip/1_min/IS_Sec_Precip_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00006",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/secPrecip/1_min/IS_Sec_Precip_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/secPrecip/30_min/IS_Sec_Precip_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00006",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/secPrecip/30_min/IS_Sec_Precip_30_min_num.csv",
          row.names=F)


datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/TFPrecip/IS_TFPrecip_1min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00006",db)
out <- out[which(out$tableName=="DP1.00006TFHORVER001"),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/TFPrecip/IS_TFPrecip_1min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/TFPrecip/IS_TFPrecip_30min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00006",db)
out <- out[which(out$tableName=="DP1.00006TFHORVER030"),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Precip/TFPrecip/IS_TFPrecip_30min_num.csv",
          row.names=F)




# SAAT
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/SAAT/1_min/IS_SAAT_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00002",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/SAAT/1_min/IS_SAAT_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/SAAT/30_min/IS_SAAT_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00002",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/SAAT/30_min/IS_SAAT_30_min_num.csv",
          row.names=F)


# TRAAT
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/TRAAT/1_min/IS_TRAAT_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00003",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/TRAAT/1_min/IS_TRAAT_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/TRAAT/30_min/IS_TRAAT_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00003",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/Temp/TRAAT/30_min/IS_TRAAT_30_min_num.csv",
          row.names=F)


# Line PAR
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/LinePAR/1_min/IS_LinePAR_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00066",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/LinePAR/1_min/IS_LinePAR_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/LinePAR/30_min/IS_LinePAR_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00066",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/LinePAR/30_min/IS_LinePAR_30_min_num.csv",
          row.names=F)


# 2D Wind
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/2Dwind/2_min/IS_2DWind_2_min.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00001",db)
out <- out[which(out$timeInd==2),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/2Dwind/2_min/IS_2DWind_2_min.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/2Dwind/30_min/IS_2DWind_30_minute.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00001",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/2Dwind/30_min/IS_2DWind_30_minute.csv",
          row.names=F)


# Barometric pressure
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/baroPres/1_min/IS_baroPres_1_min.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00004",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/baroPres/1_min/IS_baroPres_1_min.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/baroPres/30_min/IS_baroPres_30_minute.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00004",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/baroPres/30_min/IS_baroPres_30_minute.csv",
          row.names=F)


# Direct, diffuse, and global radiation
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/DirDifGloRadiation/1_min/dirDifRadiation_1_min.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00014",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/DirDifGloRadiation/1_min/dirDifRadiation_1_min.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/DirDifGloRadiation/30_min/dirDifRadiation_30_minute.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00014",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/DirDifGloRadiation/30_min/dirDifRadiation_30_minute.csv",
          row.names=F)



# Relative humidity
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/RH/1_min/IS_RH_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00098",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/RH/1_min/IS_RH_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/RH/30_min/IS_RH_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00098",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/RH/30_min/IS_RH_30_min_num.csv",
          row.names=F)



# Net radiation
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/NetRadiation/1_min/IS_NetRadiation_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00023",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/NetRadiation/1_min/IS_NetRadiation_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/NetRadiation/30_min/IS_NetRadiation_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00023",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/NetRadiation/30_min/IS_NetRadiation_30_min_num.csv",
          row.names=F)



# Soil temperature
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/SoilTemp/1_min/soilTemp_1_min.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00041",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/SoilTemp/1_min/soilTemp_1_min.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/SoilTemp/30_min/soilTemp_30_min.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00041",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/SoilTemp/30_min/soilTemp_30_min.csv",
          row.names=F)


# Primary pyranometer
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PriShortwave/1_min/datapub_NEONDOC000810_1min.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00022",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PriShortwave/1_min/datapub_NEONDOC000810_1min.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PriShortwave/30_min/datapub_NEONDOC000810_30min.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00022",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/PriShortwave/30_min/datapub_NEONDOC000810_30min.csv",
          row.names=F)


# Biological temperature
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/bioTemp/IS_bioTemp_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00005",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/bioTemp/IS_bioTemp_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/bioTemp/IS_bioTemp_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00005",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/bioTemp/IS_bioTemp_30_min_num.csv",
          row.names=F)



# Soil water and salinity
datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/soil_water_and_ion_content/IS_soilWaterIonContent_1_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00094",db)
out <- out[which(out$timeInd==1),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/soil_water_and_ion_content/IS_soilWaterIonContent_1_min_num.csv",
          row.names=F)

datapub <- read.csv("/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/soil_water_and_ion_content/IS_soilWaterIonContent_30_min_num.csv")
out <- qFullIS("NEON.DOM.SITE.DP1.00094",db)
out <- out[which(out$timeInd==30),]
DPNumber <- genISID(out,db)
DPout <- datapub
DPout$table <- out$tableName
DPout$DPNumber <- DPNumber
write.csv(DPout,"/Users/clunch/IS-Data-Publication/Ingest_files_for_Claire/soil_water_and_ion_content/IS_soilWaterIonContent_30_min_num.csv",
          row.names=F)


