#
# Private class related to configuring 'geoipupdate'
#

class geoipupdate::config (
  $account_id     = $geoipupdate::account_id,
  $license_key    = $geoipupdate::license_key,
  $edition_ids    = $geoipupdate::edition_ids,
  $package_ensure = $geoipupdate::package_ensure,
  $package_name   = $geoipupdate::package_name,
) {

  # TODO Remove file when uninstalling package
  file { '/etc/GeoIP.conf':
    # TODO ensure this gets deleted when uninstalling package
    ensure  => file,
    content => template("${module_name}/GeoIP.conf.erb"),
    require => Package['geoipupdate'],
  }

}
