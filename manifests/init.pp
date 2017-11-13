# == Class: munge
#
# See README.md for more details.
#
class munge (
  String $package_ensure                = 'present',
  String $package_name                  = $munge::params::package_name,
  Boolean $install_dev                  = false,
  String $dev_package_name              = $munge::params::dev_package_name,
  String $service_name                  = $munge::params::service_name,
  String $service_ensure                = 'running',
  Boolean $service_enable               = true,
  Boolean $service_hasstatus            = $munge::params::service_hasstatus,
  Boolean $service_hasrestart           = $munge::params::service_hasrestart,
  Stdlib::Absolutepath $munge_key_path  = $munge::params::munge_key_path,
  Optional[String] $munge_key_source    = undef,
  Boolean $manage_user                  = true,
  Optional[Integer] $munge_user_uid     = undef,
  Optional[Integer] $munge_group_gid    = undef,
) inherits munge::params {

  anchor { 'munge::start': }
  -> class { '::munge::user': }
  -> class { '::munge::install': }
  -> class { '::munge::config': }
  ~> class { '::munge::service': }
  -> anchor { 'munge::end': }

}
