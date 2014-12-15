-----------------------------------------------------------------------------------------------
local title		= "Fishing - Mossmanikin's version"
local version 	= "0.2.3"
local mname		= "fishing"
-----------------------------------------------------------------------------------------------
-- original by wulfsdad (http://forum.minetest.net/viewtopic.php?id=4375)
-- this version by Mossmanikin (https://forum.minetest.net/viewtopic.php?id=6480)
-- License (code & textures): 	WTFPL
-- Contains code from: 		animal_clownfish, animal_fish_blue_white, fishing (original), stoneage
-- Looked at code from:		default, farming
-- Dependencies: 			default
-- Supports:				animal_clownfish, animal_fish_blue_white, animal_rat, mobs
-----------------------------------------------------------------------------------------------

-- todo: 	item wear 											done
--			automatic re-baiting option 						done (but not optional)
--			different types of fish, 							done, but not finished
--			add sound											done
--			bobber												done
--			change rainworms filling inv & make 'em disappear 	done

--			placable fishing rod for decoration					done
--			make bobber move slowly while fish on hook			done
-- 			catch bigger fish with smaller						done, but not finished
--			change color of bobber when fish on hook			done

-----------------------------------------------------------------------------------------------

dofile(minetest.get_modpath("fishing").."/settings.txt")
dofile(minetest.get_modpath("fishing").."/bobber.lua")
dofile(minetest.get_modpath("fishing").."/bobber_shark.lua")
dofile(minetest.get_modpath("fishing").."/crafting.lua")
dofile(minetest.get_modpath("fishing").."/fishes.lua")
dofile(minetest.get_modpath("fishing").."/worm.lua")
dofile(minetest.get_modpath("fishing").."/trophies.lua")

-----------------------------------------------------------------------------------------------
-- Fishing Pole
-----------------------------------------------------------------------------------------------

local function rod_wear(itemstack, user, pointed_thing, uses)
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

minetest.register_tool("fishing:pole", {

	description = "Fishing Pole",
	groups = {},
	inventory_image = "fishing_pole.png",
	wield_image = "fishing_pole.png^[transformFXR270",
	stack_max = 1,
	liquids_pointable = true,
	on_use = function (itemstack, user, pointed_thing)
		if pointed_thing and pointed_thing.under then
			local pt = pointed_thing
			local node = minetest.get_node(pt.under)
			if string.find(node.name, "default:water") then
				local player = user:get_player_name()
				local inv = user:get_inventory()
				if inv:get_stack("main", user:get_wield_index()+1):get_name() == "fishing:bait_worm" then
					if not minetest.setting_getbool("creative_mode") then
						inv:remove_item("main", "fishing:bait_worm")
					end
					minetest.sound_play("fishing_bobber2", {
						pos = pt.under,
						gain = 0.5,
					})
					minetest.add_entity({interval = 1,x=pt.under.x, y=pt.under.y+(45/64), z=pt.under.z}, "fishing:bobber_entity")
					
					if WEAR_OUT == true 
					and not minetest.setting_getbool("creative_mode") then
						return rod_wear(itemstack, user, pointed_thing, 30)	
					else
						return {name="fishing:pole", count=1, wear=0, metadata=""}
					end
				end
				if inv:get_stack("main", user:get_wield_index()+1):get_name() == "fishing:fish_raw" then
					if not minetest.setting_getbool("creative_mode") then
						inv:remove_item("main", "fishing:fish_raw")
					end
					minetest.sound_play("fishing_bobber2", {
						pos = pt.under,
						gain = 0.5,
					})
					minetest.add_entity({interval = 1,x=pt.under.x, y=pt.under.y+(45/64), z=pt.under.z}, "fishing:bobber_entity_shark")
					
					if WEAR_OUT == true 
					and not minetest.setting_getbool("creative_mode") then
						return rod_wear(itemstack, user, pointed_thing, 30)	
					else
						return {name="fishing:pole", count=1, wear=0, metadata=""}
					end
				end
			end
		end
		return nil
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		if minetest.get_node(pt.under).name~="default:water_source" and minetest.get_node(pt.under).name~="default:water_flowing" then
			local wear = itemstack:get_wear()
			--print (wear)
			local direction = minetest.dir_to_facedir(placer:get_look_dir())
			--local meta1 = minetest.get_meta(pt.under)
			local meta = minetest.get_meta(pt.above)
			minetest.set_node(pt.above, {name="fishing:pole_deco", param2=direction})
			--meta1:set_int("wear", wear)
			meta:set_int("wear", wear)
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
		end
		return itemstack
	end,
})

if SIMPLE_DECO_FISHING_POLE == true then
minetest.register_node("fishing:pole_deco", {
	description = "Fishing Pole",
	inventory_image = "fishing_pole.png",
	wield_image = "fishing_pole.png^[transformFXR270",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"fishing_pole_simple.png",
		"fishing_pole_simple.png",
		"fishing_pole_simple.png",
		"fishing_pole_simple.png^[transformFX",
	},
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ 0     , -1/2   ,  0     , 0      ,  1/2   ,  1   },
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/16  , -1/2   ,  0     , 1/16   ,  1/2   ,  1   },
		}
	},
	sounds = default.node_sound_wood_defaults(),
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			local meta = minetest.env:get_meta(pos)
			local wear_out = meta:get_int("wear")
			digger:get_inventory():add_item("main", {name="fishing:pole", count=1, wear=wear_out, metadata=""})
		end
		minetest.remove_node(pos)
	end,
})

else
minetest.register_node("fishing:pole_deco", {
	description = "Fishing Pole",
	inventory_image = "fishing_pole.png",
	wield_image = "fishing_pole.png^[transformFXR270",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"fishing_pole_top.png",
		"fishing_pole_bottom.png",
		"fishing_pole_deco.png", -- right
		"fishing_pole_deco.png^[transformFX", -- left
		"fishing_pole_back.png",
		"fishing_pole_front.png"
	},
	node_box = {
		type = "fixed",
--			{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/32  , -1/16  , 14/16  , 1/32   ,  6/16  , 15/16},
			{-1/32  , -3/16  , 13/16  , 1/32   , -1/16  , 14/16},
			{-1/32  , -4/16  , 12/16  , 1/32   , -3/16  , 13/16},
			{-1/32  , -5/16  , 11/16  , 1/32   , -4/16  , 12/16},
			{-1/32  , -6/16  ,  9/16  , 1/32   , -5/16  , 11/16},
			{-1/32  , -5/16  ,  9/16  , 1/32   , -4/16  , 10/16},
			-- stick
			{-1/32  ,  6/16  , 12/16  , 1/32   ,  7/16  , 15/16}, -- top
			{-1/32  ,  5/16  , 11/16  , 1/32   ,  7/16  , 12/16},
			{-1/32  ,  5/16  , 10/16  , 1/32   ,  6/16  , 11/16},
			{-1/32  ,  4/16  ,  9/16  , 1/32   ,  6/16  , 10/16},
			{-1/32  ,  3/16  ,  8/16  , 1/32   ,  5/16  ,  9/16},
			{-1/32  ,  2/16  ,  7/16  , 1/32   ,  4/16  ,  8/16},
			{-1/32  ,  1/16  ,  6/16  , 1/32   ,  3/16  ,  7/16},
			{-1/32  ,  0     ,  5/16  , 1/32   ,  2/16  ,  6/16},
			{-1/32  , -2/16  ,  4/16  , 1/32   ,  1/16  ,  5/16},
			{-1/32  , -3/16  ,  3/16  , 1/32   ,  0     ,  4/16},
			{-1/32  , -5/16  ,  2/16  , 1/32   , -1/16  ,  3/16},
			{-1/32  , -7/16  ,  1/16  , 1/32   , -3/16  ,  2/16},
			{-1/32  , -1/2   ,  0     , 1/32   , -5/16  ,  1/16}, -- bottom
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/16  , -1/2   ,  0     , 1/16   ,  1/2   ,  1   },
		}
	},
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_wood_defaults(),
	on_dig = function(pos, node, digger)
		if digger:is_player() and digger:get_inventory() then
			local meta = minetest.get_meta(pos)
			local wear_out = meta:get_int("wear")
			digger:get_inventory():add_item("main", {name="fishing:pole", count=1, wear=wear_out, metadata=""})
		end
		minetest.remove_node(pos)
	end,
})

end
-----------------------------------------------------------------------------------------------
-- GETTING WORMS
-----------------------------------------------------------------------------------------------
-- get worms from digging in dirt:
if NEW_WORM_SOURCE == false then

minetest.register_node(":default:dirt", {
	description = "Dirt",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
 	after_dig_node = function (pos, oldnode, oldmetadata, digger)
 		if math.random(1, 100) < WORM_CHANCE then
			local tool_in_use = digger:get_wielded_item():get_name()
			if tool_in_use == "" or tool_in_use == "default:dirt" then
				if WORM_IS_MOB == true then
					minetest.add_entity({x = pos.x, y = pos.y+0.4, z = pos.z}, "fishing:bait_worm_entity")
				else
					local inv = digger:get_inventory()
					if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
						inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
					end
				end
 			end
 		end
 	end,
})

else
-- get worms from digging with hoes:

-- turns nodes with group soil=1 into soil
local function hoe_on_use(itemstack, user, pointed_thing, uses)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return
	end
	if pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local p = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
	local above = minetest.get_node(p)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end
	
	-- check if pointing at dirt
	if minetest.get_item_group(under.name, "soil") ~= 1 then
		return
	end
	
	-- turn the node into soil, play sound, get worm and wear out item
	minetest.set_node(pt.under, {name="farming:soil"})
	minetest.sound_play("default_dig_crumbly", {
		pos = pt.under,
		gain = 0.5,
	})
	
	if math.random(1, 100) < WORM_CHANCE then
		if WORM_IS_MOB == true then
			minetest.add_entity({x=pt.under.x, y=pt.under.y+0.4, z=pt.under.z}, "fishing:bait_worm_entity")
		else
			local inv = user:get_inventory()
			if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
				inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
			end
		end
	end
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

-- didn't change the hoes, just here because hoe_on_use is local
minetest.register_tool(":farming:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "farming_tool_woodhoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 30)
	end,
})
minetest.register_tool(":farming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_tool_stonehoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 90)
	end,
})
minetest.register_tool(":farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_tool_steelhoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 200)
	end,
})
minetest.register_tool(":farming:hoe_bronze", {
	description = "Bronze Hoe",
	inventory_image = "farming_tool_bronzehoe.png",
	on_use = function(itemstack, user, pointed_thing)
		return hoe_on_use(itemstack, user, pointed_thing, 220)
	end,
})

end
-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------