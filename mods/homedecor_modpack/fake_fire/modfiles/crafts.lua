--[[

	NEVER-ENDING FLINT and STEEL

	Uncraftable, at the moment, and I'm not sure yet how many wanna-be-firebug
	griefers are going to litter with fake-fire. Why give them this if it only
	makes the mess bigger? ~ LazyJ, 2014_03_13
	
	May add a priv for this later so trusted players can use it.
	~ LazyJ, 2014_06_19

minetest.register_craftitem("fake_fire:old_flint_and_steel", {
	description = "Never ending flint and steel",
	inventory_image = "flint_and_steel.png",
	stack_max = 1,
	liquids_pointable = false,
	on_use = function(itemstack, user, pointed_thing)
		n = minetest.env:get_node(pointed_thing)
		if pointed_thing.type == "node" then
			minetest.env:add_node(pointed_thing.above,
			{name="fake_fire:fake_fire"})
			minetest.sound_play("",
			{gain = 1.0, max_hear_distance = 20,})
		end
	end
})
--]]


-- RECIPE ITEM - FLINT
minetest.register_craftitem("fake_fire:flint", {
	description = "flint",
	inventory_image = "flint.png",
	stack_max = 99,
	liquids_pointable = false,
})



-- FLINT
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:flint',
	recipe = {
			"default:gravel",
			"default:gravel",
	}
})



-- FLINT & STEEL
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:flint_and_steel',
	recipe = {
		"fake_fire:flint",
		"default:steel_ingot",
	}
})



-- EMBERS
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:embers',
	recipe = {
			"default:torch",
			"group:wood",
	}
})



-- CHIMNEY TOPS - SMOKELESS
	
	-- Only the smokeless kind will be craftable and shown in the inventory.
	-- The nodes are coded to switch to the smoking chimney tops when punched.
	-- ~ LazyJ  

-- STONE CHIMNEY TOP
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:smokeless_chimney_top_stone',
	recipe = {
			"default:torch",
			"stairs:slab_stone",
	}
})



-- SANDSTONE CHIMNEY TOP
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:smokeless_chimney_top_sandstone',
	recipe = {
			"default:torch",
			"stairs:slab_sandstone",
	}
})



-- Crafting Chain - Cobble-to-Gravel-to-Sand and Convert Sands

--[[

	Craft one cobble into one gravel.
	Craft one gravel into one sand.
	Convert-craft sand to desert sand and vice-versa.
	
	This was suggested by klappspaten and it makes sense in both its natural
	progression and as a practical way for players to get some of the non-
	renewable resources that they need.
	
	Because the gravel-to-sand recipe (from one of our other custom mods)
	conflicted with the Fake Fire mod's	flint recipe, the Fake Fire mod's
	recipe was changed to require 2 gravel.
	
	I've added the cobble-gravel-sand and convert sands recipes as a bonus and
	to make-up for the more expensive flint recipe. You can comment-out these
	recipes because they aren't *required* by this fork of Fake Fire, but they
	*are* handy recipes to have.
	
	~ LazyJ
	
	

--]]

-- Cobble to Gravel
minetest.register_craft({
	output = 'default:gravel',
	recipe = {
		{'default:cobble'},
	}
})



-- Gravel to Sand
minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{'default:gravel'},
	}
})



-- Desert Sand to Sand
minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{'default:desert_sand'},
	}
})



-- Sand to Desert Sand
minetest.register_craft({
	output = 'default:desert_sand',
	recipe = {
		{'default:sand'},
	}
})