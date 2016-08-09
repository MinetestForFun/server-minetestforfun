-- Rune definitions : registration.lua

runes.datas.items = {
	["project"] = {
		description = "Projection rune",
		img = "runes_projection",
		type = "craftitem",
		needed_mana = {
			["minor"] = 15,
			["medium"] = 30,
			["major"]  = 45,
		},
	},
	["damager"] = {
		description = "Damaging rune",
		img = "runes_damaging",
		type = "craftitem",
		needed_mana = {
			["minor"] = 180,
			["medium"] = 190,
			["major"] = 230
		}
	},
	["earthquake"] = {
		description = "Earth Quake rune",
		img = "runes_earthquake",
		type = "craftitem",
		needed_mana = {
			["minor"] = 70,
			["medium"] = 80,
			["major"] = 90
		}
	},
	["heal"] = {
		description = "Healing rune",
		img = "runes_heal",
		type = "cube"
	},
	["gotome"] = {
		description = "Go to me rune",
		img = "runes_go_to_me",
		type = "cube",
		needed_mana = {
			["minor"] = 40,
			["medium"] = 50,
			["major"] = 75
		}
	},
	["megamana"] = {
		description = "Mega Mana",
		img = {
			["minor"] = "default_diamond.png",
			["medium"] = "default_diamond.png",
			["major"] = "default_diamond.png"
		},
		type = "craftitem"
	},
}

for key, value in pairs(runes.datas.items) do
	local runereg = table.copy(value)
	runereg.name = key
	runes.functions.register_rune(runereg)
end
