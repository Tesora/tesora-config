# == Class: tesora_cyclone::hosts
#
class tesora_cyclone::hosts (
) {

  host { 'review.elasticdb.org':
    ip => '10.47.232.52',
  }

  host { 'zuul.elasticdb.org':
    ip => '10.47.232.46',
  }

  host { 'jenkins01.elasticdb.org':
    ip => '10.47.232.48',
  }

  host { 'nodepool.elasticdb.org':
    ip => '10.47.232.53',
  }

  host { 'ci-backup-01.elasticdb.org':
    ip => '10.47.232.55',
  }

  host { 'static.elasticdb.org':
    ip => '10.47.232.54',
  }

  host { 'ci-puppetmaster.openstacklocal':
    ip => '10.47.232.49',
  }

}
