#
# Private class for configuring 'geoipupdate' config file
#

class geoipupdate::config (
  $account_id         = $geoipupdate::account_id,
  $license_key        = $geoipupdate::license_key,
  $edition_ids        = $geoipupdate::edition_ids,
  $package_ensure     = $geoipupdate::package_ensure,
  $package_name       = $geoipupdate::package_name,
) {
#  private()

  # file_ensure expects Enum['present', 'absent', 'file', 'directory', 'link']
  # while package_ensure expects
  # Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest']


  $file_ensure = $package_ensure ? {
    'purged'    => 'absent',
    'disabled'  => 'absent',
    'installed' => 'present',
    'latest'    => 'present',
    default     => $package_ensure,
  }


  file { '/etc/GeoIP.conf':
    ensure  => $file_ensure,
    content => template("${module_name}/GeoIP.conf.erb"),
    require => Package["${package_name}"],
  }

}
