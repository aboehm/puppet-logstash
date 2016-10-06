# Class: logstash::install
#
# define logstash installation
#

class logstash::install (
  $ensure       = $logstash::params::ensure,
  $package_name = $logstash::params::package_name,
) {

  validate_re($ensure, 'present|installed|absent|purged|held|latest')

  package { $package_name:
    ensure          => $ensure,
    install_options => ['--no-install-recommends'],
  }
}

# vi: set ft=puppet tabstop=2 shiftwidth=2 expandtab :
