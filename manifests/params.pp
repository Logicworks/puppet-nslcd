# == Class: nslcd::params
#
# This class is only used to set variables
#
class nslcd::params {

  $ensure = present
  $service_enable = true
  $service_status = running
  $autoupgrade = false
  $autorestart = true
  $source = undef
  $template = 'nslcd/nslcd.conf.erb'
  $source_dir = undef
  $source_dir_purge = undef

  $ldap_uri = 'ldap://127.0.0.1/'
  $ldap_base = 'dc=localdomain'
  $ldap_version = '3'
  $ldap_binddn = undef
  $ldap_bindpw = undef
  $ldap_ssl = false
  $ldap_tls_reqcert = undef
  $ldap_scope = undef

  # This mandates which distributions are supported
  # To add support for other distributions simply add
  # it here
  case $::operatingsystem {
    'Ubuntu','Debian': {
      $user = 'nslcd'
      $group = 'nslcd'
      $package = 'nslcd'
      $service = 'nslcd'
      $config_file = '/etc/nslcd.conf'
      $config_file_mode = '0640'
      $run_dir = '/var/run/nslcd'
    }
    'RedHat', 'CentOS', 'Fedora', 'Scientific', 'SL', 'SLC', 'Ascendos', 'CloudLinux', 'PSBM', 'OracleLinux', 'OVS', 'OEL', 'Amazon', 'XenServer': {
       $user = 'nslcd'
       $group = 'ldap'
       $package = 'nss-pam-ldapd'
       $service = 'nslcd'
       $config_file = '/etc/nslcd.conf'
       $config_file_mode = '0600'
       $run_dir = '/var/run/nslcd'
    }
    default: {
      fail("Unsupported operatingsystem ${::operatingsystem}")
    }
  }

}
