# == Class: tesora_cyclone::backup_server
#
class tesora_cyclone::backup_server {
  class { 'tesora_cyclone::template':
    iptables_public_tcp_ports => [],
  }
}
