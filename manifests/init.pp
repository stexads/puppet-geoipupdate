#
# Class geoipupdate
#

class geoipupdate (
  String		$account_id,
  String		$license_key,
  Array[String]	$edition_ids,
) {
  notify { "======= Welcome to puppet-geoipupdate": }

  notify { "The environment is ${$environment}": }
  notify { "The module_name is ${module_name}": }

  file { '/etc/GeoIP.conf':
    ensure  => file,
    content => template("${module_name}/GeoIP.conf.erb"),
  }

}
