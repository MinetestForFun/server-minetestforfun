# Based on https://github.com/ChaosWormz/mt_terms_of_use

local IRC = [[
-~= Règles du salon de chat IRC #minetestforfun@irc.inchra.net =~-
(Ces règles ont été établies le 1er Novembre 2014 par les opérateurs du canal Mg et MinetestForFun)

1) Il ne sera toléré aucune transgressions aux règles du réseau InchraNet, sous peine de la sanction prévue par les administrateurs du réseau.
2) Il ne sera toléré aucune forme de violation des lois en vigueur dans les pays de résidence des participants, ainsi que ceux des hébergeurs des serveurs.
3) Il ne sera toléré aucune sorte d'insulte, de provocation gratuite, d'incitation à la haine, au meurtre, au suicide, ou toute autre forme d'atteinte au respect mutuel des utilisateurs de l'IRC.
4) Il ne sera toléré aucune forme de flood ainsi que de spam. Rappelez-vous qu'il est préférable d'utiliser un site de téléversion de texte (aussi nommé "pastebin"), tel que "pastebin.ubuntu.com" à chaque fois que vous désirez transmettre du code ou un long texte.
	Le flood est l'action de saturer le chat de messages répétitifs, inutiles, y compris les join/part, grossiers, sans aucun rapport avec la conversation et au détriment des participants
	Le spam est l'action de faire de la publicité pour quelque chose que ce soit sans l'accord d'un ayant droit ou d'un opérateur de canal.
5) Il ne sera toléré aucun pseudonyme à caractère sexuel, haineux, contenant des termes ou propos indésirables sur le salon.
6) Il ne sera toléré aucune forme d'harcèlement moral ou à caractère sexuel, y compris par messages privés.
7) Il ne sera toléré aucun type de discrimination contre quelque participant que ce soit, ni aucune forme d'insulte envers les opérateurs, semi-opérateurs et administrateurs d'InchraNet.

Voici les sanctions prévues pour les infractions aux règles ci-dessus.

- Infraction niveau DIRT :
	Manque de respect envers autrui : Devoice une journée
	Provocation envers autrui : Devoice une journée
	Insultes envers autrui : Kick + Devoice une journée

- Infraction niveau STONE :
	- Récidivide d'infraction niveau dirt : Kick + Ban 1/2 journée
	- Flood, Discrimination : Kick + Devoice deux heures
	- Spam : Kick + Devoice 1 jour + Ban 1/2 journée

- Infraction niveau MESE :
	- Récidive d'infraction niveau stone : Kick + Ban 4 jours + devoice 5 jours
	- Diffusion de contenu à caractère sexuel : Kick + Ban 1 semaine + devoice 5 jours
	- Irrespect envers l'équipe du canal : Kick + Ban 10 jours + devoice 8 jours

- Infraction niveau OBSIDIAN :
	- Récidive d'infraction niveau mese : Kick + Ban 1 mois + devoice 2 semaines
	- Violation des lois en vigueur : Kick + Ban définitif + Gline si accord des IrcOP d'InchraNet
	- Violation des règles d'InchraNet : Kick + Ban définitif + Gline ou sanction défnie par l'équipe d'InchraNet


Autres règles de bienséances :
- Ne demandez pas à faire partie des opérateurs/semi-opérateurs du canal.
- Attention, l'abus de query et msg est dangereux pour la santé.
- Inutile de faire étalage de votre vie privée si c'est hors contexte ou si personne n'est intéressé par celle ci.
- Nous ne sanctionnons bien évidemment pas le hors-sujet, toutefois, s'il est évitable ça ne peut qu’être toujours un plus !
- Le respect d'autrui est important à nos yeux.
- En cas de problème, n'hésitez pas à contacter le staff.
]]

local function make_formspec()
	local size = { "size[10,8]" }
	table.insert(size, "textarea[0.5,0.5;9.5,8;TOS;Voici les regles, cliquez sur Accepter si vous etes d'accord avec;"..minetest.formspec_escape(IRC).."]")
	table.insert(size, "button_exit[6,7.4;1.5,0.5;accept;J'accepte]")
	table.insert(size, "button[7.5,7.4;1.5,0.5;decline;Je refuse]")
	return table.concat(size)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "irc" then return end
	local name = player:get_player_name()
	if fields.accept then
			minetest.chat_send_player(name, "Merci d'avoir accepte les regles, vous etes maintenant capable de parler.")
			minetest.chat_send_player(name, "Pour plus d'informations tapez /news")
			local privs = minetest.get_player_privs(name)
			privs.shout = true
			minetest.set_player_privs(name, privs)
		--end
		return
	elseif fields.decline then
		minetest.kick_player(name, "Aurevoir ! Vous devez accepter les règles de l'irc pour jouer sur le serveur (revennez si vous changez d'avis).")
		return
	end
end)

minetest.register_chatcommand("irc",{
	params = "",
	description = "Montre les regles de l'irc",
	privs = {spawn=true},
	func = function (name,params)
	local player = minetest.get_player_by_name(name)
		minetest.after(1, function()
			minetest.show_formspec(name, "irc", make_formspec())
		end)
	end
})
