#' Check headers
#' @description Just a helper function to make sure that headers are the same
#' @param nlist a list of header names to check against
#' @param plist possible headers
#' @export

checkNames <- function(nlist, plist){
  for(i in 1:length(nlist)){
    ifelse(nlist[i] != plist[i], return(FALSE),TRUE)
  }
  return(TRUE)
}