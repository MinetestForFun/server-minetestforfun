-- mods/default/nodes.lua

gui_slots = "listcolors[#606060AA;#808080;#101010;#202020;#FFF]"

minetest.register_node("default:stone", {
	description = "Stone",
	tiles = {"default_stone.png"},
	is_ground_content = true,
	groups = {cracky = 3, stone = 1},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"maptools:copper_coin"}, rarity = 30},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stone", {
	description = "Desert Stone",
	tiles = {"default_desert_stone.png"},
	is_ground_content = true,
	groups = {crumbly = 1, cracky = 3, stone = 1},
	drop = {
		items = {
			{items = {"default:desert_cobble"}},
			{items = {"maptools:copper_coin"}, rarity = 20},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_coal", {
	description = "Coal Ore",
	tiles = {"default_stone.png^default_mineral_coal.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"default:coal_lump"}},
			{items = {"maptools:copper_coin"}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stone_with_coal", {
	description = "Coal Ore",
	tiles = {"default_desert_stone.png^default_mineral_coal.png"},
	is_ground_content = true,
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{items = {"default:desert_cobble"}},
			{items = {"default:coal_lump"}},
			{items = {"maptools:copper_coin"}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_coin", {
	description = "Stone with Coin",
	tiles = {"default_stone.png^maptools_gold_coin.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"maptools:gold_coin"}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_iron", {
	description = "Iron Ore",
	tiles = {"default_stone.png^default_mineral_iron.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"default:iron_lump"}},
			{items = {"maptools:copper_coin 3"}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_copper", {
	description = "Copper Ore",
	tiles = {"default_stone.png^default_mineral_copper.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"default:copper_lump"}},
			{items = {"maptools:copper_coin 3"}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stone_with_copper", {
	description = "Copper Ore",
	tiles = {"default_desert_stone.png^default_mineral_copper.png"},
	is_ground_content = true,
	groups = {crumbly = 1, cracky = 3},
	drop = {
		items = {
			{items = {"default:desert_cobble"}},
			{items = {"default:copper_lump"}},
			{items = {"maptools:copper_coin 3"}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_mese", {
	description = "Mese Ore",
	tiles = {"default_stone.png^default_mineral_mese.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"default:mese_crystal"}},
			{items = {"maptools:silver_coin 2", rarity = 75}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_gold", {
	description = "Gold Ore",
	tiles = {"default_stone.png^default_mineral_gold.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"default:gold_lump"}},
			{items = {"maptools:silver_coin", rarity = 80}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})
	
minetest.register_node("default:stone_with_diamond", {
	description = "Diamond Ore",
	tiles = {"default_stone.png^default_mineral_diamond.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	drop = {
		items = {
			{items = {"default:cobble"}},
			{items = {"default:diamond"}},
			{items = {"maptools:silver_coin 1"}},
		},
	},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stonebrick", {
	description = "Stone Brick",
	tiles = {"default_stone_brick.png"},
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stonebrick", {
	description = "Desert Stone Brick",
	tiles = {"default_desert_stone_brick.png"},
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly = 3, soil = 1},
	drop = {
		items = {
			{items = {"default:dirt"}},
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.8},
	}),
})

minetest.register_node("default:dirt_with_grass_footsteps", {
	description = "Dirt with Grass and Footsteps",
	tiles = {"default_grass_footsteps.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly = 3, soil = 1, not_in_creative_inventory = 1},
	drop = {
		items = {
			{items = {"default:dirt"}},
		},
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.4},
	}),
})

minetest.register_node("default:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles = {"default_snow.png", "default_dirt.png", "default_dirt.png^default_snow_side.png"},
	is_ground_content = true,
	groups = {crumbly = 3},
	drop = {
		items = {
			{items = {"default:dirt"}},
			{items = {"default:snow"}},
		},
	},
	sounds = default.node_sound_dirt_defaults({footstep = {name = "default_snow_footstep", gain = 0.625}}),
})

minetest.register_node("default:dirt", {
	description = "Dirt",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	drop = {
		items = {
			{items = {"default:dirt"}},
			{items = {"maptools:copper_coin"}, rarity = 32},
		},
	},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})


minetest.register_abm({
	nodenames = {"default:dirt"},
	interval = 30,
	chance = 5,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if nodedef and (nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none"
				and pos.y >= 0
				and (minetest.get_node_light(above) or 0) >= 12 then
			if name == "default:snow" or name == "default:snowblock" then
				minetest.set_node(pos, {name = "default:dirt_with_snow"})
			else
				minetest.set_node(pos, {name = "default:dirt_with_grass"})
			end
		end
	end
})


minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	interval = 30,
	chance = 2,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef
				and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})

minetest.register_node("default:sand", {
	description = "Sand",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	drop = {
		items = {
			{items = {"default:sand"}},
		},
	},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
     		if not pointed_thing.type == "node" then
			return itemstack
		end
		local pn = placer:get_player_name()
		if minetest.is_protected(pointed_thing.above, pn) then
			return itemstack
		end
		minetest.add_node(pointed_thing.above, {name=itemstack:get_name()})
		local meta = minetest.get_meta(pointed_thing.above)
		meta:set_string("owner", pn)
		nodeupdate(pointed_thing.above)
		if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
		end
		return itemstack
	end
})

minetest.register_node("default:desert_sand", {
	description = "Desert Sand",
	tiles = {"default_desert_sand.png"},
	is_ground_content = true,
	drop = {
		items = {
			{items = {"default:desert_sand"}},
		},
	},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
     		if not pointed_thing.type == "node" then
			return itemstack
		end
		local pn = placer:get_player_name()
		if minetest.is_protected(pointed_thing.above, pn) then
			return itemstack
		end
		minetest.add_node(pointed_thing.above, {name=itemstack:get_name()})
		local meta = minetest.get_meta(pointed_thing.above)
		meta:set_string("owner", pn)
		nodeupdate(pointed_thing.above)
		if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
		end
		return itemstack
	end
})

minetest.register_node("default:gravel", {
	description = "Gravel",
	tiles = {"default_gravel.png"},
	is_ground_content = true,
	groups = {crumbly = 2, falling_node = 1},
	drop = {
		items = {
			{items = {"default:gravel"}},
		},
	},
	sounds = default.node_sound_gravel_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
     		if not pointed_thing.type == "node" then
			return itemstack
		end
		local pn = placer:get_player_name()
		if minetest.is_protected(pointed_thing.above, pn) then
			return itemstack
		end
		minetest.add_node(pointed_thing.above, {name=itemstack:get_name()})
		local meta = minetest.get_meta(pointed_thing.above)
		meta:set_string("owner", pn)
		nodeupdate(pointed_thing.above)
		if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
		end
		return itemstack
	end
})

minetest.register_node("default:sandstone", {
	description = "Sandstone",
	tiles = {"default_sandstone.png"},
	is_ground_content = true,
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:sandstonebrick", {
	description = "Sandstone Brick",
	tiles = {"default_sandstone_brick.png"},
	is_ground_content = true,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:clay", {
	description = "Clay",
	tiles = {"default_clay.png"},
	is_ground_content = true,
	groups = {crumbly = 3},
	drop = {
		items = {
			{items = {"default:clay_lump 8"}},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("default:clay_burned", {
	description = "Burned Clay",
	tiles = {"default_clay_burned.png"},
	is_ground_content = true,
	groups = {crumbly = 3},
	drop = {
		items = {
			{items = {"default:clay_lump 8"}},
		},
	},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("default:brick", {
	description = "Brick Block",
	tiles = {"default_brick.png"},
	is_ground_content = false,
	groups = {cracky = 3},
	drop = "default:clay_brick 9",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tree", {
	description = "Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = {
		items = {
			{items = {"default:tree"}},
		},
	},
	groups = {tree = 1,choppy = 2,oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("default:jungletree", {
	description = "Jungle Tree",
	tiles = {"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = {
		items = {
			{items = {"default:jungletree"}},
		},
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("default:junglewood", {
	description = "Junglewood Planks",
	tiles = {"default_junglewood.png"},
	groups = {choppy = 2,oddly_breakable_by_hand = 2, flammable = 3,wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:jungleleaves", {
	description = "Jungle Leaves",
	drawtype = "allfaces_optional",
	tiles = {"default_jungleleaves.png"},
	paramtype = "light",
	waving = 1,
	is_ground_content = false,
	walkable = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- Player will get sapling with 1/18 chance:
				items = {"default:junglesapling"},
				rarity = 18,
			},
			{
				-- Player will get leaves only if he gets no saplings, this is because max_items is 1:
				items = {"default:jungleleaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:junglesapling", {
	description = "Jungle Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_junglesapling.png"},
	inventory_image = "default_junglesapling.png",
	wield_image = "default_junglesapling.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:junglegrass", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	tiles = {"default_junglegrass.png"},
	inventory_image = "default_junglegrass.png",
	wield_image = "default_junglegrass.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
})

minetest.register_node("default:leaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	waving = 1,
	walkable = false,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- Player will get sapling with 1/18 chance:
				items = {"default:sapling"},
				rarity = 18,
			},
			{
				-- Player will get leaves only if he gets no saplings, this is because max_items is 1:
				items = {"default:leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:cactus", {
	description = "Cactus",
	tiles = {"default_cactus_top.png", "default_cactus_top.png", "default_cactus_side.png"},
	paramtype2 = "facedir",
	is_ground_content = true,
	drop = {
		items = {
			{items = {"default:cactus"}},
		},
	},
	groups = {snappy = 1, choppy = 3, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("default:papyrus", {
	description = "Papyrus",
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375}
	},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

default.bookshelf_formspec =
	"size[8,7;]" ..
	gui_slots ..
	"list[context;books;0, 0.3;8,2;]" ..
	"list[current_player;main;0,2.85;8,4;]" ..
	default.get_hotbar_bg(0, 2.85) ..
	default.get_hotbar_bg(0, 3.85)

minetest.register_node("default:bookshelf", {
	description = "Bookshelf",
	tiles = {"default_wood.png", "default_wood.png", "default_bookshelf.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	groups = {choppy = 3,oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.bookshelf_formspec)
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("books")
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "books" then
			if stack:get_name() == "default:book" then
				return 1
			else
				return 0
			end
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		local to_stack = inv:get_stack(to_list, to_index)
		if to_list == "books" then
			if stack:get_name() == "default:book" and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,

	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff in bookshelf at "..minetest.pos_to_string(pos) .. ".")
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " moves stuff to bookshelf at "..minetest.pos_to_string(pos) .. ".")
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			   " takes stuff from bookshelf at "..minetest.pos_to_string(pos) .. ".")
	end,
})

minetest.register_node("default:glass", {
	description = "Glass",
	drawtype = "glasslike_framed",
	tiles = {"default_glass_frame.png", "default_glass_detail.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3,oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
})

local fence_wood_texture = "default_fence_overlay.png^default_wood.png^default_fence_overlay.png^[makealpha:255,126,126"
minetest.register_node("default:fence_wood", {
	description = "Wooden Fence",
	drawtype = "fencelike",
	tiles = {"default_wood.png"},
	inventory_image = fence_wood_texture,
	wield_image = fence_wood_texture,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {choppy = 2,oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

local fence_cobble_texture = "default_fence_overlay.png^default_cobble.png^default_fence_overlay.png^[makealpha:255,126,126"
minetest.register_node("default:fence_cobble", {
	description = "Cobblestone Fence",
	drawtype = "fencelike",
	tiles = {"default_cobble.png"},
	inventory_image = fence_cobble_texture,
	wield_image = fence_cobble_texture,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

local fence_desert_cobble_texture = "default_fence_overlay.png^default_desert_cobble.png^default_fence_overlay.png^[makealpha:255,126,126"
minetest.register_node("default:fence_desert_cobble", {
	description = "Desert Cobblestone Fence",
	drawtype = "fencelike",
	tiles = {"default_desert_cobble.png"},
	inventory_image = fence_desert_cobble_texture,
	wield_image = fence_desert_cobble_texture,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

local fence_steelblock_texture = "default_fence_overlay.png^default_steel_block.png^default_fence_overlay.png^[makealpha:255,126,126"
minetest.register_node("default:fence_steelblock", {
	description = "Steel Block Fence",
	drawtype = "fencelike",
	tiles = {"default_steel_block.png"},
	inventory_image = fence_steelblock_texture,
	wield_image = fence_steelblock_texture,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

local fence_brick_texture = "default_fence_overlay.png^default_brick.png^default_fence_overlay.png^[makealpha:255,126,126"
minetest.register_node("default:fence_brick", {
	description = "Brick Fence",
	drawtype = "fencelike",
	tiles = {"default_brick.png"},
	inventory_image = fence_brick_texture,
	wield_image = fence_brick_texture,
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:ladder", {
	description = "Ladder",
	drawtype = "nodebox",
	tiles = {"default_ladder_new.png"},
	inventory_image = "default_ladder_new_inv.png",
	wield_image = "default_ladder_new_inv.png",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	climbable = true,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.375, 0.4375, -0.5, 0.375, 0.5, 0.5},
		wall_bottom = {-0.375, -0.5, -0.5, 0.375, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.375, -0.4375, 0.5, 0.375},
	},
	selection_box = {type = "wallmounted"},
	groups = {choppy = 2,oddly_breakable_by_hand = 3, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:wood", {
	description = "Wooden Planks",
	tiles = {"default_wood.png"},
	groups = {choppy = 2,oddly_breakable_by_hand = 2, flammable = 3,wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:cloud", {
	description = "Cloud",
	sunlight_propagates = true,
	tiles = {"default_cloud.png"},
	sounds = default.node_sound_defaults(),
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("default:water_flowing", {
	description = "Flowing Water",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image = "default_water_flowing_animated.png",
			backface_culling=false,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		},
		{
			image = "default_water_flowing_animated.png",
			backface_culling=true,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		},
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 2,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:snow",
	post_effect_color = {a = 120, r = 20, g = 60, b = 80},
	groups = {water= 3, liquid = 3, puts_out_fire = 1, not_in_creative_inventory = 1, freezes = 1, melt_around = 1},
})

minetest.register_node("default:water_source", {
	description = "Water Source",
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{name = "default_water_source_animated.png", animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5}}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name = "default_water_source_animated.png",
			animation = {type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5},
			backface_culling = false,
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 2,
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = WATER_VISC,
	freezemelt = "default:ice",
	post_effect_color = {a = 120, r = 20, g = 60, b = 80},
	groups = {water= 3, liquid = 3, puts_out_fire = 1, freezes = 1},
})

--[[
function default.get_water_area_p0p1(pos)
	local p0 = {
		x = math.floor(pos.x / water.D) * water.D,
		y = math.floor(pos.y / water.D) * water.D,
		z = math.floor(pos.z / water.D) * water.D,
	}
	local p1 = {
		x = p0.x + water.D - 1,
		y = p0.y + water.D - 1,
		z = p0.z + water.D - 1
	}
	return p0, p1
end

water = {}
water.D = 4
water.sounds = {}

function default.update_water_sounds_around(pos)
	local p0, p1 = default.get_water_area_p0p1(pos)
	local cp = {x = (p0.x + p1.x) / 2, y = (p0.y + p1.y) / 2, z = (p0.z + p1.z) / 2}
	local water_p = minetest.find_nodes_in_area(p0, p1, {"default:water_flowing"})
	--  print("number of flames at "..minetest.pos_to_string(p0).."/"
	--	..minetest.pos_to_string(p1)..": "..#flames_p)
	local should_have_sound = (#water_p >= 20)
	local wanted_sound = nil
	if #water_p >= 20 then
		wanted_sound = {name = "waterfall"}
	end
	local p0_hash = minetest.hash_node_position(p0)
	local sound = water.sounds[p0_hash]
	if not sound then
		if should_have_sound then
			water.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos = cp, loop = true, max_hear_distance = 16}),
				name = wanted_sound.name,
			}
		end
	else
		if not wanted_sound then
			minetest.sound_stop(sound.handle)
			water.sounds[p0_hash] = nil
		elseif sound.name ~= wanted_sound.name then
			minetest.sound_stop(sound.handle)
			water.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos = cp, loop = true, max_hear_distance = 16}),
				name = wanted_sound.name,
			}
		end
	end
end

minetest.register_abm({
	nodenames = {"default:water_flowing"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		default.update_water_sounds_around(pos)
	end
})
--]]

minetest.register_node("default:lava_flowing", {
	description = "Flowing Lava",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "flowingliquid",
	tiles = {"default_lava.png"},
	special_tiles = {
		{
			image = "default_lava_flowing_animated.png",
			backface_culling = false,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5}
		},
		{
			image = "default_lava_flowing_animated.png",
			backface_culling = true,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5}
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 2,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	damage_per_second = 8,
	post_effect_color = {a = 220, r = 250, g = 70, b = 20},
	groups = {lava = 3, liquid = 2, hot = 3, igniter = 1, not_in_creative_inventory = 1},
})

minetest.register_node("default:lava_source", {
	description = "Lava Source",
	inventory_image = minetest.inventorycube("default_lava.png"),
	drawtype = "liquid",
	tiles = {
		{name = "default_lava_source_animated.png", animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 3.0}}
	},
	special_tiles = {
		-- New-style lava source material (mostly unused)
		{
			name = "default_lava_source_animated.png",
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 3.0},
			backface_culling = false,
		}
	},
	paramtype = "light",
	light_source = LIGHT_MAX,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 2,
	liquidtype = "source",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = LAVA_VISC,
	liquid_renewable = false,
	damage_per_second = 8,
	post_effect_color = {a = 220, r = 250, g = 70, b = 20},
	groups = {lava = 3, liquid = 2, hot = 3, igniter = 1},
})

--[[
function default.get_lava_area_p0p1(pos)
	local p0 = {
		x = math.floor(pos.x / lava.D) * lava.D,
		y = math.floor(pos.y / lava.D) * lava.D,
		z = math.floor(pos.z / lava.D) * lava.D,
	}
	local p1 = {
		x = p0.x + lava.D - 1,
		y = p0.y + lava.D - 1,
		z = p0.z + lava.D - 1
	}
	return p0, p1
end

lava = {}
lava.D = 4
lava.sounds = {}

function default.update_lava_sounds_around(pos)
	local p0, p1 = default.get_lava_area_p0p1(pos)
	local cp = {x = (p0.x + p1.x) / 2, y = (p0.y + p1.y) / 2, z = (p0.z + p1.z) / 2}
	local lava_p = minetest.find_nodes_in_area(p0, p1, {"default:lava_flowing"})
	--  print("number of flames at "..minetest.pos_to_string(p0).."/"
	--	..minetest.pos_to_string(p1)..": "..#flames_p)
	local should_have_sound = (#lava_p >= 40)
	local wanted_sound = nil
	if #lava_p >= 40 then
		wanted_sound = {name = "lava"}
	end
	local p0_hash = minetest.hash_node_position(p0)
	local sound = lava.sounds[p0_hash]
	if not sound then
		if should_have_sound then
			lava.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos = cp, loop = true}),
				name = wanted_sound.name,
			}
		end
	else
		if not wanted_sound then
			minetest.sound_stop(sound.handle)
			lava.sounds[p0_hash] = nil
		elseif sound.name ~= wanted_sound.name then
			minetest.sound_stop(sound.handle)
			lava.sounds[p0_hash] = {
				handle = minetest.sound_play(wanted_sound, {pos = cp, loop = true}),
				name = wanted_sound.name,
			}
		end
	end
end

minetest.register_abm({
	nodenames = {"default:lava_flowing"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		default.update_lava_sounds_around(pos)
	end
})
--]]

minetest.register_node("default:acid_flowing", {
	description = "Flowing Acid",
	inventory_image = minetest.inventorycube("default_acid.png"),
	drawtype = "flowingliquid",
	tiles = {"default_acid.png"},
	special_tiles = {
		{
			image = "default_acid_flowing_animated.png",
			backface_culling=false,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		},
		{
			image = "default_acid_flowing_animated.png",
			backface_culling=true,
			animation={type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 0.6}
		},
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 2,
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:acid_flowing",
	liquid_alternative_source = "default:acid_source",
	liquid_viscosity = WATER_VISC,
	damage_per_second = 3,
	post_effect_color = {a = 120, r = 50, g = 90, b = 30},
	groups = {water = 3, liquid = 3, puts_out_fire = 1, not_in_creative_inventory = 1},
})

minetest.register_node("default:acid_source", {
	description = "Acid Source",
	inventory_image = minetest.inventorycube("default_acid.png"),
	drawtype = "liquid",
	tiles = {
		{name = "default_acid_source_animated.png", animation={type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.5}}
	},
	special_tiles = {
		-- New-style acid source material (mostly unused)
		{
			name = "default_acid_source_animated.png",
			animation = {type = "vertical_frames", aspect_w= 16, aspect_h = 16, length = 1.5},
			backface_culling = false,
		}
	},
	alpha = WATER_ALPHA,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 2,
	liquidtype = "source",
	liquid_alternative_flowing = "default:acid_flowing",
	liquid_alternative_source = "default:acid_source",
	liquid_viscosity = WATER_VISC,
	damage_per_second = 3,
	post_effect_color = {a = 120, r = 50, g = 90, b = 30},
	groups = {water = 3, liquid = 3, puts_out_fire = 1},
})

minetest.register_node("default:torch", {
	description = "Torch",
	drawtype = "nodebox",
	tiles = {
		{name = "default_torch_new_top.png",    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0}},
		{name = "default_torch_new_bottom.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0}},
		{name = "default_torch_new_side.png",   animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0}},
	},
	inventory_image = "default_torch_new_inv.png",
	wield_image = "default_torch_new_inv.png",
	wield_scale = {x = 1, y = 1, z = 1.25},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.0625, -0.0625, -0.0625, 0.0625, 0.5   , 0.0625},
		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, 0.0625, 0.0625},
		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, 0.0625, 0.0625},
	},
	selection_box = {
		type = "wallmounted",
		wall_top    = {-0.25, -0.0625, -0.25, 0.25, 0.5   , 0.25},
		wall_bottom = {-0.25, -0.5   , -0.25, 0.25, 0.0625, 0.25},
		wall_side   = {-0.25, -0.5  , -0.25, -0.5, 0.0625, 0.25},
	},
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:sign_wall", {
	description = "Sign",
	drawtype = "nodebox",
	tiles = {"default_sign_new.png"},
	inventory_image = "default_sign_new_inv.png",
	wield_image = "default_sign_new_inv.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
		wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
		wall_side   = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
	},
	selection_box = {type = "wallmounted"},
	groups = {choppy = 2, dig_immediate = 2, attached_node = 1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		-- local n = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		-- print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		if minetest.is_protected(pos, sender:get_player_name()) then
			minetest.record_protection_violation(pos, sender:get_player_name())
			return
		end
		local meta = minetest.get_meta(pos)
		fields.text = fields.text or ""
		minetest.log("action", (sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos) .. ".")
		meta:set_string("text", fields.text)
		meta:set_string("infotext",  "\"" .. fields.text .. "\"")
	end,
})

default.chest_formspec = 
	"size[8,9]" ..
	gui_slots ..
	"list[current_name;main;0,0.3;8,4;]" ..
	"list[current_player;main;0,4.85;8,4;]" ..
	default.get_hotbar_bg(0, 4.85) ..
	default.get_hotbar_bg(0, 5.85)

function default.get_locked_chest_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]" ..
		gui_slots ..
		"list[nodemeta:".. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,4;]" ..
		default.get_hotbar_bg(0, 4.85) ..
		default.get_hotbar_bg(0, 5.85)
 return formspec
end


minetest.register_node("default:chest", {
	description = "Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {choppy = 2,oddly_breakable_by_hand = 2},
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.chest_formspec)
		meta:set_string("infotext", "Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos) .. ".")
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos) .. ".")
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos) .. ".")
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") and player:get_player_name() ~= minetest.setting_get("name") then
		return false
	end
	return true
end

minetest.register_node("default:chest_locked", {
	description = "Locked Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_lock.png"},
	paramtype2 = "facedir",
	groups = {choppy = 2,oddly_breakable_by_hand = 2},
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.get_locked_chest_formspec(pos))
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.get_locked_chest_formspec(pos))
		meta:set_string("owner", "")
		meta:set_string("infotext", "Locked Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and has_locked_chest_privilege(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return stack:get_count()
	end,
    on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos) .. ".")
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos) .. ".")
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos) .. ".")
	end,
})

function default.furnace_active(pos, percent, item_percent)
    local formspec = 
	"size[8,8.5]"..
	gui_slots..
	"list[current_name;src;2.75, 0.5;1,1;]" ..
	"list[current_name;fuel;2.75,2.5;1,1;]" ..
	"image[2.75,1.5;1,1;default_furnace_fire_bg.png^[lowpart:" ..
	(100-percent)..":default_furnace_fire_fg.png]" ..
        "image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:" ..
        (item_percent * 100)..":gui_furnace_arrow_fg.png^[transformR270]" ..
	"list[current_name;dst;4.75,0.96;2,2;]" ..
	"list[current_player;main;0,4.25;8,4;]" ..
	default.get_hotbar_bg(0, 4.25) ..
	default.get_hotbar_bg(0, 5.25)
    return formspec
  end

function default.get_furnace_active_formspec(pos, percent)
	local meta = minetest.get_meta(pos)local inv = meta:get_inventory()
	local srclist = inv:get_list("src")
	local cooked = nil
	local aftercooked = nil
	if srclist then
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
	end
	local item_percent = 0
	if cooked then
		item_percent = meta:get_float("src_time")/cooked.time
	end
       
        return default.furnace_active(pos, percent, item_percent)
end

default.furnace_inactive_formspec =
	"size[8,8.5]"..
	gui_slots..
	"list[current_name;src;2.75, 0.5;1,1;]" ..
	"list[current_name;fuel;2.75,2.5;1,1;]" ..
	"image[2.75,1.5;1,1;default_furnace_fire_bg.png]" ..
	"image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]" ..
	"list[current_name;dst;4.75, 0.96;2,2;]" ..
	"list[current_player;main;0,4.25;8,4;]" ..
	default.get_hotbar_bg(0, 4.25) ..
	default.get_hotbar_bg(0, 5.25)

minetest.register_node("default:furnace", {
	description = "Furnace",
	tiles = {"default_furnace_top.png", "default_furnace_bottom.png", "default_furnace_side.png",
		"default_furnace_side.png", "default_furnace_side.png", "default_furnace_front.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", "Furnace")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "fuel" then
			if minetest.get_craft_result({method = "fuel",width = 1, items ={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext","Furnace is empty")
				end
				return stack:get_count()
			else
				return 0
			end
		elseif listname == "src" then
			return stack:get_count()
		elseif listname == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if to_list == "fuel" then
			if minetest.get_craft_result({method = "fuel",width = 1, items ={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext","Furnace is empty")
				end
				return count
			else
				return 0
			end
		elseif to_list == "src" then
			return count
		elseif to_list == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
})

minetest.register_node("default:furnace_active", {
	description = "Furnace (active)",
	tiles = {
		"default_furnace_top.png",
		"default_furnace_bottom.png",
		"default_furnace_side.png",
		"default_furnace_side.png",
		"default_furnace_side.png",
		{
			image = "default_furnace_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1
			},
		}
	},
	paramtype2 = "facedir",
	light_source = 9,
	drop = "default:furnace",
	groups = {cracky = 2, not_in_creative_inventory = 1,hot= 1},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", "Furnace");
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "fuel" then
			if minetest.get_craft_result({method = "fuel",width = 1, items ={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext","Furnace is empty")
				end
				return stack:get_count()
			else
				return 0
			end
		elseif listname == "src" then
			return stack:get_count()
		elseif listname == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if to_list == "fuel" then
			if minetest.get_craft_result({method = "fuel",width = 1, items ={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext","Furnace is empty")
				end
				return count
			else
				return 0
			end
		elseif to_list == "src" then
			return count
		elseif to_list == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
})

-- Locked Furnace thanks to kotolegokot:

local function has_locked_furnace_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") and player:get_player_name() ~= minetest.setting_get("name") then
		return false
	end
	return true
end

minetest.register_node("default:furnace_locked", {
	description = "Locked Furnace",
	tiles = {"default_furnace_top.png", "default_furnace_bottom.png", "default_furnace_side.png",
		"default_furnace_side.png", "default_furnace_side.png", "default_furnace_lock.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("infotext", "Locked Furnace (owned by " .. placer:get_player_name() .. ")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", "Locked Furnace")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_furnace_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked furnace belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_furnace_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked furnace belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_furnace_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked furnace belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked furnace at "..minetest.pos_to_string(pos) ..".")
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked furnace at "..minetest.pos_to_string(pos) ..".")
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked furnace at "..minetest.pos_to_string(pos) ..".")
	end,
})

minetest.register_node("default:furnace_locked_active", {
	description = "Locked Furnace (active)",
	tiles = {
		"default_furnace_top.png",
		"default_furnace_bottom.png",
		"default_furnace_side.png",
		"default_furnace_side.png",
		"default_furnace_side.png",
		{
			image = "default_furnace_lock_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1
			},
		}
	},
	paramtype2 = "facedir",
	light_source = 9,
	drop = "default:furnace_locked",
	groups = {cracky = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name())
		meta:set_string("owner", "Locked Furnace (owned by " .. player:get_player_name() .. ")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", "Locked Furnace");
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_furnace_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked furnace belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_furnace_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked furnace belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_furnace_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked furnace belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos) .. ".")
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked furnace at "..minetest.pos_to_string(pos) .. ".")
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked furnace at "..minetest.pos_to_string(pos) .. ".")
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked furnace at "..minetest.pos_to_string(pos) .. ".")
	end,
})

minetest.register_abm({
	nodenames = {"default:furnace_locked","default:furnace_locked_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there's room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					-- print("Could not insert " .. cooked.item .. ".")
				end
				meta:set_string("src_time", 0)
			end
		end
	
		local item_percent = 0
		if cooked then
			item_percent = meta:get_float("src_time")/cooked.time
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Furnace active: " .. percent .. " % (owned by "..meta:get_string("owner") .. ")")
			swap_node(pos,"default:furnace_locked_active")
			meta:set_string("formspec",
				"invsize[8,8.5;]" .. gui_slots ..
				"image[2.75,1.5;1,1;default_furnace_fire_bg.png^[lowpart:" ..
				(100-percent)..":default_furnace_fire_fg.png]" ..
		        "image[3.75,1.5;1,1;gui_furnace_arrow_bg.png^[lowpart:" ..
						(item_percent * 100)..":gui_furnace_arrow_fg.png^[transformR270]" ..
				"list[current_name;src;2.75, 0.5;1,1;]" ..
				"list[current_name;fuel;2.75,2.5;1,1;]" ..
				"list[current_name;dst;4.75, 0.96;2,2;]" ..
				"list[current_player;main;0,4.25;8,4;]" ..
				default.get_hotbar_bg(0, 4.25) ..
				default.get_hotbar_bg(0, 5.25))
			return
		end

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext","Locked Furnace is out of fuel (owned by "..meta:get_string("owner")..")")
			swap_node(pos,"default:furnace_locked")
			meta:set_string("formspec", default.furnace_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext","Locked Furnace is empty (owned by "..meta:get_string("owner")..")")
				swap_node(pos,"default:furnace_locked")
				meta:set_string("formspec", default.furnace_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	end,
})

function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

minetest.register_abm({
	nodenames = {"default:furnace","default:furnace_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		local aftercooked
		
		if srclist then
			cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there"s room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					inv:set_stack("src", 1, aftercooked.items[1])
				else
					--print("Could not insert ""..cooked.item:to_string()..""")
				end
				meta:set_string("src_time", 0)
			end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Furnace active: "..percent.."%")
			swap_node(pos,"default:furnace_active")
			meta:set_string("formspec", default.get_furnace_active_formspec(pos, percent))
			return
		end

		local fuel = nil
		local afterfuel
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if not fuel or fuel.time <= 0 then
			meta:set_string("infotext","Furnace is out of fuel")
			swap_node(pos,"default:furnace")
			meta:set_string("formspec", default.furnace_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext","Furnace is empty")
				swap_node(pos,"default:furnace")
				meta:set_string("formspec", default.furnace_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		inv:set_stack("fuel", 1, afterfuel.items[1])
	end,
})

minetest.register_node("default:cobble", {
	description = "Cobblestone",
	tiles = {"default_cobble.png"},
	is_ground_content = true,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:cobble_cooled", {
	description = "Cobblestone (cooled)",
	tiles = {"default_cobble.png"},
	is_ground_content = true,
	drop = "default:cobble",
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_cobble", {
	description = "Desert Cobblestone",
	tiles = {"default_desert_cobble.png"},
	is_ground_content = true,
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:mossycobble", {
	description = "Mossy Cobblestone",
	tiles = {"default_mossycobble.png"},
	is_ground_content = true,
	drop = {
		items = {
			{items = {"default:mossycobble"}},
			--{items = {"maptools:silver_coin"}, rarity = 64},
		},
	},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:coalblock", {
	description = "Coal Block",
	tiles = {"default_coal_block.png"},
	is_ground_content = true,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:steelblock", {
	description = "Steel Block",
	tiles = {"default_steel_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 2, ingot_block = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:copperblock", {
	description = "Copper Block",
	tiles = {"default_copper_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 2, ingot_block = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:bronzeblock", {
	description = "Bronze Block",
	tiles = {"default_bronze_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 2, ingot_block = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:mese", {
	description = "Mese Block",
	tiles = {"default_mese_block.png"},
	is_ground_content = true,
	drop = {
		items = {
			{items = {"default:mese"}},
		--	{items = {"maptools:silver_coin"}, rarity = 32},
		},
	},
	groups = {cracky = 1, level = 2, fall_damage_add_percent = -75},
	sounds = default.node_sound_wood_defaults(), -- Intended.
})
minetest.register_alias("default:mese_block", "default:mese")

local function die_later(digger)
	digger:set_hp(0)
end

minetest.register_node("default:meze", {
	description = "Meze Block",
	tiles = {"default_meze_block.png"},
	is_ground_content = true,
	drop = "",
	groups = {cracky = 1, level = 2, fall_damage_add_percent = -75},
	sounds = default.node_sound_wood_defaults(), -- Intended.
	
	on_dig = function(pos, node, digger)
		if digger and minetest.setting_getbool("enable_damage") and not minetest.setting_getbool("creative_mode") then
			minetest.after(3, die_later, digger)
			minetest.chat_send_player(digger:get_player_name(), "You feel like you did a mistake.")
			minetest.node_dig(pos, node, digger)
		elseif digger then
			minetest.node_dig(pos, node, digger)
		end
	end,
})
minetest.register_alias("default:meze_block", "default:meze")

minetest.register_node("default:goldblock", {
	description = "Gold Block",
	tiles = {"default_gold_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, ingot_block = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:diamondblock", {
	description = "Diamond Block",
	tiles = {"default_diamond_block.png"},
	is_ground_content = true,
	groups = {cracky = 1, level = 3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:obsidian_glass", {
	description = "Obsidian Glass",
	drawtype = "glasslike_framed",
	tiles = {"default_obsidian_glass_frame.png", "default_obsidian_glass_detail.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky = 3,oddly_breakable_by_hand = 3},
})

minetest.register_node("default:obsidian", {
	description = "Obsidian",
	tiles = {"default_obsidian.png"},
	is_ground_content = true,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("default:obsidian_cooled", {
	description = "Obsidian (cooled)",
	tiles = {"default_obsidian.png"},
	is_ground_content = true,
	drop = "default:obsidian",
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("default:nyancat", {
	description = "Nyan Cat",
	tiles = {"default_nc_side.png", "default_nc_side.png", "default_nc_side.png",
		"default_nc_side.png", "default_nc_back.png", "default_nc_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = LIGHT_MAX,
	groups = {cracky = 2},
	is_ground_content = false,
	post_effect_color = {a = 128, r= 255, g= 128, b= 255},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:nyancat_rainbow", {
	description = "Nyan Cat Rainbow",
	drawtype = "glasslike",
	tiles = {"default_nc_rb.png^[transformR90", "default_nc_rb.png^[transformR90",
		"default_nc_rb.png", "default_nc_rb.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = LIGHT_MAX,
	sunlight_propagates = true,
	walkable = false,
	use_texture_alpha = true,
	climbable = true,
	groups = {cracky = 2},
	is_ground_content = false,
	post_effect_color = {a = 128, r= 255, g= 128, b= 255},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:sapling", {
	description = "Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_sapling.png"},
	inventory_image = "default_sapling.png",
	wield_image = "default_sapling.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy = 3, flammable = 2, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:apple", {
	description = "Apple",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_apple.png"},
	inventory_image = "default_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2, leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name = "default:apple", param2= 1})
		end
	end,
})

minetest.register_node("default:dry_shrub", {
	description = "Dry Shrub",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_dry_shrub.png"},
	inventory_image = "default_dry_shrub.png",
	wield_image = "default_dry_shrub.png",
	paramtype = "light",
	waving = 1,
	walkable = false,
	is_ground_content = true,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node("default:grass_1", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_1.png"},
	inventory_image = "default_grass_3.png", -- Use a bigger inventory image.
	wield_image = "default_grass_3.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
	on_place = function(itemstack, placer, pointed_thing)
		-- Place a random grass node:
		local stack = ItemStack("default:grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:grass_1 " .. itemstack:get_count() - (1 - ret:get_count()))
	end,
})

minetest.register_node("default:grass_2", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_2.png"},
	inventory_image = "default_grass_2.png",
	wield_image = "default_grass_2.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	drop = "default:grass_1",
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
})
minetest.register_node("default:grass_3", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_3.png"},
	inventory_image = "default_grass_3.png",
	wield_image = "default_grass_3.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	drop = "default:grass_1",
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
})

minetest.register_node("default:grass_4", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_4.png"},
	inventory_image = "default_grass_4.png",
	wield_image = "default_grass_4.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	drop = "default:grass_1",
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
})

minetest.register_node("default:grass_5", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_5.png"},
	inventory_image = "default_grass_5.png",
	wield_image = "default_grass_5.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	drop = "default:grass_1",
	groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
	},
})

minetest.register_node("default:ice", {
	description = "Ice",
	drawtype = "glasslike",
	tiles = {"default_ice.png"},
	is_ground_content = true,
	paramtype = "light",
	use_texture_alpha = true,
	freezemelt = "default:water_source",
	post_effect_color = {a = 120, r = 120, g = 160, b = 180},
	groups = {cracky = 3, melts = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("default:snow", {
	description = "Snow",
	tiles = {"default_snow.png"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	is_ground_content = true,
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	leveled = 7,
	drawtype = "nodebox",
	freezemelt = "default:water_flowing",
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.375, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, melts = 1, float = 1},
	sounds = default.node_sound_dirt_defaults({footstep = {name = "default_snow_footstep", gain = 0.7}}),
	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "default:dirt_with_grass" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
			pos.y = pos.y + 1
			minetest.remove_node(pos)
		end
	end,
})
minetest.register_alias("snow", "default:snow")

minetest.register_node("default:snowblock", {
	description = "Snow Block",
	tiles = {"default_snow.png"},
	is_ground_content = true,
	freezemelt = "default:water_source",
	groups = {crumbly = 3, melts = 1},
	sounds = default.node_sound_dirt_defaults({footstep = {name = "default_snow_footstep", gain = 0.625}}),
})

if minetest.setting_getbool("xray") then
	-- Nodes to make partially see-through:
	minetest.override_item("default:stone_with_coal",    {tiles = {"default_mineral_coal.png"}})
	minetest.override_item("default:stone_with_iron",    {tiles = {"default_mineral_iron.png"}})
	minetest.override_item("default:stone_with_copper",  {tiles = {"default_mineral_copper.png"}})
	minetest.override_item("default:stone_with_gold",    {tiles = {"default_mineral_gold.png"}})
	minetest.override_item("default:stone_with_mese",    {tiles = {"default_mineral_mese.png"}})
	minetest.override_item("default:stone_with_diamond", {tiles = {"default_mineral_diamond.png"}})
	minetest.override_item("default:stone_with_coin",    {tiles = {"maptools_gold_coin.png"}})
	
	-- Nodes to hide:
	minetest.override_item("default:stone",                     {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:dirt",                      {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:dirt_with_grass",           {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:dirt_with_grass_footsteps", {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:dirt_with_snow",            {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:water_source",              {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:water_flowing",             {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:leaves",                    {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:jungleleaves",              {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:gravel",                    {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:sand",                      {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:desert_sand",               {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:desert_stone",              {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:cobble",                    {drawtype = "airlike", pointable = false,})
	minetest.override_item("default:desert_cobble",             {drawtype = "airlike", pointable = false,})
end
