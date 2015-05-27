screwdriver = screwdriver or {}

local function start_smoke(pos, node, clicker, chimney)
	local this_spawner_meta = minetest.get_meta(pos)
	local id = this_spawner_meta:get_int("smoky")
	local s_handle = this_spawner_meta:get_int("sound")
	local above = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name

	if id ~= 0 then
		if s_handle then
			minetest.after(0, function(s_handle)
				minetest.sound_stop(s_handle)
			end, s_handle)
		end
		minetest.delete_particlespawner(id)
		this_spawner_meta:set_int("smoky", nil)
		this_spawner_meta:set_int("sound", nil)
		return
	end

	if above == "air" and (not id or id == 0) then
		id = minetest.add_particlespawner({
			amount = 4, time = 0, collisiondetection = true,
			minpos = {x=pos.x-0.25, y=pos.y+0.4, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+5, z=pos.z+0.25},
			minvel = {x=-0.2, y=0.3, z=-0.2}, maxvel = {x=0.2, y=1, z=0.2},
			minacc = {x=0,y=0,z=0}, maxacc = {x=0,y=0.5,z=0},
			minexptime = 1, maxexptime = 3,
			minsize = 4, maxsize = 8,
			texture = "smoke_particle.png",
		})
		if chimney == 1 then
			s_handle = nil
			this_spawner_meta:set_int("smoky", id)
			this_spawner_meta:set_int("sound", nil)
		else
		s_handle = minetest.sound_play("fire_small", {
			pos = pos,
			max_hear_distance = 5,
			loop = true 
		})
		this_spawner_meta:set_int("smoky", id)
		this_spawner_meta:set_int("sound", s_handle)
		end
	return end
end

local function stop_smoke(pos)
	local this_spawner_meta = minetest.get_meta(pos)
	local id = this_spawner_meta:get_int("smoky")
	local s_handle = this_spawner_meta:get_int("sound")

	if id ~= 0 then
		minetest.delete_particlespawner(id)
	end

	if s_handle then
		minetest.after(0, function(s_handle)
			minetest.sound_stop(s_handle)
		end, s_handle)
	end

	this_spawner_meta:set_int("smoky", nil)
	this_spawner_meta:set_int("sound", nil)
end

-- FLAME TYPES
local flame_types = {"fake", "ice"}

for _, f in ipairs(flame_types) do
	minetest.register_node("fake_fire:"..f.."_fire", {
		inventory_image = f.."_fire_inv.png",
		description = f.." fire",
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {dig_immediate=3, not_in_creative_inventory=1},
		sunlight_propagates = true,
		buildable_to = true,
		walkable = false,
		light_source = 14,
		waving = 1,
		tiles = {
			{name=f.."_fire_animated.png", animation={type="vertical_frames", 
			aspect_w=16, aspect_h=16, length=1.5}},
		},
		on_rightclick = function (pos, node, clicker)
			start_smoke(pos, node, clicker)
		end,
		on_destruct = function (pos)
			stop_smoke(pos)
			minetest.sound_play("fire_extinguish", {
				pos = pos, max_hear_distance = 5
			})
		end,
		drop = ""
	})
end

minetest.register_node("fake_fire:fancy_fire", {
		inventory_image = "fancy_fire_inv.png",
		description = "Fancy Fire",
		drawtype = "mesh",
		mesh = "fancy_fire.obj",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {dig_immediate=3},
		sunlight_propagates = true,
		light_source = 14,
		walkable = false,
		damage_per_second = 4,
		on_rotate = screwdriver.rotate_simple,
		tiles = {
		{name="fake_fire_animated.png", 
		animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1}}, {name='fake_fire_logs.png'}},
		on_rightclick = function (pos, node, clicker)
			start_smoke(pos, node, clicker)
		end,
		on_destruct = function (pos)
			stop_smoke(pos)
			minetest.sound_play("fire_extinguish", {
				pos = pos, max_hear_distance = 5
			})
		end,
		drop = {
			max_items = 3,
			items = {
				{
					items = { "default:torch", "default:torch", "building_blocks:sticks" },
					rarity = 1,
				}
			}
		}
	})

-- EMBERS
minetest.register_node("fake_fire:embers", {
    description = "Glowing Embers",
	tiles = {
		{name="embers_animated.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
	},
	light_source = 9,
	groups = {crumbly=3},
	paramtype = "light",
	sounds = default.node_sound_dirt_defaults(),
})

-- CHIMNEYS
local materials = {"stone", "sandstone"}

for _, m in ipairs(materials) do
	minetest.register_node("fake_fire:chimney_top_"..m, {
		description = "Chimney Top - "..m,
		tiles = {"default_"..m..".png^chimney_top.png", "default_"..m..".png"},
		groups = {snappy=3},
		paramtype = "light",
		sounds = default.node_sound_stone_defaults(),
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		on_rightclick = function (pos, node, clicker)
			local chimney = 1
			start_smoke(pos, node, clicker, chimney)
		end,
		on_destruct = function (pos)
			stop_smoke(pos)
		end
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = 'fake_fire:chimney_top_'..m,
		recipe = {"default:torch", "stairs:slab_"..m}
	})
end

-- FLINT and STEEL
minetest.register_tool("fake_fire:flint_and_steel", {
	description = "Flint and steel",
	inventory_image = "flint_and_steel.png",
	liquids_pointable = false,
	stack_max = 1,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={flamable = {uses=65, maxlevel=1}}
	},
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" and minetest.get_node(pointed_thing.above).name == "air" then
			if not minetest.is_protected(pointed_thing.above, user:get_player_name()) then
				if string.find(minetest.get_node(pointed_thing.under).name, "ice") then
					minetest.set_node(pointed_thing.above, {name="fake_fire:ice_fire"})
				else
					minetest.set_node(pointed_thing.above, {name="fake_fire:fake_fire"})
				end
			else
				minetest.chat_send_player(user:get_player_name(), "This area is protected!")
			end
		else
			return
		end

		itemstack:add_wear(65535/65)
		return itemstack
	end
})

-- CRAFTS
minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:flint_and_steel',
	recipe = {"default:obsidian_shard", "default:steel_ingot"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:embers',
	recipe = {"default:torch", "group:wood", "default:torch"}
})

minetest.register_craft({
	type = "shapeless",
	output = 'fake_fire:fancy_fire',
	recipe = {"default:torch", "building_blocks:sticks", "default:torch" }
})

-- ALIASES
minetest.register_alias("fake_fire:smokeless_fire", "fake_fire:fake_fire")
minetest.register_alias("fake_fire:smokeless_ice_fire", "fake_fire:ice_fire")
minetest.register_alias("fake_fire:smokeless_chimney_top_stone", "fake_fire:chimney_top_stone")
minetest.register_alias("fake_fire:smokeless_chimney_top_sandstone", "fake_fire:chimney_top_sandstone")
minetest.register_alias("fake_fire:flint", "fake_fire:flint_and_steel")
