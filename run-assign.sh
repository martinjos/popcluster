#!/bin/bash
odir="$1"
datafile="$2"
mkdir -p "$odir"/assign
for outfile in "$odir"/kmeans/*.txt; do
    i=${outfile##*/}
    i=${i%.*}
    mpi_assign --cluster "$odir"/kmeans/$i.txt --assignment "$odir"/assign/$i.txt --data "$datafile"
done
