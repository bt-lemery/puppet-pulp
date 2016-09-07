# Set up the pulp database
class pulp::database {
  if $pulp::manage_db {
    $mongodb_pidfilepath = '/var/run/mongodb/mongod.pid'

    class { '::mongodb::server':
      pidfilepath => $mongodb_pidfilepath,
    }

    Service['mongodb'] -> Service['pulp_celerybeat']
    Service['mongodb'] -> Service['pulp_workers']
    Service['mongodb'] -> Service['pulp_resource_manager']
    Service['mongodb'] -> Exec['migrate_pulp_db']
  }

  exec { 'migrate_pulp_db':
    command     => 'pulp-manage-db',
    path        => '/bin:/usr/bin',
    logoutput   => 'on_failure',
    user        => 'apache',
    refreshonly => true,
    require     => File['/etc/pulp/server.conf'],
  }

  Class['pulp::install'] ~> Exec['migrate_pulp_db'] ~> Class['pulp::service']
  Class['pulp::config'] ~> Exec['migrate_pulp_db'] ~> Class['pulp::service']
}
