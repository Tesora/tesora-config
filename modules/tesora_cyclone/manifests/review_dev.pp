# == Class: tesora_cyclone::review_dev
#
class tesora_cyclone::review_dev (
  $github_oauth_token = '',
  $github_project_username = '',
  $github_project_password = '',
  $mysql_host = '',
  $mysql_password = '',
  $email_private_key = '',
  $contactstore = true,
  $contactstore_appsec = '',
  $contactstore_pubkey = '',
  $ssh_dsa_key_contents = '',
  $ssh_dsa_pubkey_contents = '',
  $ssh_rsa_key_contents = '',
  $ssh_rsa_pubkey_contents = '',
  $ssh_project_rsa_key_contents = '',
  $ssh_project_rsa_pubkey_contents = '',
  $lp_sync_consumer_key = '',
  $lp_sync_token = '',
  $lp_sync_secret = '',
  $sysadmins = [],
#BH:REMOVE  $swift_username = '',
#BH:REMOVE  $swift_password = '',
  $project_config_repo = '',
) {

  realize (
    User::Virtual::Localuser['zaro'],
  )

  class { 'project_config':
    url  => $project_config_repo,
    base => 'dev/',
  }

  class { 'tesora_cyclone::gerrit':
    vhost_name                      => 'review-dev.openstack.org',
    canonicalweburl                 => 'https://review-dev.openstack.org/',
    ssl_cert_file                   => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    ssl_key_file                    => '/etc/ssl/private/ssl-cert-snakeoil.key',
    ssl_chain_file                  => '',
    ssh_dsa_key_contents            => $ssh_dsa_key_contents,
    ssh_dsa_pubkey_contents         => $ssh_dsa_pubkey_contents,
    ssh_rsa_key_contents            => $ssh_rsa_key_contents,
    ssh_rsa_pubkey_contents         => $ssh_rsa_pubkey_contents,
    ssh_project_rsa_key_contents    => $ssh_project_rsa_key_contents,
    ssh_project_rsa_pubkey_contents => $ssh_project_rsa_pubkey_contents,
    email                           => 'review-dev@openstack.org',
    war                             =>
      'http://tarballs.openstack.org/ci/test/gerrit-v2.8.4.16.36a649d.war',
    contactstore                    => $contactstore,
    contactstore_appsec             => $contactstore_appsec,
    contactstore_pubkey             => $contactstore_pubkey,
    contactstore_url                =>
      'https://review-dev.openstack.org/fakestore',
    acls_dir                        => $::project_config::gerrit_acls_dir,
    notify_impact_file              => $::project_config::gerrit_notify_impact_file,
    projects_file                   => $::project_config::jeepyb_project_file,
    projects_config                 =>
      'tesora_cyclone/review-dev.projects.ini.erb',
    github_username                 => 'openstack-gerrit-dev',
    github_oauth_token              => $github_oauth_token,
    github_project_username         => $github_project_username,
    github_project_password         => $github_project_password,
    mysql_host                      => $mysql_host,
    mysql_password                  => $mysql_password,
    email_private_key               => $email_private_key,
    sysadmins                       => $sysadmins,
    gitweb                          => false,
    cgit                            => true,
    web_repo_url                    => 'https://git.openstack.org/cgit/',
#BH:REMOVE    swift_username                  => $swift_username,
#BH:REMOVE    swift_password                  => $swift_password,
    replication                     => [
      {
        name                 => 'github',
        url                  => 'git@github.com:',
        authGroup            => 'Anonymous Users',
        replicatePermissions => false,
        mirror               => true,
      },
      {
        name                 => 'local',
        url                  => 'file:///opt/lib/git/',
        replicationDelay     => '0',
        threads              => '4',
        mirror               => true,
      },
    ],
    require                         => $::project_config::config_dir,
  }

  gerrit::plugin { 'javamelody':
    version => 'e00d5af',
  }

  file { '/home/gerrit2/.launchpadlib':
    ensure  => directory,
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0775',
    require => User['gerrit2'],
  }
  file { '/home/gerrit2/.launchpadlib/creds':
    ensure  => present,
    owner   => 'gerrit2',
    group   => 'gerrit2',
    mode    => '0600',
    content => template('tesora_cyclone/gerrit_lp_creds.erb'),
    replace => true,
    require => User['gerrit2'],
  }

  include bup
  bup::site { 'rs-ord':
    backup_user   => 'bup-review-dev',
    backup_server => 'ci-backup-rs-ord.openstack.org',
  }
}
