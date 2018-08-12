#!/bin/bash
datafile="$1"
first=${2:-1}
last=${3:-9}
mkdir -p kmeans-output
for ((i=$first;i<=$last;i++)); do mpi_kmeans --k $i --output kmeans-output/$i.txt --data "$datafile" ; done | tee -a kmeans-log.txt
