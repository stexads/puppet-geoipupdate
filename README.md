# puppet-geoipupdate

#### Table of Contents
1. [Module Description - What the module does and why it is useful](#module%20description)
1. [Setup - The basics of getting started with `geoipupdate`](#setup)
   * [What puppet-geoipupdate affects](#What%20puppet-geoipupdate%20affects)
   * [Setup requirements](#Setup%20requirements)
   * [Beginning with `geoipupdate`](#Beginning%20with%20puppet-geoipupdate)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

# Module description
Very simple module to manage MaxMind's geoipupdate client.
This module manages `geoipupdate` from installation through setup,
and configuration.

# Setup
TODO

## What puppet-geoipupdate affects
None.

## Requirements
This module depends on the following modules:
- puppet-systemd
- puppetlabs-stdlib

## Beginning with puppet-geoipupdate
TODO

# Usage
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
    service_update_cmd => '/usr/bin/dnf -y update geoipupdate',
    timer_oncalendar   => 'Mon 00:00:00',
  }

}
```


# Limitations
It does not downlaod/manage `mmdb` files.
It only manages the `geoipupdate` client.

# Development
Submit a pull-request...
