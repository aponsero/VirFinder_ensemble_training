#!/usr/bin/env python3

import argparse
import itertools
from Bio import SeqIO
import sys, getopt
import random

def get_args():
  parser = argparse.ArgumentParser(description='Filter sequences and divide file')
  parser.add_argument('-f', '--fasta', help='FASTA input file',
    type=str, metavar='FILE', required=True)

  parser.add_argument('-o', '--output', help='output directory',
    type=str, metavar='OUTPUT', required=True)

  parser.add_argument('-s', '--split', help='split size', default=5000,
    type=int, metavar='SPLIT', required=False)

  parser.add_argument('-m', '--maxi', help='max random number',
    type=int, metavar='MAXI', required=True)

  parser.add_argument('-n', '--num', help='number of replicates',
    type=int, metavar='NUMBER', required=True)  

  return parser.parse_args()


def main():
  args = get_args()
  inputfile= args.fasta
  size_file= args.split
  maxi= args.maxi
  numReplicates = args.num
  output=args.output

  potipoti=0 
  for x in range(0, numReplicates):
    potipoti=potipoti+1
    name=output+"/file"+str(potipoti)+".fasta"
    with open(name, "w") as output_handle:

      liste=[]
      while(len(liste)<size_file):
         num=random.randint(1, maxi)
         if not num in liste :
            liste.append(num)

      cpt=1
      for record in SeqIO.parse(inputfile, "fasta"):
         if cpt in liste :
            SeqIO.write(record, output_handle, "fasta")
         cpt=cpt+1



if __name__ == "__main__":
   main()
