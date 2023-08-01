#!/bin/bash

data_directory=$1 #get directory path from second argument (first argument $0 is the path of this script)
    #find "${data_directory}/" -type f | grep "bam" | grep -v ".bam.bai" | sed -e 's/\.bam$//g'
#output_directory=$2
output_directory=$2
parent_directory=$(dirname $data_directory)
code_directory=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )  #specify location of star_align_and_qc.sh


 bgen_list="${parent_directory}/bgen_files"
 echo "$bgen_list"

 find -L "${data_directory}/" -type f `#list all files in ${fastq_directory}` | \
        grep ".*\.bgen$" `#only keep files with FASTQ in name (case insensitive)` | \
        sed -e 's/\.bgen//g' `#remove .bgen file extension` | \
        sort -u  `#sort and remove duplicate names` > ${bgen_list}
            #| \
        #head -n -1 > ${bam_list} `#remove the last line and generate a list of unique FASTQs`
    bgen_array_length=$(wc -l < ${bgen_list}) #get the number of FASTQs 
    echo "bgen_array_length: $bgen_array_length"

if [ ! -d "$data_directory/Logs" ]; then
        mkdir -p "$data_directory/Logs"
fi

sbatch -o "${data_directory}/Logs/%A_%a.log" `#put into log` \
            -a "1-${bgen_array_length}" `#initiate job array equal to the number of fastq files` \
            -W `#indicates to the script not to move on until the sbatch operation is complete` \
            "${code_directory}/bgen_to_pgen.sh" \
            "$data_directory" \
            "$parent_directory" \
            "$output_directory"

