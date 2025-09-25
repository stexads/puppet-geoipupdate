# Changelog

Notable changes to this project will be documented in this file.

## Release 0.9.9
**Features**
- Added support for running the geoipupdate client as a specified UNIX user

**Bugfixes**
**Known Issues**
- The module only supports MaxMind's client version >=2.5.0
- It does not yet support all MaxMind's client parameters and config options.
- The module expects the `target_dir` to exist and be writable by the client.
- It only supports systemd timer `OnCalendar` option.


## Release 0.9.8
**Features**
- Added support for `preserve_timestamps` config file parameter
- Added support for `parallelism` config file parameter
- Added support for `verbose` client parameter

**Bugfixes**


**Known Issues**
- The module only supports MaxMind's client version >=2.5.0
- The module expects the `target_dir` to exist and be writable by the client.
- It does not yet support all MaxMind's client parameters and config options.
- It only supports systemd timer `OnCalendar` option.


## Release 0.9.7
**Features**
- Introduced `mmdb` database downloads via systemd service

**Bugfixes**
- major code refactoring and simplified things

**Known Issues**
- The module only supports MaxMind's client version >=2.5.0
- The module expects the `target_dir` to exist and be writable by the client.
- It does not support all MaxMind's client parameters.


## Releases 0.9.1 to 0.9.6
Best to avoid!
