#' Make a pgen_list
#'
#' @param chr_list
#' @param directory
#' @return pgen_list
#' @export
get_pgen_list <- function(chr_list, directory){
  pgen_list <- map(chr_list, make_pgen, directory)
  names(pgen_list) <- chr_list
  pgen_list
}