#!/bin/bash
odir="$1"
mkdir -p "$odir"/kmeans-corrected
for each in "$odir"/kmeans/*.txt; do
    "$(dirname "$0")"/loncorrect.rb < "$each" > "$odir"/kmeans-corrected/${each##*/}
done
