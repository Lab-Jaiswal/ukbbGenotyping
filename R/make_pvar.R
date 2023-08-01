#' make pvar
#' 
#' @param chromosome which chromosome you are selecting and how it is labeled (eg: for chromosome 2 of sample3_chr2.pvar, chromsome = "chr2" OR for s1_c2.pvar, chromosome = "c2")
#' @param directory the directory with your pvar files 
#' @keywords pvar
#' @export
#' @examples
#' @export
#' make_pvar()

make_pvar <- function(chromosome, directory){
  directory_list <- list.files(directory, pattern = ".pvar", full.names = TRUE) 
  pvar_file_name <- str_subset(directory_list, chromosome)
  pvar <- NewPvar(pvar_file_name)
}