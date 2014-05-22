node default {
  crit( "Node only matched \"default\" for which there is no configuration, $::hostname" )
}

node /.*\.dgudev/ {

  include dgu_defaults

  # Thinking of modifying this for your own needs?
  # Don't! Create 'vagrant.pp' in the same directory
  # as your Vagrantfile and the vagrant provisioner
  # will use that instead.
  #include beluga::defaults

  class { 'beluga':
    stage => pre,
  }
  include beluga::developer_tools

  class { 'beluga::facts::role':
    stage => pre,
    role => 'dev',
  }

  $lamp_servers = {
    name          => 'lamp_servers',
    host          => '127.0.0.1',
    port          => 8000,
    upstream_port => 8881
  }

  $lamp_admin_servers = {
    name          => 'lamp_admin_servers',
    host          => '127.0.0.1',
    port          => 8000,
    upstream_port => 8000
  }

  $graylog_servers = {
    name          => 'graylog',
    host          => '127.0.0.1',
    port          => 8000,
    upstream_port => 8000
  }

  $solr_servers = {
    name          => 'solr',
    host          => '127.0.0.1',
    port          => 8081,
    upstream_port => 8080
  }

  $extra_backends = {
    name          => 'ckan_server',
    host          => '127.0.0.1',
    port          => 8000,
    upstream_port => 8000
  }

  $extra_selectors = { backend => 'ckan_server', condition => 'req.http.host ~ "^ckan."'}


  class { "beluga::frontend_traffic_director":
    graylog_servers           => $graylog_servers,
    lamp_servers              => $lamp_servers,
    lamp_admin_servers        => $lamp_admin_servers,
    solr_servers              => $solr_servers,
    extra_backends            => $extra_backends,
    extra_selectors           => $extra_selectors,
    frontend_domain           => 'dgud7',
    backend_domain            => 'dgud7',
  }

  class {'beluga::apache_frontend_server':
    domain_name               => 'dgud7',
    owner                     => 'co',
    group                     => 'co'
  }

  class {'beluga::caching_server':
    source_dir => "puppet:///modules/dgu_solr/solr",
  }

  class {'beluga::mysql_server':
  }

  class { 'beluga::drush_server': }

  class { 'beluga::mail_server': }
  class { 'jenkins':
    configure_firewall => false,
  }

  class { 'beluga::ruby_frontend':

  }

  #class {'ckan':
  #  virtual_env_dir => '/tmp/ckan',
  #}

  #class { 'beluga::postgresql_server':
  #}

}


node standards {

  include dgu_defaults

  class { 'beluga':
    stage => pre,
  }
  include beluga::developer_tools

  class { 'beluga::facts::role':
    stage => pre,
    role => 'prod',
  }

  $lamp_servers = {
    name          => 'lamp_servers',
    host          => '127.0.0.1',
    port          => 8000,
    upstream_port => 8881
  }

  $lamp_admin_servers = {
    name          => 'lamp_admin_servers',
    host          => '127.0.0.1',
    port          => 8000,
    upstream_port => 8000
  }

  $solr_servers = {
    name          => 'solr',
    host          => '127.0.0.1',
    port          => 8081,
    upstream_port => 8080
  }


  class { "beluga::frontend_traffic_director":
    lamp_servers              => $lamp_servers,
    lamp_admin_servers        => $lamp_admin_servers,
    solr_servers              => $solr_servers,
    frontend_domain           => 'standards',
    backend_domain            => 'standards',
  }

  class {'beluga::apache_frontend_server':
    domain_name               => 'standards',
    owner                     => 'co',
    group                     => 'co'
  }

  class {'beluga::mysql_server':
  }

  class { 'beluga::drush_server': }

}


node dataconversion {
include epimorphics_defaults
}

node dataservice {
include epimorphics_defaults
}
