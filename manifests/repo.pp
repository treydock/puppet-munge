# == Class: munge::repo
#
# Private class
#
class munge::repo {

  if $::munge::use_epel {
    case $::osfamily {
      'RedHat': {
        contain ::epel
      }
      default: {
        # Do nothing
      }
    }
  }

}
