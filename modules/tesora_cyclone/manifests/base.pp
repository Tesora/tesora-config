# == Class: tesora_cyclone::base
#
class tesora_cyclone::base(
  $certname              = $::fqdn,
  $install_users         = true,
  $pin_puppet            = '3.',
  $ca_server             = undef,
) {
  if ($::osfamily == 'Debian') {
    include apt
  }
  include tesora_cyclone::params
  include tesora_cyclone::users
  include sudoers

  case $pin_puppet {
    '2.7.': {
      $pin_facter = '1.'
      $pin_puppetdb = '1.'
    }
    /^3\./: {
      $pin_facter = '2.'
      $pin_puppetdb = '2.'
    }
    default: {
      fail("Puppet version not supported")
    }
  }

  file { '/etc/profile.d/Z98-byobu.sh':
    ensure => absent,
  }

  package { 'popularity-contest':
    ensure => absent,
  }

  package { 'git':
    ensure => present,
  }

  if ($::operatingsystem == 'Fedora') {

    package { 'hiera':
      ensure   => latest,
      provider => 'gem',
    }

    exec { 'symlink hiera modules' :
      command     => 'ln -s /usr/local/share/gems/gems/hiera-puppet-* /etc/puppet/modules/',
      path        => '/bin:/usr/bin',
      subscribe   => Package['hiera'],
      refreshonly => true,
    }

  }

  package { $::tesora_cyclone::params::packages:
    ensure => present
  }

  include pip
  $desired_virtualenv = '1.11.4'

  if (( versioncmp($::virtualenv_version, $desired_virtualenv) < 0 )) {
    $virtualenv_ensure = $desired_virtualenv
  } else {
    $virtualenv_ensure = present
  }
  package { 'virtualenv':
    ensure   => $virtualenv_ensure,
    provider => pip,
    require  => Class['pip'],
  }

  if ($install_users) {
    package { $::tesora_cyclone::params::user_packages:
      ensure => present
    }

    realize (
      User::Virtual::Localuser['andrew'],
      User::Virtual::Localuser['amrith'],
      User::Virtual::Localuser['bhunter'],
      User::Virtual::Localuser['doug'],
    )
  }

  if ! defined(File['/root/.ssh']) {
    file { '/root/.ssh':
      ensure => directory,
      mode   => '0700',
    }
  }

  ssh_authorized_key { 'puppet-remote-2014-04-17':
    ensure  => absent,
    user    => 'root',
  }
  ssh_authorized_key { 'puppet-remote-2014-05-24':
    ensure  => absent,
    user    => 'root',
  }
  ssh_authorized_key { 'puppet-remote-2014-09-11':
    ensure  => absent,
    user    => 'root',
  }
  ssh_authorized_key { 'puppet-remote-2014-09-15':
    ensure  => absent,
    user    => 'root',
  }

  ssh_authorized_key { 'TESORA-puppet-remote-20015-06-17':
    ensure  => present,
    user    => 'root',
    type    => 'ssh-rsa',
    key     => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCtVaFpO7RtFy8mQ+gIlpJR1d4DnDm7oJCGTdTgASKa/ILWj4bvZxT14tff6n2HNYtcYjz14N4VNK4+Jw1Q0q9az1T8BZ4GjDVap5IRNrniprVnOFsmutMNzqWNjQ8UgdGAYr1z7rUtQnGdN8niyj/4RyCyoPv8f6aT68B7lYm4lGuWR0ioxsEg6owCQ0C3pg3zs+JqyVdKxSB8BuNBq88gZq5uikJLjKrKrhbHL/M838Zff6VC0DOOgHNyqbwqxHtKf1nkt/KTGx4H9WC/PAu0KZm6xd2GqvYRmTPws9bloWU+gJCwPQPBsSuISwNd3eg2JUGzUB65nQCosoAq+3lT',
    require => File['/root/.ssh'],
  }
  ssh_authorized_key { '/root/.ssh/authorized_keys':
    ensure  => absent,
    user    => 'root',
  }

  # Which Puppet do I take?
  # Take $puppet_version and pin to that version
  if ($::osfamily == 'Debian') {
    apt::source { 'puppetlabs':
      location   => 'http://apt.puppetlabs.com',
      repos      => 'main',
      key        => '4BD6EC30',
      key_server => 'pgp.mit.edu',
    }

    file { '/etc/apt/apt.conf.d/80retry':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/tesora_cyclone/80retry',
      replace => true,
    }

    file { '/etc/apt/preferences.d/00-puppet.pref':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      content => template('tesora_cyclone/00-puppet.pref.erb'),
      replace => true,
    }

    file { '/etc/default/puppet':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/tesora_cyclone/puppet.default',
      replace => true,
    }

  }

  if ($::operatingsystem == 'CentOS') {
    file { '/etc/yum.repos.d/puppetlabs.repo':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/tesora_cyclone/centos-puppetlabs.repo',
      replace => true,
    }
    file { '/etc/yum.conf':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      source  => 'puppet:///modules/tesora_cyclone/yum.conf',
      replace => true,
    }
  }

  $puppet_version = $pin_puppet
  file { '/etc/puppet/puppet.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('tesora_cyclone/puppet.conf.erb'),
    replace => true,
  }

  service { 'puppet':
    ensure => stopped,
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
