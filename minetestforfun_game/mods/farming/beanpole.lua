--[[
	All textures by
	(C) Auke Kok <sofar@foo-projects.org>
	CC-BY-SA-3.0
--]]

minetest.register_craftitem("farming:beans", {
	description = "Green Beans",
	inventory_image = "farming_beans.png",
	on_use = minetest.item_eat(1),
	on_place = function(itemstack, placer, pointed_thing)
		if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
			return
		end
		local nod = minetest.get_node_or_nil(pointed_thing.under)
		if nod and nod.name == "farming:beanpole" then
			minetest.set_node(pointed_thing.under, {name="farming:beanpole_1"})
		else
			return
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
			-- check for refill
			if itemstack:get_count() == 0 then
				minetest.after(0.20,
					farming.refill_plant,
					placer,
					"farming:beans",
					placer:get_wield_index()
				)
			end -- END refill
		end
		return itemstack
	end
})

-- Beans can be used for green dye
minetest.register_craft({
	output = "dye:green",
	recipe = {
		{'farming:beans'},
	}
})

-- Beanpole

minetest.register_node("farming:beanpole", {
	description = "Bean Pole (place on soil before planting beans)",
	drawtype = "plantlike",
	tiles = {"farming_beanpole.png"},
	inventory_image = "farming_beanpole.png",
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:beanpole'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local top = {
			x = pointed_thing.above.x,
			y = pointed_thing.above.y + 1,
			z = pointed_thing.above.z
		}	
		if minetest.is_protected(pointed_thing.above, placer:get_player_name()) or minetest.is_protected(top, placer:get_player_name()) then
			return
		end
		local nod = minetest.get_node_or_nil(pointed_thing.under)
		if nod and minetest.get_item_group(nod.name, "soil") < 2 then
			return
		end

		nod = minetest.get_node_or_nil(top)
		if nod and nod.name ~= "air" then return end
		minetest.set_node(pointed_thing.above, {name = "farming:beanpole"})
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end
})

minetest.register_craft({
	output = "farming:beanpole",
	recipe = {
		{'', '', ''},
		{'default:stick', '', 'default:stick'},
		{'default:stick', '', 'default:stick'},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:beanpole",
	burntime = 10,
})

-- Define Green Bean growth stages

minetest.register_node("farming:beanpole_1", {
	drawtype = "plantlike",
	tiles = {"farming_beanpole_1.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:beanpole'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 3, not_in_creative_inventory = 1,
		attached_node = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:beanpole_2", {
	drawtype = "plantlike",
	tiles = {"farming_beanpole_2.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:beanpole'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:beanpole_3", {
	drawtype = "plantlike",
	tiles = {"farming_beanpole_3.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:beanpole'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})


minetest.register_node("farming:beanpole_4", {
	drawtype = "plantlike",
	tiles = {"farming_beanpole_4.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:beanpole'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- Last stage of growth does not have growing group so abm never checks these

minetest.register_node("farming:beanpole_5", {
	drawtype = "plantlike",
	tiles = {"farming_beanpole_5.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:beanpole'}, rarity = 1},
			{items = {'farming:beans 3'}, rarity = 1},
			{items = {'farming:beans 2'}, rarity = 2},
			{items = {'farming:beans 2'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- Wild Green Bean Bush (this is what you find on the map)

minetest.register_node("farming:beanbush", {
	drawtype = "plantlike",
	tiles = {"farming_beanbush.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:beans 1'}, rarity = 1},
			{items = {'farming:beans 1'}, rarity = 2},
			{items = {'farming:beans 1'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})