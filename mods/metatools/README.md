Minetest mod metatools
######################

A mod inspired by mgl512's itemframe issue

# Authors
 - LeMagnesium / Mg / ElectronLibre : Source code writer
 - Ataron : Texture creater

# Purpose
This mod's aim is to provide a way for admins to navigate through any (ok, not
ignores) nodes on the map, and see values of its metadatas at any of their
stratum.

# Media
"metatools_stick.png" by Ataron (CC-BY-NC-SA)

# Todo
 - Add a check if set is done in Node/fields/
 - Add a table handler for meta::set

# Special thanks
 - mgl512 (Le_Docteur) for its locked itemframe which gave me the idea of a tool
allowing to see/edit metadatas
 - Ataron who created the stick's texture

# Command tutorial

 - help										=> Get help
 - open (x,y,z)								=> Open the node to manipulate at pos (x,y,z)
 - show 									=> Show fields/path list at actual position
 - enter <path>								=> Enter next stratum through <path>
 - quit										=> Quit actual field and go back to previous stratum
 - set <name> <value>						=> Set metadata <name> to <value> (create it if it doesn't exist)
 - itemstack								=> Manipulate itemstacks in Node/inventory/*/
	- read <name>							=> Read itemstack at field name (itemstring and count)
	- erase <name>							=> Erase itemstack at field name
	- write <name> <itemstring> [<count>]	=> Set itemstack in field <name> with item <itemstring> and count <count>. Default count is one, 0 not handled.
 - close									=> Close node

 Node metadatas look like this :

 Stratum :	0		1		 2		...
			Nodes/
				|
				+- fields
				|	|
				|	+-		foo
				|	+-		bar
				|	+-		...
				+- inventory
					|
					+-		main
					|		|
					|		+-		1
					|		+-		2
					|		+-		3
					|		+-		...
					+-		craft
					|		|
					|		+-		1
					|		+-		2
					|		+-		3
					|		+-		...
					+-		...
