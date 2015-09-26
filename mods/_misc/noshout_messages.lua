
local players = {}

local function tick(name)
	if players[name] == nil then return end
	if not minetest.get_player_by_name(name) or minetest.check_player_privs(name, {shout=true}) == true then
		players[name] = nil
		return
	end

	minetest.chat_send_player(name, "Hey " .. name .. " ! Pour pouvoir communiquer avec les autres joueurs sur ce serveur, tu dois lire les règles de l'irc et les accepter. Tape /irc.")
	minetest.chat_send_player(name, "Hey " .. name .. " ! To speak to other people on this server, you have to read the rules of our irc channel and agree them. Type /irc.")
	minetest.after(20, tick, name)
end


minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if minetest.check_player_privs(name, {shout=false}) and players[name] == nil then
		minetest.after(5, tick, name)
		players[name] = true
	end
end)


minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if not name then return end
	players[name] = nil
end)
