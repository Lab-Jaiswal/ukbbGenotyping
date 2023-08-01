#!/bin/bash

#SBATCH --time=24:00:00
#SBATCH --account=sjaiswal
#SBATCH --cpus-per-task=1
#SBATCH --mem=128GB
#SBATCH --job-name=make_pgen

DATA_DIRECTORY=$1
PARENT_DIRECTORY=$2
OUTPUT_DIRECTORY=$3
LINE_NUMBER=$SLURM_ARRAY_TASK_ID #get index of which file to process from $SLURM_ARRAY_TASK_ID provided by SLURM

ARRAY_FILE="${PARENT_DIRECTORY}/bgen_files" #provide path to file containing list of fastq files

ARRAY_PREFIX="$(sed "${LINE_NUMBER}q; d" "${ARRAY_FILE}")" #extract only the line number corresponding to $SLURM_ARRAY_TASK_ID
FILENAME=$(basename "${ARRAY_PREFIX}")
PREFIX=$FILENAME

module load plink2

cd $DATA_DIRECTORY

plink2 --threads 1 --memory 130000 --bgen $FILENAME.bgen --sample $FILENAME.sample --make-pgen --maj-ref --out $OUTPUT_DIRECTORY/$FILENAME


