#!/bin/bash

. ~ubuntu/ci-launch.sh
export OS_REGION_NAME="regionOne"
export FQDN="centos6-01.slave.elasticdb.org"
./launch-node.py $FQDN --server ci-puppetmaster.openstacklocal --flavor 'm1.small' --image centos-6.5-ci-!requiretty --keep
#./launch-node.py $FQDN --server ci-puppetmaster.openstacklocal --flavor 'm1.small' --image centos6-ci --keep
