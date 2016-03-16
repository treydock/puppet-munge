# == Class: munge::install
#
# Private class
#
class munge::install {

  include '::munge'

  if $::munge::package_manage_repo {
    case $::osfamily {
      'RedHat': {
        include '::epel'
        $package_require_eff = $::munge::package_require
      }
      default: {
        # Do nothing
      }
    }
  }

  package { 'munge':
    ensure  => $::munge::package_ensure,
    name    => $::munge::package_name,
    require => $package_require_eff,
  }

  if $::munge::install_dev {
    package { 'munge-devel':
      ensure  => $::munge::package_ensure,
      name    => $::munge::dev_package_name,
      require => $package_require_eff,
    }
  }

}
