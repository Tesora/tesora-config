#!/bin/bash

set -e 

apt-get update
apt-get upgrade -y
apt-get install -y git
git clone https://github.com/Tesora/tesora-config.git /opt/config/production

#BH: the following necessary to not install puppet 3.x
export PUPPET_VERSION=2.7

/opt/config/production/install_puppet.sh
apt-get install -y puppetmaster-passenger hiera hiera-puppet

#alternate way:
#puppet resource package hiera ensure=installed
#puppet resource package hiera-puppet ensure=installed

bash /opt/config/production/install_modules.sh
echo "ci-puppetmaster" > /etc/hostname 
service hostname restart

mkdir -p /etc/puppet/hieradata/production
chown -R puppet:puppet /etc/puppet/hieradata/
chmod -R 0711 /etc/puppet/hieradata/

#puppet apply --modulepath='/opt/config/production/modules:/etc/puppet/modules' -e 'include openstack_project::puppetmaster'




