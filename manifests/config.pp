#
# Private class for configuring 'geoipupdate' config file
#

class geoipupdate::config (
  $account_id     = $geoipupdate::account_id,
  $license_key    = $geoipupdate::license_key,
  $edition_ids    = $geoipupdate::edition_ids,
  $package_ensure = $geoipupdate::package_ensure,
  $package_name   = $geoipupdate::package_name,
  $p_file_ensure  = undef,
) {
  assert_private()

  file { '/etc/GeoIP.conf':
    ensure  => $p_file_ensure,
    content => template("${module_name}/GeoIP.conf.erb"),
    require => Package["${package_name}"],
  }

}
