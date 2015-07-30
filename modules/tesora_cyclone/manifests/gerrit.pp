# == Class: tesora_cyclone::gerrit
#
# A wrapper class around the main gerrit class that sets gerrit
# up for launchpad single sign on and bug/blueprint links

class tesora_cyclone::gerrit (
  $mysql_host,
  $mysql_password,
  $vhost_name = $::fqdn,
  $canonicalweburl = "https://${::fqdn}/",
  $serveradmin = 'bhunter@tesora.com',
  $ssh_host_key = '/home/gerrit2/review_site/etc/ssh_host_rsa_key',
  $ssh_project_key = '/home/gerrit2/review_site/etc/ssh_project_rsa_key',
  $ssl_cert_file = "/etc/ssl/certs/${::fqdn}.pem",
  $ssl_key_file = "/etc/ssl/private/${::fqdn}.key",
  $ssl_chain_file = '/etc/ssl/certs/intermediate.pem',
  $ssl_cert_file_contents = '',
  $ssl_key_file_contents = '',
  $ssl_chain_file_contents = '',
  $ssh_dsa_key_contents = '', # If left empty puppet will not create file.
  $ssh_dsa_pubkey_contents = '', # If left empty puppet will not create file.
  $ssh_rsa_key_contents = '', # If left empty puppet will not create file.
  $ssh_rsa_pubkey_contents = '', # If left empty puppet will not create file.
  $ssh_project_rsa_key_contents = '', # If left empty will not create file.
  $ssh_project_rsa_pubkey_contents = '', # If left empty will not create file.
  $ssh_welcome_rsa_key_contents='', # If left empty will not create file.
  $ssh_welcome_rsa_pubkey_contents='', # If left empty will not create file.
  $ssh_replication_rsa_key_contents='', # If left empty will not create file.
  $ssh_replication_rsa_pubkey_contents='', # If left empty will not create file.
  $email = '',
  $database_poollimit = '',
  $container_heaplimit = '',
  $core_packedgitopenfiles = '',
  $core_packedgitlimit = '',
  $core_packedgitwindowsize = '',
  $sshd_threads = '',
  $httpd_acceptorthreads = '',
  $httpd_minthreads = '',
  $httpd_maxthreads = '',
  $httpd_maxwait = '',
  $war = '',
  $contactstore = false,
  $contactstore_appsec = '',
  $contactstore_pubkey = '',
  $contactstore_url = '',
  $acls_dir = 'UNDEF',
  $notify_impact_file = 'UNDEF',
  $projects_file = 'UNDEF',
  $projects_config = 'UNDEF',
  $github_username = '',
  $github_oauth_token = '',
  $github_project_username = '',
  $github_project_password = '',
  $trivial_rebase_role_id = '',
  $email_private_key = '',
  $replicate_local = true,
  $replication = [],
  $local_git_dir = '/opt/lib/git',
  $jeepyb_cache_dir = '/opt/lib/jeepyb',
#BH:REMOVE  $cla_description = 'OpenStack Individual Contributor License Agreement',
#BH:REMOVE  $cla_file = 'static/cla.html',
#BH:REMOVE  $cla_id = '2',
#BH:REMOVE  $cla_name = 'ICLA',
  $testmode = false,
  $sysadmins = [],
#BHLREMOVE  $swift_username = '',
#BHLREMOVE  $swift_password = '',
  $gitweb = true,
  $cgit = false,
  $web_repo_url = '',
  $secondary_index = true,
) {
  class { 'tesora_cyclone::server':
    iptables_public_tcp_ports => [80, 443, 29418],
    sysadmins                 => $sysadmins,
  }

#BHLREMOVE  class { 'jeepyb::openstackwatch':
#BH:REMOVE    projects       => [
#BH:REMOVE      'openstack/ceilometer',
#BH:REMOVE      'openstack/cinder',
#BH:REMOVE      'openstack/glance',
#BH:REMOVE      'openstack/heat',
#BH:REMOVE      'openstack/horizon',
#BH:REMOVE      'openstack/infra',
#BH:REMOVE      'openstack/keystone',
#BH:REMOVE      'openstack/nova',
#BH:REMOVE      'openstack/oslo',
#BH:REMOVE      'openstack/neutron',
#BH:REMOVE      'openstack/swift',
#BH:REMOVE      'openstack/tempest',
#BH:REMOVE      'openstack-dev/devstack',
#BH:REMOVE    ],
#BH:REMOVE    container      => 'rss',
#BH:REMOVE    feed           => 'openstackwatch.xml',
#BH:REMOVE    json_url       => 'https://review.openstack.org/query?q=status:open',
#BH:REMOVE    swift_username => $swift_username,
#BH:REMOVE    swift_password => $swift_password,
#BH:REMOVE    swift_auth_url => 'https://auth.api.rackspacecloud.com/v1.0',
#BH:REMOVE    auth_version   => '1.0',
#BH:REMOVE  }

  class { '::gerrit':
    vhost_name                          => $vhost_name,
    canonicalweburl                     => $canonicalweburl,
    # opinions
    enable_melody                       => true,
    melody_session                      => true,
    robots_txt_source                   => 'puppet:///modules/tesora_cyclone/gerrit/robots.txt',
    enable_javamelody_top_menu          => false,
    # passthrough
    ssl_cert_file                       => $ssl_cert_file,
    ssl_key_file                        => $ssl_key_file,
    ssl_chain_file                      => $ssl_chain_file,
    ssl_cert_file_contents              => $ssl_cert_file_contents,
    ssl_key_file_contents               => $ssl_key_file_contents,
    ssl_chain_file_contents             => $ssl_chain_file_contents,
    ssh_dsa_key_contents                => $ssh_dsa_key_contents,
    ssh_dsa_pubkey_contents             => $ssh_dsa_pubkey_contents,
    ssh_rsa_key_contents                => $ssh_rsa_key_contents,
    ssh_rsa_pubkey_contents             => $ssh_rsa_pubkey_contents,
    ssh_project_rsa_key_contents        => $ssh_project_rsa_key_contents,
    ssh_project_rsa_pubkey_contents     => $ssh_project_rsa_pubkey_contents,
    ssh_replication_rsa_key_contents    => $ssh_replication_rsa_key_contents,
    ssh_replication_rsa_pubkey_contents => $ssh_replication_rsa_pubkey_contents,
    email                               => $email,
    openidssourl                        => 'https://login.launchpad.net/+openid',
    database_poollimit                  => $database_poollimit,
    container_heaplimit                 => $container_heaplimit,
    core_packedgitopenfiles             => $core_packedgitopenfiles,
    core_packedgitlimit                 => $core_packedgitlimit,
    core_packedgitwindowsize            => $core_packedgitwindowsize,
    sshd_threads                        => $sshd_threads,
    httpd_acceptorthreads               => $httpd_acceptorthreads,
    httpd_minthreads                    => $httpd_minthreads,
    httpd_maxthreads                    => $httpd_maxthreads,
    httpd_maxwait                       => $httpd_maxwait,
    commentlinks                        => [
      {
        name  => 'bugheader',
        match => '([Cc]loses|[Pp]artial|[Rr]elated)-[Bb]ug:\\s*#?(\\d+)',
        link  => 'https://launchpad.net/bugs/$2',
      },
      {
        name  => 'bug',
        match => '\\bbug:? #?(\\d+)',
        link  => 'https://launchpad.net/bugs/$1',
      },
      {
        name  => 'story',
        match => '\\bstory:? #?(\\d+)',
        link  => 'https://storyboard.openstack.org/#!/story/$1',
      },
      {
        name  => 'blueprint',
        match => '(\\b[Bb]lue[Pp]rint\\b|\\b[Bb][Pp]\\b)[ \\t#:]*([A-Za-z0-9\\-]+)',
        link  => 'https://blueprints.launchpad.net/openstack/?searchtext=$2',
      },
      {
        name  => 'testresult',
        match => '<li>([^ ]+) <a href=\"[^\"]+\" target=\"_blank\">([^<]+)</a> : ([^ ]+)([^<]*)</li>',
        html  => '<li class=\"comment_test\"><span class=\"comment_test_name\"><a href=\"$2\">$1</a></span> <span class=\"comment_test_result\"><span class=\"result_$3\">$3</span>$4</span></li>',
      },
      {
        name  => 'launchpadbug',
        match => '<a href=\"(https://bugs\\.launchpad\\.net/[a-zA-Z0-9\\-]+/\\+bug/(\\d+))[^\"]*\">[^<]+</a>',
        html  => '<a href=\"$1\">$1</a>'
      },
      {
        name  => 'changeid',
        match => '(I[0-9a-f]{8,40})',
        link  => '#q,$1,n,z',
      },
      {
        name  => 'gitsha',
        match => '(<p>|[\\s(])([0-9a-f]{40})(</p>|[\\s.,;:)])',
        html  => '$1<a href=\"#q,$2,n,z\">$2</a>$3',
      },
    ],
    war                                 => $war,
    contactstore                        => $contactstore,
    contactstore_appsec                 => $contactstore_appsec,
    contactstore_pubkey                 => $contactstore_pubkey,
    contactstore_url                    => $contactstore_url,
    mysql_host                          => $mysql_host,
    mysql_password                      => $mysql_password,
    email_private_key                   => $email_private_key,
    replicate_local                     => $replicate_local,
    replicate_path                      => $local_git_dir,
    replication                         => $replication,
    gitweb                              => $gitweb,
    cgit                                => $cgit,
    web_repo_url                        => $web_repo_url,
    testmode                            => $testmode,
    secondary_index                     => $secondary_index,
    require                             => Class[tesora_cyclone::server],
  }

  mysql_backup::backup_remote { 'gerrit':
    database_host     => $mysql_host,
    database_user     => 'gerrit2',
    database_password => $mysql_password,
    require           => Class['::gerrit'],
  }

  if ($testmode == false) {
    include gerrit::cron
    class { 'github':
      username         => $github_username,
      project_username => $github_project_username,
      project_password => $github_project_password,
      oauth_token      => $github_oauth_token,
      require          => Class['::gerrit']
    }
  }

  file { '/home/gerrit2/review_site/static/echosign-cla.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/tesora_cyclone/gerrit/echosign-cla.html',
    replace => true,
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/static/cla.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/tesora_cyclone/gerrit/cla.html',
    replace => true,
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/static/usg-cla.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/tesora_cyclone/gerrit/usg-cla.html',
    replace => true,
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/static/system-cla.html':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => 'puppet:///modules/tesora_cyclone/gerrit/system-cla.html',
    replace => true,
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/static/title.png':
    ensure  => present,
    source  => 'puppet:///modules/tesora_cyclone/openstack.png',
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/static/openstack-page-bkg.jpg':
    ensure  => present,
    source  => 'puppet:///modules/tesora_cyclone/openstack-page-bkg.jpg',
    require => Class['::gerrit'],
  }

  package { 'libjs-jquery':
    ensure => present,
  }

  file { '/home/gerrit2/review_site/static/jquery.min.js':
    ensure  => present,
    source  => '/usr/share/javascript/jquery/jquery.min.js',
    require => [Class['::gerrit'],
                Package['libjs-jquery']],
  }

  file { '/home/gerrit2/review_site/static/hideci.js':
    ensure  => present,
    source  => 'puppet:///modules/tesora_cyclone/gerrit/hideci.js',
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/etc/GerritSite.css':
    ensure  => present,
    source  => 'puppet:///modules/tesora_cyclone/gerrit/GerritSite.css',
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/etc/GerritSiteHeader.html':
    ensure  => present,
    source  =>
      'puppet:///modules/tesora_cyclone/gerrit/GerritSiteHeader.html',
    require => Class['::gerrit'],
  }

  cron { 'gerritsyncusers':
    ensure => absent,
  }

  cron { 'sync_launchpad_users':
    ensure => absent,
  }

  file { '/home/gerrit2/review_site/hooks/change-merged':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    source  => 'puppet:///modules/tesora_cyclone/gerrit/change-merged',
    replace => true,
    require => Class['::gerrit'],
  }

  file { '/home/gerrit2/review_site/hooks/change-abandoned':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    source  => 'puppet:///modules/tesora_cyclone/gerrit/change-abandoned',
    replace => true,
    require => Class['::gerrit'],
  }

  if ($notify_impact_file != 'UNDEF') {
    file { '/home/gerrit2/review_site/hooks/notify_impact.yaml':
      ensure  => present,
      source  => $notify_impact_file,
      require => Class['::gerrit'],
    }
  }

  file { '/home/gerrit2/review_site/hooks/patchset-created':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    content => template('tesora_cyclone/gerrit_patchset-created.erb'),
    replace => true,
    require => Class['::gerrit'],
  }

  if $ssh_welcome_rsa_key_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_welcome_rsa_key':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0600',
      content => $ssh_welcome_rsa_key_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if $ssh_welcome_rsa_pubkey_contents != '' {
    file { '/home/gerrit2/review_site/etc/ssh_welcome_rsa_key.pub':
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0644',
      content => $ssh_welcome_rsa_pubkey_contents,
      replace => true,
      require => File['/home/gerrit2/review_site/etc']
    }
  }

  if ($projects_file != 'UNDEF') {
    if ($replicate_local) {
      file { $local_git_dir:
        ensure  => directory,
        owner   => 'gerrit2',
        require => Class['::gerrit'],
      }
      cron { 'mirror_repack':
        user        => 'gerrit2',
        weekday     => '0',
        hour        => '4',
        minute      => '7',
        command     => "find ${local_git_dir} -type d -name \"*.git\" -print -exec git --git-dir=\"{}\" repack -afd \\;",
        environment => 'PATH=/usr/bin:/bin:/usr/sbin:/sbin',
      }
    }

    file { '/home/gerrit2/projects.yaml':
      ensure  => present,
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0444',
      source  => $projects_file,
      replace => true,
      require => Class['::gerrit'],
    }

    file { '/home/gerrit2/projects.ini':
      ensure  => present,
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0444',
      content => template($projects_config),
      replace => true,
      require => Class['::gerrit'],
    }

    file { '/home/gerrit2/acls':
      ensure  => directory,
      owner   => 'gerrit2',
      group   => 'gerrit2',
      mode    => '0444',
      recurse => true,
      replace => true,
      purge   => true,
      force   => true,
      source  => $acls_dir,
      require => Class['::gerrit']
    }

    if ($testmode == false) {
      exec { 'manage_projects':
        command     => '/usr/local/bin/manage-projects -v >> /var/log/manage_projects.log 2>&1',
        timeout     => 900, # 15 minutes
        subscribe   => [
            File['/home/gerrit2/projects.yaml'],
            File['/home/gerrit2/acls'],
          ],
        refreshonly => true,
        logoutput   => true,
        require     => [
            File['/home/gerrit2/projects.yaml'],
            File['/home/gerrit2/acls'],
            Class['jeepyb'],
          ],
      }

      include logrotate
      logrotate::file { 'manage_projects.log':
        log     => '/var/log/manage_projects.log',
        options => [
          'compress',
          'missingok',
          'rotate 30',
          'daily',
          'notifempty',
          'copytruncate',
        ],
        require => Exec['manage_projects'],
      }
    }
  }
  file { '/home/gerrit2/review_site/bin/set_agreements.sh':
    ensure  => absent,
  }
}
