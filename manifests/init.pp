# @summary Manage MUNGE
#
# @example
#   class { 'munge':
#      munge_key_source  => 'puppet:///modules/site_munge/munge.key',
#    }
#
# @param manage_repo
#   Whether or not to manage the repo necessary to install munge.
#   If set to false, it is assumed that the munge RPMs are available via a different repository.
# @param package_ensure
#   package 'ensure' property
# @param package_name
#   Munge package name.
# @param install_dev
#   Sets if the munge-devel package should be installed
# @param dev_package_name
#   Munge dev package name.
# @param service_name
#   Munge service name
# @param service_ensure
#   Munge service 'ensure' property
# @param service_enable
#   Munge service 'enable' property
# @param service_hasstatus
#   Munge service hasstatus value.
# @param service_hasrestart
#   Munge service hasrestart value.
# @param munge_key_path
#   Path to the munge.key file.  Default is OS dependent.
# @param log_dir
#   Log directory path, should be unnecessary to set.
# @param lib_dir
#   /var/lib directory path, should be unnecessary to set.
# @param conf_dir
#   /etc/munge directory path, should be unnecessary to set.
# @param run_dir
#   daemon run directory path, should be unnecessary to set.
# @param munge_key_source
#   The source for the munge.key file
# @param munge_key_content
#   The content for the munge.key file
# @param manage_user
#   Boolen that determines if munge user and group should be managed
# @param user
#   User running munge
# @param group
#   Group running munge
# @param munge_user_uid
#   UID of the munge user
# @param munge_group_gid
#   GID of the munge group
# @param munge_user_shell
#   Shell of munge user
# @param munge_user_home
#   Home directory of munge user
# @param package_install_options
#   An array of additional options to pass when installing a package. Typical usage is enabling certain repositories like EPEL.
#
class munge (
  Boolean $manage_repo                  = false,
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
  Optional[Stdlib::Absolutepath] $log_dir = undef,
  Optional[Stdlib::Absolutepath] $lib_dir = undef,
  Optional[Stdlib::Absolutepath] $conf_dir = undef,
  Optional[Stdlib::Absolutepath] $run_dir = undef,
  Optional[String] $munge_key_source    = undef,
  Optional[String] $munge_key_content   = undef,
  Boolean $manage_user                  = true,
  String $user                          = 'munge',
  String $group                         = 'munge',
  Optional[Integer] $munge_user_uid     = undef,
  Optional[Integer] $munge_group_gid    = undef,
  Stdlib::Absolutepath $munge_user_shell = '/sbin/nologin',
  Stdlib::Absolutepath $munge_user_home = '/var/run/munge',
  Optional[Array[String]] $package_install_options = undef,
) {
  contain munge::user
  contain munge::repo
  contain munge::install
  contain munge::config
  contain munge::service

  Class['munge::user']
  -> Class['munge::repo']
  -> Class['munge::install']
  -> Class['munge::config']
  ~> Class['munge::service']
}
