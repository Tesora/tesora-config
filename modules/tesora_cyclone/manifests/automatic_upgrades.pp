# == Class: tesora_cyclone::automatic_upgrades
#
class tesora_cyclone::automatic_upgrades (
  $origins = []
) {

  if $::osfamily == 'Debian' {
    class { 'unattended_upgrades':
      origins => $origins,
    }
  }
  if $::osfamily == 'RedHat' {
    include packagekit::cron
  }

}
