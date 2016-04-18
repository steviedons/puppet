# == Class: profiles
#
# Full description of class profiles here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'profiles':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class profiles {

}

class profiles::docker {
  package { 'docker':
    ensure => present,
  }

  group { 'docker':
    ensure => present,
    notify => Service['docker'],
  }

  service { 'docker':
    ensure  => running,
    require => Package['docker'],
  }
}

class profiles::docker::gitlab {
  class {'firewalld': }
  
  docker::image { 'gitlab/gitlab-ce': }

  docker::run {'gitlab':
    image            => 'gitlab/gitlab-ce:latest',
    extra_parameters => ['--hostname gitlab.steviedons.com', '--publish 443:443', '--publish 80:80', '--restart always', '--volume /srv/gitlab/config:/etc/gitlab:Z', '--volume /srv/gitlab/logs:/var/log/gitlab:Z', '--volume /srv/gitlab/data:/var/opt/gitlab:Z'],
  }

  firewalld_port { 'Open port 80 in the public zone for gitlab':
    ensure   => present,
    zone     => 'public',
    port     => 80,
    protocol => 'tcp',
  }
  firewalld_port { 'Open port 443 in the public zone for gitlab':
    ensure   => present,
    zone     => 'public',
    port     => 443,
    protocol => 'tcp',
  }

}

class profiles::docker::owncloud {
  class { 'firewalld': }
  
  docker::image { 'owncloud:latest': }

  docker::run {'owncloud':
    image            => 'owncloud:latest',
    extra_parameters => ['--publish 8080:80', '--restart always', '--volume /srv/owncloud/apps:/var/www/html/apps:Z', '--volume /srv/owncloud/data:/var/www/html/data:Z', '--volume /srv/owncloud/config:/var/www/html/config:Z'],
  }

  firewalld_port { 'Open port 8080 in the public zone for owncloud':
    ensure   => present,
    zone     => 'public',
    port     => 8080,
    protocol => 'tcp',
  }
}

