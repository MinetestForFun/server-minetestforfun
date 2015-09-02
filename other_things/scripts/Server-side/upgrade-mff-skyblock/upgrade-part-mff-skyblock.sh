# on récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun-skyblock.git
echo "Clone de server-minetestforfun-skyblock réussit."
cd /home/quentinbd/server-minetestforfun-skyblock/
git submodule update --init --recursive

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/upgrade-mff-skyblock/olds-part/games/
rm -R /home/quentinbd/upgrade-mff-skyblock/olds-part/mods/
echo "Ancienne sauvegarde de /mods et /games correctement supprimée."

cp -R /home/quentinbd/mff-skyblock/mods/ /home/quentinbd/upgrade-mff-skyblock/olds-part/
cp -R /home/quentinbd/mff-skyblock/games/ /home/quentinbd/upgrade-mff-skyblock/olds-part/
echo "Sauvegarde de /mods et /games correctement effectuée."

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff-skyblock/games/
rm -R /home/quentinbd/mff-skyblock/mods/
mkdir /home/quentinbd/mff-skyblock/games/
cp -R /home/quentinbd/server-minetestforfun-skyblock/hungry_game/ /home/quentinbd/mff/games/
cp -R /home/quentinbd/server-minetestforfun-skyblock/mods/ /home/quentinbd/mff/
echo "Nouveaux /mods et /games correctement déplacés"

# On MAJ le minetest.conf, world.mt, et le random_messages
mkdir /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/
rm /home/quentinbd/mff-skyblock/minetest.conf
rm /home/quentinbd/mff-skyblock/games/hungry_games/worlds/minetestforfun-skyblock/world.mt
rm /home/quentinbd/mff-skyblock/games/hungry_games/worlds/minetestforfun-skyblock/random_messages
# On les remet
cp /home/quentinbd/server-minetestforfun-skyblock/minetest.conf /home/quentinbd/mff-skyblock/
cp /home/quentinbd/server-minetestforfun-skyblock/worlds/minetestforfun-skyblock/world.mt /home/quentinbd/mff-skyblock/games/hungry_games/worlds/minetestforfun-skyblock/
cp /home/quentinbd/server-minetestforfun-skyblock/worlds/minetestforfun-skyblock/random_messages /home/quentinbd/mff-skyblock/games/hungry_games/worlds/minetestforfun-skyblock/
echo "Nouveau 'random_messages/world.mt/minetest.conf/top_config.txt' correctement déplacé"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-skyblock/
echo "Bravo ! mff-skyblock/mods et mff-skyblock/games maintenant à jour"

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff-skyblock/
chmod -R 755 /home/quentinbd/mff-skyblock/
echo "ré-attribution des droits à quentinbd:quentinbd"
