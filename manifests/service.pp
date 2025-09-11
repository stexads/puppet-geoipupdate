#
# Private class for configuring 'geoipupdate' systemd service & timer
#

class geoipupdate::service (
  $package_ensure     = $geoipupdate::package_ensure,
  $service_update_cmd = $geoipupdate::service_update_cmd,
  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
) {

  # timer_ensure expects Enum['absent', 'file', 'present']
  # while package_ensure expects
  # Enum['present', 'absent', 'purged', 'disabled', 'installed', 'latest']
  $timer_ensure = $package_ensure ? {
    'purged'    => 'absent',
    'disabled'  => 'absent',
    'installed' => 'present',
    'latest'    => 'present',
    default     => $package_ensure,
  }

  systemd::timer { 'geoipupdate-update.timer':
    ensure          => $timer_ensure,
    timer_content   => template("${module_name}/geoipupdate-update.timer.erb"),
    service_content => template("${module_name}/geoipupdate-update.service.erb"),
  }

  service { 'geoipupdate-update.timer':
    enable          => $package_ensure ? {
      'absent'      => false,
      'purged'      => false,
      default       => true,
    },
    subscribe       => Systemd::Timer['geoipupdate-update.timer'],
  }

}
