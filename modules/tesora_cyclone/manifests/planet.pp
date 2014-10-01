# == Class: tesora_cyclone::planet
#
class tesora_cyclone::planet (
  $sysadmins = []
) {
  class { 'tesora_cyclone::server':
    iptables_public_tcp_ports => [80],
    sysadmins                 => $sysadmins,
  }
  include ::planet

  planet::site { 'openstack':
    git_url => 'git://git.openstack.org/openstack/openstack-planet',
  }
}
