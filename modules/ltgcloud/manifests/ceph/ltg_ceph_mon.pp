# Profile for a Ceph mon
#
class ltgcloud::ceph::ltg_ceph_mon {
  require ltgcloud::ceph::ltg_ceph_base

  Ltgcloud_Ceph_Config<| |> ->
  ltgcloud::ceph::ltg_ceph_mon_define { $::hostname:
    authentication_type => $ltgcloud::ceph::params::authentication_type,
    key                 => $ltgcloud::ceph::params::mon_key,
    keyring             => $ltgcloud::ceph::params::mon_keyring,
  }

  Ltgcloud::Ceph::Key {
    inject         => true,
    inject_as_id   => 'mon.',
    inject_keyring => "/var/lib/ceph/mon/ceph-${::hostname}/keyring",
  }
  # this supports providing the key manually
  if $ltgcloud::ceph::params::admin_key {
    ltgcloud::ceph::key { 'client.admin':
      secret       => $ltgcloud::ceph::params::admin_key,
      cap_mon      => 'allow *',
      cap_osd      => 'allow *',
      cap_mds      => 'allow',
      mode         => $ltgcloud::ceph::params::admin_key_mode,
    }
  }
  if $ltgcloud::ceph::params::bootstrap_osd_key {
    ltgcloud::ceph::key { 'client.bootstrap-osd':
      secret           => $ltgcloud::ceph::params::bootstrap_osd_key,
      keyring_path     => '/var/lib/ceph/bootstrap-osd/ceph.keyring',
      cap_mon          => 'allow profile bootstrap-osd',
    }
  }

  if $ltgcloud::ceph::params::bootstrap_mds_key {
    ltgcloud::ceph::key { 'client.bootstrap-mds':
      secret           => $ltgcloud::ceph::params::bootstrap_mds_key,
      keyring_path     => '/var/lib/ceph/bootstrap-mds/ceph.keyring',
      cap_mon          => 'allow profile bootstrap-mds',
    }
  }

  
}