# On récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun.git
echo "Clone de server-minetestforfun réussit."
cd /home/quentinbd/server-minetestforfun/
git submodule update --init --recursive

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/upgrade-mff/olds-part/games/
rm -R /home/quentinbd/upgrade-mff/olds-part/mods/
echo "Ancienne sauvegarde de /mods et /games correctement supprimée."

cp -R /home/quentinbd/mff/mods/ /home/quentinbd/upgrade-mff/olds-part/
cp -R /home/quentinbd/mff/games/ /home/quentinbd/upgrade-mff/olds-part/
echo "Sauvegarde de /mods et /games correctement effectuée."

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff/games/
rm -R /home/quentinbd/mff/mods/
mkdir /home/quentinbd/mff/games/
cp -R /home/quentinbd/server-minetestforfun/minetestforfun_game/ /home/quentinbd/mff/games/
cp -R /home/quentinbd/server-minetestforfun/mods/ /home/quentinbd/mff/
echo "Nouveaux /mods et /games correctement déplacés"

# On MAJ le minetest.conf, world.mt, random_messages et le news.txt
mkdir /home/quentinbd/mff/worlds/minetestforfun/
rm /home/quentinbd/mff-hg/minetest.conf
rm /home/quentinbd/mff/worlds/minetestforfun/world.mt
rm /home/quentinbd/mff/worlds/minetestforfun/random_messages
rm /home/quentinbd/mff/worlds/minetestforfun/news.txt
# On les remet
cp /home/quentinbd/server-minetestforfun/minetest.conf /home/quentinbd/mff/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/world.mt /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/random_messages /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/news.txt /home/quentinbd/mff/worlds/minetestforfun/
echo "Nouvelles news.txt, world.mt  et random_messages correctement déplacé"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun/
echo "Bravo ! mff/mods et mff/games maintenant à jour"

# TEMPORAIRE - ré-ajout de l'ancien mod irc
rm -R /home/quentinbd/mff/mods/irc/
cp -R /home/quentinbd/upgrade-mff/irc-old-save/ /home/quentinbd/mff/mods/
mv /home/quentinbd/mff/mods/irc-old-save/ /home/quentinbd/mff/mods/irc/
echo "TEMPORAIRE - ré-ajout de l'ancien mod irc"

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff/
chmod -R 755 /home/quentinbd/mff/
echo "ré-attribution des droits à quentinbd:quentinbd"
