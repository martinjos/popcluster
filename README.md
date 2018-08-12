# Population clustering

## Dependencies

    sudo apt install mpikmeans-tools qhull-bin  # Required dependencies

    sudo apt install wget  # For the example code only

## Running

    wget https://opendata.arcgis.com/datasets/ba64f679c85f4563bfff7fad79ae57b1_0.kml -O Centroids.kml
    ./kmlextract.rb Centroids.kml > Centroids-kml.csv
    ./lonscale.rb < Centroids-kml.csv > Centroids-kml-grid.txt
    ./lonscale.rb 1 < Centroids-kml.csv > Centroids-kml.txt
    ./run-kmeans.sh Centroids-kml-grid.txt
    ./run-assign.sh Centroids-kml-grid.txt
    ./run-loncorrect.sh
    mkdir kmeans-kml
    ./means2kml.rb -k kmeans-output-corrected -o kmeans-kml -a kmeans-assign -c Centroids-kml.txt

After running all of these commands, the directory `kmeans-kml` (created above)
will contain the output kml files with centroids and Voronoi tesselation
outlines. These can be imported into Google My Maps
(<https://mymaps.google.com/>).

## Census population data

* Centroids for census output areas (as downloaded above using `wget`): <http://geoportal.statistics.gov.uk/datasets/output-areas-december-2011-population-weighted-centroids>
* All UK census data can be downloaded by creating a query here: <https://www.nomisweb.co.uk/> (via <https://www.ons.gov.uk/>)

## Geodesic conversion approximation

* A line of latitude (north-south) is approximately 111 km, anywhere on the globe.
* A line of longitude (east-west) is about 0.6 times this, on average, across England. This ranges from about 0.64 for Penzance to about 0.56 for Berwick-upon-Tweed, and is exactly 0.6 somewhere near Nottingham.
* So we can multiply the longitude by 0.6 to convert lat/lon into an approximate spatial grid in units of about 111 km, then later divide longitude by 0.6 to go back to lat/lon.

## Adding point weights to k-Means input

Census output areas can optionally be "weighted" by population, by creating
duplicate points for the k-Means algorithm. Populations of census output areas
for the 2011 census vary from about 100 to about 4,100.
