local load_time_start = os.clock()

local creative_enabled = minetest.setting_getbool("creative_mode")

local chests = {
	["default:chest"] = function(pu, pa, par, stuff)
		minetest.add_node(pu, {name="connected_chests:chest_left", param2=par})
		minetest.add_node(pa, {name="connected_chests:chest_right", param2=par})

		local meta = minetest.get_meta(pu)
		meta:set_string("formspec",
			"size[13,9]"..
			"list[current_name;main;0,0;13,5;]"..
			"list[current_player;main;2.5,5.2;8,4;]"
		)
		meta:set_string("infotext", "Big Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 65)
		inv:set_list("main", stuff)
	end,
	["default:chest_locked"] = function(pu, pa, par, stuff, name, owner)
		local owner = owner or name
		minetest.add_node(pu, {name="connected_chests:chest_locked_left", param2=par})
		minetest.add_node(pa, {name="connected_chests:chest_locked_right", param2=par})

		local meta = minetest.get_meta(pu)
		meta:set_string("owner", owner)
		meta:set_string("formspec",
			"size[13,9]"..
			"list[current_name;main;0,0;13,5;]"..
			"list[current_player;main;2.5,5.2;8,4;]"
		)
		meta:set_string("infotext", "Big Locked Chest (owned by "..
				meta:get_string("owner")..")")
		local inv = meta:get_inventory()
		inv:set_size("main", 65)
		inv:set_list("main", stuff)
	end,
}


local function get_pointed_info(pointed_thing, name)
	if not pointed_thing then
		return
	end
	local pu = minetest.get_pointed_thing_position(pointed_thing)
	local pa = minetest.get_pointed_thing_position(pointed_thing, true)
	if not (pu and pa) then
		return
	end
	if pu.y ~= pa.y then
		return
	end
	local nd_u = minetest.get_node(pu)
	if nd_u.name ~= name then
		return
	end
	return pu, pa, nd_u.param2
end

local param_tab = {
	["-1 0"] = 0,
	 ["1 0"] = 2,
	["0 -1"] = 3,
	 ["0 1"] = 1,
}

local param_tab2 = {}
for n,i in pairs(param_tab) do
	param_tab2[i] = n
end

local pars = {[0]=2, 3, 0, 1}

local function connect_chests(pu, pa, old_param2, name)
	local oldmeta = minetest.get_meta(pu)
	local stuff = oldmeta:get_inventory():get_list("main")
	local owner = oldmeta:get_string("owner")

	local par = param_tab[pu.x-pa.x.." "..pu.z-pa.z]
	local par_inverted = pars[par]
	if old_param2 == par_inverted then
		pu, pa = pa, pu
		par = par_inverted
	end

	chests[name](pu, pa, par, stuff, name, owner)
end

for name,_ in pairs(chests) do
	local place_chest = minetest.registered_nodes[name].on_place
	minetest.override_item(name, {
		on_place = function(itemstack, placer, pointed_thing)
			if not placer then
				return
			end
			local pu, pa, par2 = get_pointed_info(pointed_thing, name)
			if not (pu and placer:get_player_control().sneak) then
				return place_chest(itemstack, placer, pointed_thing)
			end
			local protected = minetest.is_protected(pa, placer:get_player_name())
			if protected then
				return
			end
			connect_chests(pu, pa, par2, name)
			if not creative_enabled then
				itemstack:take_item()
				return itemstack
			end
		end
	})
end

local function return_remove_next(allowed_name)
	local function remove_next(pos, oldnode)
		local x, z = unpack(string.split(param_tab2[oldnode.param2], " "))
		pos.x = pos.x-x
		pos.z = pos.z-z
		if minetest.get_node(pos).name == allowed_name then
			minetest.remove_node(pos)
		end
	end
	return remove_next
end

local function log_access(pos, player, text)
	minetest.log("action", player:get_player_name()..
		" moves stuff "..text.." at "..minetest.pos_to_string(pos))
end

local default_chest = minetest.registered_nodes["default:chest"]
minetest.register_node("connected_chests:chest_left", {
	tiles = {"connected_chests_top.png", "connected_chests_top.png", "default_obsidian_glass.png",
		"default_chest_side.png", "connected_chests_side.png^[transformFX", "connected_chests_side.png^connected_chests_front.png"},
	paramtype2 = "facedir",
	drop = "default:chest 2",
	groups = default_chest.groups,
	is_ground_content = default_chest.is_ground_content,
	sounds = default_chest.sounds,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 1.5, 0.5, 0.5},
		},
	},
	can_dig = default_chest.can_dig,
	after_dig_node = return_remove_next("connected_chests:chest_right"),
	on_metadata_inventory_move = function(pos, _, _, _, _, _, player)
		log_access(pos, player, "in a big chest")
	end,
	on_metadata_inventory_put = function(pos, _, _, _, player)
		log_access(pos, player, "to a big chest")
	end,
	on_metadata_inventory_take = function(pos, _, _, _, player)
		log_access(pos, player, "from a big chest")
	end,
})


local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

local default_chest_locked = minetest.registered_nodes["default:chest_locked"]
minetest.register_node("connected_chests:chest_locked_left", {
	tiles = {"connected_chests_top.png", "connected_chests_top.png", "default_obsidian_glass.png",
		"default_chest_side.png", "connected_chests_side.png^[transformFX", "connected_chests_side.png^connected_chests_lock.png"},
	paramtype2 = "facedir",
	drop = "default:chest_locked 2",
	groups = default_chest_locked.groups,
	is_ground_content = default_chest_locked.is_ground_content,
	sounds = default_chest_locked.sounds,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 1.5, 0.5, 0.5},
		},
	},
	can_dig = default_chest_locked.can_dig,
	after_dig_node = return_remove_next("connected_chests:chest_locked_right"),
	allow_metadata_inventory_move = default_chest_locked.allow_metadata_inventory_move,
	allow_metadata_inventory_put = default_chest_locked.allow_metadata_inventory_put,
	allow_metadata_inventory_take = default_chest_locked.allow_metadata_inventory_take,
	on_metadata_inventory_move = function(pos, _, _, _, _, _, player)
		log_access(pos, player, "in a big locked chest")
	end,
	on_metadata_inventory_put = function(pos, _, _, _, player)
		log_access(pos, player, "to a big locked chest")
	end,
	on_metadata_inventory_take = function(pos, _, _, _, player)
		log_access(pos, player, "from a big locked chest")
	end,
	on_rightclick = function(pos, _, clicker)
		local meta = minetest.get_meta(pos)
		if has_locked_chest_privilege(meta, clicker) then
			minetest.show_formspec(
				clicker:get_player_name(),
				"connected_chests:chest_locked_left",
				"size[13,9]"..
				"list[nodemeta:".. pos.x .. "," .. pos.y .. "," ..pos.z .. ";main;0,0;13,5;]"..
				"list[current_player;main;2.5,5.2;8,4;]"
			)
		end
	end,
})

minetest.register_node("connected_chests:chest_right", {
	tiles = {"connected_chests_top.png^[transformFX", "connected_chests_top.png^[transformFX", "default_chest_side.png",
		"default_obsidian_glass.png", "connected_chests_side.png", "connected_chests_side.png^connected_chests_front.png^[transformFX"},
	paramtype2 = "facedir",
	drop = "",
	pointable = false,
	diggable = false,
})

minetest.register_node("connected_chests:chest_locked_right", {
	tiles = {"connected_chests_top.png^[transformFX", "connected_chests_top.png^[transformFX", "default_chest_side.png",
		"default_obsidian_glass.png", "connected_chests_side.png", "connected_chests_side.png^connected_chests_lock.png^[transformFX"},
	paramtype2 = "facedir",
	drop = "",
	pointable = false,
	diggable = false,
})

for _,i in pairs({"chest", "chest_locked"}) do
	minetest.register_abm ({
		nodenames = {"connected_chests:"..i.."_right"},
		interval = 3,
		chance = 1,
		action = function (pos, node)
			local x, z = unpack(string.split(param_tab2[node.param2], " "))
			if minetest.get_node({x=pos.x+x, y=pos.y, z=pos.z+z}).name ~= "connected_chests:"..i.."_left" then
				minetest.remove_node(pos)
			end
		end,
	})
	minetest.register_abm ({
		nodenames = {"connected_chests:"..i.."_left"},
		interval = 3,
		chance = 1,
		action = function (pos, node)
			local par = node.param2
			local x, z = unpack(string.split(param_tab2[par], " "))
			pos = {x=pos.x-x, y=pos.y, z=pos.z-z}
			if minetest.get_node(pos).name == "air" then
				minetest.set_node(pos, {name="connected_chests:"..i.."_right", param2=par})
			end
		end,
	})
end

local time = math.floor(tonumber(os.clock()-load_time_start)*100+0.5)/100
local msg = "[connected_chests] loaded after ca. "..time
if time > 0.05 then
	print(msg)
else
	minetest.log("info", msg)
end
