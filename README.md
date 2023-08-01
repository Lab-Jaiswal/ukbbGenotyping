# ukbbGenotyping
This is a package to aid in genotyping data from the UkBioBank data repository 

## Required Information
1. A list of the rsids of interest (please see chip_snps_vep_annotated_rsid.tsv)
2. Directory
3. List of chromosomes containing the rsids in step 1

## Steps to Obtain Genotype Information
1. Install the ukbbGenotyping package
````
    library(devtools)
    devtools::install_github("Lab-Jaiswal/ukbbGenotyping") #choose option 3
````
2. Use get_variants to obtain a dataframe containing the chromosome, variant_id, and index for all of the variants of interest. A finished version of variants_df can be found at "topmed_variants_4_25.rda".
````
    directory <- "/path/to/pgen/psam/pvar/data"
    rsids <- listOfRsids
    sequnce <- seq(1:22) %>% append(c("X"))
    chr_list <- sprintf("chr%s", sequnce)
    variants_df <- get_varaints(chr_list, rsids, directory) %>% filter(!is.na(index))
````

3. Create a pgen list
````
     pgen_list <- get_pgen_list(chr_list, directory)
````
4. Use get_all_genotypes to get a dataframe containing the individuals and their genotypes.
````
     genotypes <- get_all_genotypes(variants_df, pgen_list)
````

**__Please see example_run_through.R for more details.__**
