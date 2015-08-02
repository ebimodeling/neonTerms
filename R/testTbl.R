
#' Test table
#' @description simple helper function to test whether or not a table exists
#' @param tbl the table name you want to check
#' @param db the database to find the table in
#' @return TRUE if exists, FALSE if not
#' @export

testTbl <- function(tbl,db){
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  q1 <- paste("PRAGMA table_info(",tbl,")",sep="")
  tbltest <- dbGetQuery(conn = dbC, q1)
  
  return(!is.null(tbltest))
}