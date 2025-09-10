#
# Private class related to configuring 'geoipupdate'
#

class geoipupdate::config (
  $account_id     = $geoipupdate::account_id,
  $license_key    = $geoipupdate::license_key,
  $edition_ids    = $geoipupdate::edition_ids,
  $package_ensure = $geoipupdate::package_ensure,
  $package_name   = $geoipupdate::package_name,
  $systemd_timer  = $geoipupdate::systemd_timer
) {

  notify { "=== Welcome to ${module_name}::config ===": }

  # TODO Remove file when uninstalling package
  file { '/etc/GeoIP.conf':
    # TODO ensure this gets deleted when uninstalling package
    ensure  => file,
    content => template("${module_name}/GeoIP.conf.erb"),
    require => Package['geoipupdate'],
  }


  $_timer = @(EOT)
  [Timer]
  OnCalendar=*-*-* *:*:00
  RandomizedDelaySec=1s
  EOT

  $_service = @(EOT)
  [Service]
  Type=oneshot
  ExecStart=/usr/bin/touch /tmp/file
  EOT

  systemd::timer { 'geoipupdate-update.timer':
    timer_content   => $_timer,
    service_content => $_service,
  }

  service { 'geoipupdate-update.timer':
    ensure    => running,
    subscribe => Systemd::Timer['geoipupdate-update.timer'],
  }



}
