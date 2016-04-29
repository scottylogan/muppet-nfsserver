# == Class: nfsserver
class nfsserver {

  package {
    [
      'nfs-kernel-server',
      'mdadm',
    ]:
    ensure => latest,
  }

  file { '/etc/exports':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    source  => "puppet:///modules/${module_name}/exports.${::fqdn}",
    require => Package['nfs-kernel-server'],
    notify  => Service['nfs-server'],
  }

  service { 'nfs-server':
    ensure   => 'running',
    name     => 'nfs-server.service',
    enable   => true,
    provider => 'systemd',
    require  => Package['nfs-kernel-server'],
  }
}
