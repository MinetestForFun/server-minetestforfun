local cp = nil

local function register_fake_fire(name, def)
	assert(name, "local registration called without name")
	assert(def, "local registration called without node definition")

	def.is_ground_content = true
	def.inventory_image = def.inventory_image or name..".png"
	def.drawtype = "plantlike"
	def.waving = 1
	def.light_source = def.lightsource or 14
	def.sunlight_propagates = true
	def.groups = def.groups or {
		oddly_breakable_by_hand=3, dig_immediate=2,
		attached_node=1, not_in_creative_inventory=1
	}
	def.paramtype = "light"
	def.walkable = false
	def.drop = ""
	def.sounds = def.sounds or minetest.sound_play("fire_small", {pos=cp, loop=true})
	def.buildable_to = true

	local swap_on_punch = def.swap_on_punch
	def.on_punch = def.on_punch or function (pos, node, puncher)
		minetest.sound_play("fire_extinguish", {pos = pos, gain = 1.0, max_hear_distance = 5,})
		if swap_on_punch then
			minetest.set_node(pos, {name = swap_on_punch})
		end
	end

	def.swap_on_punch = nil
	def.smoking = nil
	minetest.register_node("fake_fire:"..name, def)
end


-- FLAME TYPES
register_fake_fire("fake_fire", {
	description = "Smokey, Fake Fire",
	tiles = {
		{name="fake_fire_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.5}},
	},
	swap_on_punch = "fake_fire:smokeless_fire",
})

register_fake_fire("smokeless_fire", {
	description = "Smokeless, Fake Fire",
	tiles = {
		{name="fake_fire_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.5}},
	},
	inventory_image = 'fake_fire.png',
	swap_on_punch = "fake_fire:fake_fire",
})

register_fake_fire("ice_fire", {
	description = "Smoky, Fake, Ice Fire",
	tiles = {
		{name="ice_fire_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.5}},
	},
	swap_on_punch = "fake_fire:smokeless_ice_fire",
})

register_fake_fire("smokeless_ice_fire", {
	description = "Smokeless, Fake, Ice Fire",
	tiles = {
		{name="ice_fire_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1.5}},
	},
   	inventory_image = 'ice_fire.png',
	swap_on_punch = "fake_fire:ice_fire",
})


-- FLINT and STEEL
minetest.register_tool("fake_fire:flint_and_steel", {
	description = "Flint and steel",
	inventory_image = "flint_and_steel.png",
	liquids_pointable = false,
	stack_max = 1,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={flamable = {uses=65, maxlevel=1},
		}
	},
	on_use = function(itemstack, user, pointed_thing)
		local snow_ice_list = {"snow", "ice",}
	
			for _, which_one_is_it in pairs(snow_ice_list) do
				local snow_ice = which_one_is_it
	
				if pointed_thing.type == "node"					
					and not string.find(minetest.get_node(pointed_thing.under).name, "snow")
					and not string.find(minetest.get_node(pointed_thing.under).name, "ice")
					and minetest.get_node(pointed_thing.above).name == "air"
				then
					if not minetest.is_protected(pointed_thing.above, user:get_player_name()) then
						minetest.set_node(pointed_thing.above, {name="fake_fire:smokeless_fire"})						
					else
						minetest.chat_send_player(user:get_player_name(), "You can't set a fire in someone else's area!")
					end
				elseif pointed_thing.type == "node"
					and string.find(minetest.get_node(pointed_thing.under).name,snow_ice)
					and minetest.get_node(pointed_thing.above).name == "air" then
						if not minetest.is_protected(pointed_thing.above, user:get_player_name()) then
							minetest.set_node(pointed_thing.above, {name="fake_fire:smokeless_ice_fire"})						
						else
							minetest.chat_send_player(user:get_player_name(), "You can't set a fire in someone else's area!")
						end
				end
			end
		
			minetest.sound_play("", {gain = 1.0, max_hear_distance = 2,})
			itemstack:add_wear(65535/65)
			return itemstack
	end
})


-- EMBERS
minetest.register_node("fake_fire:embers", {
    description = "Glowing Embers",
	tiles = {
		{name="embers_animated.png", animation={type="vertical_frames",
		aspect_w=16, aspect_h=16, length=2}},
		},
	inventory_image = minetest.inventorycube('fake_fire_embers.png'),
	is_ground_content = true,
	light_source = 9,
	sunlight_propagates = true,
	groups = {choppy=3, crumbly=3, oddly_breakable_by_hand=3},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	sounds = minetest.sound_play("fire_small", {pos=cp, loop=true}),
})


-- CHIMNEY TOP - STONE
minetest.register_node("fake_fire:chimney_top_stone", {
	description = "Chimney Top - Stone",
	tiles = {"chimney_top_stone.png", "default_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
	drop = "fake_fire:smokeless_chimney_top_stone",
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	on_punch = function (pos,node,puncher)
		minetest.set_node(pos, {name = "fake_fire:smokeless_chimney_top_stone"})
	end
})


-- CHIMNEY TOP - SANDSTONE
minetest.register_node("fake_fire:chimney_top_sandstone", {
	description = "Chimney Top - Sandstone",
	tiles = {"chimney_top_sandstone.png", "default_sandstone.png"},
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
	drop = "fake_fire:smokeless_chimney_top_sandstone",
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	on_punch = function (pos,node,puncher)
		minetest.set_node(pos, {name = "fake_fire:smokeless_chimney_top_sandstone"})
	end
})


-- SMOKELESS CHIMNEY TOP - STONE
minetest.register_node("fake_fire:smokeless_chimney_top_stone", {
	description = "Chimney Top - Stone",
	tiles = {"chimney_top_stone.png", "default_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	on_punch = function (pos,node,puncher)
		minetest.set_node(pos, {name = "fake_fire:chimney_top_stone"})
	end
})


-- SMOKELESS CHIMNEY TOP - SANDSTONE
minetest.register_node("fake_fire:smokeless_chimney_top_sandstone", {
	description = "Chimney Top - Sandstone",
	tiles = {"chimney_top_sandstone.png", "default_sandstone.png"},
	is_ground_content = true,
	groups = {cracky=3, oddly_breakable_by_hand=1},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
	on_punch = function (pos,node,puncher)
		minetest.set_node(pos, {name = "fake_fire:chimney_top_sandstone"})
	end
})
