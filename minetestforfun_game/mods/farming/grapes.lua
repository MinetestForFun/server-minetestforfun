-- Grapes

minetest.register_craftitem("farming:grapes", {
	description = "Grapes",
	inventory_image = "farming_grapes.png",
	on_use = minetest.item_eat(2),
	on_place = function(itemstack, placer, pointed_thing)
		if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
			return
		end
		local nod = minetest.get_node_or_nil(pointed_thing.under)
		if nod and nod.name == "farming:trellis" then
			minetest.set_node(pointed_thing.under, {name="farming:grapes_1"})
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
					"farming:grapes",
					placer:get_wield_index()
				)
			end -- END refill
		end
		return itemstack
	end
})

-- Grapes can be used for violet dye
minetest.register_craft({
	output = "dye:violet",
	recipe = {
		{'farming:grapes'},
	}
})

-- Trellis

minetest.register_node("farming:trellis", {
	description = "Trellis (place on soil before planting grapes)",
	drawtype = "plantlike",
	tiles = {"farming_trellis.png"},
	inventory_image = "farming_trellis.png",
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
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
		minetest.set_node(pointed_thing.above, {name = "farming:trellis"})
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end
})

minetest.register_craft({
	output = "farming:trellis",
	recipe = {
		{'default:stick', 'default:stick', 'default:stick'},
		{'default:stick', 'default:stick', 'default:stick'},
		{'default:stick', '', 'default:stick'},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:trellis",
	burntime = 15,
})

-- Define Grapes growth stages

minetest.register_node("farming:grapes_1", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_1.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 3, not_in_creative_inventory = 1,
		attached_node = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:grapes_2", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_2.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:grapes_3", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_3.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:grapes_4", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_4.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:grapes_5", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_5.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:grapes_6", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_6.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:grapes_7", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_7.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
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

minetest.register_node("farming:grapes_8", {
	drawtype = "plantlike",
	tiles = {"farming_grapes_8.png"},
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:trellis'}, rarity = 1},
			{items = {'farming:grapes 3'}, rarity = 1},
			{items = {'farming:grapes 1'}, rarity = 2},
			{items = {'farming:grapes 1'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

-- Wild Grape Vine (this is what you find on the map)

minetest.register_node("farming:grapebush", {
	drawtype = "plantlike",
	tiles = {"farming_grapebush.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = {
		items = {
			{items = {'farming:grapes 1'}, rarity = 1},
			{items = {'farming:grapes 1'}, rarity = 2},
			{items = {'farming:grapes 1'}, rarity = 3},
		}
	},
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory=1
	},
	sounds = default.node_sound_leaves_defaults(),
})
