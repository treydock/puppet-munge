# == Class: munge::repo
#
# Private class
#
class munge::repo {

  if $::munge::manage_repo {
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
