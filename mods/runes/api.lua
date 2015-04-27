-- API of the rune mod --

-- Global namespace
runes = {}
runes.datas = {}
runes.datas.handlers = {}
runes.datas.items = {}
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
