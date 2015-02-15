# Use the ltg internal repo instead of the packages in the internet
class ltgcloud::ceph::ltg_ceph_repo(
  $ensure  = present,
  $release = 'giant',
  $extras  = false,
  $fastcgi = false,
) {
      $enabled = $ensure ? { present => '1', absent => '0', default => absent, }
#      yumrepo { 'ext-epel-6.8':
        # puppet versions prior to 3.5 do not support ensure, use enabled instead
#        enabled    => $enabled,
#        descr      => 'External EPEL 6.8',
#        name       => 'ext-epel-6.8',
#        baseurl    => absent,
#        gpgcheck   => '0',
#        gpgkey     => absent,
#        mirrorlist => 'http://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
#        priority   => '20', # prefer ceph repos over EPEL
#        tag        => 'ceph',
#      }

      yumrepo { 'ext-ceph':
        # puppet versions prior to 3.5 do not support ensure, use enabled instead
        enabled    => $enabled,
        descr      => "External Ceph ${release}",
        name       => "ext-ceph-${release}",
#        baseurl    => "http://ceph.com/rpm-${release}/el6/\$basearch",
        baseurl=> "http://katello.hq.ltg/pulp/repos/LTG_Federal/Library/custom/Subscription/Ceph_Giant_RH7",
#        gpgcheck   => '1',
#        gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc',
        mirrorlist => absent,
        priority   => '10', # prefer ceph repos over EPEL
        tag        => 'ceph',
      }

      yumrepo { 'ext-ceph-noarch':
        # puppet versions prior to 3.5 do not support ensure, use enabled instead
        enabled    => $enabled,
        descr      => 'External Ceph noarch',
        name       => "ext-ceph-${release}-noarch",
#        baseurl    => "http://ceph.com/rpm-${release}/el6/noarch",
        baseurl => "http://katello.hq.ltg/pulp/repos/LTG_Federal/Library/custom/Subscription/Ceph_C7_Giant_noarch",
#        gpgcheck   => '1',
#        gpgkey     => 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc',
        mirrorlist => absent,
        priority   => '10', # prefer ceph repos over EPEL
        tag        => 'ceph',
      }

      Yumrepo<| tag == 'ceph' |> -> Package<| tag == 'ceph' |>

      # prefer ceph repos over EPEL
      package { 'yum-plugin-priorities':
        ensure => present,
      }
  
}