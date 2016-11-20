# == Class: tesora_cyclone::hosts
#
class tesora_cyclone::hosts (
) {

  host { 'review.elasticdb.org':
    ip => '10.242.0.215',
  }

  host { 'zuul.elasticdb.org':
    ip => '10.242.0.216',
  }

  host { 'jenkins01.elasticdb.org':
    ip => '10.242.0.238',
  }

  host { 'nodepool.elasticdb.org':
    ip => '10.242.0.240',
  }

  host { 'ci-backup-01.elasticdb.org':
    ip => '10.242.0.253',
  }

  host { 'static.elasticdb.org':
    ip => '10.242.0.246',
  }

  host { 'ci-puppetmaster.openstacklocal':
    ip => '10.242.0.208',
  }

}
