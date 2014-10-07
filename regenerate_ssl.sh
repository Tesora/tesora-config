#!/bin/bash

echo stopping puppet
sudo puppet resource service puppet ensure=stopped
sudo puppet resource service apache2 ensure=stopped

SSLDIR=`sudo puppet master --configprint ssldir`
read -p "press enter to delete $SSLDIR and proceed"

sudo rm -r $SSLDIR

sudo puppet cert list -a

read -p "when you see Starting Puppet Master, press Ctrl-C"
sudo puppet master --no-daemonize --verbose

read -p "press enter to start puppet"
sudo puppet resource service puppet ensure=running
sudo puppet resource service apache2 ensure=running
