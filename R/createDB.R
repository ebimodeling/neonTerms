#' create DB
#' @description This will create an sqlite3 database for you.  
#' @param path the path and name of your database. E.g. "test.sqlite" will create a database of that name in your current working directory
#' @details You'll just need to call this once to create your database
#' @example
#' 
#' @export
#' @import RSQLite

createDB <- function(path){
  drv <- dbDriver("SQLite")
  dbname <- path
  db <- dbConnect(drv, dbname=dbname)
}