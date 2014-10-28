node default {
  crit( "Node only matched \"default\" for which there is no configuration, $::hostname" )
}

node /.*\.dgudev/ {
  # Thinking of modifying this for your own needs?
  # Don't! Create 'vagrant.pp' in the same directory
  # as your Vagrantfile and the vagrant provisioner
  # will use that instead.

  include beluga::apache_frontend_server
  include beluga::mail_server
  include beluga::drush_server
  include beluga::mysql_server
  include beluga::ruby_frontend
  include ckan
  include dgu_defaults
  include memcached
  include orgdc
  include redis
  include uwsgi

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

  class { 'solr':
    source_dir                => "puppet:///modules/dgu_solr/solr",
    source_dir_purge          => true,
  }

  beluga::drupal_site { 'standards':
    site_owner => 'co'
  }

}


node standards {

  include prod_defaults

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
