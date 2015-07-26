--[[

shutdown par turbogus, code sous licence gpl2 ou sup
déclaration du "timer" par Jat ( du mod annonce )

Affiche l'heure dans le chat toute les minutes et
arrête votre serveur "proprement" à une heure précise afin de créer
une sauvegarde

]]--

local timer = 0

minetest.register_globalstep(function(dtime)
	timer = timer+dtime
	-- if timer < X then  = X seconde temps que s'affiche les message
	-- Default 300 seconde = 5 minute
	if timer < 60 then
		return
	end
	timer = 0
	local heure = os.date("%H")
	local minute = os.date("%M")
	-- Warn every days
	if heure == "4" and minute == "00" then
		minetest.chat_send_all("Rappel : Redémarrage journalier du serveur dans 30 minutes. (Dure 30 minutes)")
		minetest.chat_send_all("Reminder : Daily reboot of the server in 30 minutes. (Lasts 30 minutes)")
	elseif heure == "4" and minute == "15" then
		minetest.chat_send_all("Rappel : Redémarrage journalier du serveur dans 15 minutes. (Dure 30 minutes)")
		minetest.chat_send_all("Reminder : Daily reboot of the server in 15 minutes. (Lasts 30 minutes)")
	elseif heure == "4" and minute == "25" then
		minetest.chat_send_all("Rappel : Redémarrage journalier du serveur dans 5 minutes - Pensez à vous deconnecter !")
		minetest.chat_send_all("Reminder : Daily reboot of the server in 5 minutes - Think about logout!")
	elseif heure == "4" and minute == "29" then
		minetest.chat_send_all("=== ARRET DU SERVEUR - DE NOUVEAU EN LIGNE DANS 30 MIN ===")
		minetest.chat_send_all("=== SERVER SHUTTING DOWN - ONLINE AGAIN IN 30 MIN ===")
		minetest.request_shutdown()
	end

end)
