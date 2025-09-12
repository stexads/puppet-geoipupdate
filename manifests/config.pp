#
# @summary Private class for configuring 'geoipupdate' config file
#
# @account_id
# @license_key
# @edition_ids
# @package_ensure
# @package_name
# @p_file_ensure
#
# @api private
#
class geoipupdate::config (
  String $account_id     = $geoipupdate::account_id,
  String $license_key    = $geoipupdate::license_key,
  String $edition_ids    = $geoipupdate::edition_ids,
  String $package_ensure = $geoipupdate::package_ensure,
  String $package_name   = $geoipupdate::package_name,
  String $p_file_ensure  = undef,
) {
  assert_private()

  file { '/etc/GeoIP.conf':
    ensure  => $p_file_ensure,
    content => template("${module_name}/GeoIP.conf.erb"),
    require => Package["${package_name}"],
  }

}
