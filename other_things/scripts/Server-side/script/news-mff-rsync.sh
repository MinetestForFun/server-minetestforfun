#!/bin/sh 
#rsync -e "ssh -i /root/.ssh/id_dsa" -av --delete-after /home/quentinbd/minetest/worlds/minetestforfun/news.txt root@192.168.1.20:/var/www/wordpress/wp-content/uploads/news/
# Check the public key rights
chmod 600 /home/quentinbd/.ssh/id_rsa
chmod 600 /home/quentinbd/.ssh/id_rsa.pub
# Begin the RSYNC
rsync -azrv --delete /home/quentinbd/minetest/worlds/minetestforfun/news.txt quentinbd@192.168.1.20:/var/www/wordpress/wp-content/uploads/news/
echo "Transfert réussi de news.txt sur le wordpress"
