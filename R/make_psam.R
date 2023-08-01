#' Make a psam
#'
#' @param chromosome chromosome labeled as "chrNumber" (ex: "chr1")
#' @param directory directory containing the files
#' @return a psam
#' @export

make_psam <- function(chromosome, directory){
  chromosome_pattern <- str_c(".*_", chromosome, "_.*.psam")
  psam_selected <- list.files(directory, pattern = chromosome_pattern, full.names = TRUE) 
  if (length(psam_selected) > 1) {
    print(str_c("ambiguous chromosome pattern detected:", chromosome_pattern))
    return(NA)
  } else {
    psam <- read_tsv(psam_selected)
    return(psam)
  }
}