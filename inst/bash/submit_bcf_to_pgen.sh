#!/bin/bash
input_directory=$1
output_directory=$2
type_file=".bcf"
mkdir -p "${output_directory}"
bcf_list="${output_directory}/bcf_files"

code_directory=$(realpath $(dirname ${BASH_SOURCE[0]}))

find -L "${input_directory}" -type f `#list all files in ${input_directory}` | \
                grep ".*\.bcf$" `#only keep files with fastq_extension in name (case insensitive)` | \
                sort -u  `#sort and remove duplicate names` > ${bcf_list}
        bcf_array_length=$(wc -l < ${bcf_list}) #get the number of FASTQs

echo "bcf_array_length: $bcf_array_length"
mkdir -p "${output_directory}/Logs"

sbatch -o "${output_directory}/Logs/%A_%a.log" `#put into log` \
                    -a "1-${bcf_array_length}" `#initiate job array equal to the number of fastq files` \
                    -W `#indicates to the script not to move on until the sbatch operation is complete` \
                    "${code_directory}/bcf_to_pgen.sh" \
                    "$input_directory" \
                    "$output_directory"
