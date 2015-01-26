# == Class: nslcd
#
# This module manages the nslcd server. More descriptions here
#
# === Parameters
#
# [*ensure*]
#   Controls the software installation
#   Valid values: <tt>present</tt>, <tt>absent</tt>, <tt>purge</tt>
#
# [*service_enable*]
#   Controls if service should be enabled on boot
#   Valid values: <tt>true</tt>, <tt>false</tt>
#
# [*service_status*]
#   Controls service state.
#   Valid values: <tt>running</tt>, <tt>stopped</tt>, <tt>unmanaged</tt>
#
# [*autoupgrade*]
#   If Puppet should upgrade the software automatically
#   Valid values: <tt>true</tt>, <tt>false</tt>
#
# [*autorestart*]
#   If Puppet should restart service on config changes
#   Valid values: <tt>true</tt>, <tt>false</tt>
#
# [*source*]
#   Path to static Puppet file to use
#   Valid values: <tt>puppet:///modules/mymodule/path/to/file.conf</tt>
#
# [*template*]
#   Path to ERB puppet template file to use
#   Valid values: <tt>mymodule/path/to/file.conf.erb</tt>
#
# [*ldap_uri*]
#   LDAP uri to query, multiple servers can be white space separated
#   Valid values: <tt>ldap://127.0.0.1/</tt>
#
# [*ldap_base*]
#   LDAP search base
#   Valid values: <tt>dc=localdomain</tt>
#
# [*ldap_version*]
#   LDAP version number
#   Valid values: <tt>2</tt>, <tt>3</tt>
#
# [*ldap_binddn*]
#   If LDAP server requires a binddn, provide here
#   Valid values: <tt>cn=lookupuser,dc=localdomain</tt>
#
# [*ldap_bindpw*]
#   If LDAP server requires a binddn, provide password to dn here
#   Valid values: <tt>password</tt>
#
# [*ldap_ssl*]
#   If SSL encrypted LDAP should be used
#   Valid values: <tt>true</tt>, <tt>false</tt>
#
# [*ldap_tls_reqcert*]
#   If TLS server certificate should be validated
#   Valid values: <tt>never</tt>, <tt>allow</tt>,
#                 <tt>try</tt>, <tt>demand</tt>, <tt>hard</tt>
#
# [*ldap_scope*]
#   Specifies the search scope
#   Valid values: <tt>sub</tt>, <tt>one</tt>, <tt>base</tt>
#
# [*ldap_pagesize*]
#   Specifies the LDAP paging size. Recommended with AD server.
#   Valid values: <tt>1000</tt>
#
# [*ldap_referrals*]
#   Specifies whether automatic referral chasing should be enabled.
#   Recommended with Active Directory LDAP servers.
#   Valid values: <tt>yes</tt>, <tt>no</tt>
#
# [*parameters*]
#   Hash variable to pass to nslcd
#   Valid values: hash, ex:  <tt>{ 'option' => 'value' }</tt>
#
# === Sample Usage
#
# * Installing with default settings
#   class { 'nslcd': }
#
# * Uninstalling the software
#   class { 'nslcd': ensure => absent }
#
# * Installing, with service disabled on boot and using custom passwd settings
#   class { 'nslcd:
#     service_enable    => false,
#     parameters_passwd => {
#       'enable-cache'  => 'no'
#     }
#   }
#
# === Supported platforms
#
# This module has been tested on the following platforms
# * Ubuntu LTS 10.04, 12.04
# * RHEL 6.4
#
class nslcd (
  $ensure           = 'UNDEF',
  $service_enable   = 'UNDEF',
  $service_status   = 'UNDEF',
  $autoupgrade      = 'UNDEF',
  $autorestart      = 'UNDEF',
  $source           = 'UNDEF',
  $template         = 'UNDEF',
  $ldap_uri         = 'UNDEF',
  $ldap_base        = 'UNDEF',
  $ldap_version     = 'UNDEF',
  $ldap_binddn      = 'UNDEF',
  $ldap_bindpw      = 'UNDEF',
  $ldap_ssl         = 'UNDEF',
  $ldap_tls_reqcert = 'UNDEF',
  $ldap_scope       = 'UNDEF',
  $ldap_pagesize    = 'UNDEF',
  $ldap_referrals   = 'UNDEF',
  $parameters       = {}
) {

  include nslcd::params

  # puppet 2.6 compatibility
  $ensure_real = $ensure ? {
    'UNDEF' => $nslcd::params::ensure,
    default => $ensure
  }
  $service_enable_real = $service_enable ? {
    'UNDEF' => $nslcd::params::service_enable,
    default => $service_enable
  }
  $service_status_real = $service_status ? {
    'UNDEF' => $nslcd::params::service_status,
    default => $service_status
  }
  $autoupgrade_real = $autoupgrade ? {
    'UNDEF' => $nslcd::params::autoupgrade,
    default => $autoupgrade
  }
  $autorestart_real = $autorestart ? {
    'UNDEF' => $nslcd::params::autorestart,
    default => $autorestart
  }
  $source_real = $source ? {
    'UNDEF' => $nslcd::params::source,
    default => $source
  }
  $template_real = $template ? {
    'UNDEF' => $nslcd::params::template,
    default => $template
  }
  $ldap_uri_real = $ldap_uri ? {
    'UNDEF' => $nslcd::params::ldap_uri,
    default => $ldap_uri
  }
  $ldap_base_real = $ldap_base ? {
    'UNDEF' => $nslcd::params::ldap_base,
    default => $ldap_base
  }
  $ldap_version_real = $ldap_version ? {
    'UNDEF' => $nslcd::params::ldap_version,
    default => $ldap_version
  }
  $ldap_binddn_real = $ldap_binddn ? {
    'UNDEF' => $nslcd::params::ldap_binddn,
    default => $ldap_binddn
  }
  $ldap_bindpw_real = $ldap_bindpw ? {
    'UNDEF' => $nslcd::params::ldap_bindpw,
    default => $ldap_bindpw
  }
  $ldap_ssl_real = $ldap_ssl ? {
    'UNDEF' => $nslcd::params::ldap_ssl,
    default => $ldap_ssl
  }
  $ldap_tls_reqcert_real = $ldap_tls_reqcert ? {
    'UNDEF' => $nslcd::params::ldap_tls_reqcert,
    default => $ldap_tls_reqcert
  }
  $ldap_scope_real = $ldap_scope ? {
    'UNDEF' => $nslcd::params::ldap_scope,
    default => $ldap_scope
  }
  $ldap_pagesize_real = $ldap_pagesize ? {
    'UNDEF' => $nslcd::params::ldap_pagesize,
    default => $ldap_pagesize
  }
  $ldap_referrals_real = $ldap_referrals ? {
    'UNDEF' => $nslcd::params::ldap_referrals,
    default => $ldap_referrals
  }

  # Input validation
  $valid_ensure_values = [ 'present', 'absent', 'purged' ]
  $valid_service_statuses = [ 'running', 'stopped', 'unmanaged' ]
  $valid_ldap_versions = [ '2', '3' ]
  validate_re($ensure_real, $valid_ensure_values)
  validate_re($service_status_real, $valid_service_statuses)
  validate_re($ldap_version_real, $valid_ldap_versions)
  validate_bool($autoupgrade_real)
  validate_bool($autorestart_real)
  validate_bool($ldap_ssl_real)
  validate_hash($parameters)

  # Insert class parameters into hash
  # This simplifies the erb template and makes
  # it less verbose
  $general_parameters = {
    'uri'          => $ldap_uri_real,
    'base'         => $ldap_base_real,
    'ldap_version' => $ldap_version_real,
    'binddn'       => $ldap_binddn_real,
    'bindpw'       => $ldap_bindpw_real,
    'ssl'          => $ldap_ssl_real,
    'tls_reqcert'  => $ldap_tls_reqcert_real,
    'scope'        => $ldap_scope_real,
    'pagesize'     => $ldap_pagesize_real,
    'referrals'    => $ldap_referrals_real,
  }

  $full_parameters = merge($parameters, $general_parameters)

  # 'unmanaged' is an unknown service state
  $ensure_service = $service_status_real ? {
    'unmanaged' => undef,
    default     => $service_status_real
  }

  # Manages automatic upgrade behavior
  if $ensure_real == 'present' and $autoupgrade_real == true {
    $ensure_package = 'latest'
  } else {
    $ensure_package = $ensure_real
  }

  case $ensure_real {

    # If software should be installed
    present: {
      if $autorestart_real == true {
        Service['nslcd'] { subscribe => File['nslcd/config'] }
      }
      if $source_real == undef {
        File['nslcd/config'] { content => template($template_real) }
      } else {
        File['nslcd/config'] { source => $source_real }
      }
      File {
        require => Package['nslcd'],
        before  => Service['nslcd']
      }
      service { 'nslcd':
        ensure  => $ensure_service,
        name    => $nslcd::params::service,
        enable  => $service_enable_real,
        require => [ Package['nslcd'], File['nslcd/config' ] ]
      }
      file { 'nslcd/config':
        ensure  => present,
        owner   => root,
        group   => $nslcd::params::group,
        mode    => $nslcd::params::config_file_mode,
        path    => $nslcd::params::config_file,
      }
      file { 'nslcd/rundir':
        ensure  => directory,
        owner   => $nslcd::params::user,
        group   => $nslcd::params::group,
        path    => $nslcd::params::run_dir,
        mode    => '0755'
      }
    }

    # If software should be uninstalled
    absent,purged: {
    }

    # Catch all, should not end up here due to input validation
    default: {
      fail("Unsupported ensure value ${ensure_real}")
    }
  }

  package { 'nslcd':
    ensure  => $ensure_package,
    name    => $nslcd::params::package
  }

}
