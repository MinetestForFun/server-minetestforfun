--[[

shutdown par turbogus, code sous licence gpl2 ou sup
déclaration du "timer" par Jat ( du mod annonce )

Affiche l'heure dans le chat toute les minutes et
arrête votre serveur "proprement" à une heure précise afin de créer
une sauvegarde

]]--
-- compatibility with soundset mod
local SOUNDVOLUME = 1
local get_volume
if (minetest.get_modpath("soundset")) ~= nil then
	get_volume = soundset.get_gain
else
	get_volume = function (player_name, sound_type) return SOUNDVOLUME end
end

local function sound_play_all(sound)
	for _, p in ipairs(minetest.get_connected_players()) do
		local player_name = p:get_player_name()
		if player_name then
			minetest.sound_play(sound, {to_player=player_name, gain=get_volume(player_name, "other")})
		end
	end
end

local timer = 0

if not core.colorize then
   core.colorize = function(c, m)
      return m
   end
end

local function send(msg, col)
   core.chat_send_all(core.colorize(col, msg))
end

local function tick()
	local heure = os.date("%H")
	local minute = os.date("%M")
	-- Warn every days
	if heure == "06" then
		if minute == "00" then
			send("Rappel : Redémarrage journalier du serveur dans 30 minutes. (Dure 30 minutes)", "#ffff00")
			send("Reminder : Daily reboot of the server in 30 minutes. (Lasts 30 minutes)", "#ffff00")
			sound_play_all("shutdown_shutdown")
		elseif minute == "15" then
			send("Rappel : Redémarrage journalier du serveur dans 15 minutes. (Dure 30 minutes)", "#FF6600")
			send("Reminder : Daily reboot of the server in 15 minutes. (Lasts 30 minutes)", "#FF6600")
			sound_play_all("shutdown_shutdown")
		elseif minute == "25" then
			send("Rappel : Redémarrage journalier du serveur dans 5 minutes - Pensez à vous deconnecter !", "#ff0000")
			send("Reminder : Daily reboot of the server in 5 minutes - Prepare to log out!", "#ff0000")
			sound_play_all("shutdown_shutdown")
		elseif minute == "29" then
			send("=== ARRET DU SERVEUR - DE NOUVEAU EN LIGNE DANS 30 MIN ===", "#ff0000")
			send("=== SERVER SHUTTING DOWN - ONLINE AGAIN IN 30 MIN ===", "#ff0000")
			sound_play_all("shutdown_shutdown")
	--		minetest.request_shutdown()
		end
	end
	minetest.after(60, tick)
end

minetest.after(0, function() -- When server has just started
		  -- Calculate time until next minute to start laps (+1 sec to be sure)
		  minetest.after(61 - tonumber(os.date("%S")), function()
				    tick()
		  end)
end)
