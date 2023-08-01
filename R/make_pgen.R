#' Make a pgen
#'
#' @param chromosome
#' @param directory
#' @return pgen
#' @export
make_pgen <- function(chromosome, directory){
  pvar <- make_pvar(chromosome, directory)
  chromosome_expr <- str_c(".", chromosome, ".")
  directory_list <- list.files(directory, pattern = ".pgen", full.names = TRUE) 
  pgen_file_name <- str_subset(directory_list, chromosome_expr)
  pgen <- NewPgen(pgen_file_name, pvar=pvar)
}
