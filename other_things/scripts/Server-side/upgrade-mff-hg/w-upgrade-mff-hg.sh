# passer sur branche master ou stable github
cd /home/quentinbd/mff-hg/
#git checkout master
git checkout stable-0.4

# Suppression des anciens fichiers
#rm -Rv /home/quentinbd/upgrade-mff/olds
#rm -Rv /home/quentinbd/upgrade-mff/mff.tar.gz

# Sauvegarde des fichiers critiques
#cp -Rv /home/quentinbd/mff-hg/games/minetestforfun_game/ /home/quentinbd/upgrade-mff/olds/
#cp -Rv /home/quentinbd/mff-hg/mods/ /home/quentinbd/upgrade-mff/olds/
#cp -Rv /home/quentinbd/mff-hg/worlds/ /home/quentinbd/upgrade-mff/olds/
#cp /home/quentinbd/mff-hg/minetest.conf /home/quentinbd/upgrade-mff/olds/

# Sauvegarde et compression du dossier minetest (au cas ou)
#cd /home/quentinbd/upgrade-mff/
#tar -cf mff.tar.gz /home/quentinbd/mff-hg/

# Suppression de minetest
rm -Rv /home/quentinbd/mff-hg/

# Réinstallaton de minetest
cd /home/quentinbd/
#git clone https://github.com/minetest/minetest.git
# DEBUT - Utilisation de la version 0.4 stable
wget https://github.com/minetest/minetest/archive/stable-0.4.zip
unzip /home/quentinbd/stable-0.4.zip
mv /home/quentinbd/minetest-stable-0.4/ /home/quentinbd/mff-hg/
# FIN - Utilisation de la version 0.4 stable
#cd /home/quentinbd/mff-hg/games/
#git clone https://github.com/minetest/minetest_game.git

# Compilation
cd /home/quentinbd/mff-hg/
# build sqlite3
cmake . -DRUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LUAJIT=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr
make -j$(grep -c processor /proc/cpuinfo)
# build redis + irc
#cmake . -DENABLE_REDIS=1 -DRUN_RUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr
#make -j$(grep -c processor /proc/cpuinfo)

# Ajout des fichiers critiques au nouveau dossier minetest
#cp -Rv /home/quentinbd/upgrade-mff/olds/minetestforfun_game/ /home/quentinbd/mff-hg/games/
#cp -Rv /home/quentinbd/upgrade-mff/olds/mods/ /home/quentinbd/mff-hg/
#cp -Rv /home/quentinbd/upgrade-mff/olds/worlds/ /home/quentinbd/mff-hg/
#cp /home/quentinbd/upgrade-mff/olds/minetest.conf /home/quentinbd/mff-hg/

# Donne les droits à quentinbd
chmod -R 755 /home/quentinbd/mff-hg/
chown -R quentinbd:quentinbd /home/quentinbd/mff-hg/
