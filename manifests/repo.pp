### Class: logstash::repo
#
# add repository to package management
#

class logstash::repo (
  $ensure      = $logstash::params::ensure,
  $release     = $logstash::params::release,
  $include_src = $logstash::params::include_src,
) {
  
  validate_re($ensure, 'present|installed|absent|purged|held|latest')

  $ea = $ensure ? {
    /present|installed|latest/ => present,
    /absent|purged/            => absent,
    default                    => false,
  }

  if $ea != false {
    apt::source { 'logstash':
      ensure   => $ea,
      location => "http://packages.elasticsearch.org/logstash/${release}/debian",
      release  => 'stable',
      repos    => 'main',
      include  => {
        src => $include_src,
      },
    }
  }
}

# vi: set ft=puppet tabstop=2 shiftwidth=2 expandtab :
