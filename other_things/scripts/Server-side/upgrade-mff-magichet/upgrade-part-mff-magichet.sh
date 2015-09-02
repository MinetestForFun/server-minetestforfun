# on récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun-magichet.git
echo "Clone de server-minetestforfun-magichet réussit."
cd /home/quentinbd/server-minetestforfun-magichet/
git submodule update --init --recursive

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/upgrade-mff-magichet/olds-part/games/
rm -R /home/quentinbd/upgrade-mff-magichet/olds-part/mods/
echo "Ancienne sauvegarde de /mods et /games correctement supprimée."

cp -R /home/quentinbd/mff-magichet/mods/ /home/quentinbd/upgrade-mff-magichet/olds-part/
cp -R /home/quentinbd/mff-magichet/games/ /home/quentinbd/upgrade-mff-magichet/olds-part/
echo "Sauvegarde de /mods et /games correctement effectuée."

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff-magichet/games/
rm -R /home/quentinbd/mff-magichet/mods/
mkdir /home/quentinbd/mff-magichet/games/
cp -R /home/quentinbd/server-minetestforfun-magichet/hungry_game/ /home/quentinbd/mff/games/
cp -R /home/quentinbd/server-minetestforfun-magichet/mods/ /home/quentinbd/mff/
echo "Nouveaux /mods et /games correctement déplacés"

# On MAJ le minetest.conf, world.mt, et le random_messages
mkdir /home/quentinbd/mff-magichet/worlds/minetestforfun-magichet/
rm /home/quentinbd/mff-magichet/minetest.conf
rm /home/quentinbd/mff-magichet/games/hungry_games/worlds/minetestforfun-magichet/world.mt
rm /home/quentinbd/mff-magichet/games/hungry_games/worlds/minetestforfun-magichet/random_messages
# On les remet
cp /home/quentinbd/server-minetestforfun-magichet/minetest.conf /home/quentinbd/mff-magichet/
cp /home/quentinbd/server-minetestforfun-magichet/worlds/minetestforfun-magichet/world.mt /home/quentinbd/mff-magichet/games/hungry_games/worlds/minetestforfun-magichet/
cp /home/quentinbd/server-minetestforfun-magichet/worlds/minetestforfun-magichet/random_messages /home/quentinbd/mff-magichet/games/hungry_games/worlds/minetestforfun-magichet/
echo "Nouveau 'random_messages/world.mt/minetest.conf/top_config.txt' correctement déplacé"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-magichet/
echo "Bravo ! mff-magichet/mods et mff-magichet/games maintenant à jour"

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff-magichet/
chmod -R 755 /home/quentinbd/mff-magichet/
echo "ré-attribution des droits à quentinbd:quentinbd"
