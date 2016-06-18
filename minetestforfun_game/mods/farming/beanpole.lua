--[[
	All textures by
	(C) Auke Kok <sofar@foo-projects.org>
	CC-BY-SA-3.0
]]

local S = farming.intllib

-- beans
minetest.register_craftitem("farming:beans", {
	description = S("Green Beans"),
	inventory_image = "farming_beans.png",
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)

		if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
			return
		end

		local nodename = minetest.get_node(pointed_thing.under).name

		if nodename == "farming:beanpole" then
			minetest.set_node(pointed_thing.under, {name = "farming:beanpole_1"})

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
					"farming:beans",
					placer:get_wield_index()
				)
			end
		end

		return itemstack
	end
})

-- beans can be used for green dye
minetest.register_craft({
	output = "dye:green",
	recipe = {
		{'farming:beans'},
	}
})

-- beanpole
minetest.register_node("farming:beanpole", {
	description = S("Bean Pole (place on soil before planting beans)"),
	drawtype = "plantlike",
	tiles = {"farming_beanpole.png"},
	inventory_image = "farming_beanpole.png",
	visual_scale = 1.45,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	drop = "farming:beanpole",
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

-- green bean definition
local crop_def = {
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
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:beanpole_1", table.copy(crop_def))

-- stage2
crop_def.tiles = {"farming_beanpole_2.png"}
minetest.register_node("farming:beanpole_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_beanpole_3.png"}
minetest.register_node("farming:beanpole_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_beanpole_4.png"}
minetest.register_node("farming:beanpole_4", table.copy(crop_def))

-- stage 5 (final)
crop_def.tiles = {"farming_beanpole_5.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {'farming:beanpole'}, rarity = 1},
		{items = {'farming:beans 3'}, rarity = 1},
		{items = {'farming:beans 2'}, rarity = 2},
		{items = {'farming:beans 2'}, rarity = 3},
	}
}
minetest.register_node("farming:beanpole_5", table.copy(crop_def))

-- wild green bean bush (this is what you find on the map)
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
