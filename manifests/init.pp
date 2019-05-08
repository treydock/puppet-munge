# == Class: munge
#
# See README.md for more details.
#
class munge (
  Boolean $manage_repo                  = true,
  String $package_ensure                = 'present',
  String $package_name                  = 'munge',
  Boolean $install_dev                  = false,
  String $dev_package_name              = 'munge-devel',
  String $service_name                  = 'munge',
  String $service_ensure                = 'running',
  Boolean $service_enable               = true,
  Boolean $service_hasstatus            = true,
  Boolean $service_hasrestart           = true,
  Stdlib::Absolutepath $munge_key_path  = '/etc/munge/munge.key',
  Optional[String] $munge_key_source    = undef,
  Boolean $manage_user                  = true,
  Optional[Integer] $munge_user_uid     = undef,
  Optional[Integer] $munge_group_gid    = undef,
  Stdlib::Absolutepath $munge_user_shell = '/sbin/nologin',
  Stdlib::Absolutepath $munge_user_home = '/var/run/munge',
) {

  if ! $facts['os']['family'] in ['RedHat'] {
    fail("Unsupported osfamily: ${facts['os']['family']}, module ${module_name} only support osfamily RedHat")
  }

  anchor { 'munge::start': }
  -> class { '::munge::user': }
  -> class { '::munge::repo': }
  -> class { '::munge::install': }
  -> class { '::munge::config': }
  ~> class { '::munge::service': }
  -> anchor { 'munge::end': }

}
