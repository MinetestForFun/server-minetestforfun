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

local function tick()
	local heure = os.date("%H")
	local minute = os.date("%M")
	-- Warn every days
	if heure == "04" then
		if minute == "00" then
			minetest.chat_send_all("Rappel : Redémarrage journalier du serveur dans 30 minutes. (Dure 30 minutes)")
			minetest.chat_send_all("Reminder : Daily reboot of the server in 30 minutes. (Lasts 30 minutes)")
			sound_play_all("shutdown_shutdown")
		elseif minute == "15" then
			minetest.chat_send_all("Rappel : Redémarrage journalier du serveur dans 15 minutes. (Dure 30 minutes)")
			minetest.chat_send_all("Reminder : Daily reboot of the server in 15 minutes. (Lasts 30 minutes)")
			sound_play_all("shutdown_shutdown")
		elseif minute == "25" then
			minetest.chat_send_all("Rappel : Redémarrage journalier du serveur dans 5 minutes - Pensez à vous deconnecter !")
			minetest.chat_send_all("Reminder : Daily reboot of the server in 5 minutes - Think about logout!")
			sound_play_all("shutdown_shutdown")
		elseif minute == "29" then
			minetest.chat_send_all("=== ARRET DU SERVEUR - DE NOUVEAU EN LIGNE DANS 30 MIN ===")
			minetest.chat_send_all("=== SERVER SHUTTING DOWN - ONLINE AGAIN IN 30 MIN ===")
			sound_play_all("shutdown_shutdown")
	--		minetest.request_shutdown()
		end
	end
	minetest.after(20, tick)
end

tick()
