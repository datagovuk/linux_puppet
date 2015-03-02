#!/bin/bash
set -e

puppet_base='/vagrant/puppet'
to_provision='/vagrant/puppet/manifests/site.pp'

if [ -f /vagrant/vagrant.pp ] ;
then
  echo 'Found local vagrant.pp - using that instead'
  to_provision='/vagrant/vagrant.pp'
fi

#Don't change config if there are already keys
if [ ! -f /home/co/.ssh/id_rsa ];
then 
    echo "Host dev.dguteam.co.uk" >> /home/co/.ssh/config
    echo "    User vagrant_ro" >> /home/co/.ssh/config
    cp /vagrant/keys/id_rsa  /home/co/.ssh/id_rsa
    cp /vagrant/keys/id_rsa.pub  /home/co/.ssh/id_rsa.pub
    chown co: /home/co/.ssh/id_rsa.pub
    chown co: /home/co/.ssh/id_rsa
    chmod 600 /home/co/.ssh/id_rsa.pub /home/co/.ssh/id_rsa
    chmod 700 /home/co/.ssh
    echo dev > /etc/role

    #Temporary - need to add these to the base box?
    #wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb > /dev/null
    #dpkg -i puppetlabs-release-precise.deb
    apt-get update  > /dev/null 2>&1
    apt-get purge --yes puppet > /dev/null 2>&1
    cp /vagrant/puppet/puppet.conf /etc/puppet/
    cp /vagrant/puppet/autosign.conf /etc/puppet/
    cp /vagrant/puppet/auth.conf /etc/puppet/

    apt-get install --yes ruby1.9.1 ruby1.9.1-dev \
        rubygems1.9.1 irb1.9.1 ri1.9.1 rdoc1.9.1 \
        build-essential libopenssl-ruby1.9.1 libssl-dev zlib1g-dev > /dev/null 2>&1
    apt-get install --yes libactiverecord-ruby1.9.1 > /dev/null 2>&1
    apt-get install --yes libsqlite3-ruby1.9.1 > /dev/null 2>&1
    update-alternatives --set ruby /usr/bin/ruby1.9.1 > /dev/null 2>&1
    update-alternatives --set gem /usr/bin/gem1.9.1 > /dev/null 2>&1
    apt-get install --yes puppet > /dev/null 2>&1

    gem update  > /dev/null 2>&1
    gem install librarian-puppet  > /dev/null 2>&1
    gem install hiera > /dev/null 2>&1
    gem install hiera-eyaml > /dev/null 2>&1

    rm -rf /etc/puppet
    ln -sf /vagrant/puppet /etc/
    ln -sf /etc/puppet/hiera.yaml /etc/
    #Update puppet module dependencies using librarian-puppet
    cd /vagrant/puppet
        librarian-puppet update

    if [ ! -f /vagrant/keys/private_key.pkcs7.pem ];
    then
        cd /vagrant
        eyaml  createkeys
    fi
fi



ln -sf /vagrant/hieradata /etc/
sudo /usr/bin/puppet apply --verbose \
  --manifestdir=${puppet_base}/manifests \
  --modulepath=${puppet_base}/modules \
  --hiera_config=${puppet_base}/hiera.yaml \
  ${to_provision}

#sudo /usr/bin/puppet apply --verbose --manifestdir=/vagrant/puppet/manifests/ --modulepath=/vagrant/puppet/modules/ --hiera_config=/vagrant/puppet/hiera.yaml /vagrant/puppet/manifests/site.pp

#su co -c 'ssh -o StrictHostKeyChecking=no dev.data.gov.uk "echo Connection success" < /dev/null'
