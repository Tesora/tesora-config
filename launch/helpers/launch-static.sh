#!/bin/bash

. ~ubuntu/ci-launch.sh
export OS_REGION_NAME="regionOne"
export FQDN="static.elasticdb.org"
../launch-node.py $FQDN --server ci-puppetmaster.openstacklocal --flavor 'm1.small' --image ubuntu-12.04-ci --keep
