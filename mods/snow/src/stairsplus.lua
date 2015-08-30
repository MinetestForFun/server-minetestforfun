-- ===============================================================================
-- StairsPlus Bonus!
-- ===============================================================================
--[[
This section of code that makes blocks compatible with MoreBlocks' circular saw.
I've added circular saw compatible code for default snowblocks and ice. :D
A big thanks to Calinou and ShadowNinja for making this possible.

Because StairsPlus creates partial blocks, it didn't seem quite right that the
smallest microblocks would produce a full-sized water_source node when melted.
So I toned them down a bit by changing their melt to a temporary,
2-second water_source. See "melts" in abms.lua file for the various intensities.

___...::: ATTENTION MINETEST SERVER OPERATORS :::...___
You may or may not have noticed in your server logs that MoreBlocks stairs/slabs/
panels/microblocks are not recorded as to when, who, what, and where. This is
important information when trying to determine if a player who dug these blocks
is the owner (the player who placed the block) or is a griefer stealing the block.

There is an option that will log when these blocks are placed but it comes at the
cost of losing the auto-rotation of those blocks when placed. They can still be
rotated with a screwdriver but if screwdrivers are disabled on your server your
players won't be able to position MoreBlocks, saw-made blocks.

To enable logging the placement of these blocks, un-comment these lines:

--on_place = minetest.item_place

There is one in each of the "stairsplus.register_all" sections.

~ LazyJ
-- ===============================================================================
--]]

--snow_stairsplus = {}

-- Check for infinite stacks

--if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
--	snow_stairsplus.expect_infinite_stacks = false
--else
--	snow_stairsplus.expect_infinite_stacks = true
--end






-- First, let's run a check to see if MoreBlocks is installed; we're going to need it for the
-- next section of stairsplus stuff. ~LazyJ

if (minetest.get_modpath("moreblocks"))
and rawget(_G, "stairsplus")

-- 'If' MoreBlocks was found and stairsplus is available, well, 'then' go ahead with this next part:

then

--[[  Leave commented out - For reference only. ~ LazyJ
function stairsplus.register_all(modname, subname, recipeitem, fields)
		--stairsplus.register_stair_slab_panel_micro(modname, subname, recipeitem, fields)
		stairsplus:register_stair(modname, subname, recipeitem, fields)
		stairsplus:register_slab(modname, subname, recipeitem, fields)
		stairsplus:register_panel(modname, subname, recipeitem, fields)
		stairsplus:register_micro(modname, subname, recipeitem, fields)
end
  Leave commented out
--]]



-- Leave commented out. Another, possible piece of the puzzle, as to why the placement of
-- stairsplus nodes aren't recorded in the logs. Shelved till I can concentrate on it again.
-- ~ LazyJ

--ItemStack({name=nodename}):get_definition()
--itemstack ={}
--[[
		local def = itemstack:get_definition()
		function minetest.item_place_node(itemstack, placer, pointed_thing, param2)
			minetest.log("action", placer:get_player_name() .. " places node "
			.. def.name .. " at " .. minetest.pos_to_string(place_to))
		end
 Leave commented out
--]]


-- Leave commented out
--[[   FIGURE OUT HOW TO GET THE SLABS TO SHOW UP IN THE LOG ON PLACEMENT


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
		end
 Leave commented out
--]]



--[[
Below, in the "groups" line there is a "melts" category. Back in the ABMs lua file, melting
code, melts=1 will produce a water_source when the full-sized snow/ice block is melted making
a big, watery mess. melts=2 will produce a water_source only for a moment, then it changes back
to water_flowing and then dries-up and disappears. I gave these stairs/slabs/panels/microblocks
a melts value of 2 instead of 1 because they are not full blocks.

~ LazyJ
--]]

-- Default snowblock and ice stairs/slabs/panels/microblocks.

	local ndef = minetest.registered_nodes["default:ice"]
	local groups = {}
	for k, v in pairs(ndef.groups) do groups[k] = v end

	stairsplus:register_all("moreblocks", "ice", "default:ice", {
		description = ndef.description,
		paramtype2 = "facedir",
		-- Added "icemaker=1" in groups. This ties into the freezing
		-- function in the ABMs.lua file. ~ LazyJ
		groups = {cracky=1, crumbly=1, choppy=1, oddly_breakable_by_hand=1, melts=2, icemaker=1},
		sounds = default.node_sound_glass_defaults(),
		tiles = ndef.tiles,
		-- Because of the "use_texture_alpha" line, that gives ice transparency, I couldn't combine
		-- default ice and default snowblocks in a list like MoreBlocks does. ~ LazyJ
		use_texture_alpha = true,
		sunlight_propagates = true,
		-- This "on_place" line makes placing these nodes recorded in the logs.
		-- Useful for investigating griefings and determining ownership
		-- BUT these nodes will nolonger auto-rotate into position. ~ LazyJ

		--on_place = minetest.item_place,

 		-- The "on_construct" part below, thinking in terms of layers, dirt_with_snow could
 		-- also double as dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ
		on_construct = function(pos)
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "default:dirt_with_grass"
			or minetest.get_node(pos).name == "default:dirt" then
				minetest.set_node(pos, {name="default:dirt_with_snow"})
			end
		end
	})
--end


	local ndef = minetest.registered_nodes["default:snowblock"]
	local groups = {}
	for k, v in pairs(ndef.groups) do groups[k] = v end

	stairsplus:register_all("moreblocks", "snowblock", "default:snowblock", {
		description = ndef.description,
		paramtype2 = "facedir",
		-- Added "icemaker=1" in groups. This ties into the freezing function
		-- in the ABMs.lua file. ~ LazyJ
		groups = {cracky=3, crumbly=3, choppy=3, oddly_breakable_by_hand=3, melts=2, icemaker=1},
		tiles = ndef.tiles,
		sunlight_propagates = true,
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_snow_footstep", gain=0.25},
			dig = {name="default_dig_crumbly", gain=0.4},
			dug = {name="default_snow_footstep", gain=0.75},
			place = {name="default_place_node", gain=1.0}
		}),
		-- This "on_place" line makes placing these nodes recorded in the logs.
		-- Useful for investigating griefings and determining ownership
		-- BUT these nodes will nolonger auto-rotate into position. ~ LazyJ

		--on_place = minetest.item_place,

 		-- The "on_construct" part below, thinking in terms of layers,
 		-- dirt_with_snow could also double as dirt_with_frost
 		-- which adds subtlety to the winterscape. ~ LazyJ
		on_construct = function(pos)
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "default:dirt_with_grass"
			or minetest.get_node(pos).name == "default:dirt" then
				minetest.set_node(pos, {name="default:dirt_with_snow"})
			end
		end
	})



-- Snow stairs/slabs/panels/microblocks.

local snow_nodes = {
	"snow_brick",
	"snow_cobble",
}

for _, name in pairs(snow_nodes) do
	local nodename = "snow:"..name
	local ndef = minetest.registered_nodes[nodename]
	local groups = {}
	for k, v in pairs(ndef.groups) do groups[k] = v end

	stairsplus:register_all("moreblocks", name, nodename, {
		description = ndef.description,
		drop = ndef.drop,
		groups = {cracky=2, crumbly=2, choppy=2, oddly_breakable_by_hand=2, melts=2, icemaker=1},
		tiles = ndef.tiles,
		--paramtype2 = "facedir",
		sunlight_propagates = true,
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_snow_footstep", gain=0.25},
			dig = {name="default_dig_crumbly", gain=0.4},
			dug = {name="default_snow_footstep", gain=0.75},
			place = {name="default_place_node", gain=1.0}
		}),
		-- This "on_place" line makes placing these nodes recorded in the logs.
		-- Useful for investigating griefings and determining ownership
		-- BUT these nodes will nolonger auto-rotate into position. ~ LazyJ

		--on_place = minetest.item_place,


-- Some attempts to have both, the recording in the logs of the placing of
-- the stairplus stuff *and* have the auto-rotation work. No luck yet.
-- ~ LazyJ

		--[[
		on_place = function (i, p, t)
			minetest.item_place(i, p, t, 0)
			minetest.rotate_node(i, p, t)
		end,
		--]]
		--[[
		on_place = function (i, p, t)
			minetest.rotate_node(i, p, t, 0)
			minetest.item_place(i, p, t)
		end,
		--]]



-- Picking up were we left off... ~ LazyJ

 		-- The "on_construct" part below, thinking in terms of layers, dirt_with_snow could
 		-- also double as dirt_with_frost which adds subtlety to the winterscape. ~ LazyJ
		on_construct = function(pos)
			pos.y = pos.y - 1
			if minetest.get_node(pos).name == "default:dirt_with_grass"
				or minetest.get_node(pos).name == "default:dirt"
				then minetest.set_node(pos, {name="default:dirt_with_snow"})
			end
			-- Some ideas I've tried. Leaving for future reference till I can figure out a workable solution. ~ LazyJ
			--minetest.log("action", sender:get_player_name().." places" ..minetest.get_node(pos).name.. "at" ..minetest.pos_to_string(pos))
			--minetest.log("action", minetest.get_player_name().." places" ..minetest.get_node(pos).name.. "at" ..minetest.pos_to_string(pos))
			--minetest.log("action", "BINGO places "..minetest.get_name().." at "..minetest.pos_to_string(pos))
			--minetest.log("action", minetest.get_player_name().." places "..minetest.get_name().." at "..minetest.pos_to_string(pos))
			--minetest.log("action", placer:get_player_name().." places moreblocks-something at "..minetest.pos_to_string(pos))
			--minetest.log("action", " BINGO places "..minetest.get_pointed_thing().." at "..minetest.pos_to_string(pos))
			--minetest.log("action", "BINGO places moreblocks"..ndef.." at "..minetest.pos_to_string(pos))
			--minetest.log("action", "A pine sapling grows into a Christmas tree at "..minetest.pos_to_string(pos))
			--return minetest.item_place(itemstack, placer, pointed_thing, param2)
			--return minetest.item_place(itemstack, pointed_thing, param2)
		end,
	})
end

else  -- from clear up at the top, the MoreBlocks check. "Else", if MoreBlocks wasn't found, skip
		-- down to here, "return" nothing and "end" this script. ~ LazyJ
return
end
