local img = {"eye", "men", "sun"}

for i=1,3 do
	minetest.register_node("tsm_pyramids:deco_stone"..i, {
		description = "Sandstone with "..img[i],
		tiles = {"default_sandstone.png^tsm_pyramids_"..img[i]..".png"},
		is_ground_content = false,
		groups = {unbreakable=1},
		sounds = default.node_sound_stone_defaults(),
	})
end

local trap_on_timer = function (pos, elapsed)
	local objs = minetest.get_objects_inside_radius(pos, 2)
	for i, obj in pairs(objs) do
		if obj:is_player() then
			local n = minetest.get_node(pos)
			if n and n.name and minetest.registered_nodes[n.name].crack < 2 then
				minetest.set_node(pos, {name="tsm_pyramids:trap_2"})
				nodeupdate(pos)
			end
		end
	end
	return true
end

minetest.register_node("tsm_pyramids:trap", {
	description = "Cracked sandstone brick",
	tiles = {"default_sandstone_brick.png^tsm_pyramids_crack.png"},
	is_ground_content = false,
	groups = {crumbly=2,cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(0.1)
	end,
	crack = 1,
	on_timer = trap_on_timer,
	drop = "",
})

minetest.register_node("tsm_pyramids:trap_2", {
	description = "trapstone",
	tiles = {"default_sandstone_brick.png^tsm_pyramids_crack.png^[transformR90"},
	is_ground_content = false,
	groups = {crumbly=2,cracky=3,falling_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	drop = "",
})

local chestdef = minetest.registered_nodes["default:chest"]
minetest.register_node("tsm_pyramids:chest",{
	description = "tsm_pyramids Chest auto refilled",
	tiles = chestdef.tiles,
	stack_max = 1000,
	paramtype2 = "facedir",
	is_ground_content = false,
	on_construct = function(pos)
		chestdef.on_construct(pos)
		minetest.get_node_timer(pos):start(pyramids.max_time)
		pyramids.fill_chest(pos)
	end,
	on_metadata_inventory_move = chestdef.on_metadata_inventory_move,
	on_metadata_inventory_put  = chestdef.on_metadata_inventory_put,
	on_metadata_inventory_take = chestdef.on_metadata_inventory_take,
	groups = {unbreakable = 1, not_in_creative_inventory = 1},
	on_timer = function (pos, elapsed)
		pyramids.fill_chest(pos)
		return true
	end,
})

