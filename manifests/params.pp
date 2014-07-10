# == Class: munge::params
#
# Private class
#
class munge::params {

  case $::osfamily {
    'RedHat': {
      $package_name       = 'munge'
      $package_require    = Yumrepo['epel']
      $dev_package_name   = 'munge-devel'
      $service_name       = 'munge'
      $service_hasstatus  = true
      $service_hasrestart = true
      $munge_key_path     = '/etc/munge/munge.key'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
