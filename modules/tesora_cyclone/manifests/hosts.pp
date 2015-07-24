# == Class: tesora_cyclone::hosts
#
class tesora_cyclone::hosts (
) {

  host { 'review.elasticdb.org':
    ip => '10.240.28.3',
    #host_aliases => 'review',
  }

  host { 'zuul.elasticdb.org':
    ip => '10.240.28.36',
  }

  host { 'jenkins01.elasticdb.org':
    ip => '10.240.29.108',
  }

  host { 'nodepool.elasticdb.org':
    ip => '10.240.28.196',
  }

  host { 'ci-backup-01.elasticdb.org':
    ip => '10.240.28.14',
  }

  host { 'static.elasticdb.org':
    ip => '10.240.28.44',
  }

  host { 'ci-puppetmaster.openstacklocal':
    ip => '10.240.28.27',
  }

}
