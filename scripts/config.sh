export CWD=$PWD
# where programs are
export BIN_DIR="/rsgrps/bhurwitz/hurwitzlab/bin"
# where the dataset to prepare is
export V_DATASET="/rsgrps/bhurwitz/alise/my_data/Riveal_exp/V2_final/Models/Tara_JGI/Training_set/vir/5000pb_Tara_JGI_marineVir.fasta"
export H_DATASET="/rsgrps/bhurwitz/alise/my_data/Riveal_exp/V2_final/Models/Tara_JGI/Training_set/host/5000pb_filt_bacterial_modelA_cent-cleaned.fasta"
export RESULT_DIR="/rsgrps/bhurwitz/alise/my_data/Riveal_exp/V2_final/Models/Tara_JGI/models_10k_TaraJGI"
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# size of splited files and ensemble size
export SPLIT_SIZE=10000
export ENS_SIZE=10
# kmer size
export KM_SIZE=8
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
