#!/bin/bash

#SBATCH --time=72:00:00
#SBATCH --account=sjaiswal
#SBATCH --cpus-per-task=8
#SBATCH --mem=124GB
#SBATCH --job-name=CHIP_variant_call

INPUT_DIRECTORY=$1
OUTPUT_DIRECTORY="$2"

LINE_NUMBER=$SLURM_ARRAY_TASK_ID #get index of which file to process from $SLURM_ARRAY_TASK_ID provided by SLURM

 ARRAY_FILE="${OUTPUT_DIRECTORY}/bcf_files"
 ARRAY_PREFIX="$(sed "${LINE_NUMBER}q; d" "${ARRAY_FILE}")"
 #FILENAME=$(basename "${ARRAY_PREFIX}")
 FILENAME=($ARRAY_PREFIX)

 echo "$FILENAME"
 FILENAME_BASENAME=$(basename $FILENAME)
 FILENAME_OUT=$(echo "${FILENAME_BASENAME%.*}")
 echo "FILENAME_OUT: $FILENAME_OUT"

plink2 --bcf $FILENAME --make-pgen --maj-ref --threads 16 --out $FILENAME_OUT
