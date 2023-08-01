#' Make a variant index
#'
#' @param pvar_handle
#' @param variant_id
#' @return variant_index
#' @export
get_variant_index <- function(variant_id, pvar_handle, chromosome) {
  variant_index <- GetVariantsById(pvar_handle, variant_id)
  if (length(variant_index) > 1) {
    variant_id <- str_c(variant_id, 1:length(variant_index), sep = "_")
  } 
  if (length(variant_index) == 0) {
    variant_index <- NA
  }
  
  variant_df <- tibble(chromosome = chromosome, variant_id = variant_id, index = variant_index) 
  variant_df
}