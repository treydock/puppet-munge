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

[http://treydock.github.io/puppet-munge/](http://treydock.github.io/puppet-munge/)

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
