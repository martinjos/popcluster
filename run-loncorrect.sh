#!/bin/bash
for each in kmeans-output/*.txt; do ./loncorrect.rb < $each > kmeans-output-corrected/${each#*/}; done
