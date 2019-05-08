# @summary Manage munge user and group
# @api private
class munge::user {

  if $::munge::manage_user {
    group { 'munge':
      ensure     => 'present',
      name       => 'munge',
      gid        => $::munge::munge_group_gid,
      system     => true,
      forcelocal => true,
    }

    user { 'munge':
      ensure     => 'present',
      name       => 'munge',
      uid        => $::munge::munge_user_uid,
      gid        => 'munge',
      shell      => $::munge::munge_user_shell,
      home       => $::munge::munge_user_home,
      managehome => false,
      comment    => "Runs Uid 'N' Gid Emporium",
      system     => true,
      forcelocal => true,
    }
  }

}
