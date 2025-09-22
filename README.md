# puppet-geoipupdate


#### Table of Contents
1. [Module Description - What the module does and why it is useful](#Module%20description)
1. [Setup - The basics of getting started with puppet-geoipupdate](#Setup)
   * [What puppet-geoipupdate affects](#What-puppet-geoipupdate-affects)
   * [Requirements](#Requirements)
1. [Usage - Configuration options and additional functionality](#Usage)
1. [Limitations - OS compatibility, etc.](#Limitations)
1. [Known Issues](#Known%20Issues)
1. [Development - Guide for contributing to the module](#Development)
1. [README - Check here for latest version](#README)

# Module description
Very simple module to manage MaxMind's geoipupdate client.
This module manages `geoipupdate` from installation through setup,
and configuration.

It will generate the config file needed by MaxMind's client and setup and
activate a systemd service (and timer) that calls MaxMind's `geoipupdate`
client to check for new DB file versions and eventually download them.

# Setup
Install the module your preferred way.
See [Usage](#usage).


## What puppet-geoipupdate affects
The module uses a `systemd` timer and service to periodically check for new
client version.
It also generates a `GeoIP.conf` file needed by the client.
In particular it adds the following to the system:
```
GeoIP.conf
geoipupdate-update.service
geoipupdate-update.timer
```

## Requirements
This module depends on the following modules:
- puppet-systemd
- puppetlabs-stdlib

### OS Requirements
Tested on:
- RedHat 9
- RedHat 10
- Debian 13

#### Debian
Debian users need to enable the `contrib` repository component and
refresh their local package index.

# Usage
## Parameters
- package_name: defaults to `geoipupdate`
- presence_status: (possible values: "present" or "absent") Instructs the module to either install or remove the client
- account_id: Your MaxMind's account ID
- license_key: Your MaxMind's License Key
- edition_ids: The mmdb file list
- conf_dir: The destination directory for MaxMind's config file `GeoIP.conf`
- target_dir: destination directory where `geoipupdate` client saves the `mmdb` files
- timer_oncalendar: Setting within the `*.timer` unit file that defines a specific date and time for triggering the client update

## Example usage:
```yaml
Class nodes::mynode (
  String $version = '0.0.1'
) {
   # Using hiera
#  include geoipupdate

  class { 'geoipupdate':
    package_name       => 'geoipupdate',                                                                                                                                      
    presence_status    => 'present', # Enum [ "present", "absent" ]                                                                                                           
    account_id         => 'test',                                                                                                                                             
    license_key        => 'testKey',                                                                                                                                          
    edition_ids        => 'GeoIP2-Country GeoIP2-City GeoIP2-ISP',                                                                                                            
    conf_dir           => '/etc',                                                                                                                                             
    target_dir         => '/tmp/geoip',                                                                                                                                       
    timer_oncalendar   => '*-*-* *:00:*',
  }

}
```

## Note
The `conf_dir` parameter is optional. If not set, it will default to `/etc`


# Limitations
It does not support all MaxMind's client parameters.


# Known Issues
- If you change the location of the config file, the module does not remove/delete
the old config file.
- The module expects the `target_dir` to exist and be writable by the client.

# Development
Source code available at [GitHub](https://github.com/stexads/puppet-geoipupdate).
Happy to receive pull-requests...


# README
[See GitHub for latest README](https://github.com/stexads/puppet-geoipupdate/blob/main/README.md)
