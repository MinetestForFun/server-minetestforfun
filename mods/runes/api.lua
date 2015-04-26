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
	runedef.type = parameters.type or "craftitem"
	runedef.needed_mana = parameters.needed_mana or 0

	runes.datas.handlers[runedef.name] = {}

	if runedef.type == "cube" then
		minetest.register_node("runes:rune_" .. runedef.name, {
			description = runedef.desc,
			tiles = {runedef.img},
			groups = {oddly_breakable_by_hand = 2, rune = 1},
			after_place_node = function(pos, placer, itemstack, pointed_thing)
				if placer and placer:is_player() then
					local meta = minetest.get_meta(pos)
					meta:set_string("owner",placer:get_player_name())
				end
				if runes.datas.handlers[runedef.name].on_place then
					if mana.get(placer:get_player_name()) >= runedef.needed_mana then
						runes.datas.handlers[runedef.name].on_place(pos, placer, itemstack, pointed_thing)
						mana.subtract(placer:get_player_name(),runedef.needed_mana)
					else
						minetest.chat_send_player(placer:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana ..")")
					end
				end
			end,
			can_dig = function(pos, player)
				if runes.datas.handlers[runedef.name].can_dig then
					return runes.datas.handlers[runedef.name].can_dig(pos, player)
				else
					return true
				end
			end,
			on_punch = function(pos, node, puncher, pointed_thing)
				if runes.datas.handlers[runedef.name].on_punch then
					if mana.get(puncher:get_player_name()) >= runedef.needed_mana then
						runes.datas.handlers[runedef.name].on_punch(pos, node, puncher, pointed_thing)
						mana.subtract(puncher:get_player_name(),runedef.needed_mana)
					else
						minetest.chat_send_player(puncher:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana ..")")
					end
				end
			end,
			--[[after_dig_node = function(pos, oldnode, oldmetadata, digger)
				--if runes.datas.handlers[runedef.name].can_dig and runes.datas.handlers[runedef.name].can_dig(pos, digger) then
					if runes.datas.handlers[runedef.name].on_dig then
						if mana.get(digger:get_player_name()) >= runedef.needed_mana then
							runes.datas.handlers[runedef.name].on_dig(pos, oldnode, digger)
							mana.subtract(digger:get_player_name(),runedef.needed_mana)
						else
							minetest.chat_send_player(digger:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana ..")")
						end
					end
				end
			end,]]
		})

	elseif runedef.type == "plate" then
		minetest.register_node("runes:rune_" .. runedef.name, {
			description = runedef.desc,
			paramtype = "light",
			inventory_image = runedef.img,
			sunlight_propagates = true,
			walkable = false,
			tiles = {runedef.img},
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
					if mana.get(placer:get_player_name()) >= runedef.needed_mana then
						runes.datas.handlers[runedef.name].on_place(pos, placer, itemstack, pointed_thing)
						mana.subtract(placer:get_player_name(),runedef.needed_mana)
					else
						minetest.chat_send_player(placer:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana ..")")
					end
				end
			end,
			can_dig = function(pos, player)
				if runes.datas.handlers[runedef.name].can_dig then
					return runes.datas.handlers[runedef.name].can_dig(pos, player)
				else
					return true
				end
			end,
			on_punch = function(pos, node, puncher, pointed_thing)
				if runes.datas.handlers[runedef.name].on_punch then
					runes.datas.handlers[runedef.name].on_punch(pos, node, puncher, pointed_thing)
				end
			end,
		})
	elseif runedef.type == "craftitem" then
		minetest.register_craftitem("runes:rune_" .. runedef.name, {
			description = runedef.desc,
			inventory_image = runedef.img,
			groups = {rune = 1},
			on_use = function(itemstack, user, pointed_thing)
				-- Let the handler do its job
				if runes.datas.handlers[runedef.name].on_use then
					if mana.get(user:get_player_name()) >= runedef.needed_mana then
						runes.datas.handlers[runedef.name].on_use(itemstack, user, pointed_thing)
						mana.subtract(user:get_player_name(),runedef.needed_mana)
						user:get_inventory():remove_item("main",{name = runedef.name})
					else
						minetest.chat_send_player(user:get_player_name(),"Not enough mana (needed : " .. runedef.needed_mana ..")")
					end
				end
			end
		})
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
