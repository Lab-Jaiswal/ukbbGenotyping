#install.packages("devtools")
library(devtools)
library(GenomicRanges)
library(readxl)
library(magrittr)
library(tidyverse)
library(pgenlibr)
library(ukbtools)
library(lubridate)
devtools::install_github("Lab-Jaiswal/topmed_genotyping")
library(topmedGenotyping)

#Hanscombe KB, Coleman J, Traylor M, Lewis CM (e-print 158113). “ukbtoo
#UK Biobank data.” _bioRxiv_. <URL: https://doi.org/10.1101/158113>.

directory <- "/oak/stanford/projects/topmed/topmed_f9/genotypes/pgen_files/"
rsid_fp <- read_tsv("/oak/stanford/projects/topmed/topmed_f9/genotypes/pgen_files/chip_snps_vep_annotated_rsid.tsv", col_names = FALSE)
rsids <- rsid_fp %>% pull(X5)

sequnce <- seq(1:22) #%>% append(c("X"))
chr_list<- sprintf("chr%s", sequnce) 

pvar <- make_pvar("chr1", directory)

variants_df <- get_variants(chr_list[21:22], rsids, directory) %>% filter(!is.na(index)) 

pgen_list <- get_pgen_list(chr_list[21:22], directory)
`
genotypes <- get_all_genotypes(variants_df, pgen_list)
write_rds(geno_full, "ukbiobank_genotypes.rda")

