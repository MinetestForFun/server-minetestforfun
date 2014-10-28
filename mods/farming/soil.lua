
--= Soil Functions

-- Normal Soil

minetest.register_node("farming:soil", {
	description = "Soil",
	tiles = {"farming_soil.png", "default_dirt.png"},
	drop = "default:dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=2},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_alias("farming:desert_sand_soil", "farming:soil")

-- Wet Soil

minetest.register_node("farming:soil_wet", {
	description = "Wet Soil",
	tiles = {"farming_soil_wet.png", "farming_soil_wet_side.png"},
	drop = "default:dirt",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, soil=3},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_alias("farming:desert_sand_soil_wet", "farming:soil_wet")

-- If Water near Soil then turn into Wet Soil

minetest.register_abm({
	nodenames = {"farming:soil", "farming:soil_wet"},
	interval = 15,
	chance = 4,
	action = function(pos, node)

		pos.y = pos.y+1
		local nn = minetest.get_node(pos).name
		pos.y = pos.y-1

		-- what's on top of soil, if solid/not plant change soil to dirt
		if minetest.registered_nodes[nn]
		and minetest.registered_nodes[nn].walkable
		and minetest.get_item_group(nn, "plant") == 0 then
			minetest.set_node(pos, {name="default:dirt"})
		end

		-- check if there is water nearby and change soil accordingly
		if minetest.find_node_near(pos, 3, {"group:water"}) then
			if node.name == "farming:soil" then
				minetest.set_node(pos, {name="farming:soil_wet"})
			end
		elseif node.name == "farming:soil_wet" then
			minetest.set_node(pos, {name="farming:soil"})
		elseif node.name == "farming:soil" then
			minetest.set_node(pos, {name="default:dirt"})
		end
	end,
})
