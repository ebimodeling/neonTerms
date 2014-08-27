#' check duplicates
#' @description strip duplicates from potential database inputs
#' @param input a vector from a dataframe that you want to strip duplicates from
#' @param tbl the table to check for duplicates in.
#' @param db the database name
#' @param the field in the table
#' @return a vector of true and false indicating which rows of potential input should be added to the database
#' @export

stripDupes <- function(input, tbl, db, field){
  drv <- dbDriver("SQLite")
  
  dbC <- dbConnect(drv, dbname = db)
  q <- paste("SELECT",field,"FROM",tbl,sep=" ")
  out <- unlist(dbGetQuery(conn = dbC, q))
  return(!input %in% out)
  #dindex <- sapply(input, function(x,y){ind <- grep(x,y);ifelse(length(ind) > 0, for(i in ind){ifelse(x == y[i],return(TRUE),return(FALSE))},return(FALSE))},y=out)
  
  #return(dindex)
  
}
