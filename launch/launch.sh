#!/bin/bash

. ~ubuntu/ci-launch.sh
export OS_REGION_NAME="regionOne"
export FQDN="review.elasticdb.org"
./launch-node.py $FQDN --server ci-puppetmaster.elasticdb.org --flavor 'm1.xlarge' --image aa039903-6180-4d5b-8c1f-aecfe1998b8f --keep
