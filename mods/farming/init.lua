--[[
	Minetest Farming Redo Mod 1.09 (19th September 2014)
	by TenPlus1
]]

farming = {}
farming.mod = "redo"
farming.hoe_on_use = default.hoe_on_use

dofile(minetest.get_modpath("farming").."/soil.lua")
dofile(minetest.get_modpath("farming").."/hoes.lua")
dofile(minetest.get_modpath("farming").."/grass.lua")
dofile(minetest.get_modpath("farming").."/wheat.lua")
dofile(minetest.get_modpath("farming").."/cotton.lua")
dofile(minetest.get_modpath("farming").."/carrot.lua")
dofile(minetest.get_modpath("farming").."/potato.lua")
dofile(minetest.get_modpath("farming").."/tomato.lua")
dofile(minetest.get_modpath("farming").."/cucumber.lua")
dofile(minetest.get_modpath("farming").."/corn.lua")
dofile(minetest.get_modpath("farming").."/coffee.lua")
dofile(minetest.get_modpath("farming").."/melon.lua")
dofile(minetest.get_modpath("farming").."/sugar.lua")
dofile(minetest.get_modpath("farming").."/pumpkin.lua")
dofile(minetest.get_modpath("farming").."/cocoa.lua")
dofile(minetest.get_modpath("farming").."/raspberry.lua")
dofile(minetest.get_modpath("farming").."/rhubarb.lua")
dofile(minetest.get_modpath("farming").."/donut.lua") -- sweet treat
dofile(minetest.get_modpath("farming").."/mapgen.lua")
dofile(minetest.get_modpath("farming").."/compatibility.lua") -- Farming Plus compatibility

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
	or minetest.get_item_group(under.name, "soil") < 2 then
		return
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name=plantname})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

-- Single ABM Handles Growing of All Plants

minetest.register_abm({
	nodenames = {"group:growing"},
	neighbors = {"farming:soil_wet", "default:jungletree"},
	interval = 60,
	chance = 2,

	action = function(pos, node)

		-- get node type (e.g. farming:wheat_1)

		local data = nil
		data = string.split(node.name, '_', 2)
		local plant = data[1].."_"
		local numb = data[2]

		-- check if fully grown
		if not minetest.registered_nodes[plant..(numb + 1)] then return end
		
		-- Check for Cocoa Pod
		if plant == "farming:cocoa_" and minetest.find_node_near(pos, 1, {"default:jungletree"}) then
		
		else
		
			-- check if on wet soil
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet" then return end
			pos.y = pos.y+1
		
			-- check light
			if minetest.get_node_light(pos) < 13 then return end
		
		end
		
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
