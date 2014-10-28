MAPTOOLS_CREATIVE = 1 -- Set this to 0 if you want Map Tools nodes and items to appear in the creative inventory.

-- Load translation library if intllib is installed

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
	else
	S = function ( s ) return s end
end

dofile(minetest.get_modpath("maptools").."/aliases.lua")
dofile(minetest.get_modpath("maptools").."/default_nodes.lua")

--[[
Map Tools by Calinou
Licensed under the zlib license for code and CC BY-SA 3.0 for textures, see LICENSE.txt for info.
--]]

-- Redefine cloud so that the admin pickaxe can mine it.

minetest.register_node(":default:cloud", {
	description = S("Cloud"),
	tiles = {"default_cloud.png"},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	sounds = default.node_sound_defaults(),
})

-- Items

minetest.register_craft({
	type = "fuel",
	recipe = "maptools:infinitefuel",
	burntime = 1000000000,
})

-- Nodes

minetest.register_node("maptools:black", {
	description = S("Black"),
	range = 12,
	stack_max = 10000,
	tiles = {"black.png"},
	drop = "",
	post_effect_color = {a=255, r=0, g=0, b=0},
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("maptools:white", {
	description = S("White"),
	range = 12,
	stack_max = 10000,
	tiles = {"white.png"},
	drop = "",
	post_effect_color = {a=255, r=128, g=128, b=128},
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("maptools:playerclip", {
	description = S("Player Clip"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_green.png",
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:fake_walkable", {
	description = S("Player Clip"),
	drawtype = "nodebox",
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_green.png",
	drawtype = "airlike",
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0},
		},
	},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:fullclip", {
	description = S("Full Clip"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_blue.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:fake_walkable_pointable", {
	description = S("Player Clip"),
	drawtype = "nodebox",
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_green.png",
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0, 0, 0, 0, 0, 0},
		},
	},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:ignore_like", {
	description = S("Ignore-like"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_pink.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:ignore_like_no_clip", {
	description = S("Ignore-like (no clip)"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_purple.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})


minetest.register_node("maptools:ignore_like_no_point", {
	description = S("Ignore-like (no point)"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_purple.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	pointable = false,
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:ignore_like_no_clip_no_point", {
	description = S("Ignore-like (no clip, no point)"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_pink.png",
	tiles = {"invisible.png"},
	paramtype = "light",
	walkable = false,
	pointable = false,
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:fullclip_face", {
	description = S("Full Clip Face"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_white.png",
	drawtype = "nodebox",
	tiles = {"invisible.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4999, 0.5},
	},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE, fall_damage_add_percent=-100},
})

minetest.register_node("maptools:playerclip_bottom", {
	description = S("Player Clip Bottom Face"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_orange.png",
	drawtype = "nodebox",
	tiles = {"invisible.png"},
	pointable = false,
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4999, 0.5},
	},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE, fall_damage_add_percent=-100},
})

minetest.register_node("maptools:playerclip_top", {
	description = S("Player Clip Top Face"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_yellow.png",
	drawtype = "nodebox",
	tiles = {"invisible.png"},
	pointable = false,
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {-0.5, 0.4999, -0.5, 0.5, 0.5, 0.5},
	},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE, fall_damage_add_percent=-100},
})

for pusher_num=1,10,1 do
minetest.register_node("maptools:pusher_" .. pusher_num, {
	description = S("Pusher (%s)"):format(pusher_num),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^default_apple.png",
	drawtype = "nodebox",
	tiles = {"invisible.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4999, 0.5},
	},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE, fall_damage_add_percent=-100, bouncy=pusher_num*100},
})
end

minetest.register_node("maptools:lightbulb", {
	description = S("Light Bulb"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^default_mese_crystal_fragment.png",
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	light_source = 15,
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:nobuild", {
	description = S("Build Prevention"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^bones_bones.png",
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:nointeract", {
	description = S("Interact Prevention"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^default_scorched_stuff.png",
	drawtype = "airlike",
	walkable = false,
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:climb", {
	description = S("Climb Block"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^default_ladder.png",
	drawtype = "airlike",
	walkable = false,
	climbable = true,
	pointable = false,
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

for damage_num=1,5,1 do
minetest.register_node("maptools:damage_" .. damage_num, {
	description = S("Damaging Block (%s)"):format(damage_num),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^farming_cotton_" .. damage_num .. ".png",
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	damage_per_second = damage_num,
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})
end

minetest.register_node("maptools:kill", {
	description = S("Kill Block"),
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^dye_black.png",
	drawtype = "airlike",
	walkable = false,
	pointable = false,
	damage_per_second = 20,
	paramtype = "light",
	sunlight_propagates = true,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_node("maptools:smoke", {
	description = S("Smoke Block"),
	range = 12,
	stack_max = 10000,
	tiles = {"maptools_smoke.png"},
	drawtype = "allfaces_optional",
	walkable = false,
	paramtype = "light",
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	post_effect_color = {a=192, r=96, g=96, b=96},
})

minetest.register_node("maptools:ladder", {
	description = S("Fake Ladder"),
	range = 12,
	stack_max = 10000,
	drawtype = "signlike",
	tiles = {"default_ladder.png"},
	inventory_image = "default_ladder.png",
	wield_image = "default_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
		type = "wallmounted",
	},
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("maptools:permanent_fire", {
	description = S("Permanent Fire"),
	range = 12,
	stack_max = 10000,
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	sunlight_propagates = true,
	walkable = false,
	damage_per_second = 4,
})

minetest.register_node("maptools:fake_fire", {
	description = S("Fake Fire"),
	range = 12,
	stack_max = 10000,
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	drop = "",
	groups = {unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	sunlight_propagates = true,
	walkable = false,
})

minetest.register_node("maptools:igniter", {
	drawtype = "airlike",
	range = 12,
	stack_max = 10000,
	inventory_image = "default_steel_block.png^crosshair.png",
	description = S("Igniter"),
	paramtype = "light",
	inventory_image = "fire_basic_flame.png",
	drop = "",
	groups = {igniter=2, unbreakable = 1, not_in_creative_inventory = MAPTOOLS_CREATIVE},
	sunlight_propagates = true,
	pointable = false,
	walkable = false,
})

minetest.register_node("maptools:superapple", {
	description = S("Super Apple"),
	range = 12,
	stack_max = 10000,
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"maptools_superapple.png"},
	inventory_image = "maptools_superapple.png",
	paramtype = "light",
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	walkable = false,
	groups = {fleshy=3, dig_immediate=3, not_in_creative_inventory = 0},
	on_use = minetest.item_eat(20),
	sounds = default.node_sound_defaults(),
})

-- Items

minetest.register_craftitem("maptools:copper_coin", {
	description = S("Copper Coin"),
	inventory_image = "maptools_copper_coin.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.25},
	stack_max = 10000,
	groups = {not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_craftitem("maptools:silver_coin", {
	description = S("Silver Coin"),
	inventory_image = "maptools_silver_coin.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.25},
	stack_max = 10000,
	groups = {not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_craftitem("maptools:gold_coin", {
	description = S("Gold Coin"),
	inventory_image = "maptools_gold_coin.png",
	wield_scale = {x = 0.5, y = 0.5, z = 0.25},
	stack_max = 10000,
	groups = {not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

minetest.register_craftitem("maptools:infinitefuel", {
	description = S("Infinite Fuel"),
	inventory_image = "maptools_infinitefuel.png",
	stack_max = 10000,
	groups = {not_in_creative_inventory = MAPTOOLS_CREATIVE},
})

-- Tools

minetest.register_tool("maptools:pick_admin", {
	description = S("Admin Pickaxe"),
	range = 12,
	inventory_image = "maptools_adminpick.png",
	groups = {not_in_creative_inventory = MAPTOOLS_CREATIVE},
	tool_capabilities = {
		full_punch_interval = 0.1,
		max_drop_level = 3,
		groupcaps= {
			unbreakable = {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			fleshy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			choppy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			bendy =       {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			cracky =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			crumbly =     {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			snappy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
		},
		damage_groups = {fleshy = 1000},
	},
})

minetest.register_tool("maptools:pick_admin_with_drops", {
	description = S("Admin Pickaxe with Drops"),
	range = 12,
	inventory_image = "maptools_adminpick_with_drops.png",
	groups = {not_in_creative_inventory = MAPTOOLS_CREATIVE},
	tool_capabilities = {
		full_punch_interval = 0.35,
		max_drop_level = 3,
		groupcaps = {
			unbreakable = {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			fleshy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			choppy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			bendy =       {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			cracky =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			crumbly =     {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
			snappy =      {times={[1] = 0, [2] = 0, [3] = 0}, uses = 0, maxlevel = 3},
		},
		damage_groups = {fleshy = 1000},
	},
})

minetest.register_on_punchnode(function(pos, node, puncher)
	if puncher:get_wielded_item():get_name() == "maptools:pick_admin"
	and minetest.get_node(pos).name ~= "air" then
		minetest.log("action", puncher:get_player_name() .. " digs " .. minetest.get_node(pos).name .. " at " .. minetest.pos_to_string(pos) .. " using an Admin Pickaxe.")
		minetest.remove_node(pos) -- The node is removed directly, which means it even works on non-empty containers and group-less nodes.
		nodeupdate(pos) -- Run node update actions like falling nodes.
	end
end)

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "Carbone: [maptools] loaded.")
end
