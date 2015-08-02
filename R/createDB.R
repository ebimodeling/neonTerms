#' create DB
#' @description This will create an sqlite3 database for you.  
#' @param path the path and name of your database. E.g. "test.sqlite" will create a database of that name in your current working directory
#' @details You'll just need to call this once to create your database
#' 
#' @export
#' @import RSQLite

createDB <- function(path){
  if (file.exists(path)){
    print ('the database you are trying to create already exists,please choose a different name or delete that database and try again')
  }
  if (!file.exists(path)){
    drv <- dbDriver("SQLite")
    dbname <- path
    dbC <- dbConnect(drv, dbname=dbname)
  }
}