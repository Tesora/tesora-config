# Class: tesora_cyclone::users_install
#
# This class handles adding and removing openstack admin users
# from the servers.
#
# Parameters:
#   install_users - Boolean to set install or removal of O.O
#   admins.  Defaults to 'false', can be set in hiera.
#
# Requires:
#   tesora_cyclone::users - must contain the users designated.
#
# Sample Usage:
#   include tesora_cyclone::users_install
#   class { 'tesora_cyclone::users_install':
#     install_users => true,
#   }

class tesora_cyclone::users_install (
  $install_users = false,
) {

  include tesora_cyclone::users

  ## TODO: this should be it's own manifest.
  if ( $install_users == true ) {
    package { $::tesora_cyclone::params::user_packages:
      ensure => present
    }
    realize (
      User::Virtual::Localuser['andrew'],
      User::Virtual::Localuser['amrith'],
      User::Virtual::Localuser['bhunter'],
      User::Virtual::Localuser['doug'],
    )
  } else {
      user::virtual::disable{'andrew':}
      user::virtual::disable{'amrith':}
      user::virtual::disable{'bhunter':}
      user::virtual::disable{'doug':}
  }
}

