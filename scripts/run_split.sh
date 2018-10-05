#!/bin/bash

#PBS -l select=1:ncpus=1:mem=5gb
#PBS -l walltime=72:00:00
#PBS -l cput=72:00:00

source activate python2

HOST=`hostname`
LOG="$STDOUT_DIR/${HOST}_filter.log"
ERRORLOG="$STDERR_DIR/${HOST}_filter.log"

if [ ! -f "$LOG" ] ; then
	touch "$LOG"
fi
echo "Started `date`">>"$LOG"
echo "Host `hostname`">>"$LOG"

export RUN="$WORKER_DIR/Split.py"

if [ "${PBS_ARRAY_INDEX}" -eq 1 ]; then
    VDIR="$RESULT_DIR/vir_training"
    mkdir $VDIR
    python $RUN -f $V_DATASET -o $VDIR -s $SPLIT_SIZE -m $NUMV -n $ENS_SIZE 
else
    HDIR="$RESULT_DIR/host_training"
    mkdir $HDIR
    python $RUN -f $H_DATASET -o $HDIR -s $SPLIT_SIZE -m $NUMH -n $ENS_SIZE
fi

echo "Finished `date`">>"$LOG"
