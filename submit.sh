#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -f "$V_DATASET" ]]; then
    echo "$V_DATASET does not exist. Please provide a viral training set file to process Job terminated."
    exit 1
fi

if [[ ! -f "$H_DATASET" ]]; then
    echo "$H_DATASET does not exist. Please provide a host training set file to process Job terminated."
    exit 1
fi

if [[ $SPLIT_SIZE -lt 1 ]]; then
  echo "Incorrect split set size value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

if [[ $ENS_SIZE -lt 2 ]]; then
  echo "Incorrect ensemble size value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

export NUMV=$(grep -c '>' $V_DATASET)
if [ $SPLIT_SIZE -gt $NUMV ]; then
    echo "$NUMV sequences are available for viral training. Please provide a $SPLIT_SIZE inferior to $NUMV in config file."
    exit 1
fi

export NUMH=$(grep -c '>' $H_DATASET)
if [ $SPLIT_SIZE -gt $NUMH ]; then
    echo "$NUMH sequences are available for viral training. Please provide a $SPLIT_SIZE inferior to $NUMH in config file."
    exit 1
fi


if [[ $KM_SIZE -lt 1 ]]; then
  echo "Incorrect kmer size value. Please correct specified parameter in config file. Job terminated."
  exit 1
fi

if [[ ! -d "$RESULT_DIR" ]]; then
    echo "$RESULT_DIR does not exist. Directory created for pipeline output."
    mkdir -p "$RESULT_DIR"
fi

#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01-run split training set
#

PROG="02-train"
export STDERR_DIR2="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR2="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR2" "$STDOUT_DIR2"
echo "launching $SCRIPT_DIR/run_train.sh"
mkdir "$RESULT_DIR/models_trained"           

JOB_ID=`qsub $ARGS -v WORKER_DIR,RESULT_DIR,KM_SIZE,STDERR_DIR2,STDOUT_DIR2 -N run_train -e "$STDERR_DIR2" -o "$STDOUT_DIR2" -J 1-$ENS_SIZE $SCRIPT_DIR/run_train.sh`

if [ "${JOB_ID}x" != "x" ]; then
     echo Job: \"$JOB_ID\"
     PREV_JOB_ID=$JOB_ID  
else
     echo Problem submitting job. Job terminated
fi
echo "job successfully submited"



