# passer sur branche master ou stable github
cd /home/quentinbd/mff-hg/

# Suppression des anciens fichiers
rm -Rv /home/quentinbd/upgrade-mff-hg/olds
rm -Rv /home/quentinbd/upgrade-mff-hg/mff-hg.tar.gz

# Sauvegarde des fichiers critiques
cp -Rv /home/quentinbd/mff-hg/games/minetestforfun_hg/ /home/quentinbd/upgrade-mff-hg/olds/
cp -Rv /home/quentinbd/mff-hg/mods/ /home/quentinbd/upgrade-mff-hg/olds/
cp -Rv /home/quentinbd/mff-hg/worlds/ /home/quentinbd/upgrade-mff-hg/olds/
cp /home/quentinbd/mff-hg/minetest.conf /home/quentinbd/upgrade-mff-hg/olds/

# Sauvegarde et compression du dossier minetest (au cas ou)
cd /home/quentinbd/upgrade-mff-hg/
tar -cf mff-hg.tar.gz /home/quentinbd/mff-hg/

# Suppression de minetest
rm -Rv /home/quentinbd/mff-hg/

# Réinstallaton de minetest
cd /home/quentinbd/
# DEBUT - Utilisation de la dernière version 0.4 stable
wget https://codeload.github.com/minetest/minetest/zip/stable-0.4
unzip /home/quentinbd/stable-0.4
mv /home/quentinbd/minetest-stable-0.4/ /home/quentinbd/mff-hg/
rm -v /home/quentinbd/stable-0.4
# FIN - Utilisation de la version 0.4 stable

# Compilation
cd /home/quentinbd/mff-hg/
# build SQLITE3
cmake . -DBUILD_CLIENT=0 -DBUILD_SERVER=1 -DRUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LUAJIT=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr
make -j$(grep -c processor /proc/cpuinfo)

# Ajout des fichiers critiques au nouveau dossier minetest
cp -Rv /home/quentinbd/upgrade-mff-hg/olds/minetestforfun_game/ /home/quentinbd/mff-hg/games/
cp -Rv /home/quentinbd/upgrade-mff-hg/olds/mods/ /home/quentinbd/mff-hg/
cp -Rv /home/quentinbd/upgrade-mff-hg/olds/worlds/ /home/quentinbd/mff-hg/
cp /home/quentinbd/upgrade-mff-hg/olds/minetest.conf /home/quentinbd/mff-hg/

# Donne les droits à quentinbd
chmod -R 755 /home/quentinbd/mff-hg/
chown -R quentinbd:quentinbd /home/quentinbd/mff-hg/
