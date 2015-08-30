# on récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun-hungry_games.git
echo "Clone de minetest-minetestforfun-server réussit."
cd /home/quentinbd/server-minetestforfun-hungry_games/
git submodule update --init --recursive

# on sauvegarde l'ancien subgame mff-hg
rm -Rf /home/quentinbd/upgrade-mff-hg/olds-part/subgame/
echo "Ancienne sauvegarde du subgame correctement supprimée."

cp -R /home/quentinbd/mff-hg/games /home/quentinbd/upgrade-mff-hg/olds-part/subgame/
echo "Sauvegarde du subgame correctement effectuée."

# on MAJ le novueau subgame
rm -Rf /home/quentinbd/mff-hg/games/
mkdir /home/quentinbd/mff-hg/games/
cp -R /home/quentinbd/server-minetestforfun-hungry_games/ /home/quentinbd/mff-hg/games/
echo "Nouveau subgame correctement déplacé."

# on MAJ le random_messages et le world.mt
#rm /home/quentinbd/mff/worlds/minetestforfun/news.txt
#rm /home/quentinbd/mff/worlds/minetestforfun/random_messages
mkdir /home/quentinbd/mff-hg/worlds/minetestforfun-hg/
rm /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/random_messages
rm /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/world.mt
rm /home/quentinbd/mff-hg/minetest.conf
rm /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/top_config.txt
#cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun/news.txt /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/random_messages /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/world.mt /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/minetest.conf /home/quentinbd/mff-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/top_config.txt /home/quentinbd/mff-hg/games/hungry_games/worlds/minetestforfun-hg/

echo "Nouveau 'random_messages/world.mt/minetest.conf/top_config.txt' correctement déplacé"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-hungry_games/
echo "Bravo ! mff-hg/mods et mff-hg/games maintenant à jour"

# TEMPORAIRE - ré-ajout de l'ancien mod irc
#rm -R /home/quentinbd/mff-hg/games/hungry_games/mods/irc/
#rm -R /home/quentinbd/mff-hg/games/hungry_games/mods/irc_commands/
#echo "TEMPORAIRE - Suppression de l'irc car crash"
#cp -R /home/quentinbd/upgrade-mff/irc-old-save/ /home/quentinbd/mff-hg/games/hungry_games/mods/
#mv /home/quentinbd/mff-hg/games/hungry_games/mods/irc-old-save/ /home/quentinbd/mff-hg/games/hungry_games/mods/irc/
#echo "TEMPORAIRE - ré-ajout de l'ancien mod irc"

# TEMPORAIRE - ré-ajout de l'ancien mod throwing
#rm -R /home/quentinbd/minetest/mods/throwing/
#cp -R /home/quentinbd/upgrade/throwing-old-save/ /home/quentinbd/minetest/mods/
#mv /home/quentinbd/minetest/mods/throwing-old-save/ /home/quentinbd/minetest/mods/throwing/
#echo "TEMPORAIRE - ré-ajout de l'ancien mod throwing"

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff-hg/
chmod -R 755 /home/quentinbd/mff-hg/
echo "ré-attribution des droits à quentinbd:quentinbd"
