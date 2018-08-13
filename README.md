# Population clustering

## Dependencies

    sudo apt install mpikmeans-tools qhull-bin

## Running

    ./run-all.sh DIRECTORY

where DIRECTORY is the name of your output directory.

After this command completes, the directory `DIRECTORY/kml` will contain the
output kml files with centroids and Voronoi tesselation outlines. These can be
imported into Google My Maps (<https://mymaps.google.com/>).

## Adding point weights to k-Means input

Census output areas are "weighted" by population, by creating duplicate points
for the k-Means algorithm. Populations of census output areas for the 2011
census vary from about 100 to about 4,100.

This can optionally be disabled by passing the `--no-pops` option to
`run-all.sh`.

## Geodesic conversion approximation

* A line of latitude (north-south) is approximately 111 km, anywhere on the globe.
* A line of longitude (east-west) is about 0.6 times this, on average, across England. This ranges from about 0.64 for Penzance to about 0.56 for Berwick-upon-Tweed, and is exactly 0.6 somewhere near Nottingham.
* So we can multiply the longitude by 0.6 to convert lon/lat into an approximate spatial grid in units of about 111 km, then later divide longitude by 0.6 to go back to lon/lat.

