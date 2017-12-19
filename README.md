# puppet-munge

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/munge.svg)](https://forge.puppetlabs.com/treydock/munge)
[![Build Status](https://travis-ci.org/treydock/puppet-munge.png)](https://travis-ci.org/treydock/puppet-munge)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options](#usage)
3. [Reference - Parameter and detailed reference to all options](#reference)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)
6. [TODO](#todo)
7. [Additional Information](#additional-information)

## Overview

This module manages MUNGE.

## Usage

### munge

Manage munge and define a site specific munge.key

    class { 'munge':
      munge_key_source  => 'puppet:///modules/site_munge/munge.key',
    }

## Reference

### Classes

#### Public classes

* `munge`: Installs and configures munge.

#### Private classes

* `munge::repo`: Manages inclusion of stahnma/epel.
* `munge::install`: Installs munge packages.
* `munge::config`: Configures munge.
* `munge::service`: Manages the munge service.
* `munge::params`: Sets parameter defaults based on fact values.

### Parameters

#### munge

##### `use_epel`

Whether or not to include the stahnma/epel module. If set to false, it is assumed that the munge RPMs are available via a different yum repository or package management system such as Spacewalk. (defaults to 'true').

##### `package_ensure`

package 'ensure' property (defaults to 'present').

##### `package_name`

Munge package name.

##### `install_dev`

Boolean.  Sets if the munge-devel package should be installed (defaults to false).

##### `dev_package_name`

Munge dev package name.

##### `service_name`

Munge service name

##### `service_ensure`

Munge service 'ensure' property (defaults to 'running').

##### `service_enable`

Munge service 'enable' property (defaults to true).

##### `service_hasstatus`

Munge service hasstatus value.

##### `service_hasrestart`

Munge service hasrestart value.

##### `munge_key_path`

Path to the munge.key file.  Default is OS dependent.

##### `munge_key_source`

The source for the munge.key file (defaults to undef).

##### `manage_user`

Boolen that determines if munge user and group should be managed. Default is `true`

##### `munge_user_uid`

UID of the munge user. Default is `undef`

##### `munge_group_gid`

GID of the munge group. Default is `undef`

## Limitations

This module has been tested on:

* CentOS/RedHat 6 x86_64
* CentOS/RedHat 7 x86_64

## Development

### Testing

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake test

If you have Vagrant >= 1.2.0 installed you can run system tests

    bundle exec rake beaker

## TODO

## Further Information

*
