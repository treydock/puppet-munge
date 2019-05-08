# @summary Manage munge repo
# @api private
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
