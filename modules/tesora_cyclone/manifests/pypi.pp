# == Class: tesora_cyclone::pypi
#
class tesora_cyclone::pypi (
  $vhost_name = $::fqdn,
  $sysadmins = [],
) {

  class { 'tesora_cyclone::server':
    iptables_public_tcp_ports => [22, 80],
    sysadmins                 => $sysadmins,
  }

  class { 'tesora_cyclone::pypi_mirror':
    vhost_name => $vhost_name,
  }
}
