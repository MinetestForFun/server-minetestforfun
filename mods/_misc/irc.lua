# Based on https://github.com/ChaosWormz/mt_terms_of_use

local IRC = [[
-~= Regles du salon de chat IRC #minetestforfun@irc.inchra.net =~-
(Ces regles ont ete etablies le 1er Novembre 2014 par les operateurs du canal Mg et MinetestForFun)

1) Il ne sera tolere aucune transgressions aux regles du reseau InchraNet, sous peine de la sanction prevue par les administrateurs du reseau.
2) Il ne sera tolere aucune forme de violation des lois en vigueur dans les pays de residence des participants, ainsi que ceux des hebergeurs des serveurs.
3) Il ne sera tolere aucune sorte d'insulte, de provocation gratuite, d'incitation a la haine, au meurtre, au suicide, ou toute autre forme d'atteinte au respect mutuel des utilisateurs de l'IRC.
4) Il ne sera tolere aucune forme de flood ainsi que de spam. Rappelez-vous qu'il est preferable d'utiliser un site de televersion de texte (aussi nomme "pastebin"), tel que "pastebin.ubuntu.com" a chaque fois que vous desirez transmettre du code ou un long texte.
	Le flood est l'action de saturer le chat de messages repetitifs, inutiles, y compris les join/part, grossiers, sans aucun rapport avec la conversation et au detriment des participants
	Le spam est l'action de faire de la publicite pour quelque chose que ce soit sans l'accord d'un ayant droit ou d'un operateur de canal.
5) Il ne sera tolere aucun pseudonyme a caractere sexuel, haineux, contenant des termes ou propos indesirables sur le salon.
6) Il ne sera tolere aucune forme d'harcelement moral ou a caractere sexuel, y compris par messages prives.
7) Il ne sera tolere aucun type de discrimination contre quelque participant que ce soit, ni aucune forme d'insulte envers les operateurs, semi-operateurs et administrateurs d'InchraNet.

Voici les sanctions prevues pour les infractions aux regles ci-dessus.

- Infraction niveau DIRT :
	Manque de respect envers autrui : Devoice une journee
	Provocation envers autrui : Devoice une journee
	Insultes envers autrui : Kick + Devoice une journee

- Infraction niveau STONE :
	- Recidivide d'infraction niveau dirt : Kick + Ban 1/2 journee
	- Flood, Discrimination : Kick + Devoice deux heures
	- Spam : Kick + Devoice 1 jour + Ban 1/2 journee

- Infraction niveau MESE :
	- Recidive d'infraction niveau stone : Kick + Ban 4 jours + devoice 5 jours
	- Diffusion de contenu a caractere sexuel : Kick + Ban 1 semaine + devoice 5 jours
	- Irrespect envers l'equipe du canal : Kick + Ban 10 jours + devoice 8 jours

- Infraction niveau OBSIDIAN :
	- Recidive d'infraction niveau mese : Kick + Ban 1 mois + devoice 2 semaines
	- Violation des lois en vigueur : Kick + Ban definitif + Gline si accord des IrcOP d'InchraNet
	- Violation des regles d'InchraNet : Kick + Ban definitif + Gline ou sanction defnie par l'equipe d'InchraNet


Autres regles de bienseances :
- Ne demandez pas a faire partie des operateurs/semi-operateurs du canal.
- Attention, l'abus de query et msg est dangereux pour la sante.
- Inutile de faire etalage de votre vie privee si c'est hors contexte ou si personne n'est interesse par celle ci.
- Nous ne sanctionnons bien evidemment pas le hors-sujet, toutefois, s'il est evitable ca ne peut qu’être toujours un plus !
- Le respect d'autrui est important a nos yeux.
- En cas de probleme, n'hesitez pas a contacter le staff.
]]

local function make_formspec()
	local size = { "size[12,10;]" }
	table.insert(size, "background[-0.22,-0.25;13,11;irc_background.jpg]")
	table.insert(size, "textarea[.50,1;12,10;TOS;Voici les regles, cliquez sur Accepter si vous etes d'accord avec;"..minetest.formspec_escape(IRC).."]")
	table.insert(size, "button_exit[6,9.9;1.5,0.5;accept;J'accepte]")
	table.insert(size, "button[7.5,9.9;1.5,0.5;decline;Je refuse]")
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
		minetest.kick_player(name, "Aurevoir ! Vous devez accepter les regles de l'irc pour jouer sur le serveur (revennez si vous changez d'avis).")
		return
	end
end)

minetest.register_chatcommand("irc",{
	params = "",
	description = "Montre les regles de l'irc",
	func = function (name,params)
	local player = minetest.get_player_by_name(name)
		minetest.after(1, function()
			minetest.show_formspec(name, "irc", make_formspec())
		end)
	end
})
