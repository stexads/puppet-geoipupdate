#
# Class geoipupdate
#
# @ systemd_timer: True  -> uses systemd timer to schedule automatic updates
#                  False -> falls back to cron

class geoipupdate (
  String             $account_id,
  String             $license_key,
  Array[String]      $edition_ids,
  String             $package_ensure,
  String             $package_name,
  Optional[Boolean]  $systemd_timer,
) {

  contain geoipupdate::install
  contain geoipupdate::config
  contain geoipupdate::update

  Class['geoipupdate::install']
  -> Class['geoipupdate::config']
  -> Class['geoipupdate::update']

  notify { "=== Welcome to ${module_name} ===": }

}
