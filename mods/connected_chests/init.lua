local load_time_start = os.clock()

local creative_enabled = minetest.setting_getbool("creative_mode")

local big_formspec = "size[13,9]"..
	"list[current_name;main;0,0;13,5;]"..
	"list[current_player;main;2.5,5.2;8,4;]"..
	"listring[current_name;main]"..
	"listring[current_player;main]"

local chests = {
	["default:chest"] = function(pu, pa, par, stuff)
		minetest.add_node(pu, {name="connected_chests:chest_left", param2=par})
		minetest.add_node(pa, {name="connected_chests:chest_right", param2=par})

		local meta = minetest.get_meta(pu)
		meta:set_string("formspec", big_formspec)
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
		meta:set_string("formspec", big_formspec)
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
	if not pu
	or not pa
	or pu.y ~= pa.y then
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
			if not pu
			or not placer:get_player_control().sneak then
				return place_chest(itemstack, placer, pointed_thing)
			end
			if minetest.is_protected(pa, placer:get_player_name()) then
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
		if oldnode.param2 > 3 then
			return
		end
		local x, z = unpack(string.split(param_tab2[oldnode.param2], " "))
		pos.x = pos.x-x
		pos.z = pos.z-z
		if minetest.get_node(pos).name == allowed_name then
			minetest.remove_node(pos)
		end
	end
	return remove_next
end

local function return_add_next(right_name)
	local function add_next(pos, node)
		node = node or minetest.get_node(pos)
		local par = node.param2
		if par > 3 then
			node.param2 = 0
			minetest.set_node(pos, node)
			return
		end
		local x, z = unpack(string.split(param_tab2[par], " "))
		pos.x = pos.x-x
		pos.z = pos.z-z
		if minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name=right_name, param2=par})
		end
	end
	return add_next
end


local function log_access(pos, player, text)
	minetest.log("action", player:get_player_name()..
		" moves stuff "..text.." at "..minetest.pos_to_string(pos))
end


-- Adds the big chests

local top_texture = "connected_chests_top.png^default_chest_top.png^([combine:16x16:5,0=default_chest_top.png^connected_chests_frame.png^[makealpha:255,126,126)^connected_chests_top.png"
local side_texture = "connected_chests_side.png^default_chest_side.png^([combine:16x16:5,0=default_chest_side.png^connected_chests_frame.png^[makealpha:255,126,126)^connected_chests_side.png"

local chest = table.copy(minetest.registered_nodes["default:chest"])
chest.description = nil
chest.legacy_facedir_simple = nil
chest.after_place_node = nil
chest.on_receive_fields = nil
chest.tiles = {top_texture, top_texture, "default_obsidian_glass.png",
	"default_chest_side.png", side_texture.."^[transformFX", side_texture.."^connected_chests_front.png"}
chest.drop = "default:chest 2"
chest.selection_box = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 1.5, 0.5, 0.5},
	},
}
chest.on_construct = return_add_next("connected_chests:chest_right")
chest.after_destruct = return_remove_next("connected_chests:chest_right")
chest.on_metadata_inventory_move = function(pos, _, _, _, _, _, player)
	log_access(pos, player, "in a big chest")
end
chest.on_metadata_inventory_put = function(pos, _, _, _, player)
	log_access(pos, player, "to a big chest")
end
chest.on_metadata_inventory_take = function(pos, _, _, _, player)
	log_access(pos, player, "from a big chest")
end

minetest.register_node("connected_chests:chest_left", chest)


local chest_locked = table.copy(minetest.registered_nodes["default:chest_locked"])
chest_locked.description = nil
chest_locked.legacy_facedir_simple = nil
chest_locked.after_place_node = nil
chest_locked.on_construct = nil
chest_locked.on_receive_fields = nil
chest_locked.tiles = {top_texture, top_texture, "default_obsidian_glass.png",
	"default_chest_side.png", side_texture.."^[transformFX", side_texture.."^connected_chests_front.png^connected_chests_lock.png"}
chest_locked.drop = "default:chest_locked 2"
chest_locked.selection_box = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 1.5, 0.5, 0.5},
	},
}
chest_locked.on_construct = return_add_next("connected_chests:chest_locked_right")
chest_locked.after_destruct = return_remove_next("connected_chests:chest_locked_right")
chest_locked.on_metadata_inventory_move = function(pos, _, _, _, _, _, player)
	log_access(pos, player, "in a big locked chest")
end
chest_locked.on_metadata_inventory_put = function(pos, _, _, _, player)
	log_access(pos, player, "to a big locked chest")
end
chest_locked.on_metadata_inventory_take = function(pos, _, _, _, player)
	log_access(pos, player, "from a big locked chest")
end
chest_locked.on_rightclick = function(pos, _, clicker)
	local meta = minetest.get_meta(pos)
	if clicker:get_player_name() == meta:get_string("owner") or clicker:get_player_name() == minetest.setting_get("name") then
		minetest.show_formspec(
			clicker:get_player_name(),
			"connected_chests:chest_locked_left",
			"size[13,9]"..
			"list[nodemeta:".. pos.x .. "," .. pos.y .. "," ..pos.z .. ";main;0,0;13,5;]"..
			"list[current_player;main;2.5,5.2;8,4;]"
		)
	end
end

minetest.register_node("connected_chests:chest_locked_left", chest_locked)


local tube_to_left, tube_to_left_locked, tube_update, tube_groups
if minetest.global_exists("pipeworks") then
	tube_to_left_locked = {
		insert_object = function(pos, node, stack)
			local x, z = unpack(string.split(param_tab2[node.param2], " "))
			return minetest.get_meta({x=pos.x+x, y=pos.y, z=pos.z+z}):get_inventory():add_item("main", stack)
		end,
		can_insert = function(pos, node, stack)
			local x, z = unpack(string.split(param_tab2[node.param2], " "))
			return minetest.get_meta({x=pos.x+x, y=pos.y, z=pos.z+z}):get_inventory():room_for_item("main", stack)
		end,
		connect_sides = {right = 1, back = 1, front = 1, bottom = 1, top = 1}
	}

	tube_to_left = table.copy(tube_to_left_locked)
	tube_to_left.input_inventory = "main"

	tube_update = pipeworks.scan_for_tube_objects

	tube_groups = {tubedevice=1, tubedevice_receiver=1}
else
	function tube_update() end
end

minetest.register_node("connected_chests:chest_right", {
	tiles = {top_texture.."^[transformFX", top_texture.."^[transformFX", "default_chest_side.png",
		"default_obsidian_glass.png", side_texture, side_texture.."^connected_chests_front.png^[transformFX"},
	paramtype2 = "facedir",
	drop = "",
	pointable = false,
	diggable = false,
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		if node.param2 > 3 then
			node.param2 = node.param2%4
			minetest.set_node(pos, node)
			return
		end
		local x, z = unpack(string.split(param_tab2[node.param2], " "))
		local node_left = minetest.get_node({x=pos.x+x, y=pos.y, z=pos.z+z})
		if node_left.name ~= "connected_chests:chest_left"
		or node_left.param2 ~= node.param2 then
			minetest.remove_node(pos)
			return
		end
		tube_update(pos)
	end,
	after_destruct = function(pos, oldnode)
		if oldnode.param2 > 3 then
			return
		end
		local x, z = unpack(string.split(param_tab2[oldnode.param2], " "))
		local node_left = minetest.get_node({x=pos.x+x, y=pos.y, z=pos.z+z})
		if node_left.name == "connected_chests:chest_left"
		and node_left.param2 == oldnode.param2
		and minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, oldnode)
			return
		end
		tube_update(pos)
	end,
	tube = tube_to_left,
	groups = tube_groups,
})

minetest.register_node("connected_chests:chest_locked_right", {
	tiles = {top_texture.."^[transformFX", top_texture.."^[transformFX", "default_chest_side.png",
		"default_obsidian_glass.png", side_texture, side_texture.."^connected_chests_front.png^connected_chests_lock.png^[transformFX"},
	paramtype2 = "facedir",
	drop = "",
	pointable = false,
	diggable = false,
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		if node.param2 > 3 then
			node.param2 = node.param2%4
			-- ↓ calls the on_construct from the beginning again
			minetest.set_node(pos, node)
			return
		end
		local x, z = unpack(string.split(param_tab2[node.param2], " "))
		local node_left = minetest.get_node({x=pos.x+x, y=pos.y, z=pos.z+z})
		if node_left.name ~= "connected_chests:chest_locked_left"
		or node_left.param2 ~= node.param2 then
			minetest.remove_node(pos)
			return
		end
		tube_update(pos)
	end,
	after_destruct = function(pos, oldnode)
		if oldnode.param2 > 3 then
			return
		end
		local x, z = unpack(string.split(param_tab2[oldnode.param2], " "))
		local node_left = minetest.get_node({x=pos.x+x, y=pos.y, z=pos.z+z})
		if node_left.name == "connected_chests:chest_locked_left"
		and node_left.param2 == oldnode.param2
		and minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, oldnode)
			return
		end
		tube_update(pos)
	end,
	tube = tube_to_left_locked,
	groups = tube_groups,
})

-- abms to fix half chests
for _,i in pairs({"chest", "chest_locked"}) do
	minetest.register_abm ({
		nodenames = {"connected_chests:"..i.."_right"},
		interval = 10,
		chance = 1,
		action = function (pos, node)
			if node.param2 > 3 then
				node.param2 = node.param2%4
				minetest.set_node(pos, node)
				return
			end
			local x, z = unpack(string.split(param_tab2[node.param2], " "))
			local left_node = minetest.get_node({x=pos.x+x, y=pos.y, z=pos.z+z})
			if left_node.name ~= "connected_chests:"..i.."_left"
			or left_node.param2 ~= node.param2 then
				minetest.remove_node(pos)
			end
		end,
	})
	minetest.register_abm ({
		nodenames = {"connected_chests:"..i.."_left"},
		interval = 3,
		chance = 1,
		action = return_add_next("connected_chests:"..i.."_right"),
	})
end

local time = math.floor(tonumber(os.clock()-load_time_start)*100+0.5)/100
local msg = "[connected_chests] loaded after ca. "..time
if time > 0.05 then
	print(msg)
else
	minetest.log("info", msg)
end
