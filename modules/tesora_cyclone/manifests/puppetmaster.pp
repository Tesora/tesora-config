# == Class: tesora_cyclone::puppetmaster
#
class tesora_cyclone::puppetmaster (
  # BH: added default
  $root_rsa_key = '',
  $sysadmins = [],
  $version   = '3.',
  $ca_server = undef,
  # BH: was true:
  $puppetdb = false,
  $puppetdb_server = 'puppetboard.elasticdb.org',
) {
  include logrotate
  include tesora_cyclone::params

  class { 'tesora_cyclone::server':
    iptables_public_tcp_ports => [4505, 4506, 8140],
    sysadmins                 => $sysadmins,
    pin_puppet                => $version,
    ca_server                 => $ca_server,
  }

  $ansible_remote_puppet_source = 'puppet:///modules/tesora_cyclone/ansible/remote_puppet.yaml'

  file {'/etc/puppet/environments':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file {'/etc/puppet/environments/production':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file {'/etc/puppet/environments/production/environment.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/tesora_cyclone/puppetmaster/production_environment.conf',
  }

  class { 'ansible':
    ansible_hostfile => '/etc/ansible/hostfile',
  }

  file { '/etc/ansible/hostfile':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Class['ansible'],
  }

  cron { 'updatepuppetmaster':
    user        => 'root',
    minute      => '*/15',
    command     => 'bash /opt/config/production/run_all.sh',
    environment => 'PATH=/var/lib/gems/1.8/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin',
  }

  logrotate::file { 'updatepuppetmaster':
    ensure  => present,
    log     => '/var/log/puppet_run_all.log',
    options => ['compress',
      'copytruncate',
      'delaycompress',
      'missingok',
      'rotate 7',
      'daily',
      'notifempty',
    ],
    require => Cron['updatepuppetmaster'],
  }

  cron { 'deleteoldreports':
    user        => 'root',
    hour        => '3',
    minute      => '0',
    command     => 'sleep $((RANDOM\%600)) && find /var/lib/puppet/reports -name \'*.yaml\' -mtime +7 -execdir rm {} \;',
    environment => 'PATH=/var/lib/gems/1.8/bin:/usr/bin:/bin:/usr/sbin:/sbin',
  }

  file { '/etc/puppet/hiera.yaml':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    source  => 'puppet:///modules/tesora_cyclone/puppetmaster/hiera.yaml',
    replace => true,
    require => Class['tesora_cyclone::server'],
  }

  file { '/var/lib/puppet/reports':
    ensure => directory,
    owner  => 'puppet',
    group  => 'puppet',
    mode   => '0750',
    }

  if ! defined(File['/root/.ssh']) {
    file { '/root/.ssh':
      ensure => directory,
      mode   => '0700',
    }
  }

  file { '/root/.ssh/id_rsa':
    ensure  => present,
    mode    => '0400',
    content => $root_rsa_key,
  }

# Cloud credentials are stored in this directory for launch-node.py.
  file { '/root/ci-launch':
    ensure => directory,
    owner  => 'root',
    group  => 'admin',
    mode   => '0750',
    }

# For puppet master apache serving.
  package { 'puppetmaster-passenger':
    ensure => present,
  }

# To set LANG to utf8, otherwise we get charset errors on manifests
# with non-ascii chars
  file { '/etc/apache2/envvars':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/tesora_cyclone/puppetmaster/envvars.debian',
    require => Package['puppetmaster-passenger'],
  }

# For launch/launch-node.py.
  package { ['python-cinderclient', 'python-novaclient']:
    ensure   => latest,
    provider => pip,
    require  => [Package['python-lxml'], Package['libxslt1-dev']],
  }
  package { 'python-paramiko':
    ensure => present,
  }
  package { 'python-lxml':
    ensure => present,
  }
  package { 'libxslt1-dev':
    ensure => present,
  }

# Enable puppetdb

  if $puppetdb {
    class { 'puppetdb::master::config':
      puppetdb_server              => $puppetdb_server,
      puppet_service_name          => 'apache2',
      puppetdb_soft_write_failure  => true,
      manage_storeconfigs          => false,
    }
  }

# Playbooks
#
  file { '/etc/ansible/remote_puppet.yaml':
    ensure  => present,
    source  => $ansible_remote_puppet_source,
    require => Class[ansible],
  }

  file { '/etc/ansible/clean_workspaces.yaml':
    ensure  => present,
    source  => 'puppet:///modules/tesora_cyclone/ansible/clean_workspaces.yaml',
    require => Class[ansible],
  }
}
