# == Class: tesora_cyclone::slave
#
class tesora_cyclone::slave (
  $thin = false,
  $certname = $::fqdn,
  $ssh_key = '',
  $sysadmins = [],
  $python3 = false,
  $include_pypy = false
) {

  include tesora_cyclone
  include tesora_cyclone::tmpcleanup

  class { 'tesora_cyclone::server':
    iptables_public_tcp_ports => [],
    certname                  => $certname,
    sysadmins                 => $sysadmins,
  }

  class { 'jenkins::slave':
    ssh_key      => $ssh_key,
    python3      => $python3,
  }

  include jenkins::cgroups
  include ulimit
  ulimit::conf { 'limit_jenkins_procs':
    limit_domain => 'jenkins',
    limit_type   => 'hard',
    limit_item   => 'nproc',
    limit_value  => '256'
  }

  class { 'tesora_cyclone::slave_common':
    include_pypy => $include_pypy,
  }

  if (! $thin) {
    include tesora_cyclone::thick_slave
  }

}
