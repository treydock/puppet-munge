# @summary Manage munge config
# @api private
class munge::config {
  file { '/etc/munge/munge.key':
    ensure  => 'file',
    path    => $munge::munge_key_path,
    owner   => $munge::user,
    group   => $munge::group,
    mode    => '0400',
    source  => $munge::munge_key_source,
    content => $munge::munge_key_content,
  }

  if $munge::conf_dir {
    file { '/etc/munge':
      ensure => 'directory',
      path   => $munge::conf_dir,
      owner  => $munge::user,
      group  => $munge::group,
      mode   => '0700',
    }
  }

  if $munge::log_dir {
    file { '/var/log/munge':
      ensure => 'directory',
      path   => $munge::log_dir,
      owner  => $munge::user,
      group  => $munge::group,
      mode   => '0700',
    }
  }

  if $munge::lib_dir {
    file { '/var/lib/munge':
      ensure => 'directory',
      path   => $munge::lib_dir,
      owner  => $munge::user,
      group  => $munge::group,
      mode   => '0700',
    }
  }

  if $munge::run_dir {
    file { '/run/munge':
      ensure => 'directory',
      path   => $munge::run_dir,
      owner  => $munge::user,
      group  => $munge::group,
      mode   => '0755',
    }
  }
}
