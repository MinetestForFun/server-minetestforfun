-- Rune definitions : registration.lua

runes.datas.items = {
	["project"] = {
		description = "Projection rune",
		img = "runes_projection.png",
		type = "craftitem",
		needed_mana = 30
	},
	["damager"] = {
		description = "Damaging rune",
		img = "runes_damaging.png",
		type = "craftitem",
		needed_mana = 190
	},
	["earthquake"] = {
		description = "Earth Quake rune",
		img = "runes_earthquake.png",
		type = "craftitem",
		needed_mana = 80
	},
	["simple_heal"] = {
		description = "Simple healing rune",
		img = "runes_simple_heal.png",
		type = "cube"
	},
	["improved_heal"] = {
		description = "Improved healing rune",
		img = "runes_improved_heal.png",
		type = "cube"
	},
	["perfect_heal"] = {
		description = "Perfect healing rune",
		img = "runes_perfect_heal.png",
		type = "cube"
	},
	["gotome"] = {
		description = "Go to me rune",
		img = "runes_go_to_me.png",
		type = "cube",
		needed_mana = 50
	},
	["megamana"] = {
		description = "Mega Mana",
		img = "default_diamond.png",
		type = "craftitem"
	},
	["popper"] = {
		description = "Popper",
		img = "default_grass.png",
		type = "plate"
	},
}

for key, value in pairs(runes.datas.items) do
	local runereg = table.copy(value)
	runereg.name = key
	runes.functions.register_rune(runereg)
end
