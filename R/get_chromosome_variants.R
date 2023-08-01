#' Make a variant_df
#'
#' @param chromosome
#' @param variants
#' @param directory
#' @return variant_df
#' @export
get_chromosome_variants <- function(chromosome, variants, directory) {
  print(paste("now reading in variants from chromosome:", chromosome))
  pvar_handle <- make_pvar(chromosome, directory)
  variant_df <- map(variants, get_variant_index, pvar_handle, chromosome) %>% bind_rows
  variant_df
} 