#
# @summary Public class for installing, configuring and managing MaxMind's 'geoipupdate' client
#
# @account_id
# @license_key
# @edition_ids
# @package_ensure
# @conf_dir
# @timer_oncalendar
#
# @api public
#
class geoipupdate (
  String $account_id,
  String $license_key,
  String $edition_ids,
  String $package_ensure,
  String $conf_dir = '/usr/local/etc',
  String $timer_oncalendar,
) {
  # Treating 'disable' same as 'absent' for simplicity
  $p_package_ensure = $package_ensure ? {
    'disabled' => 'absent',
    default    => $package_ensure,
  }

  # package_ensure expects
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
  # while file_ensure expects
  # Enum['present', 'absent', 'file', 'directory', 'link']
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
  $p_enable = $package_ensure ? {
    'absent'   => false,
    'disabled' => false,
    'purged'   => false,
    default    => true,
  }

  # package_ensure expects
  # Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest']
  # while service_running expects
  # Enum['stopped', 'running', 'false', 'true' ]
  $p_service_running = $package_ensure ? {
    'absent'   => false,
    'disabled' => false,
    'purged'   => false,
    default    => true,
  }

  # Add more checks for other distros
  case $facts['os']['family'] {
    'RedHat', 'Debian', 'Darwin': {
      $p_package_name = 'geoipupdate'
      $p_update_cmd   = '/usr/bin/dnf -y update geoipupdate'
    }
    'Debian': {
      $p_package_name = 'geoipupdate'
      $p_update_cmd = '/usr/bin/apt -y update geoipupdate'
    }
    default: {
      notify { 'default':
        message => $facts['os']['family'],
      }
      fail('Unsupported OS family. Submit an issue to the module owner.')
    }
  }

  # Pass 'correct' parameters to 'install' class
  class { 'geoipupdate::install':
    p_package_ensure => $p_package_ensure,
    p_package_name   => $p_package_name,
  }
  # Pass 'correct' parameters to 'config' class
  class { 'geoipupdate::config':
    p_file_ensure  => $p_file_ensure,
    p_package_name => $p_package_name,
  }
  # Pass 'correct' parameters to 'service' class
  class { 'geoipupdate::service':
    p_enable          => $p_enable,
    p_update_cmd      => $p_update_cmd,
    p_timer_ensure    => $p_timer_ensure,
    p_service_running => $p_service_running,
  }

  Class['geoipupdate::install']
  -> Class['geoipupdate::config']
  -> Class['geoipupdate::service']

}
