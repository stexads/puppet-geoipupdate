#
# @summary Private class for 'geoipupdate' package installation
#
# @package_ensure
# @package_name
#
# @api private
#
class geoipupdate::install (
  String $p_package_ensure = undef,
  String $package_name     = $geoipupdate::package_name,
) {
  assert_private()

  # Not sure if os family check is needed...
  case $facts['os']['family'] {
    'RedHat': {
      package { 'geoipupdate':
        ensure => $p_package_ensure,
        name   => $package_name,
      }
    }
    default: {
      notify { 'default':
        message => $facts['os']['family'],
      }
      fail('Unsupported OS family')
    }
  }

}
