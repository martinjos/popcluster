#!/bin/bash
odir="$1"
datafile="$2"
first=${3:-1}
last=${4:-9}
mkdir -p "$odir"/kmeans
for ((i=$first;i<=$last;i++)); do
    mpi_kmeans --k $i --output "$odir"/kmeans/$i.txt --data "$datafile"
done | tee -a "$odir"/kmeans-log.txt
