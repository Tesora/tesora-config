# == Class: tesora_cyclone::template
#
# A template host with no running services
#
class tesora_cyclone::template (
  $iptables_public_tcp_ports = [],
  $iptables_public_udp_ports = [],
  $iptables_rules4           = [],
  $iptables_rules6           = [],
  $pin_puppet                = '3.',
  $install_users             = true,
  $install_resolv_conf       = false,
  $automatic_upgrades        = true,
  $certname                  = $::fqdn,
  $ca_server                 = undef,
  $enable_unbound            = true,
) {
  include ssh
  include snmpd
  if $automatic_upgrades == true {
    class { 'tesora_cyclone::automatic_upgrades':
      origins => ["Puppetlabs:${lsbdistcodename}"],
    }
  }

  class { 'iptables':
    public_tcp_ports => concat($iptables_public_tcp_ports, [5666]),
    public_udp_ports => $iptables_public_udp_ports,
    rules4           => $iptables_rules4,
    rules6           => $iptables_rules6,
  }

  class { 'ntp': }

  class { 'tesora_cyclone::base':
    install_users => $install_users,
    certname      => $certname,
    pin_puppet    => $pin_puppet,
    ca_server     => $ca_server,
  }

  package { 'lvm2':
    ensure => present,
  }

  package { 'strace':
    ensure => present,
  }

  package { 'tcpdump':
    ensure => present,
  }

  package { 'rsyslog':
    ensure => present,
  }

  package { 'git':
    ensure => present,
  }

  package { 'rsync':
    ensure => present,
  }

  if ($enable_unbound) {
    class { 'unbound':
      install_resolv_conf => $install_resolv_conf
    }
  }

  if $::osfamily == 'Debian' {
    # Make sure dig is installed
    package { 'dnsutils':
      ensure => present,
    }

    # Custom rsyslog config to disable /dev/xconsole noise on Debuntu servers
    file { '/etc/rsyslog.d/50-default.conf':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      source  =>
        'puppet:///modules/tesora_cyclone/rsyslog.d_50-default.conf',
      replace => true,
      notify  => $rsyslog_notify,
      require => Package['rsyslog'],
    }

    # Ubuntu installs their whoopsie package by default, but it eats through
    # memory and we don't need it on servers
    package { 'whoopsie':
      ensure => absent,
    }

    package { 'popularity-contest':
      ensure => absent,
    }
  }

  if ($::in_chroot) {
    notify { 'rsyslog in chroot':
      message => 'rsyslog not refreshed, running in chroot',
    }
    $rsyslog_notify = []
  } else {
    service { 'rsyslog':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      require    => Package['rsyslog'],
    }
    $rsyslog_notify = [ Service['rsyslog'] ]
  }

  # Increase syslog message size in order to capture
  # python tracebacks with syslog.
  file { '/etc/rsyslog.d/99-maxsize.conf':
    ensure  => present,
    # Note MaxMessageSize is not a puppet variable.
    content => '$MaxMessageSize 6k',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => $rsyslog_notify,
    require => Package['rsyslog'],
  }

  if ($::osfamily == 'RedHat') {
    # Make sure dig is installed
    package { 'bind-utils':
      ensure => present,
    }
  }

  class { 'tesora_cyclone::hosts': }

  class { 'nrpe':
    allowed_hosts => ['127.0.0.1', $::ipaddress ,'10.47.232.50'],
  }
}
