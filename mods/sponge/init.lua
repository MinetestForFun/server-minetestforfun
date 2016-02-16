minetest.register_node("sponge:sponge", {
	description = "Sponge Dry",
	drawtype = "normal",
	tiles = {"sponge_sponge.png"},
	paramtype = 'light',
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	stack_max = 99,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local pn = placer:get_player_name()
		if pointed_thing.type ~= "node" then
			return
		end
		if minetest.is_protected(pointed_thing.above, pn) then
			return
		end
		local change = false
		local on_water = false
		-- verifier si il est dans l'eau ou a cotée
		if string.find(minetest.get_node(pointed_thing.above).name, "water_source")
		or  string.find(minetest.get_node(pointed_thing.above).name, "water_flowing") then
			on_water = true
		end
		for i=-1,1 do
			p = {x=pos.x+i, y=pos.y, z=pos.z}
			n = minetest.get_node(p)
			-- On verifie si il y a de l'eau
			if (n.name=="default:water_flowing") or (n.name == "default:water_source")
				or (n.name == "default:river_water_flowing") or (n.name == "default:river_water_source") then
				on_water = true
			end
		end
		for i=-1,1 do
			p = {x=pos.x, y=pos.y+i, z=pos.z}
			n = minetest.get_node(p)
			-- On verifie si il y a de l'eau
			if (n.name=="default:water_flowing") or (n.name == "default:water_source")
				or (n.name == "default:river_water_flowing") or (n.name == "default:river_water_source") then
				on_water = true
			end
		end
		for i=-1,1 do
			p = {x=pos.x, y=pos.y, z=pos.z+i}
			n = minetest.get_node(p)
			-- On verifie si il y a de l'eau
			if (n.name=="default:water_flowing") or (n.name == "default:water_source")
				or (n.name == "default:river_water_flowing") or (n.name == "default:river_water_source") then
				on_water = true
			end
		end

		if on_water == true then
			for i=-3,3 do
				for j=-3,3 do
					for k=-3,3 do
						p = {x=pos.x+i, y=pos.y+j, z=pos.z+k}
						n = minetest.get_node(p)
						-- On Supprime l'eau
						if (n.name=="default:water_flowing") or (n.name == "default:water_source")
							or (n.name == "default:river_water_flowing") or (n.name == "default:river_water_source") then
							minetest.add_node(p, {name="air"})
							change = true
						end
					end
				end
			end
		end
		if change then
			minetest.add_node(pos, {name = "sponge:sponge_wet"})
		end
	end
})

minetest.register_node("sponge:sponge_wet", {
	description = "Wet Sponge",
	drawtype = "normal",
	tiles = {"sponge_sponge_wet.png"},
	paramtype = 'light',
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	stack_max = 99,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
})

-- Sponge wet back to Sponge Dry if coocked in a furnace
minetest.register_craft({
	type = "cooking", output = "sponge:sponge", recipe = "sponge:sponge_wet",
})

minetest.register_craft({
	output = "sponge:sponge",
	recipe = {
		{"", "dye:black", ""},
		{"dye:yellow", "wool:white", "dye:yellow"},
		{"", "farming:wheat", ""},
	},
})
