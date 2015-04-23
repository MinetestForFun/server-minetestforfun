-- Rune definitions : registration.lua

runes.datas.items = {
	["project"] = {
		description = "Projection rune",
		img = "default_dirt.png",
		type = "craftitem",
		needed_mana = 30
	},
	["damager"] = {
		description = "Damaging rune",
		img = "default_lava.png",
		type = "craftitem",
		needed_mana = 190
	},
	["earthquake"] = {
		description = "Earth Quake rune",
		img = "default_apple.png",
		type = "craftitem",
		needed_mana = 80
	},
	["simple_heal"] = {
		description = "Simple healing rune",
		img = "default_water.png",
		type = "cube"
	},
	["improved_heal"] = {
		description = "Improved healing rune",
		img = "default_acid.png",
		type = "cube"
	},
	["perfect_heal"] = {
		description = "Perfect healing rune",
		img = "default_lava.png",
		type = "cube"
	},
	["gotome"] = {
		description = "Go to me rune",
		img = "default_wood.png",
		type = "cube"
	}
}

for key, value in pairs(runes.datas.items) do
	local runereg = table.copy(value)
	runereg.name = key
	runes.functions.register_rune(runereg)
end
