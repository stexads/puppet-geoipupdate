#
# Private class related to updating 'geoipupdate'
#

class geoipupdate::update (
  $package_ensure = $geoipupdate::package_ensure,
  $package_name   = $geoipupdate::package_name,
  $systemd_timer  = $geoipupdate::systemd_timer
) {

  notify { "=== welcome to ${module_name}::update ===": }

}
