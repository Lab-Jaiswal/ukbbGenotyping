#install.packages("devtools")
library(devtools)
library(magrittr)
library(tidyverse)
library(pgenlibr)
#devtools::install_github("Lab-Jaiswal/ukbbGenotyping")
library(ukbbGenotyping)

directory <- "/o/s/g/sjaiswal/ukbiobank/genotype_calls/pgens_Apr_11/"
rsid_fp <- read_tsv("/o/s/p/topmed/topmed_f9/genotypes/pgen_files/chip_snps_vep_annotated_rsid.tsv", col_names = FALSE)
rsids <- rsid_fp %>% pull(X5)

sequnce <- seq(1:22) %>% append(c("X"))
chr_list<- sprintf("c%s", sequnce) 

variants_df <- get_variants(chr_list[21:23], rsids, directory) 

all_genotypes <- get_all_genotypes(variants_df, directory)

#write_rds(geno_full, "ukbiobank_genotypes.rda")
