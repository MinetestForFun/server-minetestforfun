
-- ### top playername
dofile(minetest.get_modpath("hungry_games").."/letters.lua")

top.config_file = minetest.get_worldpath() .. "/top_config.txt"
top.name = {"","",""}
top.conf = {}
top.conf.hall = {}
top.conf.podium = {}

-- load top table letters
function top.load_position()
	local file = io.open(top.config_file, "r")
	if file then
		local t = minetest.deserialize(file:read("*all"))
		file:close()
		if t and type(t) == "table" then
			return t
		end
	end
	return {}
end
top.conf = top.load_position()
-- save top position hall, podium
function top.save_top_pos()
	local input, err = io.open(top.config_file, "w")
	if input then
		input:write(minetest.serialize(top.conf))
		input:close()
	else
		minetest.log("error", "open(" .. top.config_file .. ", 'w') failed: " .. err)
	end
end

function top.get_correct_conf(playername)
	if not top.conf or not top.conf.hall then
		minetest.log("error", "no top.conf or top.conf.hall table")
		if playername then
			minetest.chat_send_player(playername, "no top.conf or top.conf.hall table")
		end
		return false
	end

	if not top.conf.hall["pos"]["x"] or not top.conf.hall["pos"]["y"] or not top.conf.hall["pos"]["z"] then
		minetest.log("error", 'no top.conf.hall["pos"] (x or y or z) table')
		if playername then
			minetest.chat_send_player(playername, 'no top.conf.hall["pos"] (x or y or z) table')
		end
		return false
	end

	if not top.conf["node0"] or not top.conf["node1"] or not top.conf["node2"] then
		minetest.log("error", 'no top.conf (node0 or node1 or node2) table')
		if playername then
			minetest.chat_send_player(playername, 'no top.conf (node0 or node1 or node2) table')
		end
		return false
	end

	if not top.conf["node0"]["p1"] or not top.conf["node1"]["p1"] or not top.conf["node2"]["p1"] then
		minetest.log("error", 'no top.conf (node0[1] or node1[1] or node2[1]) table')
		if playername then
			minetest.chat_send_player(playername, 'no top.conf (node0[p1] or node1[p1] or node2[p1]) table')
		end
		return false
	end

	if not top.conf["node0"]["p2"] or not top.conf["node1"]["p2"] or not top.conf["node2"]["p2"] then
		minetest.log("error", 'no top.conf (node0[p2] or node1[p2] or node2[p2]) table')
		if playername then
			minetest.chat_send_player(playername, 'no top.conf (node0[p2] or node1[p2] or node2[p2]) table')
		end
		return false
	end

	if not top.conf["node0"]["p3"] or not top.conf["node1"]["p3"] or not top.conf["node2"]["p3"] then
		minetest.log("error", 'no top.conf (node0[p3] or node1[p3] or node2[p3]) table')
		if playername then
			minetest.chat_send_player(playername, 'no top.conf (node0[p3] or node1[p3] or node2[p3]) table')
		end
		return false
	end

	local dir = top.conf.hall["dir"]
	if not dir or (dir ~= "N" and dir ~= "S" and dir ~= "E" and dir ~= "W") then
		minetest.log("error", 'no top.conf.hall["dir"] table')
		if playername then
			minetest.chat_send_player(playername, 'no top.conf.hall["dir"] table')
		end
		return false
	end

	return true
end

function top.get_pos(pos, dir, i)
	local pos2 = {x=pos.x, y=pos.y, z=pos.z}
	if i == nil then return pos2 end
	if dir == "N" then
		pos2.x=pos2.x+i
	elseif dir == "S" then
		pos2.x=pos2.x-i
	elseif dir == "E" then
		pos2.z=pos2.z-i
	elseif dir == "W" then
		pos2.z=pos2.z+i
	end
	return pos2
end

function top.set_letter(num, letter, lpos, dir)
	for _, p in pairs(letter) do
		local npos = top.get_pos(lpos, dir, p.x)
		local nname = top.conf[p.node]["p"..num]
		if nname ~= "air" then
			minetest.set_node({x=npos.x, y=npos.y+p.y, z=npos.z }, {name=nname})
		end
	end
end

minetest.register_chatcommand("top_update", {
	description = "update top name",
	privs = {server=true},
	func = function(name, param)
		if not param then
			return false, "invalid param, /top_update <1|2|3>"
		end
		local param_num = param:match("^(%S+)$")
		if param_num == nil or not tonumber(param_num) or (tonumber(param_num)~= 1 and tonumber(param_num)~= 2 and tonumber(param_num)~= 3) then
			return false, "invalid param, /top_update <1|2|3>"
		end
		top.update_name(tonumber(param_num), true)
	end,
})

minetest.register_chatcommand("top_verif", {
	description = "Verify top configuration",
	privs = {server=true},
	func = function(name, param)
		if top.get_correct_conf(name) then
			return true, "top configuration correct."
		end
	end,
})

function top.update_name(num, force)
	if not top.get_correct_conf() then return end
	if not ranked.top_ranks[num] or (top.name[num] == ranked.top_ranks[num] and not force) then
		return
	end
	top.name[num] = ranked.top_ranks[num]
	local playername = top.name[num]:upper()
	-- reset podium
	local pos_m = {x=top.conf.hall["pos"].x, y=top.conf.hall["pos"].y, z=top.conf.hall["pos"].z}
	local dir = top.conf.hall["dir"]
	local dec = 13*(num-1)
	pos_m.y = pos_m.y-dec
	local pos_deb = top.get_pos(pos_m, dir, -70)
	for p=1,150 do
		local pos2 = top.get_pos(pos_deb, dir, p)
		for j=0, 9 do
			minetest.set_node({x=pos2.x, y=pos2.y+j, z=pos2.z}, {name="air"})
		end
	end
	local nb = playername:len()
	local m = math.ceil(nb/2)
	local center = 3
	if nb%2 == 0 then
		center = 7
	end
	for i=1,nb do
		local d_pos = top.get_pos(pos_m, dir, -((m-i)*8)-center)
		local l = playername:sub(i, i)
		local letter
		if top.letters[l] ~= nil then
			letter = top.letters[l]
		else
			letter = top.letters["?"]
		end
		top.set_letter(num, letter, d_pos, dir)
	end
end


minetest.register_chatcommand("top_node", {
	description = "set nodes <player num(1|2|3)> <0|1|2 (support|letter center|letter)> <nodename>.",
	privs = {server=true},
	func = function(name, param)
		if not param then
			return false, "invalid param, /top_node <1|2|3> <0|1|2> <nodename>"
		end
		local param_num, param_node_num, param_node = param:match("^(%S+)%s(%S+)%s(%S+)$")
		if param_num == nil or param_node_num == nil or param_node == nil then
			return false, "invalid param, /top_node <player num(1|2|3)> <0|1|2> <nodename>"
		end
		if param_num == nil or (param_num ~= "1" and param_num ~= "2" and param_num ~= "3") then
			return false, "invalid param player num: ".. param_num
		end
		if param_node_num == nil or (param_node_num ~= "0" and param_node_num ~= "1" and param_node_num ~= "2") then
			return false, "invalid param node num: "..param_node_num
		end
		if param_node == nil or (not minetest.registered_nodes[param_node] and param_node ~= "air") then
			return false, "invalid param node:"..param_node
		end
		if not top.conf["node"..param_node_num] or type(top.conf["node"..param_node_num]) ~= "table" then
			top.conf["node"..param_node_num] = {}
		end
		top.conf["node"..param_node_num]["p"..param_num] = param_node
		top.save_top_pos()
	end,
})


minetest.register_chatcommand("top_set", {
	description = "set wall middle position, x y z <dir (N|S|E|W)>.",
	privs = {server=true},
	func = function(name, param)
		if not param then
			return false, "invalid param, /top_set x y z <dir (N|S|E|W)>"
		end
		local param_x, param_y , param_z, param_d = param:match("^(%S+)%s(%S+)%s(%S+)%s(%S+)$")
		if param_x == nil or param_y == nil or param_z == nil or param_d == nil then
			minetest.chat_send_player(name, "invalid param, /top_set x y z <dir (N|S|E|W)>")
		end
		local x = tonumber(param_x)
		if x == nil then
			return false, "invalid param x"
		end
		local y = tonumber(param_y)
		if y == nil then
			return false, "invalid param y"
		end
		local z = tonumber(param_z)
		if z == nil then
			return false, "invalid param z"
		end

		if not param_d or (param_d ~= "N" and param_d ~= "S" and param_d ~= "E" and param_d ~= "W") then
			return false, "invalid param dir"
		end
		if top.conf.hall == nil then
			top.conf.hall = {}
		end
		top.conf.hall["pos"] = {["x"]=x,["y"]=y,["z"]=z}
		top.conf.hall["dir"] = param_d
		top.save_top_pos()
	end,
})
