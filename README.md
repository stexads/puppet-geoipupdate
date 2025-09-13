# puppet-geoipupdate


#### Table of Contents
1. [Module Description - What the module does and why it is useful](#Module%20description)
1. [Setup - The basics of getting started with puppet-geoipupdate](#Setup)
   * [What puppet-geoipupdate affects](#What%20puppet-geoipupdate%20affects)
   * [Requirements](#Requirements)
1. [Usage - Configuration options and additional functionality](#Usage)
1. [Limitations - OS compatibility, etc.](#Limitations)
   * [Caveats](#Caveats)
1. [Development - Guide for contributing to the module](#Development)
1. [README - Check here for latest version](#README)

# Module description
Very simple module to manage MaxMind's geoipupdate client.
This module manages `geoipupdate` from installation through setup,
and configuration.


# Setup
Install the module your preferred way.
See [Usage](#usage).


## What puppet-geoipupdate affects
The module uses a `systemd` timer and service to periodically check for new
client version.
It also generates a `GeoIP.conf` file needed by the client.
In particular it adds the following to the system:
```
/etc/GeoIP.conf
geoipupdate-update.service
geoipupdate-update.timer
```


## Requirements
This module depends on the following modules:
- puppet-systemd
- puppetlabs-stdlib


# Usage
Example usage:
```yaml
Class nodes::mynode (
  String $version = '0.0.1'
) {
   # Using hiera
#  include geoipupdate

  class { 'geoipupdate':
    account_id         => '123456',
    license_key        => 'abcdef',
    edition_ids        => 'GeoIP2-Country GeoIP2-City GeoIP2-ISP GeoIP2-Connection-Type',
    package_ensure     => 'present',
    package_name       => 'geoipupdate',
    conf_dir           => '/etc',
    service_update_cmd => '/usr/bin/dnf -y update geoipupdate',
    timer_oncalendar   => 'Mon 00:00:00',
  }

}
```

## Note
The `conf_dir` parameter is optional. If not set, it will default to where
MaxMind's `geoipupdate` client expects it: `/usr/local/etc`.


# Limitations
The module only manages the `geoipupdate` client.
It facilitaes the installation and the update of MaxMind's client `geoipupdate`.
This is by design. It does not downlaod or manage `mmdb` files.


## Caveats
If you change the location of the config file, the module does not remove/delete
the old config file.


# Development
Source code available at [GitHub](https://github.com/stexads/puppet-geoipupdate).
Happy to receive pull-requests...


# README
[See GitHub for latest README](https://github.com/stexads/puppet-geoipupdate/blob/main/README.md)
