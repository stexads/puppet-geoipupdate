#
#  Private class for 'geoipupdate' package installation
#

class geoipupdate::install (
  $package_ensure     = $geoipupdate::package_ensure,
  $package_name       = $geoipupdate::package_name,
  $service_update_cmd = $geoipupdate::service_update_cmd,
  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
) {
#  private()

  # Not sure if os family check is needed...
  case $facts['os']['family'] {
    'RedHat': {
      package { 'geoipupdate':
        ensure => $package_ensure,
        name   => $package_name,
      }
    }
    default: {
      fail('Unsupported OS family')
    }
  }

}
