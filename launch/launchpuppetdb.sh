#!/bin/bash

. ~ubuntu/ci-launch.sh
export OS_REGION_NAME="regionOne"
export FQDN="puppetdb.elasticdb.org"
./launch-node.py $FQDN --server ci-puppetmaster.openstacklocal --flavor 'm1.tiny' --image f7e8e814-979c-4c77-962c-bad5627e3f12 --keep
