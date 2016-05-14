h2omes = {}
h2omes.homes = {} -- table players home
h2omes.path = minetest.get_worldpath() .. "/h2omes/"
minetest.mkdir(h2omes.path)

h2omes.time = 2 * 60 --MFF 04/05/2016 2 minutes plus 20 minutes

h2omes.have_nether = false -- nether mod
if (minetest.get_modpath("nether") ~= nil) then
	h2omes.have_nether = true
end


function h2omes.check(name)
	if h2omes.homes[name] == nil then
		h2omes.homes[name] = {["home"] = {}, ["pit"] = {}}
	end
end


--function save_homes
function h2omes.save_homes(name)
	local file = h2omes.path..name
	local input, err = io.open(file, "w")
	if input then
		input:write(minetest.serialize(h2omes.homes[name]))
		input:close()
	else
		minetest.log("error", "open(" .. file .. ", 'w') failed: " .. err)
	end
end


--function load_homes
function h2omes.load_homes(name)
	h2omes.check(name)
	local file = h2omes.path..name
	local input, err = io.open(file, "r")
	if input then
		local data = minetest.deserialize(input:read())
		io.close(input)
		if data and type(data) == "table" then
			if data.home then
				if data.home.real then
					h2omes.homes[name].home.real = data.home.real
				end
				if data.home.nether then
					h2omes.homes[name].home.nether = data.home.nether
				end
			end
			if data.pit then
				if data.pit.real  then
					h2omes.homes[name].pit.real = data.pit.real
				end
				if data.pit.nether then
					h2omes.homes[name].pit.nether = data.pit.nether
				end
			end
		end
	end
end


--function set_homes
function h2omes.set_home(name, home_type, pos)
	h2omes.check(name)
	if not pos then
		local player = minetest.get_player_by_name(name)
		if not player then return end
		pos = player:getpos()
	end
	if not pos then return false end
	if pos.y < -19600 and h2omes.have_nether then
		h2omes.homes[name][home_type].nether = pos
	else
		h2omes.homes[name][home_type].real = pos
	end
	minetest.chat_send_player(name, home_type.." set!")
	minetest.sound_play("dingdong",{to_player=name, gain = 1.0})
	h2omes.save_homes(name)
	return true
end


--function get_homes
function h2omes.get_home(name, home_type)
	h2omes.check(name)
	local player = minetest.get_player_by_name(name)
	if not player then return nil end
	local pos = player:getpos()
	if not pos then return nil end
	local status = "real"
	if pos.y < -19600 and h2omes.have_nether then
		status = "nether"
	end
	if h2omes.homes[name][home_type][status] then
		return h2omes.homes[name][home_type][status]
	end
	return nil
end


--function to_homes
function h2omes.to_home(name, home_type)
	h2omes.check(name)
	local player = minetest.get_player_by_name(name)
	if not player then return false end
	local pos = player:getpos()
	if not pos then return false end
	local status = "real"
	if pos.y < -19600 and h2omes.have_nether then
		status = "nether"
	end
	if h2omes.homes[name][home_type][status] then
		player:setpos(h2omes.homes[name][home_type][status])
		minetest.chat_send_player(name, "Teleported to "..home_type.."!")
		minetest.sound_play("teleport", {to_player=name, gain = 1.0})
		return true
	end
	return false
end


function h2omes.show_formspec_home(name)
	local formspec = {"size[6,7]label[2.1,0;Home Settings]"}
	--home
	table.insert(formspec, "label[2.5,1;HOME]")
	local home = h2omes.get_home(name, "home")
	table.insert(formspec, "button[0.5,2;1.5,1;set_home;Set Home]")
	if home then
		table.insert(formspec, string.format("label[2,1.5;x:%s, y:%s, z:%s]", math.floor(home.x), math.floor(home.y), math.floor(home.z) ))
		table.insert(formspec, "button_exit[4,2;1.5,1;to_home;To Home]")
	else
		table.insert(formspec, "label[2.3,1.5;Home no set]")
	end
	--pit
	table.insert(formspec, "label[2.5,3;PIT]")
	local pit = h2omes.get_home(name, "pit")
	table.insert(formspec, "button[0.5,4;1.5,1;set_pit;Set Pit]")
	if pit then
		table.insert(formspec, string.format("label[2,3.5;x:%s, y:%s, z:%s]", math.floor(pit.x), math.floor(pit.y), math.floor(pit.z) ))
		table.insert(formspec, "button_exit[4,4;1.5,1;to_pit;To Pit]")
	else
		table.insert(formspec, "label[2.3,3.5;Pit no set]")
	end
	table.insert(formspec, "button_exit[2.3,6.3;1.5,1;close;Close]")
	minetest.show_formspec(name, "h2omes:formspec", table.concat(formspec))
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = player:get_player_name()
	if not name or name == "" then return end
	if formname == "h2omes:formspec" then
		if fields["set_home"] then
			--h2omes.set_home(name, "home")
			action_timers.wrapper(name, "sethome", "sethome_" .. name, h2omes.time, h2omes.set_home, {name, "home"})
			h2omes.show_formspec_home(name)
		elseif fields["set_pit"] then
			--h2omes.set_home(name, "pit")
			action_timers.wrapper(name, "sethome", "sethome_" .. name, h2omes.time, h2omes.set_home, {name, "pit"})
			h2omes.show_formspec_home(name)
		elseif fields["to_home"] then
			--h2omes.to_home(name, "home")
			action_timers.wrapper(name, "tohome", "tohome_" .. name, h2omes.time, h2omes.to_home, {name, "home"})
		elseif fields["to_pit"] then
			--h2omes.to_home(name, "pit")
			action_timers.wrapper(name, "tohome", "tohome_" .. name, h2omes.time, h2omes.to_home, {name, "pit"})
		end
	end
end)


minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not name or name == "" then return end
	h2omes.load_homes(name)
end)


minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if not name or name == "" then return end
	h2omes.homes[name] = nil
end)


minetest.register_privilege("home", "Can use /sethome, /home, /setpit and /pit")


minetest.register_chatcommand("home", {
	description = "Teleport you to your home point",
	privs = {home=true},
	func = function (name, params)
		if not h2omes.get_home(name, "home") then
			minetest.chat_send_player(name, "Set a home using /sethome")
			return false
		end
		--h2omes.to_home(name, "home")
		return action_timers.wrapper(name, "tohome", "tohome_" .. name, h2omes.time, h2omes.to_home, {name, "home"})
	end,
})


minetest.register_chatcommand("sethome", {
	description = "Set your home point",
	privs = {home=true},
	func = function (name, params)
		--h2omes.set_home(name, "home")
		return action_timers.wrapper(name, "sethome", "sethome_" .. name, h2omes.time, h2omes.set_home, {name, "home"})
	end,
})


minetest.register_chatcommand("pit", {
	description = "Teleport you to your pit point",
	privs = {home=true},
	func = function (name, params)
		if not h2omes.get_home(name, "pit") then
			minetest.chat_send_player(name, "Set a pit using /setpit")
			return false
		end
		--h2omes.to_home(name, "pit")
		return action_timers.wrapper(name, "tohome", "tohome_" .. name, h2omes.time, h2omes.to_home, {name, "pit"})
	end,
})


minetest.register_chatcommand("setpit", {
	description = "Set your pit point",
	privs = {home=true},
	func = function (name, params)
		--h2omes.set_home(name, "pit")
		return action_timers.wrapper(name, "sethome", "sethome_" .. name, h2omes.time, h2omes.set_home, {name, "pit"})
	end,
})

minetest.log("action","[h2omes] Loaded.")
