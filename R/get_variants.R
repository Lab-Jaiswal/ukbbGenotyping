#' Make a variants_df
#'
#' @param chr_list
#' @param variants
#' @param directory
#' @return variants_df
#' @export
get_variants <- function(chr_list, variants, directory){
  variants_df <- map(chr_list, get_chromosome_variants, variants, directory) %>% bind_rows %>% filter(!is.na(index))
  variants_df
}
