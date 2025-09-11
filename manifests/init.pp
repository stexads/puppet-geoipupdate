#
# Class geoipupdate
#

class geoipupdate (
  String             $account_id,
  String             $license_key,
  Array[String]      $edition_ids,
  String             $package_ensure,
  String             $package_name,
  String             $service_update_cmd,
  String             $timer_oncalendar,
) {

  contain geoipupdate::install
  contain geoipupdate::config
  contain geoipupdate::service

  Class['geoipupdate::install']
  -> Class['geoipupdate::config']
  -> Class['geoipupdate::service']

}
