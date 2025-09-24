# puppet-geoipupdate


#### Table of Contents
1. [Module Description - What the module does and why it is useful](#Module-description)
1. [Setup - The basics of getting started with puppet-geoipupdate](#Setup)
   * [What puppet-geoipupdate affects](#What-puppet-geoipupdate-affects)
   * [Dependencies](Dependencies)
   * [OS Requirements](#OS-Requirements)
1. [Usage - Configuration options and additional functionality](#Usage)
   * [Parameters](#Parameters)
   * [Example usage](#Example-usage)
1. [Limitations - OS compatibility, etc.](#Limitations)
   * [Other](#Other)
1. [Known Issues](#Known-Issues)
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

And best of all, it will download `mmdb` files in `target_dir`.

## Dependencies
This module depends on the following modules:
- puppet-systemd (>= 9.0.0)
- puppetlabs-stdlib (>= 9.7.0)

## OS Requirements
Tested on:
- RedHat 9
- RedHat 10
- Debian 13

#### Debian
Debian users need to enable the `contrib` repository component and
refresh their local package index.

# Usage
## Parameters
- presence_status: (possible values: "present" or "absent") Instructs the module to either install or remove the client
- target_dir: Destination directory where `geoipupdate` client saves the `mmdb` files
- account_id: Your MaxMind's account ID
- license_key: Your MaxMind's License Key
- edition_ids: The mmdb file list
- timer_oncalendar: Setting within the `*.timer` unit file that defines a specific date and time for triggering the client update
- package_name: defaults to `geoipupdate`
- conf_dir: The destination directory for MaxMind's config file `GeoIP.conf`
- preserve_timestamps: Whether to preserve modification times of files downloaded from the MM server
- verbose: Display version information
- parallelism: Set the number of parallel database downloads


### Default parameter values
- `package_name`: `geoipupdate`
- `timer_oncalendar`: `daily`
- `conf_dir`: `etc`
- `preserve_timestamps`: `true`
- `verbose`: `false`
- `parallelism`: `1`


## Example usage
```yaml
Class nodes::mynode (
  String $version = '0.0.1'
) {
  # Using hiera
  #include geoipupdate

  class { 'geoipupdate':
    presence_status     => 'present', # Enum [ "present", "absent" ]
    target_dir          => '/tmp/geoip',
    account_id          => 'test',
    license_key         => 'testKey',
    edition_ids         => 'GeoIP2-Country GeoIP2-City GeoIP2-ISP',
    timer_oncalendar    => '*-*-* *:00:*',
    package_name        => 'geoipupdate',
    conf_dir            => '/etc',
    preserve_timestamps => true,
    verbose             => true,
    parallelism         => 1,
  }
}
```

# Limitations
It only supports systemd `OnCalendar` itimer option.

It does not support all MaxMind's client optional parameters and config options.
Namely it does not yet support following config file options:
- `Host`
- `Proxy`
- `ProxyUserPassword`
- `LockFile`
- `RetryFor`

And it does not yet support following client options:
- `--stack-trace`
- `--output`

## Other
This is a limitation of MaxMind's client: CSV databases are not supported.

# Known Issues
- The module expects the `target_dir` to exist and be writable by the client.

# Development
Source code available at [GitHub](https://github.com/stexads/puppet-geoipupdate).
Happy to receive pull-requests...


# README
[See GitHub for latest README](https://github.com/stexads/puppet-geoipupdate/blob/main/README.md)
