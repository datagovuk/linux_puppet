linux_puppet
============

Puppet manifests to install DGU infrastructure.

To install the DGU Infrastructure you will need the following software installed on your computer with the corresponding version number.

Virtualbox 3.4+ - https://www.virtualbox.org/wiki/Downloads

Vagrant 1.4.3+ - https://www.vagrantup.com/downloads.html

It is recommended that your host machine has at least 4GB of RAM installed.

Ensure Git is installed, then on the HOST machine;

  git clone https://github.co.uk/datagovuk/linux_puppet.git
  
  cd linux_puppet
  
  vagrant up
  
  vagrant ssh

Once you are in the VM shell type the following;
 
  /vagrant/drupalup.sh
  
Wait until finished, then browse to http://localhost:8000 in your browser on your host machine.

Thats it.
