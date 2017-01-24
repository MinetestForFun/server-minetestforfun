-- Minetest 0.5 mod: bones
-- See README.txt for licensing and other information.
--REVISED 20151117 by maikerumine for adding bones to inventory after punch


bones = {}
local share_bones_time = (tonumber(minetest.setting_get("share_bones_time")) or 1800)

bones.bones_formspec =
	"size[14,9]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;main;0,0.3;14,4;]"..
	"list[current_player;main;3,4.85;8,1;]"..
	"list[current_player;main;3,6.08;8,3;8]"..
	"listring[current_name;main]"..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(3,4.85)


minetest.register_node("bones:bones", {
	description = "Bones",
	tiles = {
		"bones_top.png",
		"bones_bottom.png",
		"bones_side.png",
		"bones_side.png",
		"bones_rear.png",
		"bones_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	stack_max = 999,
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		return stack:get_count()
	end,


	on_punch = function(pos, node, player)
		-- only owner can punch bones to directly add to inventory
		local owner = minetest.get_meta(pos):get_string("owner")
		if owner ~= player:get_player_name() then
			return
		end

		local inv = minetest.get_meta(pos):get_inventory()
		local player_inv = player:get_inventory()

		for i=1, inv:get_size("main") do
			local stk = inv:get_stack("main", i)
			if player_inv:room_for_item("main", stk) then
				inv:set_stack("main", i, nil)
				player_inv:add_item("main", stk)
			end
		end

		if inv:is_empty("main") then
			minetest.remove_node(pos)
		end
	end,

	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		if meta:get_inventory():is_empty("main") then
			minetest.remove_node(pos)
			return
		end

		local time = meta:get_int("time") + elapsed
		if time < share_bones_time then
			meta:set_int("time", time)
			return true
		else
			minetest.remove_node(pos)
		end
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "main", drops)
		drops[#drops+1] = "bones:bones"
		minetest.remove_node(pos)
		return drops
	end,
})

local find_best_node = function(pos)
	local nodes = minetest.find_nodes_in_area(
		{x=pos.x-2,y=pos.y, z=pos.z-2},
		{x=pos.x+2,y=pos.y+2, z=pos.z+2},
		{"air"}
	)
	if #nodes > 0 then
		return nodes[1]
	end

	nodes = minetest.find_nodes_in_area(
		{x=pos.x-2,y=pos.y, z=pos.z-2},
		{x=pos.x+2,y=pos.y+2, z=pos.z+2},
		{"group:liquid"}
	)
	if #nodes > 0 then
		return nodes[1]
	end

	nodes = minetest.find_nodes_in_area(
		{x=pos.x-2,y=pos.y, z=pos.z-2},
		{x=pos.x+2,y=pos.y+2, z=pos.z+2},
		{"group:leaves", "group:plant", "group:flower"}
	)
	if #nodes > 0 then
		return nodes[1]
	end
	return nil
end


minetest.register_on_dieplayer(function(player)
	if minetest.setting_getbool("creative_mode") or not player then
		return
	end
	local player_name = player:get_player_name()
	if player_name == "" then return end

	local pos = player:getpos()
	pos.y = math.floor(pos.y + 0.5)

	minetest.chat_send_player(player_name, 'Died at '..math.floor(pos.x)..','..math.floor(pos.y)..','..math.floor(pos.z))

	local bones_pos = nil
	local node = minetest.get_node_or_nil(pos)
	if node and node.name == "air" then
		bones_pos = pos
	else
		bones_pos = find_best_node(pos)
	end
	if not bones_pos then return end -- no pos to place bones

	minetest.set_node(bones_pos, {name="bones:bones"})

	local meta = minetest.get_meta(bones_pos)
	meta:set_string("formspec", bones.bones_formspec)
	meta:set_string("owner", player_name)
	meta:set_string("infotext", player_name.."'s bones")
	local time = os.date("*t")
	meta:set_int("time", 0)

	local bones_inv = meta:get_inventory()
	bones_inv:set_size("main", 14*4)


	local player_inv = player:get_inventory()
	-- main inventory
	for i=1, player_inv:get_size("main") do
		local stack = player_inv:get_stack("main", i)
		if stack then
			local stack_name = stack:get_name()
			if not pclasses.data.reserved_items[stack_name] or
			not pclasses.api.util.can_have_item(player_name, stack_name) then
				bones_inv:add_item("main", stack)
				player_inv:set_stack("main", i, nil)
			end
		end
	end

	-- craft inventory
	for i=1, player_inv:get_size("craft") do
		local stack = player_inv:get_stack("craft", i)
		if stack then
			bones_inv:add_item("main", stack)
			player_inv:set_stack("craft", i, nil)
		end
	end

	-- unified_inventory bags
	if minetest.get_modpath("unified_inventory") then
		for n = 1, 4 do
			local stack = unified_inventory.extract_bag(player, n)
			if stack then
				bones_inv:add_item("main", stack)
			end
		end
	end

	--3d_armor
	if minetest.get_modpath("3d_armor") then
		local name, player_inv, armor_inv, pos = armor:get_valid_player(player, "[on_dieplayer]")
		if name then
			for i=1, player_inv:get_size("armor") do
				local stack = armor_inv:get_stack("armor", i)
				if stack:get_count() > 0 and (not pclasses.data.reserved_items[stack:get_name()] or
				not pclasses.api.util.can_have_item(name, stack:get_name())) then
					bones_inv:add_item("main", stack)
					armor_inv:set_stack("armor", i, nil)
					player_inv:set_stack("armor", i, nil)
				end
			end
			armor:set_player_armor(player)
		end
	end
	minetest.chat_send_player(player_name, 'Your bones is at '..math.floor(bones_pos.x)..','..math.floor(bones_pos.y)..','..math.floor(bones_pos.z))
	minetest.get_node_timer(bones_pos):start(10)
end)

