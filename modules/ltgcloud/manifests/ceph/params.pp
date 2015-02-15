class ltgcloud::ceph::params (
  # puppet 2.7 compatibiliy hack. TODO: change to undef once 2.7 is deprecated
  $fsid = '4b5c8c0a-ff60-454b-a1b4-9747aa737d19',
  $release = undef,           # If undef, selected in ltg_ceph_repo
  $authentication_type = undef,
  $mon_initial_members = undef,
  $mon_host = undef,
  $osd_pool_default_pg_num = undef,
  $osd_pool_default_pgp_num = undef,
  $osd_pool_default_size = undef,
  $osd_pool_default_min_size = undef,
  $cluster_network = undef,
  $public_network = undef,
  $admin_key = undef,
  $admin_key_mode = undef,
  $mon_key = undef,
  $mon_keyring = undef,
  $bootstrap_osd_key = undef,
  $bootstrap_mds_key = undef,
  $osds = undef,
  $manage_repo = true,      # Add true if repo needs to be installed as well
  $packages = 'ceph', # just provide the minimum per default
  $rgw_port = 80,
  $rgw_socket_path = '/tmp/radosgw.sock',
) {
      $pkg_radosgw = 'ceph-radosgw'
      $user_radosgw = 'apache'
      $pkg_fastcgi = 'mod_fastcgi'
}
