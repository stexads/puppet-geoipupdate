#
# @summary Private class for 'geoipupdate' package installation
#
# @p_package_ensure
# @p_package_name
#
# @api private
#
class geoipupdate::install (
  String $p_package_ensure = undef,
  String $p_package_name   = undef,
) {
  assert_private()

  package { 'geoipupdate':
    ensure => $p_package_ensure,
    name   => $p_package_name,
  }

}
