# == Class: munge::repo
#
# Private class
#
class munge::repo {

  if $::munge::use_epel {
    case $::osfamily {
      'RedHat': {
        include '::epel'
      }
      default: {
        # Do nothing
      }
    }
  }

}
