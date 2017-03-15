# == Class: logstash
#
# Logstash puppet module.
#
# === Authors
#
# Alexander Böhm <alxndr.boehm@gmail.com>
#
# === Copyright
#
# Copyright 2016 Alexander Böhm
#

class logstash (
  $release = $logstash::params::release,
  $enable  = $logstash::params::enable,
  $ensure  = $logstash::params::ensure,
  $running = $logstash::params::running,
  $inputs  = $logstash::params::inputs,
  $filters = $logstash::params::filters,
  $outputs = $logstash::params::outputs,
) inherits logstash::params {

  validate_re($ensure, 'present|installed|absent|purged|held|latest')
  validate_re($running, 'running|stopped')
  validate_bool($enable, true, false)

  include elastic
  include java

  anchor { 'logstash::begin': } ->
  Class['elastic::repo'] ->
  Class['apt::update'] ->
  Class['java'] ->
  Class['logstash::install'] ->
  Class['logstash::config'] ->
  Class['logstash::service'] ->
  anchor { 'logstash::end': }

  ensure_resource('class', 'java', {
    distribution => 'jdk',
  })

  ensure_resource('class', 'logstash::install', {
    ensure  => $ensure,
  })

  ensure_resource('class', 'logstash::config', {
    ensure  => $ensure,
    inputs  => $inputs,
    filters => $filters,
    outputs => $outputs,
  })

  ensure_resource('class', 'logstash::service', {
    enable  => $enable,
    running => $running,
  })
}

# vi: set ft=puppet tabstop=2 shiftwidth=2 expandtab :
