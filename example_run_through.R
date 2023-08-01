#install.packages("devtools")
library(devtools)
library(magrittr)
library(tidyverse)
library(pgenlibr)
#devtools::install_github("Lab-Jaiswal/ukbbGenotyping")
library(ukbbGenotyping)

directory <- "/oak/stanford/groups/sjaiswal/maurertm/ukb_genetic_files/22828_files/22828_pgens_Apr_11/"
rsid_fp <- read_tsv("/oak/stanford/projects/topmed/topmed_f9/genotypes/pgen_files/chip_snps_vep_annotated_rsid.tsv", col_names = FALSE)
rsids <- rsid_fp %>% pull(X5)

sequnce <- seq(1:22) %>% append(c("X"))
chr_list<- sprintf("c%s", sequnce) 

variants_df <- get_variants(chr_list[21:23], rsids, directory) 
pgen_list <- get_pgen_list(chr_list[21:23], directory)

all_genotypes <- get_all_genotypes(variants_df, pgen_list, directory)

#write_rds(geno_full, "ukbiobank_genotypes.rda")
