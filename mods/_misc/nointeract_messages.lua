
local players = {}

local function tick(name)
	if players[name] == nil then return end
	if not minetest.get_player_by_name(name) or minetest.check_player_privs(name, {interact=true}) == true then
		players[name] = nil
		return
	end
	if minetest.check_player_privs(name, {shout=true}) then
		minetest.chat_send_player(name, "Hey " .. name .. " ! Pour pouvoir construire et intéragir sur ce serveur, tu dois lire les règles du serveur et les accepter. Tape /rules.")
		minetest.chat_send_player(name, "Hey " .. name .. " ! To build and interact on this server, you have to read the rules of our server and agree them. Type /rules.")
	end
	minetest.after(20, tick, name)
end


minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not minetest.check_player_privs(name, {interact=true}) and players[name] == nil then
		minetest.after(7, tick, name)
		players[name] = true
	end
end)


minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if not name then return end
	players[name] = nil
end)
