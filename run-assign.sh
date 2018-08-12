#!/bin/bash
datafile="$1"
mkdir -p kmeans-assign
for outfile in kmeans-output/*.txt; do i=${outfile#*/}; i=${i%.*}; mpi_assign --cluster kmeans-output/$i.txt --assignment kmeans-assign/$i.txt --data "$datafile" ; done
