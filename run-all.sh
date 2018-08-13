#!/bin/bash

pops=yes
if [ "$1" = --no-pops ]; then
    pops=no
    shift
fi

if [ $# = 0 ]; then
    echo "Usage: run-all.sh [--no-pops] OUTPUT-DIR [FIRST-K=1] [LAST-K=9]" >&2
    exit 2
fi

sdir="$(dirname "$0")"
odir="$1"
first=${2:-1}
last=${3:-10}

if ! mkdir "$odir"; then
    echo "Unable to make new directory $odir"
    exit 1
fi

centroids_csv="$sdir/uk-census-2011/centroids.csv" 
centroids_square="$odir/centroids-square.txt"
centroids_lonlat="$odir/centroids-lonlat.txt"
kml_dir="$odir/kml"

"$sdir"/lonscale.rb < "$centroids_csv" > "$centroids_square"
"$sdir"/lonscale.rb 1 < "$centroids_csv" > "$centroids_lonlat"
"$sdir"/run-kmeans.sh "$odir" "$centroids_square" $first $last
"$sdir"/run-assign.sh "$odir" "$centroids_square"
"$sdir"/run-loncorrect.sh "$odir"
mkdir "$kml_dir"
"$sdir"/means2kml.rb -k "$odir"/kmeans-corrected -o "$kml_dir" -a "$odir"/assign -c "$centroids_lonlat"
