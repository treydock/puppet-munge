# == Class: munge
#
# See README.md for more details.
#
class munge (
  $package_ensure       = 'present',
  $package_name         = $munge::params::package_name,
  $service_name         = $munge::params::service_name,
  $service_ensure       = 'running',
  $service_enable       = true,
  $service_hasstatus    = $munge::params::service_hasstatus,
  $service_hasrestart   = $munge::params::service_hasrestart,
  $munge_key_path       = $munge::params::munge_key_path,
  $munge_key_source     = undef,
) inherits munge::params {

  anchor { 'munge::start': }->
  class { '::munge::install': }->
  class { '::munge::config': }~>
  class { '::munge::service': }->
  anchor { 'munge::end': }

}
