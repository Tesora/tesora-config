# == Class: tesora_cyclone::nodepool_prod
#
class tesora_cyclone::nodepool_prod(
  $mysql_root_password,
  $mysql_password,
  $nodepool_ssh_private_key = '',
  $nodepool_template = 'tesora_cyclone/nodepool/nodepool.yaml.erb',
  $sysadmins = [],
  $statsd_host = '',
  $jenkins_api_user ='',
  $jenkins_api_key ='',
  $jenkins_credentials_id ='',
  $bluebox_username ='',
  $bluebox_password ='',
  $bluebox_project ='',
  $image_log_document_root = '/var/log/nodepool/image',
  $enable_image_log_via_http = true,
  $project_config_repo = '',
  $git_source_repo = 'https://github.com/tesora/tesora-nodepool',
  $clouds_yaml_template = 'tesora_cyclone/nodepool/clouds.yaml.erb',
) {
  class { 'tesora_cyclone::server':
    sysadmins                 => $sysadmins,
    iptables_public_tcp_ports => [80],
  }

  include bup
  bup::site { 'bluebox':
    backup_user   => 'bup-nodepool',
    backup_server => 'ci-backup-01.elasticdb.org',
  }

  class { 'project_config':
    url  => $project_config_repo,
  }

  class { '::nodepool':
    mysql_root_password       => $mysql_root_password,
    mysql_password            => $mysql_password,
    nodepool_ssh_private_key  => $nodepool_ssh_private_key,
    statsd_host               => $statsd_host,
    image_log_document_root   => $image_log_document_root,
    enable_image_log_via_http => $enable_image_log_via_http,
    scripts_dir               => $::project_config::nodepool_scripts_dir,
    elements_dir              => $::project_config::nodepool_elements_dir,
    require                   => $::project_config::config_dir,
    git_source_repo           => $git_source_repo,
  }

  file { '/etc/nodepool/nodepool.yaml':
    ensure  => present,
    owner   => 'nodepool',
    group   => 'root',
    mode    => '0400',
    content => template($nodepool_template),
    require => [
      File['/etc/nodepool'],
      User['nodepool'],
    ],
  }

  file { '/home/nodepool/.config':
    ensure => directory,
    owner   => 'nodepool',
    group   => 'nodepool',
    require => [
      User['nodepool'],
    ],
  }

  file { '/home/nodepool/.config/openstack':
    ensure => directory,
    owner   => 'nodepool',
    group   => 'nodepool',
    require => [
      File['/home/nodepool/.config'],
    ],
  }

  file { '/home/nodepool/.config/openstack/clouds.yaml':
    ensure  => present,
    owner   => 'nodepool',
    group   => 'nodepool',
    mode    => '0400',
    content => template($clouds_yaml_template),
    require => [
      File['/home/nodepool/.config/openstack'],
      User['nodepool'],
    ],
  }
}
