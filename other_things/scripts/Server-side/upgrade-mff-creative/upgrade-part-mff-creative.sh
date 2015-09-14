# on récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun-creative.git
echo "Clone de server-minetestforfun-creative réussit."
cd /home/quentinbd/server-minetestforfun-creative/
git submodule update --init --recursive

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/upgrade-mff-creative/olds-part/games/
rm -R /home/quentinbd/upgrade-mff-creative/olds-part/mods/
echo "Ancienne sauvegarde de /mods et /games correctement supprimée."

cp -R /home/quentinbd/mff-creative/mods/ /home/quentinbd/upgrade-mff-creative/olds-part/
cp -R /home/quentinbd/mff-creative/games/ /home/quentinbd/upgrade-mff-creative/olds-part/
echo "Sauvegarde de /mods et /games correctement effectuée."

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff-creative/mods/
rm -R /home/quentinbd/mff-creative/games/
mkdir /home/quentinbd/mff-creative/games/
mkdir /home/quentinbd/server-minetestforfun-creative/games
mkdir /home/quentinbd/mff-creative/games/minetestforfun_creative/
mkdir /home/quentinbd/mff-creative/games/minetestforfun_creative/mods/
cp -R /home/quentinbd/server-minetestforfun-creative/mods/ /home/quentinbd/mff-creative/games/minetestforfun_creative/
echo "Nouveaux /mods et /games correctement déplacés"

# On MAJ le minetest.conf, game.conf, world.mt, et le random_messages
mkdir /home/quentinbd/mff-creative/worlds/minetestforfun-creative/
rm /home/quentinbd/mff-creative/minetest.conf
rm /home/quentinbd/mff-creative/worlds/minetestforfun-creative/world.mt
rm /home/quentinbd/mff-creative/worlds/minetestforfun-creative/random_messages
# On les remet
cp /home/quentinbd/server-minetestforfun-creative/minetest.conf /home/quentinbd/mff-creative/games/minetestforfun_creative/
cp /home/quentinbd/server-minetestforfun-creative/minetest.conf /home/quentinbd/mff-creative/
cp /home/quentinbd/server-minetestforfun-creative/game.conf /home/quentinbd/mff-creative/games/minetestforfun_creative/
#cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/world.mt /home/quentinbd/mff-creative/worlds/minetestforfun-creative/
cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/random_messages /home/quentinbd/mff-creative/worlds/minetestforfun-creative/
echo "Nouveau 'minetest.conf, game.conf, world.mt, et le random_messages' correctement déplacé"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-creative/
echo "Bravo ! mff-creative/mods et mff-creative/games maintenant à jour"

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff-creative/
chmod -R 755 /home/quentinbd/mff-creative/
echo "ré-attribution des droits à quentinbd:quentinbd"
