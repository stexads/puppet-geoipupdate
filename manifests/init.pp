#
# @summary Public class for installing, configuring and managing MaxMind's 'geoipupdate' client
#
# @package_name
# @presence_status
# @conf_dir
# @target_dir Note: module does not create the dir or test the existance or remove on module un-installation
# @account_id
# @license_key
# @edition_ids
# @timer_oncalendar
#
# @api public
#
class geoipupdate (
  String                      $package_name     = 'geoipupdate',
  Enum[ "present", "absent" ] $presence_status,
  String                      $conf_dir         = '/etc',
  String                      $target_dir,
  String                      $account_id,
  String                      $license_key,
  String                      $edition_ids,
  String                      $timer_oncalendar,
) {

  package { 'geoipupdate':
    ensure => $presence_status,
    name   => $package_name,
  }

  file { "${conf_dir}/GeoIP.conf":
    ensure  => $presence_status,
    content => template("${module_name}/GeoIP.conf.erb"),
  }

  # presence_status expects
  # Enum['present', 'absent']
  # while systemd timer enable/active expect
  # Enum['stopped', 'running', 'false', 'true' ]
  $_status = $presence_status ? {
    'absent' => false,
    default  => true,
  }

  systemd::timer { 'geoipupdate-update.timer':
    ensure          => $presence_status,
    enable          => $_status,
    active          => $_status,
    timer_content   => template("${module_name}/geoipupdate-update.timer.erb"),
    service_content => template("${module_name}/geoipupdate-update.service.erb"),
  }

}
