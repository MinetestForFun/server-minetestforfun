-- Amulets
runes.functions.register_amulet("silver_cross",		"Silver Cross",			1,	25 )
runes.functions.register_amulet("minotaur_eye",		"Minotaur Eye",			1,	50 )
runes.functions.register_amulet("hellfire",	"Hellfire Amulet",		1,	75 )
runes.functions.register_amulet("grim_reaper",	"Grim Reaper's Amulet",		1,	100)

-- Recipes
minetest.register_craft({
	output = "runes:silver_cross_amulet",
	recipe = {
		{"", "farming:cotton", ""},
		{"default:silver_ingot", "default:silver_ingot", "default:silver_ingot"},
		{"", "default:silver_ingot", ""},
	}
})

minetest.register_craft({
	output = "runes:minotaur_eye_amulet",
	recipe = {
		{"", "darkage:chain", ""},
		{"technic:brass_ingot", "mobs:minotaur_eye", "technic:brass_ingot"},
		{"", "mesecons_materials:glue", ""},
	}
})

minetest.register_craft({
	output = "runes:hellfire_amulet",
	recipe = {
		{"", "darkage:chain", ""},
		{"mobs:lava_orb", "default:diamondblock", "mobs:lava_orb"},
		{"default:obsidian", "bucket:bucket_lava", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "runes:grim_reaper_amulet",
	recipe = {
		{"", "runes:hellfire_amulet", ""},
		{"nether:white", "runes:black_magic_block", "nether:white"},
		{"", "default:mithrilblock", ""},
	}
})

minetest.register_craft({
	output = "runes:black_magic_block",
	recipe = {
		{"nether:white", "runes:hellfire_amulet", "default:obsidian"},
		{"default:nyancat", "nether:tree", "default:mese"},
		{"default:obsidian", "default:mithrilblock", "nether:white"},
	}
})

-- Nodes
minetest.register_node("runes:black_magic_block", {
	description = "Black Magic Block",
	tiles = {"runes_black_magic_block.png"},
	is_ground_content = true,
	paramtype2 = "facedir",
	groups = {crumbly=3},
	sounds = default.node_sound_sand_defaults(),
})

-- Globalstep checking for the amulets
tmpdata = {}
loop = function()
	for _, player in pairs(minetest.get_connected_players()) do
		local inv = player:get_inventory()
		local pname = player:get_player_name()
		local basemana = mana.getmax(pname) - (tmpdata[pname] or 0) -- Baseline mana, without any amulets
		local addons = 0
		for index, item in pairs(inv:get_list("main")) do
			local itemname = item:get_name()
			local itemcount = item:get_count()
			for name, manadiff in pairs(runes.datas.amulets) do
				if itemname == "runes:" .. name .. "_amulet" then
					addons = addons + (manadiff * itemcount)
					--print("Detected " .. name)
				end
			end
		end
		mana.setmax(pname, basemana + addons)
		tmpdata[pname] = addons
	end
	minetest.after(1, loop)
end

minetest.after(0, loop)

minetest.register_on_leaveplayer(function(player)
	local pname = player:get_player_name()
	mana.setmax(pname, mana.getmax(pname) - tmpdata[pname]) -- Reset
	tmpdata[pname] = nil
	mana.save_to_file(pname) -- Double class since we aren't sure mana hasn't already saved (it probably did)
end)
