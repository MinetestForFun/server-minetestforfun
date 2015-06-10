-- Based on
-- Minetest 0.4 mod: stairs
-- See README.txt for licensing and other information.


-- ADD CHECK FOR MOREBLOCKS/SKIP IF NOT FOUND CODE STUFF HERE





snow_stairs = {}  -- This is a little trick. Without it Minetest will complain
			-- "attempt to index global 'snow' (a nil value)" and
			-- refuse to load. So a value without definition "={}"is assigned to snow.

-- Node will be called snow:stair_<subname>
function snow_stairs.register_stair(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node("snow:stair_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
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
				if minetest.get_node(pos).name == "default:dirt_with_grass"
					-- Thinking in terms of layers, dirt_with_snow could also double as
					-- dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ, 2014_04_04
					or minetest.get_node(pos).name == "default:dirt" then
					minetest.set_node(pos, {name="default:dirt_with_snow"})
				end
			end
	})
--[[
	-- for replace ABM
	minetest.register_node("snow:stair_" .. subname.."upside_down", {
		replace_name = "snow:stair_" .. subname,
		groups = {slabs_replace=1},
	})
--]]
	minetest.register_craft({
		output = 'snow:stair_' .. subname .. ' 6',
		recipe = {
			{recipeitem, "", ""},
			{recipeitem, recipeitem, ""},
			{recipeitem, recipeitem, recipeitem},
		},
	})

	-- Flipped recipe
	minetest.register_craft({
		output = 'snow:stair_' .. subname .. ' 6',
		recipe = {
			{"", "", recipeitem},
			{"", recipeitem, recipeitem},
			{recipeitem, recipeitem, recipeitem},
		},
	})
end

-- Node will be called snow:slab_<subname>
function snow_stairs.register_slab(subname, recipeitem, groups, images, description, sounds)
	minetest.register_node("snow:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = groups,
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_snow_footstep", gain=0.25},
			dig = {name="default_dig_crumbly", gain=0.4},
			dug = {name="default_snow_footstep", gain=0.75},
			place = {name="default_place_node", gain=1.0}
		}),
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			-- If it's being placed on an another similar one, replace it with
			-- a full block
			local slabpos = nil
			local slabnode = nil
			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local n0 = minetest.get_node(p0)
			local n1 = minetest.get_node(p1)
			local param2 = 0

			local n0_is_upside_down = (n0.name == "snow:slab_" .. subname and
					n0.param2 >= 20)

			if n0.name == "snow:slab_" .. subname and not n0_is_upside_down and p0.y+1 == p1.y then
				slabpos = p0
				slabnode = n0
			elseif n1.name == "snow:slab_" .. subname then
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
			end

			-- If pointing at the side of a upside down slab
			if n0_is_upside_down and p0.y+1 ~= p1.y then
				param2 = 20
			end

			return minetest.item_place(itemstack, placer, pointed_thing, param2)
		end,

		on_construct = function(pos)
				pos.y = pos.y - 1
				if minetest.get_node(pos).name == "default:dirt_with_grass"
					-- Thinking in terms of layers, dirt_with_snow could also double as
					-- dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ, 2014_04_04
					or minetest.get_node(pos).name == "default:dirt" then
					minetest.set_node(pos, {name="default:dirt_with_snow"})
				end
			end

	})
--[[
	-- for replace ABM
	minetest.register_node("snow:slab_" .. subname.."upside_down", {
		replace_name = "snow:slab_"..subname,
		groups = {slabs_replace=1},
	})
--]]

	minetest.register_craft({
		output = 'snow:slab_' .. subname .. ' 6',
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
function snow_stairs.register_stair_and_slab(subname, recipeitem, groups, images, desc_stair, desc_slab, freezemelt, liquidtype, paramtype, sunlight_propagates)
	snow_stairs.register_stair(subname, recipeitem, groups, images, desc_stair, freezemelt, liquidtype, paramtype, sunlight_propagates)
	snow_stairs.register_slab(subname, recipeitem, groups, images, desc_slab, freezemelt, liquidtype, paramtype, sunlight_propagates)
end


list_of_snow_stuff = {
	--{"row[1] = first item in row",
	-- "row[2] = second item in row",
	-- "row[3] = third item in row", and so on, and so on...}, ~ LazyJ
	{"ice", "default:ice", "default_ice.png", "Ice Stairs", "Ice Slabs"},
	{"snowblock", "default:snowblock", "default_snow.png", "Snowblock Stairs", "Snowblock Slabs"},
	{"snow_cobble", "snow:snow_cobble", "snow_snow_cobble.png", "Snow Cobble Stairs", "Snow Cobble Slabs"},
	{"snow_brick", "snow:snow_brick", "snow_snow_brick.png", "Snow Brick Stair", "Snow Brick Slab"},
}

for _, row in ipairs(list_of_snow_stuff) do
	local snow_subname = row[1]
	local snow_recipeitem = row[2]
	local snow_images = row[3]
	local snow_desc_stair = row[4]
	local snow_desc_slab = row[5]




	snow_stairs.register_stair_and_slab(snow_subname, snow_recipeitem,
			{cracky=2, crumbly=2, choppy=2, oddly_breakable_by_hand=2, melts=1, icemaker=1},
			{snow_images},
			snow_desc_stair,
			snow_desc_slab,
			"default:water_source",
			"none",
			"light",
			true
			)

end  -- End the "list of snow stuff" part of the above section. ~ LazyJ


-- Snow stairs and slabs should be easier to break than the more dense and
-- manufactured, other snow-type nodes in the list above. ~ lazyJ
minetest.override_item("snow:stair_snowblock", {
		groups = {cracky=3, crumbly=3, choppy=3, oddly_breakable_by_hand=3, melts=2, icemaker=1},
})

minetest.override_item("snow:slab_snowblock", {
		groups = {cracky=3, crumbly=3, choppy=3, oddly_breakable_by_hand=3, melts=2, icemaker=1},
})



-- Everything above is made of snow and uses snow sounds, ice, however, should sound more like glass
-- and be harder to dig. ~ LazyJ
minetest.override_item("snow:stair_ice", {
		groups = {cracky=1, crumbly=1, choppy=1, oddly_breakable_by_hand=1, melts=2, icemaker=1},
		use_texture_alpha = true,
		sounds = default.node_sound_glass_defaults(),
})

minetest.override_item("snow:slab_ice", {
		groups = {cracky=1, crumbly=1, choppy=1, oddly_breakable_by_hand=1, melts=2, icemaker=1},
		use_texture_alpha = true,
		sounds = default.node_sound_glass_defaults(),
})
