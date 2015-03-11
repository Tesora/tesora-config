#!/bin/bash

. ~ubuntu/ci-launch.sh
export OS_REGION_NAME="regionOne"
export FQDN="git01.elasticdb.org"
../launch-node-centos.py $FQDN --server ci-puppetmaster.openstacklocal --flavor 'build.m1.smaller' --image 'centos-6.5-ci-!requiretty' --keep
