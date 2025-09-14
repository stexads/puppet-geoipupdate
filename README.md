# puppet-geoipupdate


#### Table of Contents
1. [Module Description - What the module does and why it is useful](#Module%20description)
1. [Setup - The basics of getting started with puppet-geoipupdate](#Setup)
   * [What puppet-geoipupdate affects](#What-puppet-geoipupdate-affects)
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

### OS Requirements
Supports `RedHat`, `Debian` and `MacOS`.

Tested on:
- RedHat 9
- RedHat 10
- Debian 13

#### Debian
Debian users need to enable the `contrib` repository component and
refresh their local package index.

# Usage
## Parameters
- package_ensure: Instructs the module to either install or remove the client
- account_id: Your MaxMind's account ID
- license_key: Your MaxMind's License Key
- edition_ids: The mmdb file list
- conf_dir: The destination directory for MaxMind's config file `GeoIP.conf`
- timer_oncalendar: Setting within the `*.timer` unit file that defines a specific date and time for triggering the client update

## Example usage:
```yaml
Class nodes::mynode (
  String $version = '0.0.1'
) {
   # Using hiera
#  include geoipupdate

  class { 'geoipupdate':
    package_ensure     => 'present',
    account_id         => '123456',
    license_key        => 'abcdef',
    edition_ids        => 'GeoIP2-Country GeoIP2-City GeoIP2-ISP GeoIP2-Connection-Type',
    conf_dir           => '/etc',
    timer_oncalendar   => 'Mon 00:00:00',
  }

}
```

## Note
The `conf_dir` parameter is optional. If not set, it will default to where
MaxMind's `geoipupdate` client expects its configuration file: `/usr/local/etc`


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
