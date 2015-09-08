
local players = {}
local music_volume = 1
local SOUNDVOLUME = 1
-- compatibility with soundset mod
local get_volume
if (minetest.get_modpath("soundset")) ~= nil then
	get_volume = soundset.get_gain
else
	get_volume = function (player_name, sound_type) return SOUNDVOLUME end
	-- set volume command
	minetest.register_chatcommand("svol", {
		params = "<svol>",
		description = "set sound volume (0.1 to 1.0)",
		privs = {server=true},
		func = function(name, param)
			if tonumber(param) then
				SOUNDVOLUME = tonumber(param)
				minetest.chat_send_player(name, "Sound volume set.")
			else
				minetest.chat_send_player(name, "Sound volume no set, bad param.")
			end
		end,
	})
end


local musics = {
	--{name="StrangelyBeautifulShort", length=3*60+.5, gain=music_volume*.7},
	--{name="Loneliness", length=3*60+51, gain=music_volume*.9},
	--{name="AvalonShort", length=2*60+58, gain=music_volume*1.4},
	--{name="Aube", length=2*60+24, gain=music_volume*1.8},
	--{name="Interlude", length=3*60+30.5, gain=music_volume*1.8},
	--{name="mtest", length=4*60+33, gain=music_volume},
	--{name="echos", length=2*60+26, gain=music_volume},
	--{name="FoamOfTheSea", length=1*60+50, gain=music_volume},
	{name="Ambivalent", length=2*60+31, gain=music_volume*.9},
	--{name="eastern_feeling", length=3*60+51, gain=music_volume},
	--{name="Mass_Effect_Uncharted_Worlds", length=2*60+29, gain=music_volume},
	{name="EtherealShort", length=3*60+4, gain=music_volume*.7},
	--{name="Mute", length=3*60+43, gain=music_volume*.9},
	--{name="FarawayShort", length=3*60+5, gain=music_volume*.7},
	{name="dark_ambiance", length=44, gain=music_volume}
}


-- stops all sounds that are not in still_playing
local stop_sound = function(player_name)
	if players[player_name] ~= nil then
		minetest.sound_stop(players[player_name])
		players[player_name] = nil
	end
end

-- start playing the sound, set the handler and delete the handler after sound is played
local play_sound = function(player_name, music, gain)
	if players[player_name] == nil then
		local handler = minetest.sound_play(music.name, {to_player=player_name, gain=music.gain*gain})
		if handler ~= nil then
			players[player_name] = handler
			minetest.after(music.length, stop_sound, player_name)
		end
	end
end


local function tick()
	for _, player in ipairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		local gain = get_volume(player_name, "music")
		if gain > 0 and players[player_name] == nil then
			local music = musics[math.random(#musics)]
			play_sound(player_name, music, gain)
		end
	end
	minetest.after(math.random(15,30)*60, tick)
end

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	stop_sound(player_name)
end)

minetest.after(60, tick)

