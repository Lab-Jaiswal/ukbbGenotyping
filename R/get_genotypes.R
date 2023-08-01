#' Make a genotypes_df
#'
#' @param variants_df
#' @param directory
#' @param psam
#' @return pgen_list
#' @export
get_genotypes <- function(variants_df, directory, psam){
  chrom_list <- pull(variants_df, chromosome) %>% unique()
  pgen_list <- get_pgen_list(chrom_list, directory)
  
  genotypes <- group_by(variants_df, chromosome) %>% 
    group_map(get_genotypes_from_pgen, pgen_list) %>% 
    bind_cols
  rownames(genotypes) <- psam$IID
  genotypes_df <- as_tibble(genotypes, rownames = "eid")
}
