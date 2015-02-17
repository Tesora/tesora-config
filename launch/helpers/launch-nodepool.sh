#!/bin/bash

. ~ubuntu/ci-launch.sh
export OS_REGION_NAME="regionOne"
export FQDN="nodepool.elasticdb.org"
../launch-node.py $FQDN --server ci-puppetmaster.openstacklocal --flavor 'm1.medium' --image ubuntu-12.04 --keep
#./launch-node.py $FQDN --server ci-puppetmaster.openstacklocal --flavor 'm1.small' --image centos6-ci --keep
