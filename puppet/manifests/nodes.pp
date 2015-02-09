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
  include ckan
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

  class { 'jenkins':
    configure_firewall        => false,
  }

  include dgu_solr

  beluga::drupal_site { 'standards':
    site_owner => 'co'
  }

  package {'puppetmaster':
    ensure  =>  latest,
  }
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

node puppetmaster {
  include prod_defaults
}

node dataconversion {
  include epimorphics_defaults
  include java
  class { "tomcat":
  }
  include orgdc
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
