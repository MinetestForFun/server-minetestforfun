-- craft items

minetest.register_craftitem("mushroom:spore1",{
	description = "Unidentified Mushroom Spore",
	inventory_image = "mushroom_spore.png",
	wield_image = "mushroom_spore.png",
})

minetest.register_craftitem("mushroom:spore2",{
	description = "Unidentified Mushroom Spore",
	inventory_image = "mushroom_spore.png",
	wield_image = "mushroom_spore.png",
})

minetest.register_craftitem("mushroom:identifier",{
	description = "Mushroom Spore Identifier/Spore Extractor",
	inventory_image = "mushroom_identifier.png",
	wield_image = "mushroom_identifier.png",
})

minetest.register_craftitem("mushroom:brown_essence",{
	description = "Healthy Brown Mushroom Essence",
	inventory_image = "mushroom_essence.png",
	wield_image = "mushroom_essence.png",
	on_use = minetest.item_eat(10),
})

minetest.register_craftitem("mushroom:poison",{
	description = "Red Mushroom Poison",
	inventory_image = "mushroom_poison.png",
	wield_image = "mushroom_poison.png",
	on_use = minetest.item_eat(-10),
})

-- recipes

minetest.register_craft( {
		output = "mushroom:identifier",
		recipe = { 
			{ "", "default:torch", "" },
			{ "default:steel_ingot", "default:mese_crystal_fragment", "default:steel_ingot" },
		}
})

minetest.register_craft( {
         type = "shapeless",
         output = "mushroom:brown_essence",
         recipe = { "mushroom:brown" , "vessels:glass_bottle" },
})

minetest.register_craft( {
         type = "shapeless",
         output = "mushroom:poison",
         recipe = { "mushroom:red" , "vessels:glass_bottle" },
})

minetest.register_craft( {
         type = "shapeless",
         output = "mushroom:spore_brown",
         recipe = { "mushroom:identifier" , "mushroom:spore1" },
         replacements = {
             { 'mushroom:identifier', 'mushroom:identifier' }
         }
})

minetest.register_craft( {
         type = "shapeless",
         output = "mushroom:spore_red",
         recipe = { "mushroom:identifier" , "mushroom:spore2" },
         replacements = {
             { 'mushroom:identifier', 'mushroom:identifier' }
         }
})

minetest.register_craft( {
         type = "shapeless",
         output = "mushroom:spore_red 2",
         recipe = { "mushroom:identifier" , "mushroom:red" },
         replacements = {
             { 'mushroom:identifier', 'mushroom:identifier' }
         }
})

minetest.register_craft( {
         type = "shapeless",
         output = "mushroom:spore_brown 2",
         recipe = { "mushroom:identifier" , "mushroom:brown" },
         replacements = {
             { 'mushroom:identifier', 'mushroom:identifier' }
         }
})
