# Class: logstash
#
# logstash puppet module 
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

  include logstash::params
  include stdlib
  include elastic
  include java

  validate_re($ensure, 'present|installed|absent|purged|held|latest')
  validate_re($running, 'running|stopped')
  validate_bool($enable, true, false)

  anchor { 'logstash::begin': } ->
  Class['elastic::key'] ->
  Class['logstash::repo'] ->
  Class['java'] ->
  Class['logstash::install'] ->
  Class['logstash::config'] ->
  Class['logstash::service'] ->
  anchor { 'logstash::end': }

  ensure_resource('class', 'elastic::key', {
    ensure  => $ensure,
  })

  ensure_resource('class', 'logstash::repo', {
    ensure  => $ensure,
    release => $release,
  })

  ensure_resource('class', 'java', {
    distribution => 'jdk',
  })

  ensure_resource('class', 'logstash::install', {
    ensure => $ensure,
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
