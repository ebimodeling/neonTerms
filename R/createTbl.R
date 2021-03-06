#' create a database table
#' @description This will create a table for you from named list of terms and types
#' @param tbl the name of the table to create
#' @param db the database to create the table in
#' @param namelist A named list of table headings
#' @param types A list of types that each column should be, e.g. TEXT or INT
#' 
#' @examples \dontrun{
#'  tbl <- "mytable"
#'  db <- "test.db"
#'  namelist <- c("id","desc")
#'  types <- c("INT","TEXT")
#'  createTbl(tbl,db,namelist,types)
#' } 
#' @export

createTbl <- function(tbl,db,namelist,types){
  drv <- dbDriver("SQLite")
  dbC <- dbConnect(drv, dbname=db)
  pre <- paste("CREATE TABLE ",tbl, "(",sep="")
  ### Add commas
  types[1:(length(types)-1)] <- sapply(types[1:(length(types)-1)],function(x){paste(x,",",sep="")})
  cols <- paste(as.vector(rbind(namelist,types)),collapse=" ")
  fullq <- paste(pre,cols,")",sep="")
  dbSendQuery(conn = dbC, fullq)
  
}
