# logstash

#### Table of Contents

1. [Description](#module-description)
2. [Setup](#setup)
    * [What logstash affects](#what-logstash-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with logstash](#beginning-with-logstash)
3. [Usage](#usage)
4. [Reference](#reference)
5. [Limitations](#limitations)

## Module Description

Module for automatic installation, configuration and purging of logstash
(https://www.elastic.co/de/products/logstash).

## Setup

### What logstash affects

* installs the elastic package maintainer key from elastic.co
* add logstash repository
* installs/helds/remove logstash package
* place/remove logstash configuration files
* activate/deactivate and starts/stop logstash service

### Setup Requirements

Required modules:

* aboehm/elastic (https://github.com/aboehm/puppet-elastic)
* puppetlabs/apt (https://forge.puppet.com/puppetlabs/apt)
* puppetlabs/java (https://forge.puppet.com/puppetlabs/java)
* puppetlabs/stdlib (https://forge.puppet.com/puppetlabs/stdlib)

### Beginning with logstash

To install logstash with default settings, place following lines:

~~~
class { 'logstash':
}
~~~

To remove logstash: 

~~~
class { 'logstash':
  ensure => purge,
}
~~~

If using additional configuration, use the parameters `inputs`, `filters` and
`outputs` to point at corresponding templates. The standard configuration
installs a syslog server (RFC 5424) at port 10514. If the `@cee` tag is
recongnized, the message part are interpreted as JSON. The output is send to a
elasticsearch instance listen on localhost.

~~~
class { 'logstash':
  ensure  => present,
  inputs  => [
    'logstash/input_syslog.conf'
  ],
  filters => [
    'logstash/filter_syslog_00_match.conf',
    'logstash/filter_syslog_01_cee.conf'
  ],
  outputs => [
    'logstash/output_elasticsearch.conf'
  ],
}
~~~

## Usage

Include logstash module and configure with hiera.

## Reference

### Classes

* `logstash`: Define behavior of logstash
* `logstash::config`: Declare actions for configuration files
* `logstash::install`: Install/remove package
* `logstash::params`: Basic parameters of module
* `logstash::repo`: Manage logstash repository

## Limitations

Only Debian/Ubuntu are supported.


