-- Nodes that would affect the local temperature e.g. fans, heater, A/C

local S = homedecor.gettext

homedecor.register("air_conditioner", {
	description = S("Air Conditioner"),
	mesh = "homedecor_ac.obj",
	tiles = {
		"homedecor_ac.png",
		"default_glass.png"
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type="regular" },
})

-- fans

minetest.register_entity("homedecor:mesh_desk_fan", {
	collisionbox = homedecor.nodebox.null,
	visual = "mesh",
	mesh = "homedecor_desk_fan.b3d",
	textures = {"homedecor_desk_fan_uv.png"},
	visual_size = {x=10, y=10},
})

homedecor.register("desk_fan", {
	description = "Desk Fan",
	groups = {oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875}, -- NodeBox1
		}
	},
	tiles = {"homedecor_desk_fan_body.png"},
	inventory_image = "homedecor_desk_fan_inv.png",
	wield_image = "homedecor_desk_fan_inv.png",
	selection_box = { type = "regular" },
	on_rotate = screwdriver.disallow,
	on_construct = function(pos)
		local entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
		local meta = minetest.get_meta(pos)
		meta:set_string("active", "no")
		if entity_remove[1] == nil then
			minetest.add_entity({x=pos.x, y=pos.y, z=pos.z}, "homedecor:mesh_desk_fan") --+(0.0625*10)
			entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
			if minetest.get_node(pos).param2 == 0 then --list of rad to 90 degree: 3.142/2 = 90; 3.142 = 180; 3*3.142 = 270
				entity_remove[1]:setyaw(3.142)
			elseif minetest.get_node(pos).param2 == 1 then
				entity_remove[1]:setyaw(3.142/2)
			elseif minetest.get_node(pos).param2 == 3 then
				entity_remove[1]:setyaw((-3.142/2))
			else
				entity_remove[1]:setyaw(0)
			end
		end
	end,
	on_punch = function(pos)
		local entity_anim = minetest.get_objects_inside_radius(pos, 0.1)
		local speedy_meta = minetest.get_meta(pos)
		if speedy_meta:get_string("active") == "no" then
			speedy_meta:set_string("active", "yes")
		elseif speedy_meta:get_string("active") == "yes" then
			speedy_meta:set_string("active", "no")
		end

		if entity_anim[1] == nil then
			minetest.add_entity({x=pos.x, y=pos.y, z=pos.z}, "homedecor:mesh_desk_fan") --+(0.0625*10)
			local entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
			if minetest.get_node(pos).param2 == 0 then --list of rad to 90 degree: 3.142/2 = 90; 3.142 = 180; 3*3.142 = 270
				entity_remove[1]:setyaw(3.142)
			elseif minetest.get_node(pos).param2 == 1 then
				entity_remove[1]:setyaw(3.142/2)
			elseif minetest.get_node(pos).param2 == 3 then
				entity_remove[1]:setyaw((-3.142/2))
			else
				entity_remove[1]:setyaw(0)
			end
		end
		local entity_anim = minetest.get_objects_inside_radius(pos, 0.1)
		if minetest.get_meta(pos):get_string("active") == "no" then
			entity_anim[1]:set_animation({x=0,y=0}, 1, 0)
		elseif minetest.get_meta(pos):get_string("active") == "yes" then
			entity_anim[1]:set_animation({x=0,y=96}, 24, 0)
		end
	end,
	after_dig_node = function(pos)
		local entity_remove = minetest.get_objects_inside_radius(pos, 0.1)
		entity_remove[1]:remove()
	end,
})

-- ceiling fan

homedecor.register("ceiling_fan", {
	description = S("Ceiling Fan"),
	tiles = {
		{	name="homedecor_ceiling_fan_top.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.5} },
		{	name="homedecor_ceiling_fan_bottom.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.5} },
		'homedecor_ceiling_fan_sides.png',
	},
	inventory_image = "homedecor_ceiling_fan_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, 0.495, -0.5, 0.5, 0.495, 0.5 },
			{ -0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625 }
		}
	},
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-1,
	sounds = default.node_sound_glass_defaults(),
})

-- heating devices

homedecor.register("space_heater", {
	description = S("Space heater"),
	tiles = { 'homedecor_heater_tb.png',
		  'homedecor_heater_tb.png',
		  'homedecor_heater_sides.png',
		  'homedecor_heater_sides.png',
		  'homedecor_heater_back.png',
		  'homedecor_heater_front.png'
	},
	inventory_image = "homedecor_heater_inv.png",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, 0.0625, 0.1875, 0, 0.3125},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1875, -0.5, 0.0625, 0.1875, 0, 0.3125}
	}
})

local r_cbox = homedecor.nodebox.slab_z(-0.25)
homedecor.register("radiator", {
	mesh = "homedecor_radiator.obj",
	tiles = {
		"homedecor_generic_metal_black.png^[colorize:#ffffff:200",
		"homedecor_radiator_controls.png"
	},
	inventory_image = "homedecor_radiator_inv.png",
	description = "Radiator heater",
	groups = {snappy=3},
	selection_box = r_cbox,
	collision_box = r_cbox,
	sounds = default.node_sound_wood_defaults(),
})
