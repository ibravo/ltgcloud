
class ltgcloud::ceph::config (
  $fsid                  = '',
  $mon_initial_members   = [ ],
  $mon_host              = [ ],
  $cluster_network       = '',
  $public_network        = '',
  $images_key            = '',
  $volumes_key           = '',
  $osd_pool_default_size = '',
  $osd_journal_size      = '',
) {

  file { "etc-ceph":
    path    => "/etc/ceph",
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    ensure => directory,
  }

  file { "etc-ceph-conf":
    path    => "/etc/ceph/ceph.conf",
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('ltgcloud/ceph-conf.erb'),
  }

  if $images_key {
    ::ltgcloud::ceph::keyring_config{ "images":
      key => $images_key,
    }
  }
  if $volumes_key {
    ::ltgcloud::ceph::keyring_config{ "volumes":
      key => $volumes_key,
    }
  }
}
