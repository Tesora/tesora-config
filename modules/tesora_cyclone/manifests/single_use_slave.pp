# == Class: tesora_cyclone::single_use_slave
#
# This class configures single use Jenkins slaves with a few
# toggleable options. Most importantly sudo rights for the Jenkins
# user are by default off but can be enabled. Also, automatic_upgrades
# are off by default as the assumption is the backing image for
# this single use slaves will be refreshed with new packages
# periodically.
class tesora_cyclone::single_use_slave (
  $certname = $::fqdn,
  $install_users = true,
  $install_resolv_conf = true,
  $sudo = false,
  $thin = true,
  $python3 = false,
  $include_pypy = false,
  $automatic_upgrades = false,
  $all_mysql_privs = false,
  $enable_unbound = true,
  $ssh_key = $tesora_cyclone::jenkins_ssh_key
) inherits tesora_cyclone {
  class { 'tesora_cyclone::template':
    certname            => $certname,
    automatic_upgrades  => $automatic_upgrades,
    install_users       => $install_users,
    install_resolv_conf => $install_resolv_conf,
    enable_unbound      => $enable_unbound,
    iptables_rules4     =>
      [
        # Ports 69 and 6385 allow to allow ironic VM nodes to reach tftp and
        # the ironic API from the neutron public net
        '-p udp --dport 69 -s 172.24.4.0/23 -j ACCEPT',
        '-p tcp --dport 6385 -s 172.24.4.0/23 -j ACCEPT',
        # Ports 8000, 8003, 8004 from the devstack neutron public net to allow
        # nova servers to reach heat-api-cfn, heat-api-cloudwatch, heat-api
        '-p tcp --dport 8000 -s 172.24.4.0/23 -j ACCEPT',
        '-p tcp --dport 8003 -s 172.24.4.0/23 -j ACCEPT',
        '-p tcp --dport 8004 -s 172.24.4.0/23 -j ACCEPT',
        '-m limit --limit 2/min -j LOG --log-prefix "iptables dropped: "',
      ],
  }
  class { 'jenkins::slave':
    ssh_key         => $ssh_key,
    python3         => $python3,
  }

  class { 'tesora_cyclone::slave_common':
    include_pypy    => $include_pypy,
    sudo            => $sudo,
  }

  if (! $thin) {
    class { 'tesora_cyclone::thick_slave':
      all_mysql_privs => $all_mysql_privs,
    }
  }

}
