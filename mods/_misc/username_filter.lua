-- By VanessaE, sfan5, and kaeza.

local disallowed = {
	["guest"]				=	"Les comptes Guest/invités sont désactivés sur ce serveur.  "..
								"S'il vous plaît, choisissez un nom d'utilisateur correcte et réessayez.",
	["^[0-9]+$"]			=	"Les identifiants contenant uniquement des chiffres sont désactivés sur ce serveur. "..
								"S'il vous plaît, choisissez un nom d'utilisateur correcte et réessayez.",
	["[0-9].-[0-9].-[0-9].-[0-9].-[0-9]"]	=	"Trop de chiffres dans votre identifiant. "..
						"S'il vous plaît, réessayez avec moins de 5 chiffres dans votre identifiant.",
	["[4a]dm[1il]n"]		=	"Ce nom d'utilisateur est désactivé pour des raisons évidentes. "..
								"Merci de choisir un autre nom d'utilisateur."
}



minetest.register_on_prejoinplayer(function(name, ip)
	local lname = name:lower()
	for re, reason in pairs(disallowed) do
		if lname:find(re) then
			return reason
		end
	end

	if #name < 2 then
		return "Identifiant trop court. "..
				"S'il vous plaît, choisissez un identifiant avec au moins 2 lettres et réessayez."
	end
	
	if #name > 18 then
      return "Identifiant trop long. "..
            "S'il vous plaît, choisissez un identifiant avec moins de 18 caractères."
	end

end)
