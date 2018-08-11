For census population data:
Go here: https://www.nomisweb.co.uk/
Referenced here: https://www.ons.gov.uk/
Self-explanatory: http://geoportal.statistics.gov.uk/datasets/output-areas-december-2011-population-weighted-centroids

Ubuntu package: mpikmeans-tools; programs mpi_kmeans, mpi_assign
Ubuntu package: qhull-bin; programs qhull qconvex

Data dir: ~/Downloads/gov.uk/populations/

A line of latitude (north-south) is approximately 111 km, anywhere on the globe.
A line of longitude (east-west) is about 0.6 times this, on average, across England.
So we can multiply the longitude by 0.6 to convert lat/lon into an approximate spatial grid.
Then divide longitude by 0.6 to go back to lat/lon.

