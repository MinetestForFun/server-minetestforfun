
local get_pos_all = function(pos, dir)
	local posall
	if dir == 0 then
		posall = { {x=pos.x, y=pos.y, z=pos.z}, {x=pos.x+1, y=pos.y, z=pos.z},  {x=pos.x, y=pos.y+1, z=pos.z}, {x=pos.x+1, y=pos.y+1, z=pos.z} }
	elseif dir == 1 then
		posall = { {x=pos.x, y=pos.y, z=pos.z}, {x=pos.x, y=pos.y, z=pos.z-1}, {x=pos.x, y=pos.y+1, z=pos.z}, {x=pos.x, y=pos.y+1, z=pos.z-1} }
	elseif dir == 2 then
		posall = { {x=pos.x, y=pos.y, z=pos.z}, {x=pos.x-1, y=pos.y, z=pos.z}, {x=pos.x, y=pos.y+1, z=pos.z}, {x=pos.x+-1, y=pos.y+1, z=pos.z} }
	elseif dir == 3 then
		posall = { {x=pos.x, y=pos.y, z=pos.z}, {x=pos.x, y=pos.y, z=pos.z+1},  {x=pos.x, y=pos.y+1, z=pos.z}, {x=pos.x, y=pos.y+1, z=pos.z+1} }
	end
	return posall
end

minetest.register_node("minesimon:game_placer", {
	description = "minesimon Placer Game",
	tiles = {
		"minesimon_game_placer.png", "minesimon_game_placer.png",
		"minesimon_game_placer.png", "minesimon_game_placer.png",
		"minesimon_game_placer.png", "minesimon_game_placer.png"
	},
	drawtype = "normal",
	paramtype2 = "facedir",
	is_ground_content = false,
	sunlight_propagates = true,
	drop = "",
	groups = {oddly_breakable_by_hand=1},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end
		local pt = pointed_thing.above
		local dir = minetest.dir_to_facedir(placer:get_look_dir())
		local posall = get_pos_all(pt, dir)

		for _, p in pairs(posall) do
			local node = minetest.get_node_or_nil(p)
			if not node or node.name ~= "air" then
				--print("node:"..dump(node))
				return itemstack
			end
			if minetest.is_protected(p, placer:get_player_name()) then
				--print("protected")
				minetest.record_protection_violation(p, placer:get_player_name())
				return itemstack
			end
		end

		for i, p in pairs(posall) do
			minetest.set_node(p, {name = "minesimon:note_"..i.."_off", param2 = dir})
			local meta = minetest.get_meta(p)
			meta:set_string("infotext", "Rightclick to play")
		end
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
})



for i=1, 4 do
	minetest.register_node("minesimon:note_"..i.."_on", {
		description = "minesimon Note "..i.." on",
		tiles = {
			"minesimon_note_"..i..".png", "minesimon_note_"..i..".png",
			"minesimon_note_"..i..".png", "minesimon_note_"..i..".png",
			"minesimon_note_"..i..".png", "minesimon_note_"..i..".png"
		},
		drawtype = "normal",
		paramtype2 = "facedir",
		is_ground_content = false,
		sunlight_propagates = true,
		drop = "",
		groups = {unbreakable=1, not_in_creative_inventory=1},
		light_source = 15,
	})

	minetest.register_node("minesimon:note_" .. i .. "_off", {
		description = "minesimon Note "..i.." off",
		tiles = {
			"minesimon_note_"..i..".png", "minesimon_note_"..i..".png",
			"minesimon_note_"..i..".png", "minesimon_note_"..i..".png",
			"minesimon_note_"..i..".png", "minesimon_note_"..i..".png"
		},
		drawtype = "normal",
		paramtype2 = "facedir",
		is_ground_content = false,
		sunlight_propagates = true,
		drop = "",
		groups = {unbreakable=1,not_in_creative_inventory=1},

		on_rightclick = function(pos, node, player, itemstack, pointed_thing)
			if not player then return end
			local playername = player:get_player_name()
			local onepos = minesimon.get_one_pos(pos, node.param2, i)
			local str_pos = minesimon.get_name_pos(onepos)
			minesimon.start_game(playername, onepos, str_pos, pos, node.param2, i)
		end,

		on_punch = function(pos, node, puncher, pointed_thing)
			if not puncher then return end
			local playername = puncher:get_player_name()
			local onepos = minesimon.get_one_pos(pos, node.param2, i)
			local str_pos = minesimon.get_name_pos(onepos)
			if not minesimon["games"][str_pos] or minesimon["games"][str_pos]["ingame"] == false or minesimon["games"][str_pos]["wait"] ~= false then return end

			if minesimon["games"][str_pos]["player"] ~= playername then
				local t1 = minesimon["games"][str_pos]["last_punch"]
				if math.ceil((os.clock() - t1) * 10) > 100 then
					minesimon["players"][minesimon["games"][str_pos]["player"]] = false
					minesimon["games"][str_pos]["ingame"] = false
					minesimon["games"][str_pos]["player"] = false
				end
				return
			end
			minesimon.get_correct(playername, str_pos, i)
		end,

		can_dig = function(pos, player)
			if i ~= 1 then return false end
			if minetest.is_protected(p, player:get_player_name()) then
				minetest.record_protection_violation(p, player:get_player_name())
				return false
			end
			return true
		end,

		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			if i == 1 then
				local dir = oldnode.param2
				local posall = get_pos_all(pos, dir)
				for i, p in pairs(posall) do
					minetest.remove_node(p)
				end
			end
		end,
	})
end

