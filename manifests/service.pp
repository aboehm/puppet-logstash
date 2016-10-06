### Class: logstash::service
#
# service configuration
#

class logstash::service (
  $enable       = $logstash::params::enable,
  $running      = $logstash::params::running,
  $service_name = $logstash::params::service_name,
) {
  service { $service_name:
    ensure => $running,
    enable => $enable,
  }
}

# vi: set ft=puppet tabstop=2 shiftwidth=2 expandtab :
