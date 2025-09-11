#
# Class geoipupdate
#

class geoipupdate (
  String $account_id,
  String $license_key,
  String $edition_ids,
  String $package_ensure,
  String $package_name,
  String $service_update_cmd,
  String $timer_oncalendar,
) {

  # package_ensure expects
  # Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest']
  # while file_ensure expects
  # Enum['present', 'absent', 'file', 'directory', 'link']
  $p_package_ensure = $package_ensure ? {
    'disabled' => 'absent',
    default    => $package_ensure,
  }

  # file_ensure expects
  # Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest']
  # while file_ensure expects
  # Enum['present', 'absent', 'file', 'directory', 'link']
  $p_file_ensure = $package_ensure ? {
    'purged'    => 'absent',
    'disabled'  => 'absent',
    'installed' => 'present',
    'latest'    => 'present',
    default     => $package_ensure,
  }

  # package_ensure expects
  # Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest']
  # while timer_ensure expects
  # Enum['absent', 'file', 'present']
  $p_timer_ensure = $package_ensure ? {
    'purged'    => 'absent',
    'disabled'  => 'absent',
    'installed' => 'present',
    'latest'    => 'present',
    default     => $package_ensure,
  }

  # package_ensure expects
  # Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest']
  # while service_enable expects
  # Enum['stopped', 'running', 'false', 'true' ]
  $p_service_enable = $package_ensure ? {
    'absent'         => false,
    'disabled'       => false,
    'purged'         => false,
    default          => true,
  }

  # Pass 'correct' parameter to 'install' class
  class { 'geoipupdate::install':
    p_package_ensure => $p_package_ensure,
  }
  # Pass 'correct' parameter to 'config' class
  class { 'geoipupdate::config':
    p_file_ensure    => $p_file_ensure,
  }
  # Pass 'correct' parameters to 'service' class
  class { 'geoipupdate::service':
    p_service_enable => $p_service_enable,
    p_timer_ensure   => $p_timer_ensure,
  }

  Class['geoipupdate::install']
  -> Class['geoipupdate::config']
  -> Class['geoipupdate::service']

}
