#!/bin/bash -e

## Install Git and Puppet
yum -y update
yum -y install epel-release
yum -y install git puppet

# Clone the 'puppet' repo
mv /etc/puppet/ /etc/puppet-bak
git clone https://github.com/steviedons/puppet.git /etc/puppet

# Run Puppet initially to set up the auto-deploy mechanism
puppet apply /etc/puppet/manifests/site.pp

