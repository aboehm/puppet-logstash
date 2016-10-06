### Class: logstash::params
#
# default paramets for module
#

class logstash::params {
  $release = '2.4'

  $ensure = 'present'
  $package_name = 'logstash'
  $include_src = false

  $service_name = 'logstash'
  $enable  = true
  $running = running

  $inputs = [
    'logstash/input_syslog.conf'
  ]
  $filters = [
    'logstash/filter_syslog_00_match.conf',
    'logstash/filter_syslog_01_cee.conf'
  ]
  $outputs = [
    'logstash/output_elasticsearch.conf'
  ]

  $purge_undef = true
  $config_dir = '/etc/logstash/conf.d'
  $config_dir_mode = '0755'
  $config_file_mode = '0644'

  $user = 'logstash'
  $group = 'logstash'
}

# vi: set ft=puppet tabstop=2 shiftwidth=2 expandtab :
