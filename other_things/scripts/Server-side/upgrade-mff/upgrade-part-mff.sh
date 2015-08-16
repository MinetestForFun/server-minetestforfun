# on récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/minetest-minetestforfun-server.git
echo "Clone de minetest-minetestforfun-server réussit."
cd /home/quentinbd/minetest-minetestforfun-server/
git submodule update --init --recursive

# on sauvegarde les anciens minetest/games et minetest/mods
rm -R /home/quentinbd/upgrade-mff/olds-part/games/
rm -R /home/quentinbd/upgrade-mff/olds-part/mods/
echo "Ancienne sauvegarde de /mods et /games correctement supprimée."

cp -R /home/quentinbd/mff/mods/ /home/quentinbd/upgrade-mff/olds-part/
cp -R /home/quentinbd/mff/games/ /home/quentinbd/upgrade-mff/olds-part/
echo "Sauvegarde de /mods et /games correctement effectuée."

# on MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff/games/
rm -R /home/quentinbd/mff/mods/
mkdir /home/quentinbd/mff/games/
cp -R /home/quentinbd/minetest-minetestforfun-server/minetestforfun_game/ /home/quentinbd/mff/games/
cp -R /home/quentinbd/minetest-minetestforfun-server/mods/ /home/quentinbd/mff/
echo "Nouveaux /mods et /games correctement déplacés"

# on MAJ les news, random_messages et le world.mt
rm /home/quentinbd/mff/worlds/minetestforfun/news.txt
rm /home/quentinbd/mff/worlds/minetestforfun/random_messages
rm /home/quentinbd/mff/worlds/minetestforfun/world.mt
cp /home/quentinbd/minetest-minetestforfun-server/worlds/minetestforfun/news.txt /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/minetest-minetestforfun-server/worlds/minetestforfun/random_messages /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/minetest-minetestforfun-server/worlds/minetestforfun/world.mt /home/quentinbd/mff/worlds/minetestforfun/
echo "Nouvelles news.txt, world.mt  et random_messages correctement déplacé"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/minetest-minetestforfun-server/
echo "Bravo ! minetest/mods et minetest/games maintenant à jour"

# TEMPORAIRE - ré-ajout de l'ancien mod irc
rm -R /home/quentinbd/mff/mods/irc/
cp -R /home/quentinbd/upgrade-mff/irc-old-save/ /home/quentinbd/mff/mods/
mv /home/quentinbd/mff/mods/irc-old-save/ /home/quentinbd/mff/mods/irc/
echo "TEMPORAIRE - ré-ajout de l'ancien mod irc"

# TEMPORAIRE - ré-ajout de l'ancien mod throwing
#rm -R /home/quentinbd/minetest/mods/throwing/
#cp -R /home/quentinbd/upgrade/throwing-old-save/ /home/quentinbd/minetest/mods/
#mv /home/quentinbd/minetest/mods/throwing-old-save/ /home/quentinbd/minetest/mods/throwing/
#echo "TEMPORAIRE - ré-ajout de l'ancien mod throwing"

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/
chown -R 755 /home/quentinbd/
echo "ré-attribution des droits à quentinbd:quentinbd"
