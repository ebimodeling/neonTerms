# Packages needed - you only need to run these once to install them:
install.packages("devtools")
install.packages("dplyr")
install.packages("Rcpp")
install.packages("roxygen2")
install.packages("RSQLite")
################################


# The commands in this file will extract a variety of useful information
# from an existing database. If products haven't been ingested into
# the database yet, add the ingest commands to DB_generation_commands, 
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

# finds all uses of a given term in the database
termLookUp("shortRadMean")

# checks term definitions in a new file against existing database
# deprecated in favor of shiny app
divTerms <- termDefLookUp(datapub)


########## TERM ALIGNMENT
# comparing term names against controlled vocabulary list:
controlled <- read.csv("/Users/clunch/organismalIPT/controlFieldNames/Controlled_fieldNames.csv", 
                       strip.white=T)
head(controlled)
colnames(controlled)[3:4] <- c("fieldName","description")
controlTerms <- termDefLookUp(controlled)
write.table(controlTerms, file="term compare.csv", sep=",", row.names=F)

# find term names not present in controlled vocabulary list
q <- "SELECT TermDefinition.termName, TermDefinition.termDefinition FROM TermDefinition"
out <- dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)
termsNotIn <- out[!(out[,1] %in% controlled$fieldName),]
write.table(termsNotIn, file="database terms not in controlled fields.csv", 
            sep=",", row.names=F)

##############




###########################################
# other junk, just me playing around

dbListTables(dbConnect(dbDriver("SQLite"),db))
dbListFields(dbConnect(dbDriver("SQLite"),db), "DataProductDescription")

q <- "SELECT DataProductDescription.name FROM DataProductDescription"
dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)

###
# this updates DP name:
UPDATE "main"."DataProductDescription" SET "name" = ?1 WHERE  "rowid" = 3
Parameters:
  param 1 (text): Ground beetles sampled from pitfall traps

# and this updates spatial index:
UPDATE "main"."SpatialIndex" SET "spatialInd" = ?1 WHERE  "rowid" = 3
Parameters:
  param 1 (integer): 1
###

head(out)

# trying running queries outside of qFull function
dpID <- "NEON.DOM.SITE.DP0.10001"
q <- paste("SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, 
           TermDefinition.termName,\nSpatialIndex.spatialInd,SpatialIndex.spatialDesc,
           TemporalIndex.timeInd,TemporalIndex.timeDesc\nFROM TableDPLink\nINNER JOIN 
           TableDefinition\nON TableDPLink.dpID = '", dpID, "' AND TableDPLink.tableID = 
           TableDefinition.tableID\nINNER JOIN TermDefinition \nON TermDefinition.termID = 
           TableDefinition.termID\nINNER JOIN SpatialIndex\nON TableDPLink.dpID = 
           SpatialIndex.dpID\nINNER JOIN TemporalIndex\nON TableDPLink.dpID = 
           TemporalIndex.dpID\nORDER BY TableDefinition.tableID,SpatialIndex.spatialInd,
           TemporalIndex.timeInd,TableDefinition.termID", sep = "")
dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)

# query for IS products outside of qFull function
dpID <- "NEON.DOM.SITE.DP1.00024"
q <- paste("SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, 
           TermDefinition.termName,\nVerticalIndex.verInd,VerticalIndex.verDesc,
           TemporalIndex.timeInd,TemporalIndex.timeDesc\nFROM TableDPLink\nINNER JOIN 
           TableDefinition\nON TableDPLink.dpID = '", dpID, "' AND TableDPLink.tableID = 
           TableDefinition.tableID\nINNER JOIN TermDefinition \nON TermDefinition.termID = 
           TableDefinition.termID\nINNER JOIN VerticalIndex\nON TableDPLink.dpID = 
           VerticalIndex.dpID\nINNER JOIN TemporalIndex\nON TableDPLink.dpID = 
           TemporalIndex.dpID\nORDER BY TableDefinition.tableID,VerticalIndex.verInd,
           TemporalIndex.timeInd,TableDefinition.termID", sep = "")
dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)

q <- paste("SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, 
           TermDefinition.termName FROM TableDPLink, 
           TableDefinition,TermDefinition
           WHERE TableDPLink.dpID = '", dpID, "' AND TableDPLink.tableID = 
           TableDefinition.tableID AND TermDefinition.termID = TableDefinition.termID",
           sep="")
dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)





# get all uses of uid
q <- "SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, 
           TermDefinition.termName,\nSpatialResolution.spatialRes,SpatialResolution.spatialDesc,
           TemporalResolution.timeRes,TemporalResolution.timeDesc\nFROM TableDPLink\nINNER JOIN 
           TableDefinition\nON TermDefinition.termName = 'uid' AND TableDPLink.tableID = 
           TableDefinition.tableID\nINNER JOIN TermDefinition \nON TermDefinition.termID = 
           TableDefinition.termID\nINNER JOIN SpatialResolution\nON TableDPLink.dpID = 
           SpatialResolution.dpID\nINNER JOIN TemporalResolution\nON TableDPLink.dpID = 
           TemporalResolution.dpID\nORDER BY TableDefinition.tableID,SpatialResolution.spatialRes,
           TemporalResolution.timeRes,TableDefinition.termID"
dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)

# get all 30 min temporal resolution with term definitions included
q <- "SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, 
           TermDefinition.termName, TermDefinition.termDefinition,
           \nSpatialResolution.spatialRes,SpatialResolution.spatialDesc,
           TemporalResolution.timeRes,TemporalResolution.timeDesc\nFROM TableDPLink\nINNER JOIN 
           TableDefinition\nON TemporalResolution.timeDesc = '30 Minute averages' AND TableDPLink.tableID = 
           TableDefinition.tableID\nINNER JOIN TermDefinition \nON TermDefinition.termID = 
           TableDefinition.termID\nINNER JOIN SpatialResolution\nON TableDPLink.dpID = 
           SpatialResolution.dpID\nINNER JOIN TemporalResolution\nON TableDPLink.dpID = 
           TemporalResolution.dpID\nORDER BY TableDefinition.tableID,SpatialResolution.spatialRes,
           TemporalResolution.timeRes,TableDefinition.termID"
dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)

# pull by DP name instead of number
q <- paste("SELECT TableDPLink.dpID, TableDefinition.termID, TableDefinition.tableID, 
           TermDefinition.termName,\nSpatialResolution.spatialRes,SpatialResolution.spatialDesc,
           TemporalResolution.timeRes,TemporalResolution.timeDesc\nFROM TableDPLink\nINNER JOIN 
           TableDefinition\nON DataProductDescription.name = 'Triple aspirated air temperature' 
           AND TableDPLink.tableID = 
           TableDefinition.tableID\nINNER JOIN TermDefinition \nON TermDefinition.termID = 
           TableDefinition.termID\nINNER JOIN SpatialResolution\nON TableDPLink.dpID = 
           SpatialResolution.dpID\nINNER JOIN TemporalResolution\nON TableDPLink.dpID = 
           TemporalResolution.dpID\nORDER BY TableDefinition.tableID,SpatialResolution.spatialRes,
           TemporalResolution.timeRes,TableDefinition.termID", sep = "")
dbGetQuery(dbConnect(dbDriver("SQLite"),db), q)
# doesn't work - keeps saying no such column for any column header in DataProductDescription

# to remove single tables from database:
dbRemoveTable(dbConnect(dbDriver("SQLite"),db), "DataProductDescription")

