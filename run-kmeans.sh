#!/bin/bash
datafile="${1:-$HOME/Downloads/gov.uk/populations/Output_Areas_December_2011_Population_Weighted_Centroids-kml-grid.txt}"
for ((i=1;i<=9;i++)); do mpi_kmeans --k $i --output kmeans-output/$i.txt --data "$datafile" ; done | tee kmeans-log.txt
