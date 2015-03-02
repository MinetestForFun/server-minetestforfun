local inbox = {}

--[[
TODO
* Different node_box and texture for empty mailbox
]]

minetest.register_craft({
	output ="inbox:empty",
	recipe = {
		{"","default:steel_ingot",""},
		{"default:steel_ingot","","default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"}
	}
})

minetest.register_node("inbox:empty", {
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-4/12, -6/12, -6/12, 4/12, 0/12, 6/12},
			{-3/12, 0/12, -6/12, 3/12, 2/12, 6/12},
			{3/12, 0/12, -4/12, 4/12, 5/12, -2/12},
			{3/12, 3/12, -2/12, 4/12, 5/12, 0/12}
		}
	},
	description = "Mailbox",
	tiles = {"inbox_top.png", "inbox_bottom.png", "inbox_east.png",
		"inbox_west.png", "inbox_back.png", "inbox_front.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()
		meta:set_string("owner", owner)
		meta:set_string("infotext", owner.."'s Mailbox")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		inv:set_size("drop", 1)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		local player = clicker:get_player_name()
		local owner  = meta:get_string("owner")
		local meta = minetest.get_meta(pos)
		if owner == player then
			minetest.show_formspec(
				clicker:get_player_name(),
				"default:chest_locked",
				inbox.get_inbox_formspec(pos))
		else
			minetest.show_formspec(
				clicker:get_player_name(),
				"default:chest_locked",
				inbox.get_inbox_insert_formspec(pos))
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local owner = meta:get_string("owner")
		local inv = meta:get_inventory()
		return player:get_player_name() == owner and inv:is_empty("main")
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "drop" and inv:room_for_item("main", stack) then
			inv:remove_item("drop", stack)
			inv:add_item("main", stack)
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if listname == "main" then
			return 0
		end
		if listname == "drop" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			if inv:room_for_item("main", stack) then
				return -1
			else
				return 0
			end
		end
	end,
})

function inbox.get_inbox_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		"list[nodemeta:".. spos .. ";main;0,0;8,4;]"..
		"list[current_player;main;0,5;8,4;]"
	return formspec
end

function inbox.get_inbox_insert_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec =
		"size[8,9]"..
		"list[nodemeta:".. spos .. ";drop;3.5,2;1,1;]"..
		"list[current_player;main;0,5;8,4;]"
	return formspec
end

print("[Mod]Inbox Loaded!")
