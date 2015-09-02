# on récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun-hungry_games.git
echo "Clone de server-minetestforfun-hungry_games réussit."
cd /home/quentinbd/server-minetestforfun-hungry_games/
git submodule update --init --recursive

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/upgrade-mff-hg/olds-part/games/
rm -R /home/quentinbd/upgrade-mff-hg/olds-part/mods/
echo "Ancienne sauvegarde de /mods et /games correctement supprimée."

cp -R /home/quentinbd/mff-hg/mods/ /home/quentinbd/upgrade-mff-hg/olds-part/
cp -R /home/quentinbd/mff-hg/games/ /home/quentinbd/upgrade-mff-hg/olds-part/
echo "Sauvegarde de /mods et /games correctement effectuée."

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff-hg/games/
rm -R /home/quentinbd/mff-hg/mods/
mkdir /home/quentinbd/mff-hg/games/
cp -R /home/quentinbd/server-minetestforfun-hungry_games/hungry_game/ /home/quentinbd/mff/games/
cp -R /home/quentinbd/server-minetestforfun-hungry_games/mods/ /home/quentinbd/mff/
echo "Nouveaux /mods et /games correctement déplacés"

# On MAJ le minetest.conf, world.mt, random_messages et le top_config.txt
mkdir /home/quentinbd/mff-hg/worlds/minetestforfun-hg/
rm /home/quentinbd/mff-hg/minetest.conf
rm /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/world.mt
rm /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/random_messages
rm /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/top_config.txt
# On les remet
cp /home/quentinbd/server-minetestforfun-hungry_games/minetest.conf /home/quentinbd/mff-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/world.mt /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/random_messages /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/top_config.txt /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/
echo "Nouveau 'random_messages/world.mt/minetest.conf/top_config.txt' correctement déplacé"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-hungry_games/
echo "Bravo ! mff-hg/mods et mff-hg/games maintenant à jour"

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff-hg/
chmod -R 755 /home/quentinbd/mff-hg/
echo "ré-attribution des droits à quentinbd:quentinbd"
