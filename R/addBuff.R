#' add buffer
#' @export

addBuff <- function(buf, num){
  num <- as.character(num)
  if(buf-nchar(num) >= 0){
    tocat <- paste(rep("0",(buf-nchar(num))),collapse="")
  } else {
    stop("Your buffer character size is too small, make it BIG!")
  }
  return(paste(tocat,num,sep=""))
  
}