#
#  Private class for 'geoipupdate' install
#

class geoipupdate::install (
  $package_ensure     = $geoipupdate::package_ensure,
  $package_name       = $geoipupdate::package_name,
  $service_update_cmd = $geoipupdate::service_update_cmd,
  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
) {

  $_package_ensure = $package_ensure ? {
    true     => 'present',
    false    => 'purged',
    'absent' => 'purged',
    default  => $package_ensure,
  }

  # Not sure if os family check is needed...
  case $facts['os']['family'] {
    'RedHat': {
      package { 'geoipupdate':
        ensure => $_package_ensure,
        name   => $package_name,
      }
    }
    default: {
      fail('Unsupported OS family')
    }
  }

}
