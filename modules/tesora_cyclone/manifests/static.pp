# == Class: tesora_cyclone::static
#
class tesora_cyclone::static (
  $sysadmins = [],
  $swift_authurl = '',
  $swift_user = '',
  $swift_key = '',
  $swift_tenant_name = '',
  $swift_region_name = '',
  $swift_default_container = '',
  $project_config_repo = '',
) {

  class { 'tesora_cyclone::server':
    iptables_public_tcp_ports => [22, 80, 443],
    sysadmins                 => $sysadmins,
  }

  class { 'project_config':
    url  => $project_config_repo,
  }

  include tesora_cyclone
  class { 'jenkins::jenkinsuser':
    ssh_key => $tesora_cyclone::jenkins_ssh_key,
  }

  include apache
  include apache::mod::wsgi

  a2mod { 'rewrite':
    ensure => present,
  }
  a2mod { 'proxy':
    ensure => present,
  }
  a2mod { 'proxy_http':
    ensure => present,
  }

  if ! defined(File['/srv/static']) {
    file { '/srv/static':
      ensure => directory,
    }
  }

  ###########################################################
  # Developer

  apache::vhost { 'developer.elasticdb.org':
    port     => 80,
    priority => '50',
    docroot  => '/srv/static/publish-docs',
    require  => File['/srv/static/publish-docs'],
  }

  file { '/srv/static/publish-docs':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    require => User['jenkins'],
  }

  ###########################################################
  # Tarballs

  apache::vhost { 'tarballs.elasticdb.org':
    port     => 80,
    priority => '50',
    docroot  => '/srv/static/tarballs',
    require  => File['/srv/static/tarballs'],
  }

  file { '/srv/static/tarballs':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    require => User['jenkins'],
  }

  ###########################################################
  # CI

  apache::vhost { 'ci.elasticdb.org':
    port     => 80,
    priority => '50',
    docroot  => '/srv/static/ci',
    require  => File['/srv/static/ci'],
  }

  file { '/srv/static/ci':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    require => User['jenkins'],
  }

  ###########################################################
  # Logs

  apache::vhost { 'logs.elasticdb.org':
    port     => 80,
    priority => '50',
    docroot  => '/srv/static/logs',
    require  => File['/srv/static/logs'],
    template => 'tesora_cyclone/logs.vhost.erb',
  }

  apache::vhost { 'logs-dev.elasticdb.org':
    port     => 80,
    priority => '51',
    docroot  => '/srv/static/logs',
    require  => File['/srv/static/logs'],
    template => 'tesora_cyclone/logs-dev.vhost.erb',
  }

  file { '/srv/static/logs':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    require => User['jenkins'],
  }

  file { '/srv/static/logs/robots.txt':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/tesora_cyclone/disallow_robots.txt',
    require => File['/srv/static/logs'],
  }

  package { 'keyring':
    #ensure   => 'latest',  # BH workaround for PUP6120
    provider => 'pip',
  }

  vcsrepo { '/opt/os-loganalyze':
    ensure   => latest,
    provider => git,
    revision => 'master',
    source   => 'https://git.openstack.org/openstack-infra/os-loganalyze',
    require  => Package['keyring'],
  }

  exec { 'install_os-loganalyze':
    command     => 'python setup.py install',
    cwd         => '/opt/os-loganalyze',
    path        => '/bin:/usr/bin',
    refreshonly => true,
    subscribe   => Vcsrepo['/opt/os-loganalyze'],
  }

  file { '/etc/os_loganalyze':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => Vcsrepo['/opt/os-loganalyze'],
  }

  file { '/etc/os_loganalyze/wsgi.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'www-data',
    mode    => '0440',
    content => template('tesora_cyclone/os-loganalyze-wsgi.conf.erb'),
    require => File['/etc/os_loganalyze'],
  }

  file { '/srv/static/logs/help':
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/tesora_cyclone/logs/help',
    require => File['/srv/static/logs'],
  }

  file { '/usr/local/sbin/log_archive_maintenance.sh':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
    source => 'puppet:///modules/tesora_cyclone/log_archive_maintenance.sh',
  }

  cron { 'gziprmlogs':
    user        => 'root',
    minute      => '0',
    hour        => '7',
    weekday     => '6',
    command     => 'bash /usr/local/sbin/log_archive_maintenance.sh',
    environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
    require     => File['/usr/local/sbin/log_archive_maintenance.sh'],
  }

  ###########################################################
  # Docs-draft

  apache::vhost { 'docs-draft.elasticdb.org':
    port     => 80,
    priority => '50',
    docroot  => '/srv/static/docs-draft',
    require  => File['/srv/static/docs-draft'],
  }

  file { '/srv/static/docs-draft':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    require => User['jenkins'],
  }

  file { '/srv/static/docs-draft/robots.txt':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/tesora_cyclone/disallow_robots.txt',
    require => File['/srv/static/docs-draft'],
  }

  class { 'tesora_cyclone::pypi_mirror':
    vhost_name => 'pypi.elasticdb.org',
  }

  # Legacy pypi mirror
  file { '/srv/static/mirror/web/openstack':
    ensure  => absent,
    force   => true,
  }

  ###########################################################
  # Specs

  apache::vhost { 'specs.elasticdb.org':
    port     => 80,
    priority => '50',
    docroot  => '/srv/static/specs',
    require  => File['/srv/static/specs'],
  }

  file { '/srv/static/specs':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    require => User['jenkins'],
  }

  file { '/srv/static/specs/index.html':
    ensure  => present,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0444',
    source  => $::project_config::specs_index_file,
    require => [File['/srv/static/specs'],
                $::project_config::config_dir],
  }
}
