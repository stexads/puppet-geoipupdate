#
# @summary Private class for configuring 'geoipupdate' config file
#
# @package_ensure
# @account_id
# @license_key
# @edition_ids
# @conf_dir
# @p_file_ensure
# @p_package_name
#
# @api private
#
class geoipupdate::config (
  String $package_ensure = $geoipupdate::package_ensure,
  String $account_id     = $geoipupdate::account_id,
  String $license_key    = $geoipupdate::license_key,
  String $edition_ids    = $geoipupdate::edition_ids,
  String $conf_dir       = $geoipupdate::conf_dir,
  String $p_file_ensure  = undef,
  String $p_package_name = undef,
) {
  assert_private()

  file { "${conf_dir}/GeoIP.conf":
    ensure  => $p_file_ensure,
    content => template("${module_name}/GeoIP.conf.erb"),
    require => Package["${p_package_name}"],
  }

}
