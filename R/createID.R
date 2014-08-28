#' assign a uniue ID
#' @description Will assign a unique ID to a new set of rows by picking up at the end of the id's in the table
#' @param numid The number of new id's to return
#' @param tbl the table to get id's from
#' @param db the database name
#' @return a vector of true and false indicating which rows of potential input should be added to the database
#' @export

createID <- function(numid, tbl,db){
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  q1 <- paste("PRAGMA table_info(",tbl,")",sep="")
  eids <- dbGetQuery(conn = dbC, q1)
  q2 <- paste("SELECT",eids$name[1],"FROM",tbl,sep=" ")
  
  out <- dbGetQuery(conn = dbC, q2)
  if(length(out[[1]]) == 0){
    newids <-  1:numid
  
  } else {
  newids <- (max(out[[1]])+1):(numid+max(out[[1]])) 
  }
  if(numid == 0){newids <- vector()}
  return(newids)
}

