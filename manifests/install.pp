# == Class: munge::install
#
# Private class
#
class munge::install {

  include '::munge'

  case $::osfamily {
    'RedHat': {
      include '::epel'
    }
    default: {
      # Do nothing
    }
  }

  package { 'munge':
    ensure  => $::munge::package_ensure,
    name    => $::munge::package_name,
    require => $::munge::package_require,
  }

}
