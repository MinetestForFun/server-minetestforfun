-- Based on
-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.


-- ADD CHECK FOR MOREBLOCKS/SKIP IF NOT FOUND CODE STUFF HERE


-- what of the recipeitem can be copied
local recipe_values = {
	"description", "tiles", "groups", "sounds", "use_texture_alpha", "sunlight_propagates",
	"freezemelt", "liquidtype", "sunlight_propagates",
	"stair_desc", "slab_desc"
}

local stairdef = {
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = true,
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dig = {name="default_dig_crumbly", gain=0.4},
		dug = {name="default_snow_footstep", gain=0.75},
		place = {name="default_place_node", gain=1.0}
	}),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.5, 0, 0, 0.5, 0.5, 0.5},
		},
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		local p0 = pointed_thing.under
		local p1 = pointed_thing.above
		local param2 = 0

		local placer_pos = placer:getpos()
		if placer_pos then
			local dir = {
				x = p1.x - placer_pos.x,
				y = p1.y - placer_pos.y,
				z = p1.z - placer_pos.z
			}
			param2 = minetest.dir_to_facedir(dir)
		end

		if p0.y-1 == p1.y then
			param2 = param2 + 20
			if param2 == 21 then
				param2 = 23
			elseif param2 == 23 then
				param2 = 21
			end
		end

		return minetest.item_place(itemstack, placer, pointed_thing, param2)
	end,

	on_construct = function(pos)
		pos.y = pos.y - 1
		local node = minetest.get_node(pos)
		if node.name == "default:dirt_with_grass"
			-- Thinking in terms of layers, dirt_with_snow could also double as
			-- dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ, 2014_04_04
		or node.name == "default:dirt" then
			node.name = "default:dirt_with_snow"
			minetest.set_node(pos, node)
		end
	end
}

-- Node will be called snow:stair_<subname>
local function register_stair(subname, recipeitem, newdef)
	local def = table.copy(stairdef)


	for n,i in pairs(newdef) do
		def[n] = i
	end

	local name = "snow:stair_" .. subname
	minetest.register_node(name, def)
--[[
	-- for replace ABM
	minetest.register_node("snow:stair_" .. subname.."upside_down", {
		replace_name = "snow:stair_" .. subname,
		groups = {slabs_replace=1},
	})
--]]
	minetest.register_craft({
		output = name .. " 6",
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe
	minetest.register_craft({
		output = name .. " 6",
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end


local slabdef = table.copy(stairdef)
slabdef.node_box = {
	type = "fixed",
	fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
}
slabdef.on_place = nil

-- Node will be called snow:slab_<subname>
local function register_slab(subname, recipeitem, newdef)
	local def = table.copy(slabdef)

	local name = "snow:slab_" .. subname
	def.on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end

		-- If it's being placed on an another similar one, replace it with
		-- a full block
		local slabpos, slabnode
		local p0 = pointed_thing.under
		local p1 = pointed_thing.above
		local n0 = minetest.get_node(p0)
		local n1 = minetest.get_node(p1)

		local n0_is_upside_down = (n0.name == name and
				n0.param2 >= 20)

		if n0.name == name
		and not n0_is_upside_down
		and p0.y+1 == p1.y then
			slabpos = p0
			slabnode = n0
		elseif n1.name == name then
			slabpos = p1
			slabnode = n1
		end
		if slabpos then
			-- Remove the slab at slabpos
			minetest.remove_node(slabpos)
			-- Make a fake stack of a single item and try to place it
			local fakestack = ItemStack(recipeitem)
			fakestack:set_count(itemstack:get_count())

			pointed_thing.above = slabpos
			local success
			fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
			-- If the item was taken from the fake stack, decrement original
			if success then
				itemstack:set_count(fakestack:get_count())
			-- Else put old node back
			else
				minetest.set_node(slabpos, slabnode)
			end
			return itemstack
		end

		local param2
		-- Upside down slabs
		if p0.y-1 == p1.y then
			-- Turn into full block if pointing at a existing slab
			if n0_is_upside_down  then
				-- Remove the slab at the position of the slab
				minetest.remove_node(p0)
				-- Make a fake stack of a single item and try to place it
				local fakestack = ItemStack(recipeitem)
				fakestack:set_count(itemstack:get_count())

				pointed_thing.above = p0
				local success
				fakestack, success = minetest.item_place(fakestack, placer, pointed_thing)
				-- If the item was taken from the fake stack, decrement original
				if success then
					itemstack:set_count(fakestack:get_count())
				-- Else put old node back
				else
					minetest.set_node(p0, n0)
				end
				return itemstack
			end

			-- Place upside down slab
			param2 = 20
		elseif n0_is_upside_down
		and p0.y+1 ~= p1.y then
			-- If pointing at the side of a upside down slab
			param2 = 20
		end

		return minetest.item_place(itemstack, placer, pointed_thing, param2)
	end

	for n,i in pairs(newdef) do
		def[n] = i
	end

	minetest.register_node(name, def)
--[[
	-- for replace ABM
	minetest.register_node("snow:slab_" .. subname.."upside_down", {
		replace_name = "snow:slab_"..subname,
		groups = {slabs_replace=1},
	})
--]]

	minetest.register_craft({
		output = name .. " 6",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})




end
--[[
-- Replace old "upside_down" nodes with new param2 versions
minetest.register_abm({
	nodenames = {"group:slabs_replace"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		node.name = minetest.registered_nodes[node.name].replace_name
		node.param2 = node.param2 + 20
		if node.param2 == 21 then
			node.param2 = 23
		elseif node.param2 == 23 then
			node.param2 = 21
		end
		minetest.set_node(pos, node)
	end,
})
--]]



-- Snow stairs and slabs require extra definitions because of their extra
-- features (freezing, melting, and how they change dirt and dirt_with_grass). ~ LazyJ

-- Nodes will be called snow:{stair,slab}_<subname>
local function register_stair_and_slab(subname, recipeitem, def)
	local recipedef = minetest.registered_nodes[recipeitem]
	for _,i in pairs(recipe_values) do
		if def[i] == nil
		and recipedef[i] ~= nil then
			def[i] = recipedef[i]
		end
	end
	local groups = table.copy(def.groups)
	groups.cooks_into_ice = nil
	if groups.melts then
		groups.melts = math.min(groups.melts+1, 3)
	end
	def.groups = groups

	local stair_desc = def.stair_desc
	def.stair_desc = nil
	local slab_desc = def.slab_desc
	def.slab_desc = nil

	def.description = stair_desc
	register_stair(subname, recipeitem, def)

	def.description = slab_desc
	register_slab(subname, recipeitem, def)
end


list_of_snow_stuff = {
	--{"row[1] = first item in row",
	-- "row[2] = second item in row",
	-- "row[3] = third item in row", and so on, and so on...}, ~ LazyJ
	{"ice", "default:ice", "Ice Stairs", "Ice Slabs"},
	{"snowblock", "default:snowblock", "Snowblock Stairs", "Snowblock Slabs"},
	{"snow_cobble", "snow:snow_cobble", "Snow Cobble Stairs", "Snow Cobble Slabs"},
	{"snow_brick", "snow:snow_brick", "Snow Brick Stair", "Snow Brick Slab"},
	{"ice_brick", "snow:ice_brick", "Ice Brick Stair", "Ice Brick Slab"},
}

for _, row in pairs(list_of_snow_stuff) do
	register_stair_and_slab(row[1], row[2], {
		stair_desc = row[3],
		slab_desc = row[4],
	})
end
