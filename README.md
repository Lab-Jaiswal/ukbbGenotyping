# ukbbGenotyping
This is a package to aid in genotyping data from the UkBioBank data repository 

## Downloading Genetic Data from the UkBioBank

1. Downlaod the keyfile provided by the UkBioBank into the same folder you would like to download your data
        a. It will look something like k####r####.key, where the #'s are numbers
   
        b. The keyfile will be emailed, along with and MD5 checksum and instructions, by the UkBioBank once your data is ready.
3. Save `parallel_fetch.sh` to the same folder you would like to download your data

        a. `parallel_fetch.sh` can be found [here](https://github.com/neurodatascience/ukbm)
5. Run `bash parallel_fetch.sh -f 22828 gfetch k####r####.key`

        a. If you wish to download another genetic field, swap out 22828 for the field_id
        b. This step will take anywhere from 12-24 hours and otuput .sample and .bgen files for every chromosome
        c. You can download each .sample/.bgen pair on a per chromosome basis using `gfetch 22828 -c#` (the # is the number chromosome you want downlaoded); however, if you wish to analyze genetic data across multiple chromosomes, `parallel_fetch.sh` is much faster and memory efficient
7. Once the .sample and .bgen files have been generated, download the following files from the [inst/bash](https://github.com/Lab-Jaiswal/ukbbGenotyping/tree/main/inst/bash) folder in this package:
        
        - bgen_to_pgen.sh
        - submit_bgen_to_pgen.sh
8. Customize the SBATCH header in `make_pgen.sh` to meet your institution's conventions:
        a.  memory may be reduced up to 64GB
        b. time may be reduced to as little as 12 hours, but I recommend 24 if you reduce the memory
        c. cpus-per-task *must* stay equal to one
9. Run submit_make_pgen.sh using the following command:

        ./sumbit_make_pgen.sh /loaction/of/your/bgen/and/sample/files /location/where/you/would/like/the/output/saved

## Obtaining Genotype Information
### Required Information
1. A list of the rsids of interest (please see chip_snps_vep_annotated_rsid.tsv)
2. Directory
3. List of chromosomes containing the rsids in step 1

### Obtaining Genotype Information from pgens
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
    chr_list <- sprintf("c%s", sequnce)
    variants_df <- get_varaints(chr_list, rsids, directory) %>% filter(!is.na(index))
````

3. Use get_all_genotypes to get a dataframe containing the individuals and their genotypes.
````
     genotypes <- get_all_genotypes(variants_df, directory)
````

**__Please see example_run_through.R for more details.__**
