--code copied from Pilzadam's nether mod and edited
local portal_target = nether.buildings+1
local damage_enabled = minetest.setting_getbool("enable_damage")

local abm_allowed
minetest.after(5, function()
	abm_allowed = true
end)

table.icontains = table.icontains or function(t, v)
	for _,i in ipairs(t) do
		if i == v then
			return true
		end
	end
	return false
end

local players_in_nether = {}
local file = io.open(minetest.get_worldpath()..'/nether_players', "r")
if file then
	local contents = file:read('*all')
	io.close(file)
	if contents then
		players_in_nether = string.split(contents, " ")
	end
end

local function save_nether_players()
	local output = ''
	for _,name in ipairs(players_in_nether) do
		output = output..name..' '
	end
	local f = io.open(minetest.get_worldpath()..'/nether_players', "w")
	f:write(output)
	io.close(f)
end

local update_background
--if damage_enabled then
	function update_background(player, down)
		if down then
			player:set_sky({r=15, g=0, b=0}, "plain")
		else
			player:set_sky(nil, "regular")
		end
	end
--else
--	function update_background()end
--end

function nether.player_to_nether(player, safe)
	local pname = player:get_player_name()
	if table.icontains(players_in_nether, pname) then
		return
	end
	table.insert(players_in_nether, pname)
	save_nether_players()
	if not safe then
		minetest.chat_send_player(pname, "For any reason you arrived here. Type /nether_help to find out things like craft recipes.")
		player:set_hp(0)
	end
	update_background(player, true)
end

function nether.player_from_nether(player)
	local pname = player:get_player_name()
	local changes
	for n,i in ipairs(players_in_nether) do
		if i == pname then
			table.remove(players_in_nether, n)
			changes = true
		end
	end
	if changes then
		save_nether_players()
	end
	update_background(player)
end


--if damage_enabled then
local function player_exists(name)
	for _,player in pairs(minetest.get_connected_players()) do
		if player:get_player_name() == name then
			return true
		end
	end
	return false
end


-- Chatcommands removed
--[[ Chatcommands (edited) written by sss
minetest.register_chatcommand("to_hell", {
	params = "[<player_name>]",
	description = "Send someone to hell",
	func = function(name, pname)
		if not minetest.check_player_privs(name, {nether=true}) then
			return false, "You need the nether priv to execute this chatcommand."
		end
		if not player_exists(pname) then
			pname = name
		end
		local player = minetest.get_player_by_name(pname)
		if not player then
			return false, "Something went wrong."
		end
		minetest.chat_send_player(pname, "Go to hell !!!")
		player_to_nether(player)
		return true, pname.." is now in the nether."
	end
})

minetest.register_chatcommand("from_hell", {
	params = "[<player_name>]",
	description = "Extract from hell",
	func = function(name, pname)
		if not minetest.check_player_privs(name, {nether=true}) then
			return false, "You need the nether priv to execute this chatcommand."
		end
		if not player_exists(pname) then
			pname = name
		end
		local player = minetest.get_player_by_name(pname)
		if not player then
			return false, "Something went wrong."
		end
		minetest.chat_send_player(pname, "You are free now")
		player_from_nether(player)
		local pos_togo = {x = 0, y = 35, z = -7}
		if minetest.setting_getbool("static_spawnpoint") ~= nil then
			local stsp_conf = minetest.setting_get("static_spawnpoint")
			pos_togo = {x = stsp_conf:split(",")[1]+0,y = stsp_conf:split(",")[2]+0,z = stsp_conf:split(",")[3]+0}
		end
		player:moveto(pos_togo)
		return true
	end
})]]

minetest.register_on_respawnplayer(function(player)
	local pname = player:get_player_name()
	if not table.icontains(players_in_nether, pname) then
		return
	end
	local target = vector.add(player:getpos(), {x=math.random(-100,100), y=0, z=math.random(-100,100)})
	target.y = portal_target + math.random(4)
	player:moveto(target)
	minetest.after(0, function(pname, target)
		local player = minetest.get_player_by_name(pname)
		if player then
			player:moveto(target)
		end
	end, pname, target)
	return true
end)

local function update_players()
	for _,player in ipairs(minetest.get_connected_players()) do
		local pname = player:get_player_name()
		local ppos = player:getpos()
		if table.icontains(players_in_nether, pname) then
			if ppos.y > nether.start then
				player:moveto({x=ppos.x, y=portal_target, z=ppos.z})
				update_background(player, true)
				--[[minetest.kick_player(pname, "\n1. Maybe you were not allowed to teleport out of the nether."..
					"\n2. Maybe the server lagged."..
					"\n3. please rejoin")]]
			end
		elseif ppos.y < nether.start then
			update_background(player)
			player:moveto({x=ppos.x, y=20, z=ppos.z})
			--[[minetest.kick_player(pname, "\n1. Maybe you were not allowed to teleport to the nether."..
				"\n2. Maybe the server lagged."..
				"\n3. please rejoin")]]
		end
	end
end

local function tick()
	update_players()
	minetest.after(2, tick)
end
tick()

minetest.register_on_joinplayer(function(player)
	minetest.after(0, function(player)
		if player:getpos().y < nether.start then
			update_background(player, true)
		end
	end, player)
end)

local function remove_portal_essence(pos)
	for z = -1,1 do
		for y = -2,2 do
			for x = -1,1 do
				local p = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
				if minetest.get_node(p).name == "nether:portal" then
					minetest.remove_node(p)
				end
			end
		end
	end
end

minetest.register_abm({
	nodenames = {"nether:portal"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		if not abm_allowed then
			return
		end
		minetest.add_particlespawner({
			amount = 32,
			time = 4,
			minpos = {x=pos.x-0.25, y=pos.y-0.5, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+0.34, z=pos.z+0.25},
			minvel = {x=0, y=1, z=0},
			maxvel = {x=0, y=2, z=0},
			minacc = {x=-0.5,y=-3,z=-0.3},
			maxacc = {x=0.5,y=-0.4,z=0.3},
			minexptime = 1,
			maxexptime = 1,
			minsize = 0.4,
			maxsize = 3,
			collisiondetection = true,
			texture = "nether_portal_particle.png^[transform"..math.random(0,7),
		})
		for _,obj in pairs(minetest.get_objects_inside_radius(pos, 1)) do
			if obj:is_player() then
				local meta = minetest.get_meta(pos)
				local target = minetest.string_to_pos(meta:get_string("target"))
				if target then
					minetest.after(3, function(obj, pos, target)
						local pname = obj:get_player_name()
						if table.icontains(players_in_nether, pname) then
							return
						end
						local objpos = obj:getpos()
						objpos.y = objpos.y+0.1 -- Fix some glitches at -8000
						if minetest.get_node(vector.round(objpos)).name ~= "nether:portal" then
							return
						end

						remove_portal_essence(pos)

						minetest.sound_play("nether_portal_usual", {to_player=pname, gain=1})
						nether.player_to_nether(obj)
						--obj:setpos(target)

					end, obj, pos, target)
				end
			end
		end
	end,
})

local function move_check(p1, max, dir)
	local p = {x=p1.x, y=p1.y, z=p1.z}
	local d = math.abs(max-p1[dir]) / (max-p1[dir])
	while p[dir] ~= max do
		p[dir] = p[dir] + d
		if minetest.get_node(p).name ~= "default:obsidian" then
			return false
		end
	end
	return true
end

local function check_portal(p1, p2)
	if p1.x ~= p2.x then
		if not move_check(p1, p2.x, "x") then
			return false
		end
		if not move_check(p2, p1.x, "x") then
			return false
		end
	elseif p1.z ~= p2.z then
		if not move_check(p1, p2.z, "z") then
			return false
		end
		if not move_check(p2, p1.z, "z") then
			return false
		end
	else
		return false
	end

	if not move_check(p1, p2.y, "y") then
		return false
	end
	if not move_check(p2, p1.y, "y") then
		return false
	end

	return true
end

local function is_portal(pos)
	for d=-3,3 do
		for y=-4,4 do
			local px = {x=pos.x+d, y=pos.y+y, z=pos.z}
			local pz = {x=pos.x, y=pos.y+y, z=pos.z+d}
			if check_portal(px, {x=px.x+3, y=px.y+4, z=px.z}) then
				return px, {x=px.x+3, y=px.y+4, z=px.z}
			end
			if check_portal(pz, {x=pz.x, y=pz.y+4, z=pz.z+3}) then
				return pz, {x=pz.x, y=pz.y+4, z=pz.z+3}
			end
		end
	end
end

local function make_portal(pos)
	local p1, p2 = is_portal(pos)
	if not p1
	or not p2 then
		print("[nether] something failed.")
		return false
	end

	if p1.y < nether.start then
		print("[nether] aborted, obsidian portals can't be used to get out")
		return
	end

	for d=1,2 do
	for y=p1.y+1,p2.y-1 do
		local p
		if p1.z == p2.z then
			p = {x=p1.x+d, y=y, z=p1.z}
		else
			p = {x=p1.x, y=y, z=p1.z+d}
		end
		if minetest.get_node(p).name ~= "air" then
			return false
		end
	end
	end

	local param2
	if p1.z == p2.z then
		param2 = 0
	else
		param2 = 1
	end

	local target = {x=p1.x, y=p1.y, z=p1.z}
	target.x = target.x + 1
	target.y = portal_target + math.random(4)

	for d=0,3 do
	for y=p1.y,p2.y do
		local p = {}
		if param2 == 0 then
			p = {x=p1.x+d, y=y, z=p1.z}
		else
			p = {x=p1.x, y=y, z=p1.z+d}
		end
		if minetest.get_node(p).name == "air" then
			minetest.set_node(p, {name="nether:portal", param2=param2})
		end
		local meta = minetest.get_meta(p)
		meta:set_string("p1", minetest.pos_to_string(p1))
		meta:set_string("p2", minetest.pos_to_string(p2))
		meta:set_string("target", minetest.pos_to_string(target))
	end
	end
	print("[nether] construction accepted.")
	return true
end

minetest.override_item("default:obsidian", {
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local p1 = minetest.string_to_pos(meta:get_string("p1"))
		local p2 = minetest.string_to_pos(meta:get_string("p2"))
		local target = minetest.string_to_pos(meta:get_string("target"))
		if not p1 or not p2 then
			return
		end
		for x=p1.x,p2.x do
		for y=p1.y,p2.y do
		for z=p1.z,p2.z do
			local nn = minetest.get_node({x=x,y=y,z=z}).name
			if nn == "default:obsidian" or nn == "nether:portal" then
				if nn == "nether:portal" then
					minetest.remove_node({x=x,y=y,z=z})
				end
				local m = minetest.get_meta({x=x,y=y,z=z})
				m:set_string("p1", "")
				m:set_string("p2", "")
				m:set_string("target", "")
			end
		end
		end
		end
		meta = minetest.get_meta(target)
		if not meta then
			return
		end
		p1 = minetest.string_to_pos(meta:get_string("p1"))
		p2 = minetest.string_to_pos(meta:get_string("p2"))
		if not p1 or not p2 then
			return
		end
		for x=p1.x,p2.x do
		for y=p1.y,p2.y do
		for z=p1.z,p2.z do
			local nn = minetest.get_node({x=x,y=y,z=z}).name
			if nn == "default:obsidian" or nn == "nether:portal" then
				if nn == "nether:portal" then
					minetest.remove_node({x=x,y=y,z=z})
				end
				local m = minetest.get_meta({x=x,y=y,z=z})
				m:set_string("p1", "")
				m:set_string("p2", "")
				m:set_string("target", "")
			end
		end
		end
		end
	end
})

minetest.after(0.1, function()
	minetest.override_item("default:mese_crystal_fragment", {
		on_place = function(stack, player, pt)
			if pt.under
			and minetest.get_node(pt.under).name == "default:obsidian" then
				print("[nether] tries to enable a portal")
				local done = make_portal(pt.under)
				if done then
					minetest.chat_send_player(
						player:get_player_name(),
						"Warning: If you are in the nether you may not be able to find the way out!"
					)
					if not minetest.setting_getbool("creative_mode") then
						stack:take_item()
					end
				end
			end
			return stack
		end
	})
end)
--end


vector.square = vector.square or
function(r)
	local tab, n = {}, 1
	for i = -r+1, r do
		for j = -1, 1, 2 do
			local a, b = r*j, i*j
			tab[n] = {a, b}
			tab[n+1] = {b, a}
			n=n+2
		end
	end
	return tab
end

local function netherport(pos)
	local x, y, z = pos.x, pos.y, pos.z
	for _,i in ipairs({-1, 3}) do
		if minetest.get_node({x=x, y=y+i, z=z}).name ~= "nether:white" then
			return
		end
	end
	for _,sn in ipairs(vector.square(1)) do
		if minetest.get_node({x=x+sn[1], y=y-1, z=z+sn[2]}).name ~= "nether:netherrack"
		or minetest.get_node({x=x+sn[1], y=y+3, z=z+sn[2]}).name ~= "nether:blood_cooked" then
			return
		end
	end
	for _,sn in ipairs(vector.square(2)) do
		if minetest.get_node({x=x+sn[1], y=y-1, z=z+sn[2]}).name ~= "nether:netherrack_black"
		or minetest.get_node({x=x+sn[1], y=y+3, z=z+sn[2]}).name ~= "nether:wood_empty" then
			return
		end
	end
	for i = -1,1,2 do
		for j = -1,1,2 do
			if minetest.get_node({x=x+i, y=y+2, z=z+j}).name ~= "nether:apple" then
				return
			end
		end
	end
	for i = -2,2,4 do
		for j = 0,2 do
			for k = -2,2,4 do
				if minetest.get_node({x=x+i, y=y+j, z=z+k}).name ~= "nether:netherrack_brick_blue" then
					return
				end
			end
		end
	end
	for i = -1,1 do
		for j = -1,1 do
			if minetest.get_node({x=x+i, y=y+4, z=z+j}).name ~= "nether:wood_empty" then
				return
			end
		end
	end
	return true
end

-- cache known portals
local known_portals_d = {}
local known_portals_u = {}
local function get_portal(t, z,x)
	return t[z] and t[z][x]
end
local function set_portal(t, z,x, y)
	t[z] = t[z] or {}
	t[z][x] = y
end

function nether_port(player, pos)
	if not player
	or not pos
	or not pos.x then
		minetest.log("error", "[nether] nether_port: something failed.")
		return
	end
	if not netherport(pos) then
		return
	end
	minetest.sound_play("nether_teleporter", {to_player=player:get_player_name()}) --MFF crabman (5/09/2015) fix positional sound don't work to player
	minetest.sound_play("nether_teleporter", {pos=pos})
	if pos.y < nether.start then
		nether.player_from_nether(player)
		local pos_togo = {x = 0, y = 35, z = -7}
		if minetest.setting_getbool("static_spawnpoint") ~= nil then
			local stsp_conf = minetest.setting_get("static_spawnpoint")
			pos_togo = minetest.string_to_pos(stsp_conf)
		end
		player:moveto(pos_togo)
	else
		set_portal(known_portals_u, pos.z,pos.x, pos.y)
		pos.y = get_portal(known_portals_d, pos.z,pos.x) or portal_target+math.random(4)
		player:moveto(pos)
		player_to_nether(player, true)
	end
	minetest.sound_play("nether_teleporter", {pos=pos})
	return true
end
