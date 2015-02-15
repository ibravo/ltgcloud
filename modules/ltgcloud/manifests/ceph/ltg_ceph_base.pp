# Installs ceph Monitor
class ltgcloud::ceph::ltg_ceph_base (

) inherits ltgcloud::ceph::params {

  if ( $manage_repo ) {
    Class['ltgcloud::ceph::ltg_ceph_repo'] -> Class['ltgcloud::ceph::cephinit']

    class { 'ltgcloud::ceph::ltg_ceph_repo':
      release => $release,
    }
  }

  class { 'ltgcloud::ceph::cephinit':
    fsid                      => $fsid,
    authentication_type       => $authentication_type,
    osd_pool_default_pg_num   => $osd_pool_default_pg_num,
    osd_pool_default_pgp_num  => $osd_pool_default_pgp_num,
    osd_pool_default_size     => $osd_pool_default_size,
    osd_pool_default_min_size => $osd_pool_default_min_size,
    mon_initial_members       => $mon_initial_members,
    mon_host                  => $mon_host,
    cluster_network           => $cluster_network,
    public_network            => $public_network,
  }

}