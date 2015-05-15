--[[
	Minetest Farming Redo Mod 1.14 (11th May 2015)
	by TenPlus1
]]

farming = {}
farming.mod = "redo"
farming.path = minetest.get_modpath("farming")
farming.hoe_on_use = default.hoe_on_use

dofile(farming.path.."/soil.lua")
dofile(farming.path.."/hoes.lua")
dofile(farming.path.."/grass.lua")
dofile(farming.path.."/wheat.lua")
dofile(farming.path.."/cotton.lua")
dofile(farming.path.."/carrot.lua")
dofile(farming.path.."/potato.lua")
dofile(farming.path.."/tomato.lua")
dofile(farming.path.."/cucumber.lua")
dofile(farming.path.."/corn.lua")
dofile(farming.path.."/coffee.lua")
dofile(farming.path.."/melon.lua")
dofile(farming.path.."/sugar.lua")
dofile(farming.path.."/pumpkin.lua")
dofile(farming.path.."/cocoa.lua")
dofile(farming.path.."/raspberry.lua")
dofile(farming.path.."/blueberry.lua")
dofile(farming.path.."/rhubarb.lua")
dofile(farming.path.."/beanpole.lua")
dofile(farming.path.."/donut.lua")
dofile(farming.path.."/mapgen.lua")
dofile(farming.path.."/compatibility.lua") -- Farming Plus compatibility

-- Place Seeds on Soil

function farming.place_seed(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing

	-- check if pointing at a node
	if not pt and pt.type ~= "node" then
		return
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name]
	or not minetest.registered_nodes[above.name] then
		return
	end

	-- can I replace above node, and am I pointing at soil
	if not minetest.registered_nodes[above.name].buildable_to
	or minetest.get_item_group(under.name, "soil") < 2 
	or minetest.get_item_group(above.name, "plant") ~= 0 then -- ADDED this line for multiple seed placement bug
		return
	end

	-- add the node and remove 1 item from the itemstack
	if not minetest.is_protected(pt.above, placer:get_player_name()) then
		minetest.add_node(pt.above, {name=plantname})
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end
end

-- Single ABM Handles Growing of All Plants

minetest.register_abm({
	nodenames = {"group:growing"},
	neighbors = {"farming:soil_wet", "default:jungletree"},
	interval = 80,
	chance = 2,

	action = function(pos, node)

		-- split plant name (e.g. farming:wheat_1)
		local plant = node.name:split("_")[1].."_"
		local numb = node.name:split("_")[2]

		-- fully grown ?
		if not minetest.registered_nodes[plant..(numb + 1)] then return end
		
		-- cocoa pod on jungle tree ?
		if plant ~= "farming:cocoa_" then

			-- growing on wet soil ?
			if minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name ~= "farming:soil_wet" then return end
		end

		-- enough light ?
		if minetest.get_node_light(pos) < 13 then return end

		-- grow
		minetest.set_node(pos, {name=plant..(numb + 1)})

	end
})

-- Function to register plants (for compatibility)

farming.register_plant = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	if not def.description then
		def.description = "Seed"
	end
	if not def.inventory_image then
		def.inventory_image = "unknown_item.png"
	end
	if not def.steps then
		return nil
	end

	-- Register seed
	minetest.register_node(":" .. mname .. ":seed_" .. pname, {
		description = def.description,
		tiles = {def.inventory_image},
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		drawtype = "signlike",
		groups = {seed = 1, snappy = 3, attached_node = 1},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
		on_place = function(itemstack, placer, pointed_thing)
			return farming.place_seed(itemstack, placer, pointed_thing, mname .. ":"..pname.."_1")
		end
	})

	-- Register harvest
	minetest.register_craftitem(":" .. mname .. ":" .. pname, {
		description = pname:gsub("^%l", string.upper),
		inventory_image = mname .. "_" .. pname .. ".png",
	})

	-- Register growing steps
	for i=1,def.steps do
		local drop = {
			items = {
				{items = {mname .. ":" .. pname}, rarity = 9 - i},
				{items = {mname .. ":" .. pname}, rarity= 18 - i * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = 9 - i},
				{items = {mname .. ":seed_" .. pname}, rarity = 18 - i * 2},
			}
		}
		
		local g = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, growing = 1}
		-- Last step doesn't need growing=1 so Abm never has to check these
		if i == def.steps then
			g = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
		end

		minetest.register_node(mname .. ":" .. pname .. "_" .. i, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			walkable = false,
			buildable_to = true,
			is_ground_content = true,
			drop = drop,
			selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},},
			groups = g,
			sounds = default.node_sound_leaves_defaults(),
		})
	end

	-- Return info
	local r = {seed = mname .. ":seed_" .. pname, harvest = mname .. ":" .. pname}
	return r
end

--[[ Cotton (example, is already registered in cotton.lua)
farming.register_plant("farming:cotton", {
	description = "Cotton seed",
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
})
--]]
