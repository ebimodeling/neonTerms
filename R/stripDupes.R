#' check duplicates
#' @description strip duplicates from potential database inputs
#' @param input a vector from a dataframe that you want to strip duplicates from
#' @param tbl the table to check for duplicates in.
#' @param db the database name
#' @param the field in the table
#' @return a vector of true and false indicating which rows of potential input should be added to the database
#' @export

stripDupes <- function(input, tbl, db, field){
  
  db <- dbConnect(drv, dbname = db)
  q <- paste("SELECT",field,"FROM",tbl,sep=" ")
  out <- dbGetQuery(conn = db, q)
  
  dindex <- sapply(input, function(x,y){ind <- grep(x,y);for(i in ind){ifelse(x == y[i],return(TRUE),return(FALSE))}},y=out)
  
  return(dindex)
  
}