#!/bin/bash

echo "Node listing as of "`date` > nodes.txt

for i in *.lua; do
	echo -e "\nIn $i:\n" >> nodes.txt
	cat $i | grep "minetest.register_node(" | \
	sed "s/minetest.register_node(.homedecor:/homedecor:/; s/., {//" | \
	sort  >> nodes.txt
done

less nodes.txt
rm -f nodes.txt
