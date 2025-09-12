#
# @summary Private class for configuring 'geoipupdate' systemd service & timer
#
# @package_ensure
# @service_update_cmd
# @timer_oncalendar
# @p_service_enable
# @p_timer_ensure
#
# @api private
#
class geoipupdate::service (
  String  $package_ensure     = $geoipupdate::package_ensure,
  String  $service_update_cmd = $geoipupdate::service_update_cmd,
  String  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
  Boolean $p_service_enable   = undef,
  String  $p_timer_ensure     = undef,
) {
  assert_private()

  systemd::timer { 'geoipupdate-update.timer':
    ensure          => $p_timer_ensure,
    timer_content   => template("${module_name}/geoipupdate-update.timer.erb"),
    service_content => template("${module_name}/geoipupdate-update.service.erb"),
  }

  service { 'geoipupdate-update.timer':
    enable    => $p_service_enable,
    subscribe => Systemd::Timer['geoipupdate-update.timer'],
  }

}
