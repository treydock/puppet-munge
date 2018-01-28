# treydock-munge changelog

Release notes for the treydock-munge module.

## [1.1.0](https://github.com/treydock/puppet-munge/tree/1.1.0) (2018-01-28)
[Full Changelog](https://github.com/treydock/puppet-munge/compare/1.0.0...1.1.0)

**Implemented enhancements:**

- Changes to allow for using or not using the stahnma/epel module [\#4](https://github.com/treydock/puppet-munge/pull/4) ([millerjl1701](https://github.com/millerjl1701))

## [1.0.0](https://github.com/treydock/puppet-munge/tree/1.0.0) (2017-11-13)
[Full Changelog](https://github.com/treydock/puppet-munge/compare/0.1.1...1.0.0)

**Implemented enhancements:**

- BREAKING: Manage munge user and group, can be disabled [\#3](https://github.com/treydock/puppet-munge/pull/3) ([treydock](https://github.com/treydock))
- BREAKING: Use data types for parameters - drop puppet 3 support [\#2](https://github.com/treydock/puppet-munge/pull/2) ([treydock](https://github.com/treydock))

------------------------------------------

## 0.1.1 - 2014-07-10

Fix metadata.json dependencies

------------------------------------------

## 0.1.0 - 2014-07-10

This release is a backwards compatible feature update.

Features:

* Conditionally install munge-devel package

Bug fixes and minor changes related to development:

* Fix LICENSE file
* Add Puppet 3.6.x to travis-ci tests
* Update fixtures to latest versions
* Fix rest-client >= 1.7.0 preventing Ruby 1.8.7 unit tests from running
* Do not pin puppet version when PUPPET_GEM_VERSION is not defined in development

------------------------------------------

## 0.0.2 - 2014-06-18

* Fix LICENSE file - wget fail

------------------------------------------

## 0.0.1 - 2014-06-18

* Initial release
