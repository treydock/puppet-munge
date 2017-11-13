# Private class
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
      shell      => '/sbin/nologin',
      home       => '/var/run/munge',
      managehome => false,
      comment    => "Runs Uid 'N' Gid Emporium",
      system     => true,
      forcelocal => true,
    }
  }

}
