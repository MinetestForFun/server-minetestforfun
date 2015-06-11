-- AWARDS
--    by Rubenwardy
-------------------------------------------------------
-- this is the init file for the award mod
-------------------------------------------------------

local S
if (minetest.get_modpath("intllib")) then
	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function ( s ) return s end
end

dofile(minetest.get_modpath("awards").."/api.lua")

-- Light it up
awards.register_achievement("award_lightitup",{
	title = S("Light It Up"),
	description = S("Place 100 torches."),
	prizes = {"moreblocks:super_glow_glass 5"},
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "default:torch",
		target = 100
	}
})

-- Light ALL the things!
awards.register_achievement("award_light_all_the_things",{
	title = S("Light ALL The Things!"),
	description = S("Place 1,000 torches."),
	prizes = {"moreblocks:super_glow_glass 25"},
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "default:torch",
		target = 1000
	}
})


-- Saint-Maclou
if minetest.get_modpath("moreblocks") then
	awards.register_achievement("award_saint_maclou",{
		title = S("Saint-Maclou"),
		description = S("Place 20 coal checkers."),
		prizes = {"default:mese 2"},
		icon = "novicebuilder.png",
		trigger = {
			type = "place",
			node = "moreblocks:coal_checker",
			target = 20
		}
	})

	-- Castorama
	awards.register_achievement("award_castorama",{
		title = S("Castorama"),
		description = S("Place 20 iron checkers."),
		prizes = {"default:mese 2"},
		icon = "novicebuilder.png",
		trigger = {
			type = "place",
			node = "moreblocks:iron_checker",
			target = 20
		}
	})

	-- Sam the Trapper
	awards.register_achievement("award_sam_the_trapper",{
		title = S("Sam the Trapper"),
		description = S("Place 2 trap stones."),
		prizes = {"default:stonebrick 10"},
		icon = "novicebuilder.png",
		trigger = {
			type = "place",
			node = "moreblocks:trap_stone",
			target = 2
		}
	})
end

-- Obsessed with Obsidian
awards.register_achievement("award_obsessed_with_obsidian",{
	title = S("Obsessed with Obsidian"),
	description = S("Mine 50 obsidian."),
	prizes = {"default:obsidian 10"},
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:obsidian",
		target = 50
	}
})

-- On the way
awards.register_achievement("award_on_the_way",{
	title = S("On The Way"),
	description = S("Place 100 rails."),
	prizes = {"default:rail 10"},
	icon = "novicebuilder.png",
	trigger = {
		type = "place",
		node = "default:rail",
		target = 100
	}
})

-- Lumberjack
awards.register_achievement("award_lumberjack",{
	title = S("Lumberjack"),
	description = S("Dig 100 tree blocks."),
	prizes = {"default:axe_bronze"},
	icon = "default_tree.png",
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 100
	}
})

-- Semi-pro Lumberjack
awards.register_achievement("award_lumberjack_semipro",{
	title = S("Semi-pro Lumberjack"),
	description = S("Dig 1,000 tree blocks."),
	prizes = {"default:wood 99", "default:axe_mese"},
	icon = "default_tree.png",
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 1000
	}
})

-- Professional Lumberjack
awards.register_achievement("award_lumberjack_professional",{
	title = S("Professional Lumberjack"),
	description = S("Dig 10,000 tree blocks."),
	prizes = {"default:stick 999"},
	icon = "default_tree.png",
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 10000
	}
})

-- L33T Lumberjack
awards.register_achievement("award_lumberjack_leet",{
	title = S("L33T Lumberjack"),
	description = S("Dig 100,000 tree blocks."),
	prizes = {"default:axe_diamond"},
	icon = "default_tree.png",
	trigger = {
		type = "dig",
		node = "default:tree",
		target = 100000
	}
})

-- Junglebaby
awards.register_achievement("award_junglebaby",{
	title = S("Junglebaby"),
	description = S("Dig 100 jungle tree blocks."),
	prizes = {"default:wood 10"},
	icon = "default_jungletree.png",
	trigger = {
		type = "dig",
		node = "default:jungletree",
		target = 100
	}
})

-- Jungleman
awards.register_achievement("award_jungleman",{
	title = S("Jungleman"),
	description = S("Dig 1,000 jungle tree blocks."),
	prizes = {"default:wood 99"},
	icon = "default_jungletree.png",
	trigger = {
		type = "dig",
		node = "default:jungletree",
		target = 1000
	}
})

-- Found some Mese!
awards.register_achievement("award_mesefind",{
	title = S("First Mese Find"),
	description = S("Find some Mese."),
	icon = "default_mese_block.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone_with_mese",
		target = 1
	}
})

-- You're a copper
awards.register_achievement("award_youre_a_copper",{
	title = S("You're a copper"),
	description = S("Dig 1,000 copper ores."),
	prizes = {"default:copper_ingot 20"},
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone_with_copper",
		target = 1000
	}
})

-- You're winner
awards.register_achievement("award_youre_winner",{
	title = S("YOU'RE A WINNER!"),
	description = S("Dig 1 mossy cobblestone."),
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:mossycobble",
		target = 1
	},
	secret = true,
})

-- Found a Nyan cat!
awards.register_achievement("award_nyanfind",{
	title = S("OMG, Nyan Cat!"),
	description = S("Find a nyan cat."),
	icon = "default_nc_rb.png",
	trigger = {
		type = "dig",
		node = "default:nyancat",
		target = 1
	}
})

-- Mini Miner
awards.register_achievement("award_mine2",{
	title = S("Mini Miner"),
	description = S("Dig 100 stone blocks."),
	prizes = {"default:steel_ingot"},
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 100
	}
})

-- Hardened Miner
awards.register_achievement("award_mine3",{
	title = S("Hardened Miner"),
	description = S("Dig 1,000 stone blocks"),
	prizes = {"default:pick_mese"},
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 1000
	}
})

-- Master Miner
awards.register_achievement("award_mine4",{
	title = S("Master Miner"),
	description = S("Dig 10,000 stone blocks."),
	prizes = {"default:pick_diamond"},
	icon = "miniminer.png",
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:stone",
		target = 10000
	}
})

-- Marchand de sable
awards.register_achievement("award_marchand_de_sable",{
	title = S("Marchand De Sable"),
	description = S("Dig 1,000 sand."),
	prizes = {"default:shovel_mese"},
	background = "bg_mining.png",
	trigger = {
		type = "dig",
		node = "default:sand",
		target = 1000
	}
})

-- Join
awards.register_achievement("award_join2",{
	title = S("Frequent Visitor"),
	description = S("Connect to the server 50 times."),
	prizes = {"default:sword_mese"},
	trigger = {
		type = "join",
		target = 50
	},
	secret = true
})

-- Dying Spree
awards.register_achievement("award_dying_spree",{
	title = S("Dying Spree"),
	description = S("Die 5 times."),
	prizes = {"maptools:superapple 2"},
	trigger = {
		type = "death",
		target = 5
	}
})

-- Bot-like
awards.register_achievement("award_bot_like",{
	title = S("Bot-like"),
	description = S("Die 10 times."),
	prizes = {"maptools:superapple 4"},
	trigger = {
		type = "death",
		target = 10
	}
})

-- You Suck!
awards.register_achievement("award_you_suck",{
	title = S("You Suck!"),
	description = S("Die 100 times."),
	prizes = {"3d_armor:boots_diamond"},
	trigger = {
		type = "death",
		target = 100
	},
	secret = true
})

-- Burned to death
awards.register_achievement("award_burn",{
	title = S("You're a witch!"),
	description = S("Burn to death in a fire.")
	--prizes = {"default:water_source"}, NE MARCHE PAS
})
awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 2, "fire:basic_flame") ~= nil then
		return "award_burn"
	end
	return nil
end)

-- Died in flowing lava
awards.register_achievement("award_in_the_flow",{
	title = S("In the Flow"),
	description = S("Die in flowing lava.")
	--prizes = {"default:obsidian"}, NE MARCHE PAS ICI
})
awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 2, "default:lava_flowing") ~= nil then
		return "award_in_the_flow"
	end
	return nil
end)

-- Die near diamond ore
awards.register_achievement("award_this_is_sad",{
	title = S("This is Sad"),
	description = S("Die near diamond ore.")
	--prizes = {"default:diamond 2"}, NE MARCHE PAS
})
awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 5, "default:stone_with_diamond") ~= nil then
		return "award_this_is_sad"
	end
	return nil
end)

-- Die near diamond ore
awards.register_achievement("award_the_stack",{
	title = S("The Stack"),
	description = S("Die near bones.")
})
awards.register_onDeath(function(player,data)
	local pos = player:getpos()
	if pos and minetest.find_node_near(pos, 5, "bones:bones") ~= nil then
		return "award_the_stack"
	end
	return nil
end)

