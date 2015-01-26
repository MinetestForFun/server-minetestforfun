--Rocks

local cbox = {
	type = "fixed",
	fixed = {-5/16, -8/16, -6/16, 5/16, -1/32, 5/16},
}

minetest.register_node("cavestuff:pebble_1",{
	description = "Pebble",
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
    tiles = {"undergrowth_pebble.png"},
    paramtype = "light",
	paramtype2 = "facedir",
    groups = {cracky=3, stone=1},
    selection_box = cbox,
    collision_box = cbox,
    on_place = function(itemstack, placer, pointed_thing)
		-- place a random pebble node
		local stack = ItemStack("cavestuff:pebble_"..math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cavestuff:pebble_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:pebble_2",{
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
    tiles = {"undergrowth_pebble.png"},
	drop = "cavestuff:pebble_1",
    tiles = {"undergrowth_pebble.png"},
    paramtype = "light",
	paramtype2 = "facedir",
    groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	selection_box = cbox,
	collision_box = cbox,
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:desert_pebble_1",{
	description = "Desert Pebble",
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
    tiles = {"default_desert_stone.png"},
    paramtype = "light",
	paramtype2 = "facedir",
    groups = {cracky=3, stone=1},
	selection_box = cbox,
	collision_box = cbox,
    on_place = function(itemstack, placer, pointed_thing)
		-- place a random pebble node
		local stack = ItemStack("cavestuff:desert_pebble_"..math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("cavestuff:desert_pebble_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("cavestuff:desert_pebble_2",{
	drawtype = "mesh",
	mesh = "cavestuff_pebble.obj",
	drop = "cavestuff:desert_pebble_1",
    tiles = {"default_desert_stone.png"},
    paramtype = "light",
	paramtype2 = "facedir",
    groups = {cracky=3, stone=1, not_in_creative__inventory=1},
	selection_box = cbox,
	collision_box = cbox,
    sounds = default.node_sound_stone_defaults(),
})

--Staclactites

minetest.register_node("cavestuff:stalactite_1",{
	drawtype="nodebox",
	tiles = {"undergrowth_pebble.png"},
	groups = {cracky=3,attached_node=1},
	description = "Stalactite",
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.187500,0.425000,-0.150003,0.162500,0.500000,0.162500},
			{-0.112500,0.162500,-0.100000,0.087500,0.475000,0.087500},
			{-0.062500,-0.275000,-0.062500,0.062500,0.500000,0.062500},
			{-0.037500,-0.837500,0.037500,0.037500,0.500000,-0.025000},
		}
	},
	
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		if minetest.get_node(pt.under).name=="default:stone" 
		and minetest.get_node({x=pt.under.x, y=pt.under.y-1, z=pt.under.z}).name=="air"
		and minetest.get_node({x=pt.under.x, y=pt.under.y-2, z=pt.under.z}).name=="air" then
			minetest.set_node({x=pt.under.x, y=pt.under.y-1, z=pt.under.z}, {name="cavestuff:stalactite_"..math.random(1,3)})
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})

minetest.register_node("cavestuff:stalactite_2",{
	drawtype="nodebox",
	tiles = {"undergrowth_pebble.png"},
	groups = {cracky=3,attached_node=1,not_in_creative_inventory=1},
	drop = "cavestuff:stalactite_1",
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.187500,0.387500,-0.150003,0.162500,0.500000,0.162500},
	            {-0.112500,0.112500,-0.100000,0.087500,0.475000,0.087500},
	            {-0.062500,-0.675000,-0.062500,0.062500,0.500000,0.062500},
	            {-0.037500,-0.975000,0.037500,0.037500,0.500000,-0.025000},
		}
	},
})

minetest.register_node("cavestuff:stalactite_3",{
	drawtype="nodebox",
	tiles = {"undergrowth_pebble.png"},
	groups = {cracky=3,attached_node=1,not_in_creative_inventory=1},
	drop = "cavestuff:stalactite_1",
	paramtype = "light",
	paramtype2 = "wallmounted",
	node_box = {
	   type = "fixed",
	   fixed = {
		   {-0.187500,0.387500,-0.150003,0.162500,0.500000,0.162500},
		   {-0.112500,0.037500,-0.100000,0.087500,0.475000,0.087500},
		   {-0.062500,-0.437500,-0.062500,0.062500,0.500000,0.062500},
		   {-0.037500,-1.237500,0.037500,0.037500,0.500000,-0.025000},
	    }
    },
})

--Stalagmites



