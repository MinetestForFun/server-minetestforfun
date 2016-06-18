
local S = farming.intllib

-- grapes
minetest.register_craftitem("farming:grapes", {
	description = S("Grapes"),
	inventory_image = "farming_grapes.png",
	on_use = minetest.item_eat(2),

	on_place = function(itemstack, placer, pointed_thing)

		if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
			return
		end

		local nodename = minetest.get_node(pointed_thing.under).name

		if nodename == "farming:trellis" then
			minetest.set_node(pointed_thing.under, {name = "farming:grapes_1"})

			minetest.sound_play("default_place_node", {pos = pointed_thing.above, gain = 1.0})
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
			end
		end

		return itemstack
	end
})

-- grapes can be used for violet dye
minetest.register_craft({
	output = "dye:violet",
	recipe = {
		{'farming:grapes'},
	}
})

-- trellis
minetest.register_node("farming:trellis", {
	description = S("Trellis (place on soil before planting grapes)"),
	drawtype = "plantlike",
	tiles = {"farming_trellis.png"},
	inventory_image = "farming_trellis.png",
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "farming:trellis",
	selection_box = farming.select,
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_place = function(itemstack, placer, pointed_thing)

		if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
			return
		end

		local nodename = minetest.get_node(pointed_thing.under).name

		if minetest.get_item_group(nodename, "soil") < 2 then
			return
		end

		local top = {
			x = pointed_thing.above.x,
			y = pointed_thing.above.y + 1,
			z = pointed_thing.above.z
		}

		nodename = minetest.get_node(top).name

		if nodename ~= "air" then
			return
		end

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

-- grapes definition
local crop_def = {
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
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:grapes_1", table.copy(crop_def))

-- stage2
crop_def.tiles = {"farming_grapes_2.png"}
minetest.register_node("farming:grapes_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_grapes_3.png"}
minetest.register_node("farming:grapes_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_grapes_4.png"}
minetest.register_node("farming:grapes_4", table.copy(crop_def))

-- stage 5
crop_def.tiles = {"farming_grapes_5.png"}
minetest.register_node("farming:grapes_5", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_grapes_6.png"}
minetest.register_node("farming:grapes_6", table.copy(crop_def))

-- stage 7
crop_def.tiles = {"farming_grapes_7.png"}
minetest.register_node("farming:grapes_7", table.copy(crop_def))

-- stage 8 (final)
crop_def.tiles = {"farming_grapes_8.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:trellis'}, rarity = 1},
		{items = {'farming:grapes 3'}, rarity = 1},
		{items = {'farming:grapes 1'}, rarity = 2},
		{items = {'farming:grapes 1'}, rarity = 3},
	}
}
minetest.register_node("farming:grapes_8", table.copy(crop_def))

-- wild grape vine (this is what you find on the map)
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
