#
# Private class related to updating 'geoipupdate'
#

class geoipupdate::update (
  $package_ensure     = $geoipupdate::package_ensure,
  $package_name       = $geoipupdate::package_name,
  $service_update_cmd = $geoipupdate::service_update_cmd,
  $timer_oncalendar   = $geoipupdate::timer_oncalendar,
) {

  notify { "=== welcome to ${module_name}::update ===": }

}
