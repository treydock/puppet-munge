# @summary Manage munge config
# @api private
class munge::config {

  file { '/etc/munge/munge.key':
    ensure => 'file',
    path   => $::munge::munge_key_path,
    owner  => 'munge',
    group  => 'munge',
    mode   => '0400',
    source => $::munge::munge_key_source,
  }

}
