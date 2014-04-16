Vagrant.configure("2") do |config|
  config.ssh.username = "co"
  config.ssh.private_key_path = "keys/id_rsa"
  config.vm.hostname = "vagrant.dgudev"
  #config.vm.synced_folder ".", "/vagrant", type: "nfs"

  config.vm.box     = "dgu-dev-1.0"
  config.vm.box_url = "http://co-dev1.dh.bytemark.co.uk/dgu-dev-1.0.box"

  config.vm.network "private_network", ip: "192.168.16.10"
  config.vm.network "forwarded_port", guest: 8000, host: 8000 # apache
  config.vm.network "forwarded_port", guest: 8880, host: 8880 # nginx
  config.vm.network "forwarded_port", guest: 8881, host: 8881 # varnish
  config.vm.network "forwarded_port", guest: 8081, host: 8081 # tomcat
  config.vm.network "forwarded_port", guest: 8080, host: 8888 # jenkins
  config.vm.network "forwarded_port", guest: 3306, host: 3366 # mysql

 config.vm.provider "virtualbox" do |vb|
    # allow symlinks - you are using this in a *nix host system right?
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
 end


  # Use a shell provisioner to Vagrant here which will use
  # rake inside the VM to run vagrant:provision
  # Put a custom vagrant.pp in this directory if you want to run your own manifest.
  config.vm.provision :shell, :path => "bin/vagrant-provision.sh"

end
