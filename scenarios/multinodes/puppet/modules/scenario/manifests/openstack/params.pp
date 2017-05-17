# Module:: scenario
# Manifest:: openstack/param.pp
#

class scenario::openstack::params {

  $admin_password = 'admin'

  $controller_public_address = hiera("scenario::openstack::controller_public_address")
  $storage_public_address = hiera("scenario::openstack::storage_public_address")

  $public_network = hiera("scenario::openstack::public_network")
  $data_network = hiera("scenario::openstack::data_network")


  case $::osfamily {
    'Debian': {
      include ::apt
      class { '::openstack_extras::repo::debian::ubuntu':
        release         => 'mitaka',
        repo            => 'proposed',
        package_require => true,
      }
      $package_provider = 'apt'
    }
    default: {
      fail("Unsupported osfamily (${::osfamily})")
    }
  }


}
