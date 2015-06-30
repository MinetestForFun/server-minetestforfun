-- API of the rune mod --

-- Global namespace
runes = {}
runes.datas = {}
runes.datas.handlers = {}
runes.datas.items = {}
runes.datas.amulets = {}
runes.functions = {}

-- Simple rune register function
runes.functions.register_rune = function(parameters)
	local runedef = {}

	if not parameters.name then
		minetest.log("ERROR","[runes] Cannot register rune : no name")
		return
	end

	runedef.name = parameters.name
	runedef.desc = parameters.description or ""
	runedef.img  = parameters.img or "default_stone.png"
	if type(runedef.img) ~= "table" then
		runedef.img = {
			["minor"] = runedef.img .. "_minor.png",
			["medium"] = runedef.img .. "_medium.png",
			["major"] = runedef.img .. "_major.png",
		}
	end
	runedef.type = parameters.type or "craftitem"
	runedef.needed_mana = parameters.needed_mana or {["minor"] = 0, ["medium"] = 5, ["major"] = 10}

	runes.datas.handlers[runedef.name] = {}

	if runedef.type == "cube" then
		for _, level in pairs({"minor", "medium", "major"}) do
			minetest.register_node("runes:rune_" .. runedef.name .. "_" .. level, {
				description = runedef.desc .. " ("..level..")",
				tiles = {runedef.img[level]},
				groups = {oddly_breakable_by_hand = 2, rune = 1},
				after_place_node = function(pos, placer, itemstack, pointed_thing)
					if placer and placer:is_player() then
						local meta = minetest.get_meta(pos)
						meta:set_string("owner",placer:get_player_name())
					end
					if runes.datas.handlers[runedef.name].on_place then
						if mana.get(placer:get_player_name()) >= runedef.needed_mana[level] then
							local answer = runes.datas.handlers[runedef.name].on_place(level, pos, placer, itemstack, pointed_thing)
							-- True answer leads to no dicrease (generally because the handler did it itself)
							if not answer then
								mana.subtract(placer:get_player_name(),runedef.needed_mana[level])
							end
						else
							minetest.chat_send_player(placer:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana[level] ..")")
						end
					end
				end,
				can_dig = function(pos, player)
					if runes.datas.handlers[runedef.name].can_dig then
						return runes.datas.handlers[runedef.name].can_dig(level, pos, player)
					else
						return true
					end
				end,
				on_punch = function(pos, node, puncher, pointed_thing)
					if runes.datas.handlers[runedef.name].on_punch then
						if mana.get(puncher:get_player_name()) >= runedef.needed_mana[level] then
							runes.datas.handlers[runedef.name].on_punch(level, pos, node, puncher, pointed_thing)
							mana.subtract(puncher:get_player_name(),runedef.needed_mana[level])
						else
							minetest.chat_send_player(puncher:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana[level] ..")")
						end
					end
				end,
				--[[after_dig_node = function(pos, oldnode, oldmetadata, digger)
						--if runes.datas.handlers[runedef.name].can_dig and runes.datas.handlers[runedef.name].can_dig(pos, digger) then
						if runes.datas.handlers[runedef.name].on_dig then
							if mana.get(digger:get_player_name()) >= runedef.needed_mana[level] then
								runes.datas.handlers[runedef.name].on_dig(pos, oldnode, digger)
								mana.subtract(digger:get_player_name(),runedef.needed_mana)
							else
								minetest.chat_send_player(digger:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana[level] ..")")
							end
						end
					end
				end,]]
			})
		end

	elseif runedef.type == "plate" then
		for _, level in pairs({"minor", "medium", "major"}) do
			minetest.register_node("runes:rune_" .. runedef.name .. "_" .. level, {
				description = runedef.desc .. " (" .. level .. ")",
				paramtype = "light",
				inventory_image = runedef.img[level],
				sunlight_propagates = true,
				walkable = false,
				tiles = {runedef.img[level]},
				groups = {rune = 1, oddly_breakable_by_hand = 2},
				drawtype = "nodebox",
				node_box = {
					type = "fixed",
					fixed = {
						{-0.5, -0.5, -0.5, 0.5, -0.499, 0.5},
					}
				},
				after_place_node = function(pos, placer, itemstack, pointed_thing)
					if placer and placer:is_player() then
						local meta = minetest.get_meta(pos)
						meta:set_string("owner",placer:get_player_name())
					end
					if runes.datas.handlers[runedef.name].on_place then
						if mana.get(placer:get_player_name()) >= runedef.needed_mana[level] then
							local answer = runes.datas.handlers[runedef.name].on_place(level, pos, placer, itemstack, pointed_thing)
							if not answer then
								mana.subtract(placer:get_player_name(),runedef.needed_mana[level])
							end
						else
							minetest.chat_send_player(placer:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana[level] ..")")
						end
					end
				end,
				can_dig = function(pos, player)
					if runes.datas.handlers[runedef.name].can_dig then
						return runes.datas.handlers[runedef.name].can_dig(level, pos, player)
					else
						return true
					end
				end,
				on_punch = function(pos, node, puncher, pointed_thing)
					if runes.datas.handlers[runedef.name].on_punch then
						if mana.get(placer:get_player_name()) >= runedef.needed_mana[level] then
							local answer = runes.datas.handlers[runedef.name].on_punch(level, pos, node, puncher, pointed_thing)
							if not answer then
								mana.subtract(placer:get_player_name(),runedef.needed_mana[level])
							end
						else
							minetest.chat_send_player(placer:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana[level] ..")")
						end
					end
				end,
			})
		end

	elseif runedef.type == "craftitem" then
		for _, level in pairs({"minor", "medium", "major"}) do
			minetest.register_craftitem("runes:rune_" .. runedef.name .. "_" .. level, {
				description = runedef.desc .. " (" .. level ..")",
				inventory_image = runedef.img[level],
				groups = {rune = 1},
				on_use = function(itemstack, user, pointed_thing)
					-- Let the handler do its job
					if runes.datas.handlers[runedef.name].on_use then
						if mana.get(user:get_player_name()) >= runedef.needed_mana[level] then
							local answer = runes.datas.handlers[runedef.name].on_use(level, itemstack, user, pointed_thing)
							if not answer then
								mana.subtract(user:get_player_name(),runedef.needed_mana[level])
								user:get_inventory():remove_item("main",{name = runedef.name .. "_" .. level})
							end
						else
							minetest.chat_send_player(user:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana[level] ..")")
						end
					end
				end
			})
		end
	end
end


-- Handler connector
runes.functions.connect = function(itemname, callback, handler)
	--[[ Available callback :
		use
		place
		dig
		can_dig
		punch
	]]

	if not runes.datas.items[itemname] then
		minetest.log("error","[runes] Cannot connect handler at " .. handler .. " to unknown item " .. itemname)
		return
	end

	if callback == "use" then
		runes.datas.handlers[itemname].on_use = handler
	elseif callback == "place" then
		runes.datas.handlers[itemname].on_place = handler
	elseif callback == "dig" then
		runes.datas.handlers[itemname].on_dig = handler
	elseif callback == "can_dig" then
		runes.datas.handlers[itemname].can_dig = handler
	elseif callback == "punch" then
		runes.datas.handlers[itemname].on_punch = handler
	else
		minetest.log("error","[runes] Cannot connect handler to item's " .. itemname .. " unknown " .. callback .. " callback")
		return
	end
end

-- Amulets

runes.functions.register_amulet = function(name, desc, maxcount, manadiff)
	minetest.register_craftitem("runes:" .. name .. "_amulet", {
		description = desc,
		inventory_image = "runes_" .. name .. "_amulet.png",
		groups = {amulet = 1, rune = 1},
		stack_max = maxcount,
	})
	runes.datas.amulets[name] = manadiff
end

-- Inventory

unified_inventory.register_button("runes", {
	type = "image",
	image = "runes_heal_major.png",
	tooltip = "Rune inventory",
	show_with = false, --Modif MFF (Crabman 30/06/2015)
})
unified_inventory.register_page("runes", {
	get_formspec = function(player)
		local name = player:get_player_name()
		local formspec = "background[0,0.2;8,4;runes_rune_inventory.png]"..
			"background[0,4.5;8,4;ui_wooden_chest_inventory.png]"..
			"size[8,10]"..
			"list[detached:"..name.."_runes;runes;0,0.2;8,4;]"
		return {formspec=formspec}
	end,
})

runes.functions.register_detached_inventory = function(player)
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	local datafile = io.open(minetest.get_worldpath().."/runes/"..name.."_rune.inv", "r")
	local rune_inv_data = {}
	if datafile then
		local line = datafile:read()
		if line then
			rune_inv_data = minetest.deserialize(line)
		end
		io.close(datafile)
	end
	local rune_inv = minetest.create_detached_inventory(name.."_runes",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end,
		allow_put = function(inv, listname, index, stack, player)
			if minetest.get_item_group(stack:get_name(), "rune") > 0 then
				return stack:get_count()
			end
			return 0
		end,
		allow_take = function(inv, listname, index, stack, player)
			return stack:get_count()
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return count
		end,
	})
	rune_inv:set_size("runes", 8*4)
	rune_inv:set_list("runes",rune_inv_data)
	minetest.log("action","[runes] Rune inventory loaded for player " .. name)
end

minetest.register_on_joinplayer(runes.functions.register_detached_inventory)

runes.functions.save_detached_inventory = function(player)
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	local datafile = io.open(minetest.get_worldpath().."/runes/"..name.."_rune.inv", "w")
	local rune_inv_data = minetest.get_inventory({type = "detached", name=name.."_runes"})
	local translated_rune_data = {}
	for index, data in pairs(rune_inv_data:get_list("runes")) do
		translated_rune_data[index] = data:get_name() .. " " .. data:get_count()
	end
	if datafile then
		datafile:write(minetest.serialize(translated_rune_data))
		io.close(datafile)
	end
	minetest.log("action", "[runes] Rune inventory saved for player " .. name)
end

minetest.register_on_leaveplayer(runes.functions.save_detached_inventory)
minetest.register_on_shutdown(function()
	for index, player in pairs(minetest.get_connected_players()) do
		runes.functions.save_detached_inventory(player)
	end
end)
