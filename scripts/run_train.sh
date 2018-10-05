#!/bin/bash

#PBS -l select=1:ncpus=28:mem=168gb
#PBS -l walltime=48:00:00
#PBS -l cput=48:00:00

module load R
RUN="$WORKER_DIR/train.r"

HOST=`hostname`
LOG="$STDOUT_DIR2/${HOST}.log"
ERRORLOG="$STDERR_DIR2/${HOST}.log"

if [ ! -f "$LOG" ] ; then
	touch "$LOG"
fi
echo "Started `date`">>"$LOG"
echo "Host `hostname`">>"$LOG"

export V_FILE="$RESULT_DIR/vir_training/file${PBS_ARRAY_INDEX}.fasta"
export H_FILE="$RESULT_DIR/host_training/file${PBS_ARRAY_INDEX}.fasta"
export MOD_DIR="$RESULT_DIR/models_trained/model${PBS_ARRAY_INDEX}"
export MOD_NAME="mod${PBS_ARRAY_INDEX}"
mkdir $MOD_DIR
export KMER=$KM_SIZE

Rscript $RUN $V_FILE $H_FILE $MOD_DIR $MOD_NAME $KMER

echo "Finished `date`">>"$LOG"
