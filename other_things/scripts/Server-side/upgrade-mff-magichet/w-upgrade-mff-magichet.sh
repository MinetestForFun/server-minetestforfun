# passer sur branche master ou stable github
cd /home/quentinbd/mff-magichet/

# Suppression des anciens fichiers
rm -Rv /home/quentinbd/upgrade-mff-magichet/olds
rm -Rv /home/quentinbd/upgrade-mff-magichet/mff-magichet.tar.gz

# Sauvegarde des fichiers critiques
cp -Rv /home/quentinbd/mff-magichet/games/minetestforfun_game/ /home/quentinbd/upgrade-mff-magichet/olds/
cp -Rv /home/quentinbd/mff-magichet/mods/ /home/quentinbd/upgrade-mff-magichet/olds/
cp -Rv /home/quentinbd/mff-magichet/worlds/ /home/quentinbd/upgrade-mff-magichet/olds/
cp /home/quentinbd/mff-magichet/minetest.conf /home/quentinbd/upgrade-mff-magichet/olds/

# Sauvegarde et compression du dossier minetest (au cas ou)
cd /home/quentinbd/upgrade-mff-magichet/
tar -cf mff-magichet.tar.gz /home/quentinbd/mff-magichet/

# Suppression de minetest
rm -Rv /home/quentinbd/mff-magichet/

# Réinstallaton de minetest
cd /home/quentinbd/
# DEBUT - Utilisation de la dernière version 0.4 stable
wget https://codeload.github.com/minetest/minetest/zip/stable-0.4
unzip /home/quentinbd/stable-0.4
mv /home/quentinbd/minetest-stable-0.4/ /home/quentinbd/mff-magichet/
rm -v /home/quentinbd/stable-0.4
# FIN - Utilisation de la version 0.4 stable

# Compilation
cd /home/quentinbd/mff-magichet/
# build SQLITE3
cmake . -DBUILD_CLIENT=0 -DBUILD_SERVER=1 -DRUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LUAJIT=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr
make -j$(grep -c processor /proc/cpuinfo)

# Ajout des fichiers critiques au nouveau dossier minetest
cp -Rv /home/quentinbd/upgrade-mff-magichet/olds/minetestforfun_game/ /home/quentinbd/mff-magichet/games/
cp -Rv /home/quentinbd/upgrade-mff-magichet/olds/mods/ /home/quentinbd/mff-magichet/
cp -Rv /home/quentinbd/upgrade-mff-magichet/olds/worlds/ /home/quentinbd/mff-magichet/
cp /home/quentinbd/upgrade-mff-magichet/olds/minetest.conf /home/quentinbd/mff-magichet/

# Donne les droits à quentinbd
chmod -R 755 /home/quentinbd/mff-magichet/
chown -R quentinbd:quentinbd /home/quentinbd/mff-magichet/
