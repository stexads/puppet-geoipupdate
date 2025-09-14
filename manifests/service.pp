#
# @summary Private class for configuring 'geoipupdate' systemd service & timer
#
# @timer_oncalendar
# @p_update_cmd
# @p_timer_ensure
# @p_enable
# @p_service_running
#
# @api private
#
class geoipupdate::service (
  String  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
  String  $p_update_cmd       = undef,
  String  $p_timer_ensure     = undef,
  Boolean $p_enable           = undef,
  Boolean $p_service_running  = undef,
) {
  assert_private()

  systemd::timer { 'geoipupdate-update.timer':
    # This ensures removal of systemd service and timer files when removing the package
    ensure          => $p_timer_ensure,
    # When active and enable are set to true the puppet service geoipupdate-update.timer will be declared, started and enabled
    enable          => $p_enable,
    active          => $p_enable,
    timer_content   => template("${module_name}/geoipupdate-update.timer.erb"),
    service_content => template("${module_name}/geoipupdate-update.service.erb"),
    notify          => Exec['systemd-daemon-reload'],
  }

  service { 'geoipupdate-update.service':
    ensure    => $p_service_running,
    enable    => $p_enable,
    subscribe => Systemd::Timer['geoipupdate-update.timer'],
    notify    => Exec['systemd-daemon-reload'],
  }

  # Some testing showed issues with timer not finding service when deploying
  # changes to the service
  exec { 'systemd-daemon-reload':
    command     => '/bin/systemctl daemon-reload',
    refreshonly => true,
  }

}
