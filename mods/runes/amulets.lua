-- Amulets

runes.functions.register_amulet("snake",	"Snake Amulet",		10,	5  )
runes.functions.register_amulet("scorpion",	"Scorpion Amulet",	5,	7  )
runes.functions.register_amulet("cactus",	"Cactus Amulet",	5,	10 )
runes.functions.register_amulet("eye", 		"Eye Amulet",		3,	20 )
runes.functions.register_amulet("anubis",	"Anubis' Amulet",	3,	25 )
runes.functions.register_amulet("horus",	"Horus' Amulet",	2,	40 )
runes.functions.register_amulet("thot",		"Thot's Amulet",	2,	45 )
runes.functions.register_amulet("osiris",	"Osiris' Amulet",	2,	50 )
runes.functions.register_amulet("ra",		"Ra's Amulet",		1,	100)

-- Globalstep checking for the amulets
minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local inv = player:get_inventory()
		local basemana = mana.settings.default_max
		for index, item in pairs(inv:get_list("main")) do
			local itemname = item:get_name()
			local itemcount = item:get_count()
			for name, manadiff in pairs(runes.datas.amulets) do
				if itemname == "runes:" .. name .. "_amulet" then
					basemana = basemana + (manadiff * itemcount)
				end
			end
		end
		if basemana ~= mana.settings.default_max then
			mana.setmax(player:get_player_name(), basemana)
		end
	end
end)
