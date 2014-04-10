#! /bin/bash
cd /tmp
rm -rf dgu_d7
git clone https://github.com/datagovuk/dgu_d7.git
cd dgu_d7
rm -rf /home/co/dgud7
drush make --working-copy --no-gitinfofile distro.make /home/co/dgud7
cd /home/co/dgud7
rm -rf /home/co/dgud7/shared_dguk_assets
git clone https://github.com/datagovuk/shared_dguk_assets.git
cd /home/co/dgud7/shared_dguk_assets
npm install
grunt
cd /home/co/dgud7
ln -s home/co/dgud7/shared_dguk_assets/assets
drush  --db-url=mysql://root:dev@localhost/dgud7 --uri=dgud7 --root=/home/co/dgud7 --yes --verbose site-install dgu --sites-subdir=default --account-name=admin --account-pass=admin --site-mail='dgud7-info@vagrant.dgudev' --site-name='dgud7' --yes
sudo rm -rf /var/www/dgud7
sudo ln -sf /home/co/dgud7 /var/www/
echo "You should now be able to browse to http://localhost:8000"
