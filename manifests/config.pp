#
# Private class related to configuring 'geoipupdate'
#

class geoipupdate::config (
  $account_id         = $geoipupdate::account_id,
  $license_key        = $geoipupdate::license_key,
  $edition_ids        = $geoipupdate::edition_ids,
  $package_ensure     = $geoipupdate::package_ensure,
  $package_name       = $geoipupdate::package_name,
  $service_update_cmd = $geoipupdate::service_update_cmd,
  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
) {

  notify { "=== Welcome to ${module_name}::config ===": }

  file { '/etc/GeoIP.conf':
    ensure  => $package_ensure,
    content => template("${module_name}/GeoIP.conf.erb"),
    require => Package['geoipupdate'],
  }

  systemd::timer { 'geoipupdate-update.timer':
    #timer_content   => $_timer,
    timer_content => template("${module_name}/geoipupdate-update.timer.erb"),
    service_content => template("${module_name}/geoipupdate-update.service.erb"),
  }

  service { 'geoipupdate-update.timer':
    ensure    => running,
    subscribe => Systemd::Timer['geoipupdate-update.timer'],
  }



}
