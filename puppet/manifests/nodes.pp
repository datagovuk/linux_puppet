node default {
  crit( "Node only matched \"default\" for which there is no configuration, $::hostname" )
}

node /.*\.dgudev/ {
  # Thinking of modifying this for your own needs?
  # Don't! Create 'vagrant.pp' in the same directory
  # as your Vagrantfile and the vagrant provisioner
  # will use that instead.

  include beluga::mail_server
  include beluga::drush_server
  include beluga::mysql_server
  include beluga::ruby_frontend
  class { 'ckan':
    nginx_vhost => 'dgud7',
    nginx_port  => 8880,
  }
  include dgu_defaults
  include memcached
  include orgdc
  include redis

  class { 'sudo':
    purge                     => false,
    config_file_replace       => false,
  }

  class { 'beluga::developer_tools':
    install_git               => true,
    install_vim               => true,
  }


  class { 'beluga::frontend_traffic_director':
    extra_selectors           => $extra_selectors,
    frontend_domain           => 'dgud7',
    backend_domain            => 'dgud7',
  }

# clashing with tomcat. disable for now.
#  class { 'jenkins':
#    configure_firewall        => false,
#  }

  include dgu_solr

  beluga::drupal_site { 'standards':
    site_owner => 'co'
  }
  beluga::drupal_site { 'dgud7':
    site_owner => 'co'
  }
  package {'puppetmaster':
    ensure  =>  latest,
  }

  host{'localhost':
    ensure => present,
    host_aliases => ['dgud7', 'standards', 'ckan'],
    ip => '127.0.0.1',
  }

  class {'varnish':
    varnish_listen_port => 8881,
  }
  include varnish::vcl
  include dgu_organogram_explorer
}

node standards {

  include prod_defaults
  network_config { 'eth0':
    ensure  => 'present',
    family  => 'inet',
    method  => 'static',
    ipaddress => '46.43.41.17',
    netmask => '255.255.255.192',
    onboot  => 'true',
  }

  class {"beluga::developer_tools":
    install_git => true,
  }

  class {'beluga::apache_frontend_server': }

  class {'beluga::mysql_server': }

  class { 'beluga::drush_server': }
  include standards_site

}

node fetdirector {
  include prod_defaults
  network_config { 'eth0':
    ensure  => 'present',
    family  => 'inet',
    method  => 'static',
    ipaddress => '46.43.41.15',
    netmask => '255.255.255.192',
    onboot  => 'true',
  }

  host{'localhost':
    ensure => present,
    host_aliases => ['fetdirector'],
    ip => '127.0.0.1',
  }

  class {"beluga::developer_tools":
    install_git => true,
  }
  nginx::resource::vhost { 'data.gov.uk':
    proxy_redirect => "http://dgud7/ http://\$host/",
    proxy_set_header => ['X-Real-IP  $remote_addr', 'X-Forwarded-For $remote_addr', 'Host $host'],
    proxy => "http://upstream-dgud7_prod_01",
  }
}

node ckan_prod_01 {
  class { 'ckan':
    nginx_vhost => 'data.gov.uk',
    nginx_port  => 80,
  }
}

node puppetmaster {
  include prod_defaults
}

node dataconversion {
  include epimorphics_defaults
  include java
  class { "tomcat":
  }
  include beluga::apache_frontend_server
  include orgdc
  include dgu_organogram_explorer
}

node dataservice {
  include epimorphics_defaults
  include java
  class { "tomcat":
  }
}

node epdev {
  include epimorphics_defaults
  include java
  class { "tomcat":
  }
}


