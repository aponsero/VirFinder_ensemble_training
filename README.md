# VirFinder_ensemble_training
Scripts for training of an ensemble of linear classifiers using VirFinder
This pipeline is meant to be run on an HPC with a PBS scheduler. 

## Quick start

### Prerequisites
You need to have the R package [VirFinder](https://github.com/jessieren/VirFinder) and its dependencies installed.

### Edit the config.sh file
please modify the 
  - V_DATASET = indicate here the fasta file containing viral sequences for the training set
  - H_DATASET = indicate here the fasta file containing host sequences for the training set
  - RESULT_DIR = indicate here the directory for the outputs
  - SPLIT_SIZE = indicate the number of training example to train the models on 
  - ENS_SIZE= indicate the number of models to train
  - KM_SIZE= indicate the kmer size to use for the training
  - MAIL_USER = indicate here your arizona.edu email
  - GROUP = indicate here your group affiliation
  
### Run ./submit
this command will submit two jobs in queue. 

