#! /bin/bash
cd /tmp
rm -rf dgu_d7
git clone https://github.com/datagovuk/dgu_d7.git
cd dgu_d7
rm -rf /vagrant/dgud7
drush make --working-copy --no-gitinfofile distro.make /vagrant/dgud7
cd /vagrant
rm -rf shared_dguk_assets
git clone https://github.com/datagovuk/shared_dguk_assets.git
cd /vagrant/shared_dguk_assets
npm install
grunt
cd /vagrant/dgud7
ln -s ../shared_dguk_assets/assets
drush  --db-url=mysql://root:dev@localhost/dgud7 --uri=dgud7 --root=/vagrant/dgud7/ --yes --verbose site-install dgu --sites-subdir=dgud7 --account-name=admin --account-pass=admin --site-mail='dgud7-info@vagrant.dgudev' --site-name='dgud7' --yes
cd /vagrant/dgud7/sites/default/
ln -s ../dgud7/settings.php
ln -s ../dgud7/files
sudo rm -rf /var/www/dgud7
ln -sf /vagrant/dgud7 /var/www/
echo "You should now be able to browse to http://localhost:8000"
echo "The dev database could be imported now. Do you want to import it (y/n)?"
read choice
if [[ "$choice" == "y" ]]; then
    echo "Importing Database, please wait.."
    #scp -v co@46.43.41.25:/var/jenkins_backups/drupal/dgu_current.sql.gz /vagrant
    echo "Extracting Database"
    gunzip -cfv /vagrant/dgu_current.sql.gz
    mysql -u root -pdev dgud7 < /vagrant/dgu_current.sql
    echo "The current dgud7 database was imported!"
    echo "You should now be able to browse to http://localhost:8000"
else
    echo "The database was not imported."
    echo "You can still browse to http://localhost:8000"
fi
