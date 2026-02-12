# @summary Manage munge service
# @api private
class munge::service {
  service { 'munge':
    ensure => $munge::service_ensure,
    enable => $munge::service_enable,
    name   => $munge::service_name,
  }
}
