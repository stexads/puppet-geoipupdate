#
# Class geoipupdate
#

class geoipupdate (
  String        $account_id,
  String        $license_key,
  Array[String]	$edition_ids,
  String        $package_ensure,
  String        $package_name,
) {

  include geoipupdate::install
  include geoipupdate::config

  notify { "=== Welcome to ${module_name} ===": }

}
