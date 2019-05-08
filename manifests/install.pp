# @summary Manage munge packages
# @api private
class munge::install {

  package { 'munge':
    ensure => $::munge::package_ensure,
    name   => $::munge::package_name,
  }

  if $::munge::install_dev {
    package { 'munge-devel':
      ensure => $::munge::package_ensure,
      name   => $::munge::dev_package_name,
    }
  }

}
