
-- Mushroom mod by DanDuncombe and VanessaE
--
-- License:  CC-By-SA for texures derived from Minetest defaults,
--           WTFPL for all code and everything else.

mushroom = {}

minetest.register_node("mushroom:brown",{
	description = "Brown Mushroom",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {"mushroom_brown.png"},
	inventory_image = "mushroom_brown.png",
	wield_image = "mushroom_brown.png",
	groups = {oddly_breakable_by_hand=3,attached_node=1},
	paramtype = "light",
	walkable = false,
	on_use = minetest.item_eat(5),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
	drop = "mushroom:brown",
})

minetest.register_node("mushroom:red",{
	description = "Red Mushroom",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {"mushroom_red.png"},
	inventory_image = "mushroom_red.png",
	wield_image = "mushroom_red.png",
	groups = {oddly_breakable_by_hand=3,attached_node=1},
	paramtype = "light",
	walkable = false,
	on_use = minetest.item_eat(-5),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
    drop = "mushroom:red",
})

minetest.register_node("mushroom:spore_brown",{
	description = "Brown Mushroom Spore",
	drawtype = "raillike",
	paramtype = "light",
	tiles = {"mushroom_spore_brown.png"},
	sunlight_propagates = true,
	walkable = false,
	groups = {oddly_breakable_by_hand=3,attached_node=1},
	inventory_image = "mushroom_spore_brown.png",
	wield_image = "mushroom_spore_brown.png",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
})

minetest.register_node("mushroom:spore_red",{
	description = "Red Mushroom Spore",
	drawtype = "raillike",
	paramtype = "light",
	tiles = {"mushroom_spore_red.png"},
	sunlight_propagates = true,
	walkable = false,
	groups = {oddly_breakable_by_hand=3,attached_node=1},
	inventory_image = "mushroom_spore_red.png",
	wield_image = "mushroom_spore_red.png",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
	},
})

--Natural Mushrooms

minetest.register_node("mushroom:brown_natural",{
	description = "Brown Mushroom (Naturally Spawned)",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {"mushroom_brown.png"},
	inventory_image = "mushroom_brown.png",
	wield_image = "mushroom_brown.png",
	groups = {oddly_breakable_by_hand=3},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
	drop = "mushroom:brown",
})

minetest.register_node("mushroom:red_natural",{
	description = "Red Mushroom (Naturally Spawned)",
	drawtype = "plantlike",
	sunlight_propagates = true,
	tiles = {"mushroom_red.png"},
	inventory_image = "mushroom_red.png",
	wield_image = "mushroom_red.png",
	groups = {oddly_breakable_by_hand=3},
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
	},
    drop = "mushroom:red",
})

-- Spore Growing ABMs

minetest.register_abm({
	nodenames = {"mushroom:spore_brown"},
	neighbors = {"air"},
	interval = 120,
	chance = 4,
	action = function(pos, node)
		local soil = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
		if (soil.name == "farming:soil_wet" or string.find(soil.name, "homedecor:flower_pot_"))
			and minetest.get_node_light(pos, nil) < 8 then
	 			minetest.add_node({x=pos.x,y=pos.y,z=pos.z}, {name="mushroom:brown"})
		end
	end
})

minetest.register_abm({
	nodenames = {"mushroom:spore_red"},
	neighbors = {"air"},
	interval = 120,
	chance = 4,
	action = function(pos, node)
		local soil = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
		if (soil.name == "farming:soil_wet" or string.find(soil.name, "homedecor:flower_pot_"))
			and minetest.get_node_light(pos, nil) < 8 then
	 			minetest.add_node({x=pos.x,y=pos.y,z=pos.z}, {name="mushroom:red"})
		end
	end
})

-- list of trees that mushrooms can grow next to

local trees_list = {
	"default:tree",
	"default:jungletree",
	"moretrees:apple_tree_trunk",
	"moretrees:beech_trunk",
	"moretrees:birch_trunk",
	"moretrees:fir_trunk",
	"moretrees:oak_trunk",
	"moretrees:pine_trunk",
	"moretrees:rubber_tree_trunk",
	"moretrees:rubber_tree_trunk_empty",
	"moretrees:sequoia_trunk",
	"moretrees:spruce_trunk",
	"moretrees:willow_trunk",
}

-- Natural Spawning ABM

minetest.register_abm({
	nodenames = {
		"default:dirt_with_grass",
		"default:dirt",
		"woodsoils:dirt_with_leaves_1",
		"woodsoils:dirt_with_leaves_2",
		"woodsoils:grass_with_leaves_1",
		"woodsoils:grass_with_leaves_2",
		"farming:soil_wet"
	},
	neighbors = {"air"},
	interval = 300,
	chance = 100,
	action = function(pos, node)
		local top_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		if minetest.get_node(top_pos).name == "air" and minetest.get_node_light(top_pos, nil) < 8 
			and minetest.find_node_near(pos, 1, trees_list)
			and minetest.find_node_near(pos, 3, "default:water_source") then
			if math.random(0, 1) == 0 then
				minetest.add_node(top_pos, {name="mushroom:brown_natural"})
			else
				minetest.add_node(top_pos, {name="mushroom:red_natural"})
			end
		end
	end
})

minetest.register_abm({
	nodenames = {"default:stone"},
	neighbors = {"air"},
	interval = 300,
	chance = 100,
	action = function(pos, node)
		local top_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		if minetest.get_node(top_pos).name == "air" and minetest.get_node_light(top_pos, nil) < 8 
			and minetest.find_node_near(pos, 1, {"default:water_source"}) then
			if math.random(0,1) == 0 then
				minetest.add_node(top_pos, {name="mushroom:brown_natural"})
			else
				minetest.add_node(top_pos, {name="mushroom:red_natural"})
			end
		end
	end
})

-- Spreading ABM

minetest.register_abm({
	nodenames = {
		"mushroom:brown_natural",
		"mushroom:red_natural"
	},
	neighbors = {"air"},
	interval = 120,
	chance = 100,
	action = function(pos, node)
		local soil_pos = {x=pos.x, y=pos.y-1, z=pos.z}
		local soil = minetest.get_node(soil_pos)
		local woodsoil_str = "woodsoils:.+_with_leaves_?"
		if minetest.get_node_light(pos, nil) < 8 
		  and minetest.find_node_near(pos, 1, trees_list) then
			local spread_x = math.random(-1, 1)
			local spread_z = math.random(-1, 1)
			local newpos = {x=pos.x+spread_x, y=pos.y, z=pos.z+spread_z}
			local newsoil = minetest.get_node({x=newpos.x, y=newpos.y-1, z=newpos.z})
			if minetest.get_node(newpos).name == "air"
			  and (newsoil.name == "default:dirt_with_grass"
			    or newsoil.name == "default:dirt"
			    or string.match(newsoil.name, woodsoil_str)) 
			  and minetest.find_node_near(newpos, 3, "default:water_source") then
				minetest.add_node(newpos, {name=node.name})
			end		
		end
	end
})

-- Dying ABM

minetest.register_abm({
	nodenames = {
		"mushroom:brown",
		"mushroom:red",
	},
	neighbors = {"air"},
	interval = 120,
	chance = 50,
	action = function(pos, node)
		local soil = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		if soil.name ~= "farming:soil_wet"
		  and not string.find(soil.name, "homedecor:flower_pot_") then
				minetest.remove_node(pos)
		end
	end
})

dofile(minetest.get_modpath("mushroom").."/crafting.lua")
dofile(minetest.get_modpath("mushroom").."/compat.lua")

print("[Mushrooms] loaded.")

