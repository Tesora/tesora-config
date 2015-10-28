# == Class: tesora_cyclone::hosts
#
class tesora_cyclone::hosts (
) {

  host { 'review.elasticdb.org':
    ip => '10.240.64.217',
  }

  host { 'zuul.elasticdb.org':
    ip => '10.240.64.214',
  }

  host { 'jenkins01.elasticdb.org':
    ip => '10.240.64.212',
  }

  host { 'nodepool.elasticdb.org':
    ip => '10.240.64.216',
  }

  host { 'ci-backup-01.elasticdb.org':
    ip => '10.240.64.14',
  }

  host { 'static.elasticdb.org':
    ip => '10.240.64.211',
  }

  host { 'ci-puppetmaster.openstacklocal':
    ip => '10.240.64.210',
  }

}
