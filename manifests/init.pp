# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include dispatcher
class dispatcher(
  Stdlib::Filesource $module_file,
  Boolean $decline_root,
  Stdlib::Absolutepath $log_file,
  Enum['error', 'warn', 'info', 'debug', 'trace'] $log_level,
  Variant[Boolean, Pattern[/^[\d\-,]+$/]] $pass_error,
  Boolean $use_processed_url,
  Optional[Integer[0]] $keep_alive_timeout                    = undef,
  Optional[Boolean] $no_cannon_url                            = undef
) {

  # Check for Apache because it is used by parameter defaults
  if ! defined(Class['apache']) {
    fail('You must include the Apache class before using any dispatcher class or resources.')
  }

  if $::osfamily == 'RedHat' or $::operatingsystem =~ /^[Aa]mazon$/ {
    $_mod_path = "${::apache::httpd_dir}/${::apache::lib_path}"
    $_farm_path = $::apache::mod_dir

  } elsif $::osfamily == 'Debian' {
    $_mod_path = $::apache::lib_path
    $_farm_path = $::apache::mod_enable_dir
  } else {
    fail("Class['dispatcher']: Unsupported osfamily: ${::osfamily}")
  }
  $_filename = basename($module_file)

  $_owner = 'root'
  $_group = $::apache::params::root_group

  apache::mod { 'dispatcher':
    lib => 'mod_dispatcher.so',
  }

  file { "${_mod_path}/${_filename}" :
    ensure => file,
    owner  => $_owner,
    group  => $_group,
    source => $module_file,
  }

  file { "${_mod_path}/mod_dispatcher.so" :
    ensure => link,
    owner  => $_owner,
    group  => $_group,
    target => "${_mod_path}/${_filename}",
    notify => Class['Apache::Service'],
  }

  file { "${_farm_path}/dispatcher.conf" :
    ensure  => file,
    owner   => $_owner,
    group   => $_group,
    content => template("${module_name}/dispatcher.conf.erb"),
    notify  => Class['Apache::Service'],
  }

  file { "${_farm_path}/dispatcher.farms.any" :
    ensure => file,
    owner  => $_owner,
    group  => $_group,
    source => 'puppet:///modules/dispatcher/dispatcher.farms.any',
    notify => Class['Apache::Service'],
  }
}
