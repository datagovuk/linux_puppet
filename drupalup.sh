#! /bin/bash

set -e

export PATH=$PATH:/usr/local/node/node-v0.10.26/bin

cd /tmp
sudo rm -rf dgu_d7
git clone https://github.com/datagovuk/dgu_d7.git
cd dgu_d7
sudo rm -rf /vagrant/dgud7
drush make --working-copy --no-gitinfofile distro.make /vagrant/dgud7
cd /vagrant/dgud7
sudo rm -rf /vagrant/dgud7/shared_dguk_assets
git clone https://github.com/datagovuk/shared_dguk_assets.git
cd /vagrant/dgud7/shared_dguk_assets
npm install
grunt
cd /vagrant/dgud7
ln -s ./shared_dguk_assets/assets
drush  --db-url=mysql://root:dev@localhost/dgud7 --uri=dgud7 --root=/vagrant/dgud7 --yes --verbose site-install dgu --sites-subdir=default --account-name=admin --account-pass=admin --site-mail='dgud7-info@vagrant.dgudev' --site-name='dgud7' --yes
sudo rm -rf /var/www/dgud7
sudo ln -sf /vagrant/dgud7 /var/www/
cp -R /vagrant/dgud7/profiles/dgu/sample/images/files /vagrant/dgud7/sites/default/
zcat /vagrant/dgud7/profiles/dgu/sample/dgud7_default_db.sql.gz | mysql -u root -pdev dgud7
drush -y composer-json-rebuild
drush -y composer-manager
drush -y updatedb
mv /vagrant/dgud7/sites/default/files/ /home/co/files/
sudo chown -R www-data:www-data /home/co/files
ln -s /home/co/files /vagrant/dgud7/sites/default/
echo "You should now be able to browse to http://localhost:8000"
