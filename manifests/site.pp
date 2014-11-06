#
# Top-level variables
#
# There must not be any whitespace between this comment and the variables or
# in between any two variables in order for them to be correctly parsed and
# passed around in test.sh
#
$elasticsearch_nodes = [
  'elasticsearch02.elasticdb.org',
]
$elasticsearch_clients = [
  'logstash.elasticdb.org',
  'logstash-worker01.elasticdb.org',
]

#
# Default: should at least behave like an openstack server
#
node default {
  class { 'tesora_cyclone::server':
    sysadmins => hiera('sysadmins', []),
  }
}

#
# Long lived servers:
#
# Node-OS: precise
node 'review.elasticdb.org' {
  class { 'tesora_cyclone::review':
    project_config_repo                 => 'https://github.com/Tesora/tesora-project-config',
    github_oauth_token                  => hiera('gerrit_github_token', 'XXX'),
    github_project_username             => hiera('github_project_username', 'username'),
    github_project_password             => hiera('github_project_password', 'XXX'),
    mysql_host                          => hiera('gerrit_mysql_host', 'localhost'),
    mysql_password                      => hiera('gerrit_mysql_password', 'XXX'),
    email_private_key                   => hiera('gerrit_email_private_key', 'XXX'),
    gerritbot_password                  => hiera('gerrit_gerritbot_password', 'XXX'),
    gerritbot_ssh_rsa_key_contents      => hiera('gerritbot_ssh_rsa_key_contents', 'XXX'),
    gerritbot_ssh_rsa_pubkey_contents   => hiera('gerritbot_ssh_rsa_pubkey_contents', 'XXX'),
    ssl_cert_file_contents              => hiera('gerrit_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents               => hiera('gerrit_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents             => hiera('gerrit_ssl_chain_file_contents', 'XXX'),
    ssh_dsa_key_contents                => hiera('gerrit_ssh_dsa_key_contents', 'XXX'),
    ssh_dsa_pubkey_contents             => hiera('gerrit_ssh_dsa_pubkey_contents', 'XXX'),
    ssh_rsa_key_contents                => hiera('gerrit_ssh_rsa_key_contents', 'XXX'),
    ssh_rsa_pubkey_contents             => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    ssh_project_rsa_key_contents        => hiera('gerrit_project_ssh_rsa_key_contents', 'XXX'),
    ssh_project_rsa_pubkey_contents     => hiera('gerrit_project_ssh_rsa_pubkey_contents', 'XXX'),
    ssh_welcome_rsa_key_contents        => hiera('welcome_message_gerrit_ssh_private_key', 'XXX'),
    ssh_welcome_rsa_pubkey_contents     => hiera('welcome_message_gerrit_ssh_public_key', 'XXX'),
    ssh_replication_rsa_key_contents    => hiera('gerrit_replication_ssh_rsa_key_contents', 'XXX'),
    ssh_replication_rsa_pubkey_contents => hiera('gerrit_replication_ssh_rsa_pubkey_contents', 'XXX'),
    lp_sync_consumer_key                => hiera('gerrit_lp_consumer_key', 'XXX'),
    lp_sync_token                       => hiera('gerrit_lp_access_token', 'XXX'),
    lp_sync_secret                      => hiera('gerrit_lp_access_secret', 'XXX'),
    contactstore_appsec                 => hiera('gerrit_contactstore_appsec', 'XXX'),
    contactstore_pubkey                 => hiera('gerrit_contactstore_pubkey', 'XXX'),
    sysadmins                           => hiera('sysadmins', []),
#    swift_username                      => hiera('swift_store_user', 'username'),
#    swift_password                      => hiera('swift_store_key', 'XXX'),
  }
}

# Node-OS: precise
node 'review-dev.elasticdb.org' {
  class { 'tesora_cyclone::review_dev':
    project_config_repo             => 'https://github.com/Tesora/tesora-project-config',
    github_oauth_token              => hiera('gerrit_dev_github_token', 'XXX'),
    github_project_username         => hiera('github_dev_project_username', 'username'),
    github_project_password         => hiera('github_dev_project_password', 'XXX'),
    mysql_host                      => hiera('gerrit_dev_mysql_host', 'localhost'),
    mysql_password                  => hiera('gerrit_dev_mysql_password', 'XXX'),
    email_private_key               => hiera('gerrit_dev_email_private_key', 'XXX'),
    contactstore_appsec             => hiera('gerrit_dev_contactstore_appsec', 'XXX'),
    contactstore_pubkey             => hiera('gerrit_dev_contactstore_pubkey', 'XXX'),
    ssh_dsa_key_contents            => hiera('gerrit_dev_ssh_dsa_key_contents', 'XXX'),
    ssh_dsa_pubkey_contents         => hiera('gerrit_dev_ssh_dsa_pubkey_contents', 'XXX'),
    ssh_rsa_key_contents            => hiera('gerrit_dev_ssh_rsa_key_contents', 'XXX'),
    ssh_rsa_pubkey_contents         => hiera('gerrit_dev_ssh_rsa_pubkey_contents', 'XXX'),
    ssh_project_rsa_key_contents    => hiera('gerrit_dev_project_ssh_rsa_key_contents', 'XXX'),
    ssh_project_rsa_pubkey_contents => hiera('gerrit_dev_project_ssh_rsa_pubkey_contents', 'XXX'),
    lp_sync_consumer_key            => hiera('gerrit_dev_lp_consumer_key', 'XXX'),
    lp_sync_token                   => hiera('gerrit_dev_lp_access_token', 'XXX'),
    lp_sync_secret                  => hiera('gerrit_dev_lp_access_secret', 'XXX'),
    sysadmins                       => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'jenkins.elasticdb.org' {
  class { 'tesora_cyclone::jenkins':
    project_config_repo     => 'https://github.com/Tesora/tesora-project-config',
    jenkins_jobs_password   => hiera('jenkins_jobs_password', 'XXX'),
    jenkins_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    ssl_cert_file_contents  => hiera('jenkins_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('jenkins_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('jenkins_ssl_chain_file_contents', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
    zmq_event_receivers     => ['logstash.elasticdb.org',
                                'nodepool.elasticdb.org',
    ],
  }
}

# Node-OS: precise
node /^jenkins\d+\.openstack\.org$/ {
  class { 'tesora_cyclone::jenkins':
    jenkins_jobs_password   => hiera('jenkins_jobs_password', 'XXX'),
    jenkins_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    ssl_cert_file           => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    ssl_key_file            => '/etc/ssl/private/ssl-cert-snakeoil.key',
    ssl_chain_file          => '',
    sysadmins               => hiera('sysadmins', []),
    zmq_event_receivers     => ['logstash.elasticdb.org',
                                'nodepool.elasticdb.org',
    ],
  }
}

# Node-OS: precise
node 'jenkins-dev.elasticdb.org' {
  class { 'tesora_cyclone::jenkins_dev':
    jenkins_ssh_private_key  => hiera('jenkins_dev_ssh_private_key_contents', 'XXX'),
    sysadmins                => hiera('sysadmins', []),
    mysql_password           => hiera('nodepool_dev_mysql_password', 'XXX'),
    mysql_root_password      => hiera('nodepool_dev_mysql_root_password', 'XXX'),
    nodepool_ssh_private_key => hiera('jenkins_dev_ssh_private_key_contents', 'XXX'),
    jenkins_api_user         => hiera('jenkins_dev_api_user', 'username'),
    jenkins_api_key          => hiera('jenkins_dev_api_key', 'XXX'),
    jenkins_credentials_id   => hiera('jenkins_dev_credentials_id', 'XXX'),
    hpcloud_username         => hiera('nodepool_hpcloud_username', 'username'),
    hpcloud_password         => hiera('nodepool_hpcloud_password', 'XXX'),
    hpcloud_project          => hiera('nodepool_hpcloud_project', 'XXX'),
  }
}

# Node-OS: precise
node 'cacti.elasticdb.org' {
  include tesora_cyclone::ssl_cert_check
  class { 'tesora_cyclone::cacti':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'community.elasticdb.org' {
  class { 'tesora_cyclone::community':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'puppetmaster.elasticdb.org' {
  class { 'tesora_cyclone::puppetmaster':
    root_rsa_key => hiera('puppetmaster_root_rsa_key', 'XXX'),
    sysadmins    => hiera('sysadmins', []),
    version      => '3.6.',
  }
}

# Node-OS: precise
node 'puppetdb.elasticdb.org' {
  class { 'tesora_cyclone::puppetdb':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'graphite.elasticdb.org' {
  class { 'tesora_cyclone::graphite':
    sysadmins               => hiera('sysadmins', []),
    graphite_admin_user     => hiera('graphite_admin_user', 'username'),
    graphite_admin_email    => hiera('graphite_admin_email', 'email@example.com'),
    graphite_admin_password => hiera('graphite_admin_password', 'XXX'),
    statsd_hosts            => ['logstash.elasticdb.org',
                                'nodepool.elasticdb.org',
                                'zuul.elasticdb.org'],
  }
}

# Node-OS: precise
node 'groups.elasticdb.org' {
  class { 'tesora_cyclone::groups':
    sysadmins           => hiera('sysadmins', []),
    site_admin_password => hiera('groups_site_admin_password', 'XXX'),
    site_mysql_host     => hiera('groups_site_mysql_host', 'localhost'),
    site_mysql_password => hiera('groups_site_mysql_password', 'XXX'),
    conf_cron_key       => hiera('groups_conf_cron_key', 'XXX'),
  }
}

# Node-OS: precise
node 'groups-dev.elasticdb.org' {
  class { 'tesora_cyclone::groups_dev':
    sysadmins           => hiera('sysadmins', []),
    site_admin_password => hiera('groups_dev_site_admin_password', 'XXX'),
    site_mysql_host     => hiera('groups_dev_site_mysql_host', 'localhost'),
    site_mysql_password => hiera('groups_dev_site_mysql_password', 'XXX'),
    conf_cron_key       => hiera('groups_dev_conf_cron_key', 'XXX'),
  }
}

# Node-OS: precise
node 'lists.elasticdb.org' {
  class { 'tesora_cyclone::lists':
    listadmins   => hiera('listadmins', []),
    listpassword => hiera('listpassword', 'XXX'),
  }
}

# Node-OS: precise
node 'paste.elasticdb.org' {
  class { 'tesora_cyclone::paste':
    db_host     => hiera('paste_db_host', 'localhost'),
    db_password => hiera('paste_db_password', 'XXX'),
    sysadmins   => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'planet.elasticdb.org' {
  class { 'tesora_cyclone::planet':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'eavesdrop.elasticdb.org' {
  class { 'tesora_cyclone::eavesdrop':
    project_config_repo     => 'https://github.com/Tesora/tesora-project-config',
    nickpass                => hiera('openstack_meetbot_password', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
    statusbot_nick          => hiera('statusbot_nick', 'username'),
    statusbot_password      => hiera('statusbot_nick_password', 'XXX'),
    statusbot_server        => 'chat.freenode.net',
    statusbot_channels      => 'edeploy, fuel-dev, heat, magnetodb, murano, openstack, openstack-101, openstack-anvil, openstack-bacon, openstack-barbican, openstack-blazar, openstack-board, openstack-ceilometer, openstack-chef, openstack-cinder, openstack-cloudkeep, openstack-community, openstack-containers, openstack-dev, openstack-dns, openstack-doc, openstack-entropy, openstack-foundation, openstack-gantt, openstack-gate, openstack-hyper-v, openstack-infra, openstack-ironic, openstack-keystone, openstack-manila, openstack-meeting, openstack-meeting-3, openstack-meeting-alt, openstack-meniscus, openstack-merges, openstack-metering, openstack-monasca, openstack-neutron, openstack-nova, openstack-opw, openstack-oslo, openstack-packaging, openstack-qa, openstack-raksha, openstack-rating, openstack-relmgr-office, openstack-sahara, openstack-sdks, openstack-stable, openstack-state-management, openstack-swift, openstack-translation, openstack-trove, openstack-zaqar, packstack-dev, refstack, storyboard, syscompass, tripleo',
    statusbot_auth_nicks    => 'jeblair, ttx, fungi, mordred, clarkb, sdague, SergeyLukjanov, jhesketh, lifeless',
    statusbot_wiki_user     => hiera('statusbot_wiki_username', 'username'),
    statusbot_wiki_password => hiera('statusbot_wiki_password', 'XXX'),
    statusbot_wiki_url      => 'https://wiki.elasticdb.org/w/api.php',
    statusbot_wiki_pageid   => '1781',
    accessbot_nick          => hiera('accessbot_nick', 'username'),
    accessbot_password      => hiera('accessbot_nick_password', 'XXX'),
  }
}

# Node-OS: precise
node 'etherpad.elasticdb.org' {
  class { 'tesora_cyclone::etherpad':
    ssl_cert_file_contents  => hiera('etherpad_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('etherpad_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('etherpad_ssl_chain_file_contents', 'XXX'),
    mysql_host              => hiera('etherpad_db_host', 'localhost'),
    mysql_user              => hiera('etherpad_db_user', 'username'),
    mysql_password          => hiera('etherpad_db_password', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'etherpad-dev.elasticdb.org' {
  class { 'tesora_cyclone::etherpad_dev':
    mysql_host          => hiera('etherpad-dev_db_host', 'localhost'),
    mysql_user          => hiera('etherpad-dev_db_user', 'username'),
    mysql_password      => hiera('etherpad-dev_db_password', 'XXX'),
    sysadmins           => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'wiki.elasticdb.org' {
  class { 'tesora_cyclone::wiki':
    mysql_root_password     => hiera('wiki_db_password', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
    ssl_cert_file_contents  => hiera('wiki_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('wiki_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('wiki_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: precise
node 'logstash.elasticdb.org' {
  class { 'tesora_cyclone::logstash':
    sysadmins           => hiera('sysadmins', []),
    elasticsearch_nodes => $elasticsearch_nodes,
    gearman_workers     => $elasticsearch_clients,
    discover_nodes      => [
      'elasticsearch02.elasticdb.org:9200',
    ],
  }
}

# Node-OS: precise
node /^logstash-worker\d+\.openstack\.org$/ {
  class { 'tesora_cyclone::logstash_worker':
    sysadmins             => hiera('sysadmins', []),
    elasticsearch_nodes   => $elasticsearch_nodes,
    elasticsearch_clients => $elasticsearch_clients,
    discover_node         => 'elasticsearch02.elasticdb.org',
  }
}

# Node-OS: precise
node /^elasticsearch0[1-7]\.openstack\.org$/ {
  class { 'tesora_cyclone::elasticsearch_node':
    sysadmins             => hiera('sysadmins', []),
    elasticsearch_nodes   => $elasticsearch_nodes,
    elasticsearch_clients => $elasticsearch_clients,
    discover_nodes        => $elasticsearch_nodes,
  }
}

# A CentOS machine to load balance git access.
# Node-OS: centos6
node 'git.elasticdb.org' {
  class { 'tesora_cyclone::git':
    sysadmins               => hiera('sysadmins', []),
    balancer_member_names   => [
      'git01.elasticdb.org',
      'git02.elasticdb.org',
      'git03.elasticdb.org',
      'git04.elasticdb.org',
      'git05.elasticdb.org',
    ],
    balancer_member_ips     => [
      '198.61.223.164',
      '23.253.102.209',
      '162.242.144.38',
      '166.78.46.164',
      '166.78.46.121',
    ],
  }
}

# CentOS machines to run cgit and git daemon. Will be
# load balanced by git.elasticdb.org.
# Node-OS: centos6
node /^git\d+\.openstack\.org$/ {
  include tesora_cyclone
  class { 'tesora_cyclone::git_backend':
    project_config_repo     => 'https://github.com/Tesora/tesora-project-config',
    vhost_name              => 'git.elasticdb.org',
    sysadmins               => hiera('sysadmins', []),
    git_gerrit_ssh_key      => hiera('gerrit_replication_ssh_rsa_pubkey_contents', 'XXX'),
    ssl_cert_file_contents  => hiera('git_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('git_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('git_ssl_chain_file_contents', 'XXX'),
    behind_proxy            => true,
  }
}

# Machines in each region to run PyPI mirrors.
# Node-OS: precise
node /^pypi\..*\.openstack\.org$/ {
  class { 'tesora_cyclone::pypi':
    sysadmins               => hiera('sysadmins', []),
  }
}

# A machine to run ODSREG in preparation for summits.
# Node-OS: precise
node 'summit.elasticdb.org' {
  class { 'tesora_cyclone::summit':
    sysadmins => hiera('sysadmins', []),
  }
}

# A machine to run Storyboard
# Node-OS: precise
node 'storyboard.elasticdb.org' {
  class { 'tesora_cyclone::storyboard':
    project_config_repo     => 'https://github.com/Tesora/tesora-project-config',
    sysadmins               => hiera('sysadmins', []),
    mysql_host              => hiera('storyboard_db_host', 'localhost'),
    mysql_user              => hiera('storyboard_db_user', 'username'),
    mysql_password          => hiera('storyboard_db_password', 'XXX'),
    rabbitmq_user           => hiera('storyboard_rabbit_user', 'username'),
    rabbitmq_password       => hiera('storyboard_rabbit_password', 'XXX'),
    ssl_cert_file_contents  => hiera('storyboard_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('storyboard_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('storyboard_ssl_chain_file_contents', 'XXX')
  }
}

# A machine to serve static content.
# Node-OS: precise
node 'static.elasticdb.org' {
  class { 'tesora_cyclone::static':
    project_config_repo     => 'https://github.com/Tesora/tesora-project-config',
    sysadmins               => hiera('sysadmins', []),
    swift_authurl           => 'https://identity.api.rackspacecloud.com/v2.0/',
    swift_user              => 'infra-files-ro',
    swift_key               => hiera('infra_files_ro_password', 'XXX'),
    swift_tenant_name       => hiera('infra_files_tenant_name', 'tenantname'),
    swift_region_name       => 'DFW',
    swift_default_container => 'infra-files',
  }
}

# A machine to serve various project status updates.
# Node-OS: precise
node 'status.elasticdb.org' {
  class { 'tesora_cyclone::status':
    sysadmins                     => hiera('sysadmins', []),
    gerrit_host                   => 'review.elasticdb.org',
    gerrit_ssh_host_key           => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    reviewday_ssh_public_key      => hiera('reviewday_rsa_pubkey_contents', 'XXX'),
    reviewday_ssh_private_key     => hiera('reviewday_rsa_key_contents', 'XXX'),
    releasestatus_ssh_public_key  => hiera('releasestatus_rsa_pubkey_contents', 'XXX'),
    releasestatus_ssh_private_key => hiera('releasestatus_rsa_key_contents', 'XXX'),
    recheck_ssh_public_key        => hiera('elastic-recheck_gerrit_ssh_public_key', 'XXX'),
    recheck_ssh_private_key       => hiera('elastic-recheck_gerrit_ssh_private_key', 'XXX'),
    recheck_bot_nick              => 'openstackrecheck',
    recheck_bot_passwd            => hiera('elastic-recheck_ircbot_password', 'XXX'),
  }
}

# Node-OS: precise
node 'nodepool.elasticdb.org' {
  class { 'tesora_cyclone::nodepool_prod':
    project_config_repo      => 'https://github.com/Tesora/tesora-project-config',
    mysql_password           => hiera('nodepool_mysql_password', 'XXX'),
    mysql_root_password      => hiera('nodepool_mysql_root_password', 'XXX'),
    nodepool_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    sysadmins                => hiera('sysadmins', []),
    statsd_host              => 'graphite.elasticdb.org',
    jenkins_api_user         => hiera('jenkins_api_user', 'username'),
    jenkins_api_key          => hiera('jenkins_api_key', 'XXX'),
    jenkins_credentials_id   => hiera('jenkins_credentials_id', 'XXX'),
    rackspace_username       => hiera('nodepool_rackspace_username', 'username'),
    rackspace_password       => hiera('nodepool_rackspace_password', 'XXX'),
    rackspace_project        => hiera('nodepool_rackspace_project', 'project'),
    hpcloud_username         => hiera('nodepool_hpcloud_username', 'username'),
    hpcloud_password         => hiera('nodepool_hpcloud_password', 'XXX'),
    hpcloud_project          => hiera('nodepool_hpcloud_project', 'project'),
    tripleo_username         => hiera('nodepool_tripleo_username', 'username'),
    tripleo_password         => hiera('nodepool_tripleo_password', 'XXX'),
    tripleo_project          => hiera('nodepool_tripleo_project', 'project'),
  }
}

# Node-OS: precise
node 'zuul.elasticdb.org' {
  class { 'tesora_cyclone::zuul_prod':
    project_config_repo            => 'https://github.com/Tesora/tesora-project-config',
    gerrit_server                  => 'review.elasticdb.org',
    gerrit_user                    => 'jenkins',
    gerrit_ssh_host_key            => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key           => hiera('zuul_ssh_private_key_contents', 'XXX'),
    url_pattern                    => 'http://logs.elasticdb.org/{build.parameters[LOG_PATH]}',
    swift_authurl                  => 'https://identity.api.rackspacecloud.com/v2.0/',
    swift_user                     => 'infra-files-rw',
    swift_key                      => hiera('infra_files_rw_password', 'XXX'),
    swift_tenant_name              => hiera('infra_files_tenant_name', 'tenantname'),
    swift_region_name              => 'DFW',
    swift_default_container        => 'infra-files',
    swift_default_logserver_prefix => 'http://logs.elasticdb.org/',
    zuul_url                       => 'http://zuul.elasticdb.org/p',
    sysadmins                      => hiera('sysadmins', []),
    statsd_host                    => 'graphite.elasticdb.org',
    gearman_workers                => [
      'nodepool.elasticdb.org',
      'jenkins.elasticdb.org',
      'jenkins01.elasticdb.org',
      'jenkins02.elasticdb.org',
      'jenkins03.elasticdb.org',
      'jenkins04.elasticdb.org',
      'jenkins05.elasticdb.org',
      'jenkins06.elasticdb.org',
      'jenkins07.elasticdb.org',
      'jenkins-dev.elasticdb.org',
      'zm01.elasticdb.org',
      'zm02.elasticdb.org',
      'zm03.elasticdb.org',
      'zm04.elasticdb.org',
    ],
  }
}

# Node-OS: precise
node 'zm01.elasticdb.org' {
  class { 'tesora_cyclone::zuul_merger':
    gearman_server       => 'zuul.elasticdb.org',
    gerrit_server        => 'review.elasticdb.org',
    gerrit_user          => 'jenkins',
    gerrit_ssh_host_key  => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_ssh_private_key_contents', 'XXX'),
    sysadmins            => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'zm02.elasticdb.org' {
  class { 'tesora_cyclone::zuul_merger':
    gearman_server       => 'zuul.elasticdb.org',
    gerrit_server        => 'review.elasticdb.org',
    gerrit_user          => 'jenkins',
    gerrit_ssh_host_key  => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_ssh_private_key_contents', 'XXX'),
    sysadmins            => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'zm03.elasticdb.org' {
  class { 'tesora_cyclone::zuul_merger':
    gearman_server       => 'zuul.elasticdb.org',
    gerrit_server        => 'review.elasticdb.org',
    gerrit_user          => 'jenkins',
    gerrit_ssh_host_key  => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_ssh_private_key_contents', 'XXX'),
    sysadmins            => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'zm04.elasticdb.org' {
  class { 'tesora_cyclone::zuul_merger':
    gearman_server       => 'zuul.elasticdb.org',
    gerrit_server        => 'review.elasticdb.org',
    gerrit_user          => 'jenkins',
    gerrit_ssh_host_key  => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_ssh_private_key_contents', 'XXX'),
    sysadmins            => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'zuul-dev.elasticdb.org' {
  class { 'tesora_cyclone::zuul_dev':
    project_config_repo  => 'https://github.com/Tesora/tesora-project-config',
    gerrit_server        => 'review-dev.elasticdb.org',
    gerrit_user          => 'zuul-dev',
    zuul_ssh_private_key => hiera('zuul_dev_ssh_private_key_contents', 'XXX'),
    url_pattern          => 'http://logs.elasticdb.org/{build.parameters[LOG_PATH]}',
    zuul_url             => 'http://zuul-dev.elasticdb.org/p',
    sysadmins            => hiera('sysadmins', []),
    statsd_host          => 'graphite.elasticdb.org',
    gearman_workers      => [
      'jenkins.elasticdb.org',
      'jenkins01.elasticdb.org',
      'jenkins-dev.elasticdb.org',
    ],
  }
}

# Node-OS: centos6
node 'pbx.elasticdb.org' {
  class { 'tesora_cyclone::pbx':
    sysadmins     => hiera('sysadmins', []),
    sip_providers => [
      {
        provider => 'voipms',
        hostname => 'dallas.voip.ms',
        username => hiera('voipms_username', 'username'),
        password => hiera('voipms_password', 'XXX'),
        outgoing => false,
      },
    ],
  }
}

# Node-OS: precise
# A backup machine.  Don't run cron or puppet agent on it.
node /^ci-backup-.*\.elasticdb\.org$/ {
  include tesora_cyclone::backup_server
}

# Node-OS: precise
node 'proposal.slave.elasticdb.org' {
  include tesora_cyclone
  class { 'tesora_cyclone::proposal_slave':
    transifex_username       => 'openstackjenkins',
    transifex_password       => hiera('transifex_password', 'XXX'),
    jenkins_ssh_public_key   => $tesora_cyclone::jenkins_ssh_key,
    proposal_ssh_public_key  => hiera('proposal_ssh_public_key_contents', 'XXX'),
    proposal_ssh_private_key => hiera('proposal_ssh_private_key_contents', 'XXX'),
  }
}

# Node-OS: precise
node 'pypi.slave.elasticdb.org' {
  include tesora_cyclone
  class { 'tesora_cyclone::pypi_slave':
    pypi_username          => 'openstackci',
    pypi_password          => hiera('pypi_password', 'XXX'),
    jenkins_ssh_public_key => $tesora_cyclone::jenkins_ssh_key,
    jenkinsci_username     => hiera('jenkins_ci_org_user', 'username'),
    jenkinsci_password     => hiera('jenkins_ci_org_password', 'XXX'),
    mavencentral_username  => hiera('mavencentral_org_user', 'username'),
    mavencentral_password  => hiera('mavencentral_org_password', 'XXX'),
  }
}

# Node-OS: precise
node 'openstackid-dev.elasticdb.org' {
  class { 'tesora_cyclone::openstackid_dev':
    sysadmins               => hiera('sysadmins', []),
    site_admin_password     => hiera('openstackid_dev_site_admin_password', 'XXX'),
    id_mysql_host           => hiera('openstackid_dev_id_mysql_host', 'localhost'),
    id_mysql_password       => hiera('openstackid_dev_id_mysql_password', 'XXX'),
    id_mysql_user           => hiera('openstackid_dev_id_mysql_user', 'username'),
    ss_mysql_host           => hiera('openstackid_dev_ss_mysql_host', 'localhost'),
    ss_mysql_password       => hiera('openstackid_dev_ss_mysql_password', 'XXX'),
    ss_mysql_user           => hiera('openstackid_dev_ss_mysql_user', 'username'),
    ss_db_name              => hiera('openstackid_dev_ss_db_name', 'username'),
    redis_password          => hiera('openstackid_dev_redis_password', 'XXX'),
    ssl_cert_file_contents  => hiera('openstackid_dev_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('openstackid_dev_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('openstackid_dev_ssl_chain_file_contents', 'XXX'),
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
