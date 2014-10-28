# Based on https://github.com/ChaosWormz/mt_terms_of_use

local RULES = [[
Voici les règles :

1)	Aucune atteinte intentionnelle au bon fonctionnement du serveur ne sera admise. (lag, crash, exploit de bug, etc...)
2)	La triche (hack, client modifié, etc...) n'est pas tolérée sur le serveur. Soyez fair-play et apprenez à jouer selon les règles.
3)	Sur le serveur, le PVP est autorisé, le vole/grief est aussi autorisé. (pensez au mod areas pour protéger vos biens)
4)	Merci de ne pas spammer ou flooder.
5)	Chaque joueur à l'entière responsabilité de son compte, nous ne sommes en aucun cas responsable d'une utilisation frauduleuse de votre compte dans le jeu.
6)	Si possible, évitez les constructions de tours en 1x1 et, poser des blocs gâchant le décor n'importe ou. Ceci pour que le serveur reste le plus beau, sauvage et naturel possibe.
7)	Ne demandez pas à être membre de l'equipe du serveur.
8)	Aucune forme d'insulte ou de racisme n'est admise.

Cliquez sur le bouton "Accepter" pour pouvoir construire et intéragir sur le serveur.
]]

local function make_formspec()
	local size = { "size[10,8]" }
	table.insert(size, "textarea[0.5,0.5;9.5,8;TOS;Voici les regles, cliquez sur Accepter si vous etes d'accord avec;"..RULES.."]")
	table.insert(size, "button_exit[6,7.4;1.5,0.5;accept;J'accepte]")
	table.insert(size, "button[7.5,7.4;1.5,0.5;decline;Je refuse]")
	return table.concat(size)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "rules" then return end
	local name = player:get_player_name()
	if fields.accept then
		if minetest.check_player_privs(name, {shout=true}) then
			minetest.chat_send_player(name, "Merci d'avoir accepte les regles, vous etes maintenant capable de construire et d'interagir avec le serveur.")
			minetest.chat_send_player(name, "Amusez vous bien a survivre et construire !")
			minetest.chat_send_player(name, "Pour plus d'informations tapez /news")
			local privs = minetest.get_player_privs(name)
			privs.interact = true
			minetest.set_player_privs(name, privs)
		end
		return
	elseif fields.decline then
		minetest.kick_player(name, "Aurevoir ! Vous devez accepter les règles pour jouer sur le serveur (revennez si vous changez d'avoir).")
		return
	end
end)

minetest.register_chatcommand("rules",{
	params = "",
	description = "Montre les regles du serveur",
	privs = {shout=true},
	func = function (name,params)
	local player = minetest.get_player_by_name(name)
		minetest.after(1, function()
			minetest.show_formspec(name, "rules", make_formspec())
		end)
	end
})
