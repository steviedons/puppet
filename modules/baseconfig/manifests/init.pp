# == Class: baseconfig
#
# Performs initial configuration tasks for all Vagrant boxes.
#
class baseconfig {
  
  package { ['epel-release', 'yum-cron', 'vim-enhanced', 'htop', 'tree', 'unzip', 'git']:
    ensure => present,
  }

  group { 'wheel':
    ensure => present,
  }

  user { 'steve':
    ensure     => present,
    comment    => 'Stephen Donovan',
    home       => '/home/steve',
    groups     => ['wheel','docker'],
    password   => '$6$9oEtZVi1$MEHcx4PbHsu81cDb2EJPElBOMHDQkIg4Bjn.hifQ8aFVnT9tFrVqbvJXl6DJ5ncJC0m5wuzMf61u/qtDXmp291',
    managehome => true,
  }

  ssh_authorized_key { 'steve_ssh':
    user    => 'steve',
    type    => 'rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCY7dN61s6H57fYGV2THhvTzhi0xXQLd59UTSmKc8D+Vl7v7OzBFNL43VfdzsXk539ylo6jrWjeI4pmIL5oBRBIf/X57DW/c33TBYhePfEJC7XiQLibWpgo0dz4uoa0iFBGE10UymoNMsuGYIFnzXF0UXQ7LlT/f1rdZp3iv7P0B4rU5HtxLI30eAlXvG62ODxSXCn7xvsrkvR7PHC/LPxKe3vqQfwoQ2qg8F1jXbtNKQtQuDaT/PdvkjkhD/KM+YQH9sLuYyngaTSjbu6BMpMWaRwlvvM0byCbKd+gzhXJohENHm8+qsSjNjZjbyFUoyYthwBC8ER2WHLNe4tj2u9N',
    require => User['steve'],
  }

  ssh_authorized_key { 'steve_ssh':
    user    => 'steve',
    type    => 'rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDYcNQ3A8x6F4v4tPtnhspywienwOjB8xUUbp9YMfiMbntnbzBPdiCAheuWfus7K5l5NZ24NKSG3A+F2G5UJ1GfUuXnQ3xwziDK6NJFDUdbRhbH0b0E1mo/Dk1wrlyYuUbCG0k8jAQaVGsSMvZW0UJQmRR+X36yL9oEplI+bykHh6tHRzRWPyss390K0TuHzwLUO0I3iYfd9XexbFl365h9i7KAnThMfCraeOvqTnERzRoJHVj5GDQQBk7zfBWXVpWWIXi3GLt3BaR0XtAYjMZouT/XtcpsQkt08nSasZBFxmksvZlEG6L2Hr8PT/7nmT+lr6vKUAoE6aZ0+i/LEfKj',
    require => User['steve'],
  }

  service { 'yum-cron':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package['yum-cron'],
  }

}
