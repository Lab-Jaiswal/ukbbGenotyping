#' A tidyUkBioBank function
#' Function output: genotypes of all individuals of the variants of interest
#' 
#' @param variants variants of interest
#' @param variants_df dataframe containing all of the variants in the directory, created with get_directory_variants 
#' @keywords get genotypes from pgen
#' @export
#' @examples
#' get_genotypes_from_pgen()

get_genotypes_from_pgen <- function(variants, variants_df, pgen_list) {
  chr_name <- unique(variants_df$chromosome)
  print(chr_name)
  pgen_handle <- pgen_list[[chr_name]]
  geno_mat <- ReadList(pgen_handle, variants$index, meanimpute=F)
  colnames(geno_mat) <- variants$variant_id
  geno_mat
}