#
# Private class for configuring 'geoipupdate' systemd service & timer
#

class geoipupdate::service (
  $package_ensure     = $geoipupdate::package_ensure,
  $service_update_cmd = $geoipupdate::service_update_cmd,
  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
  $p_service_enable   = undef,
  $p_timer_ensure     = undef,
) {
  assert_private()

  systemd::timer { 'geoipupdate-update.timer':
    ensure          => $p_timer_ensure,
    timer_content   => template("${module_name}/geoipupdate-update.timer.erb"),
    service_content => template("${module_name}/geoipupdate-update.service.erb"),
  }

  service { 'geoipupdate-update.timer':
    enable          => $p_service_enable,
    subscribe       => Systemd::Timer['geoipupdate-update.timer'],
  }

}
