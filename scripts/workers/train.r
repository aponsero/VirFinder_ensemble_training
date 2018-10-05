#!/usr/bin/env Rscript
args<-commandArgs(TRUE)

trainFaFileVirus <- args[1]
trainFaFileHost <-args[2]
userModDir <- args[3]
userModName <- args[4]
w <- as.integer(args[5])

library(VirFinder)
VF.trainModUser <- VF.train.user(trainFaFileHost, trainFaFileVirus, userModDir, userModName, w, equalSize=TRUE)

