# @summary Manage munge repo
# @api private
class munge::repo {
  if $munge::manage_repo {
    case $facts['os']['family'] {
      'RedHat': {
        contain epel
      }
      default: {
        # Do nothing
      }
    }
  }
}
