--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--


-- register register_privilege
minetest.register_privilege('level', 'Can use /level')

-- level
minetest.register_chatcommand('level', {
	description = 'Get or change a players current level.',
	privs = {level = true},
	params = "<player_name> <level>",
	func = function(name, param)
		local found, _, player_name, level = param:find("^([^%s]+)%s+(.+)$")
		if not player_name then
			player_name = name
		end
		level = tonumber(level)
		if not level then
			minetest.chat_send_player(name, player_name..' is on level '..skyblock.feats.get_level(player_name))
			return
		end
		if skyblock.feats.set_level(player_name, level) then
			minetest.chat_send_player(name, player_name..' has been set to level '..level)
		else
			minetest.chat_send_player(name, 'cannot change '..player_name..' to level '..level)
		end
	end,
})

-- who
minetest.register_chatcommand('who', {
	description = 'Display list of online players and their current level.',
	func = function(name)
		minetest.chat_send_player(name, 'Current Players:')
		for _,player in ipairs(minetest.get_connected_players()) do
			local player_name = player:get_player_name()
			minetest.chat_send_player(name, ' - '..player_name..' - level '..skyblock.feats.get_level(player_name))
		end
	end,
})
