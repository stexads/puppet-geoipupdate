#
# @summary Main class for installing, configuring and managing MaxMind's 'geoipupdate' client
#
# @param presence_status Installation value to be either: 'present' or 'absent'
# @param target_dir Note: module does not create the dir or test the existance or remove on module un-installation
# @param account_id Your MaxMind account ID
# @param license_key Your MaxMind License Key
# @param edition_ids Your MaxMind files to download
# @param user Set the UNIX user that the geoipupdate client process is executed as
# @param package_name Defaults to 'geoipupdate', which should not need to be overriden
# @param timer_oncalendar Defines timer triggerring of geoipupdate client calls
# @param conf_dir Directory where the configuration file `GeoIP.conf` will be written
# @param preserve_timestamps Whether to preserve modification times of files downloaded from the server
# @param verbose Enable/disable verbose mode
# @param parallelism The maximum number of parallel database downloads
class geoipupdate (
  Enum['present', 'absent'] $presence_status,
  String                    $target_dir,
  String                    $account_id,
  String                    $license_key,
  String                    $edition_ids,
  String                    $user                = 'root',
  String                    $package_name        = 'geoipupdate',
  String                    $timer_oncalendar    = 'daily',
  String                    $conf_dir            = '/etc',
  Boolean                   $preserve_timestamps = true,
  Boolean                   $verbose             = false,
  Integer                   $parallelism         = 1,
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
    timer_content   => template( "${module_name}/geoipupdate-update.timer.erb" ),
    service_content => template( "${module_name}/geoipupdate-update.service.erb" ),
  }
}
