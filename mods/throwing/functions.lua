--~
--~ Shot and reload system
--~

local players = {}

minetest.register_on_joinplayer(function(player)
	local playerName = player:get_player_name()
	players[playerName] = {
		reloading=false,
	}
end)

minetest.register_on_leaveplayer(function(player)
	local playerName = player:get_player_name()
	players[playerName] = nil
end)

function throwing_is_player(name, obj)
	return (obj:is_player() and obj:get_player_name() ~= name)
end

function throwing_is_entity(obj)
	return (obj:get_luaentity() ~= nil
			and not string.find(obj:get_luaentity().name, "throwing:")
			and obj:get_luaentity().name ~= "__builtin:item"
			and obj:get_luaentity().name ~= "gauges:hp_bar"
			and obj:get_luaentity().name ~= "signs:text")
end

function throwing_get_trajectoire(self, newpos)
	if self.lastpos.x == nil then
		return {newpos}
	end
	local coord = {}
	local nx = (newpos["x"] - self.lastpos["x"])/3
	local ny = (newpos["y"] - self.lastpos["y"])/3
	local nz = (newpos["z"] - self.lastpos["z"])/3

	if nx and ny and nz then
		table.insert(coord, {x=self.lastpos["x"]+nx, y=self.lastpos["y"]+ny ,z=self.lastpos["z"]+nz })
		table.insert(coord, {x=newpos["x"]-nx, y=newpos["y"]-ny ,z=newpos["z"]-nz })
	end
	table.insert(coord, newpos)
	return coord
end

function throwing_touch(pos, objpos)
	local rx = pos.x - objpos.x
	local ry = pos.y - (objpos.y+1)
	local rz = pos.z - objpos.z
	if (ry < 1 and ry > -1) and (rx < 1 and rx > -1) and (rz < 1 and rz > -1) then
		return true
	end
	return false
end

function throwing_shoot_arrow (itemstack, player, stiffness, is_cross)
	if not player then return end
	local arrow = itemstack:get_metadata()
	itemstack:set_metadata("")
	player:set_wielded_item(itemstack)
	local playerpos = player:getpos()
	local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}, arrow)
	if not obj then return end
	local dir = player:get_look_dir()
	obj:setvelocity({x=dir.x*stiffness, y=dir.y*stiffness, z=dir.z*stiffness})
	obj:setacceleration({x=dir.x*-3, y=-10, z=dir.z*-3})
	obj:setyaw(player:get_look_yaw()+math.pi)
	if is_cross then
		minetest.sound_play("throwing_crossbow_sound", {pos=playerpos})
	else
		minetest.sound_play("throwing_bow_sound", {pos=playerpos})
	end
	if obj:get_luaentity() then
		obj:get_luaentity().player = player:get_player_name()
		obj:get_luaentity().inventory = player:get_inventory()
		obj:get_luaentity().stack = player:get_inventory():get_stack("main", player:get_wield_index()-1)
		obj:get_luaentity().lastpos = {x=playerpos.x,y=playerpos.y+1.5,z=playerpos.z}
		obj:get_luaentity().bow_damage = stiffness
	end
	return true
end

function throwing_unload (itemstack, player, unloaded, wear)
	if itemstack:get_metadata() then
		for _,arrow in ipairs(throwing_arrows) do
			if itemstack:get_metadata() == arrow[2] then
				if not minetest.setting_getbool("creative_mode") then
					player:get_inventory():add_item("main", arrow[1])
				end
				break
			end
		end
	end
	if wear >= 65535 then
		player:set_wielded_item({})
	else
		player:set_wielded_item({name=unloaded, wear=wear})
	end
end

function throwing_reload (itemstack, player, pos, is_cross, loaded)
	local playerName = player:get_player_name()
	players[playerName]['reloading'] = false
	if itemstack:get_name() == player:get_wielded_item():get_name() then
		if (pos.x == player:getpos().x and pos.y == player:getpos().y and pos.z == player:getpos().z) or not is_cross then
			local wear = itemstack:get_wear()
			for _,arrow in ipairs(throwing_arrows) do
				if player:get_inventory():get_stack("main", player:get_wield_index()+1):get_name() == arrow[1] then
					if not minetest.setting_getbool("creative_mode") then
						player:get_inventory():remove_item("main", arrow[1])
					end
					local meta = arrow[2]
					player:set_wielded_item({name=loaded, wear=wear, metadata=meta})
					break
				end
			end
		end
	end
end

-- Bows and crossbows

function throwing_register_bow (name, desc, scale, stiffness, reload_time, toughness, is_cross, craft)
	minetest.register_tool("throwing:" .. name, {
		description = desc,
		inventory_image = "throwing_" .. name .. ".png",
		wield_scale = scale,
	    stack_max = 1,
		on_use = function(itemstack, user, pointed_thing)
			local pos = user:getpos()
			local playerName = user:get_player_name()
			if not players[playerName]['reloading'] then
				players[playerName]['reloading'] = true
				minetest.after(reload_time, throwing_reload, itemstack, user, pos, is_cross, "throwing:" .. name .. "_loaded")
			end
			return itemstack
		end,
	})

	minetest.register_tool("throwing:" .. name .. "_loaded", {
		description = desc,
		inventory_image = "throwing_" .. name .. "_loaded.png",
		wield_scale = scale,
	    stack_max = 1,
		on_use = function(itemstack, user, pointed_thing)
			local wear = itemstack:get_wear()
			if not minetest.setting_getbool("creative_mode") then
				wear = wear + (65535/toughness)
			end
			local unloaded = "throwing:" .. name
			throwing_shoot_arrow(itemstack, user, stiffness, is_cross)
			minetest.after(0, throwing_unload, itemstack, user, unloaded, wear)
			return itemstack
		end,
		on_drop = function(itemstack, dropper, pointed_thing)
			local wear = itemstack:get_wear()
			local unloaded = "throwing:" .. name
			minetest.after(0, throwing_unload, itemstack, dropper, unloaded, wear)
		end,
		groups = {not_in_creative_inventory=1},
	})

	minetest.register_craft({
		output = 'throwing:' .. name,
		recipe = craft
	})

	local craft_width = 1
	-- Since # isn't stable especially when there are nils in the table, count by hand
	for _,v in ipairs(craft) do
		for i,__ in ipairs(v) do
			if i > craft_width then
				craft_width = i
			end
		end
	end
	local rev_craft = {}
	for i,y in ipairs(craft) do
		rev_craft[i] = {}
		for j,x in ipairs(y) do
			rev_craft[i][craft_width-j+1] = x
		end
	end
	minetest.register_craft({
		output = 'throwing:' .. name,
		recipe = rev_craft
	})
end

