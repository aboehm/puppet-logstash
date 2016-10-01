# Class: logstash::config
#
# place logstash configuration files
#

class logstash::config (
  $ensure           = $logstash::params::ensure,
  $inputs           = $logstash::params::inputs,
  $filters          = $logstash::params::filters,
  $outputs          = $logstash::params::outputs,
  $purge_undef      = $logstash::params::purge_undef,
  $config_dir       = $logstash::params::config_dir,
  $config_file_mode = $logstash::params::config_file_mode,
  $config_dir_mode  = $logstash::params::config_dir_mode,
  $user             = $logstash::params::user,
  $group            = $logstash::params::group,
) {

  validate_re($ensure, 'installed|present|absent|held|purged|latest')
  validate_bool($purge_undef, true, false)
  validate_array($inputs, $filters, $outputs)

  if $ensure =~ /present|installed|latest/ {
    $ef = 'file'
    $ed = 'directory'
  } elsif $ensure =~ /purge/ {
    $ef = 'absent'
    $ed = 'absent'
  } else {
    $ef = false
    $ed = false
  }

  if $ef != false {
    file { $config_dir:
      ensure  => $ed,
      mode    => $config_dir_mode,
      recurse => true,
      purge   => $purge_undef,
    }

    each($inputs) |$idx, $f| {
      $fn = regsubst($f, '/', '_')
      $prio = 100 + $idx
      $cfgname = "${prio}_${fn}"

      file { "${config_dir}/${cfgname}":
        ensure  => $ef,
        mode    => $config_file_mode,
        owner   => $user,
        group   => $group,
        content => template($f),
        notify  => Service['logstash'],
      }
    }

    each($filters) |$idx, $f| {
      $fn = regsubst($f, '/', '_')
      $prio = 500 + $idx
      $cfgname = "${prio}_${fn}"

      file { "${config_dir}/${cfgname}":
        ensure  => $ef,
        mode    => $config_file_mode,
        owner   => $user,
        group   => $group,
        content => template($f),
        notify  => Service['logstash'],
      }
    }

    each($outputs) |$idx, $f| {
      $fn = regsubst($f, '/', '_')
      $prio = 900 + $idx
      $cfgname = "${prio}_${fn}"

      file { "${config_dir}/${cfgname}":
        ensure  => $ef,
        mode    => $config_file_mode,
        owner   => $user,
        group   => $group,
        content => template($f),
        notify  => Service['logstash'],
      }
    }
  }
}

# vi: set ft=puppet tabstop=2 shiftwidth=2 expandtab :
