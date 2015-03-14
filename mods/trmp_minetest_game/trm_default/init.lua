--[[
	This is a Treasure Registration Mod (TRM) for the default mod.
	It is meant to use together with the default mod and the Treasurer mod.

	This TRM registers a bunch of items found in the default mod.
]]

treasurer.register_treasure("default:gold_ingot",0.01,7,{1,10},nil,"crafting_component")
treasurer.register_treasure("default:bronze_ingot",0.02,5,{1,16},nil,"crafting_component")
treasurer.register_treasure("default:copper_ingot",0.06,3,{1,17},nil,"crafting_component")
treasurer.register_treasure("default:steel_ingot",0.09,4,{1,20},nil,"crafting_component")
treasurer.register_treasure("default:clay_brick",0.1,5,{2,12},nil,"crafting_component")
treasurer.register_treasure("default:coal_lump",0.2,2,{3,10},nil,{ "crafting_component", "fuel" })
treasurer.register_treasure("default:coalblock",0.02,6,1,nil, "fuel")
treasurer.register_treasure("default:obsidian_shard",0.05,5,{3,20},nil,"crafting_component")
treasurer.register_treasure("default:obsidian_shard",0.0005,5,{21,90},nil,"crafting_component")
treasurer.register_treasure("default:mese_crystal",0.008,9,{1,5},nil,"crafting_component")


treasurer.register_treasure("default:paper",0.1,2,{3,6},nil,"crafting_component")
treasurer.register_treasure("default:stick",0.1,2,{1,15},nil,"crafting_component")
treasurer.register_treasure("default:stick",0.05,2,{16,33},nil,"crafting_component")
treasurer.register_treasure("default:book",0.1,4,{1,2},nil,"crafting_component")

treasurer.register_treasure("default:mese_crystal_fragment",0.01,3,{1,9},nil,"crafting_component")
treasurer.register_treasure("default:sapling",0.05,2,{1,20},nil,"seed")
treasurer.register_treasure("default:junglesapling",0.03,3,{1,5},nil,"seed")
treasurer.register_treasure("default:apple",0.2,0.5,{1,7},nil,"food")

treasurer.register_treasure("default:shovel_wood",0.02,2,nil,nil,"minetool")
treasurer.register_treasure("default:shovel_stone",0.050,3,nil,nil,"minetool")
treasurer.register_treasure("default:shovel_steel",0.07,5,nil,nil,"minetool")
treasurer.register_treasure("default:shovel_bronze",0.006,6,nil,nil,"minetool")
treasurer.register_treasure("default:shovel_mese",0.0012,8,nil,nil,"minetool")
treasurer.register_treasure("default:shovel_diamond",0.0008,9,nil,nil,"minetool")

treasurer.register_treasure("default:axe_wood",0.02,2,nil,nil,"minetool")
treasurer.register_treasure("default:axe_stone",0.045,3,nil,nil,"minetool")
treasurer.register_treasure("default:axe_steel",0.05,5,nil,nil,"minetool")
treasurer.register_treasure("default:axe_bronze",0.005,6,nil,nil,"minetool")
treasurer.register_treasure("default:axe_mese",0.0002,8,nil,nil,"minetool")
treasurer.register_treasure("default:axe_diamond",0.000125,9,nil,nil,"minetool")

treasurer.register_treasure("default:pick_wood",0.005,2,nil,nil,"minetool")
treasurer.register_treasure("default:pick_stone",0.018,3,nil,nil,"minetool")
treasurer.register_treasure("default:pick_steel",0.02,5,nil,nil,"minetool")
treasurer.register_treasure("default:pick_bronze",0.004,6,nil,nil,"minetool")
treasurer.register_treasure("default:pick_mese",0.008,8,nil,nil,"minetool")
treasurer.register_treasure("default:pick_diamond",0.005,9,nil,nil,"minetool")

treasurer.register_treasure("default:sword_wood",0.001,2,nil,nil,"melee_weapon")
treasurer.register_treasure("default:sword_stone",0.016,3,nil,nil,"melee_weapon")
treasurer.register_treasure("default:sword_steel",0.02,5,nil,nil,"melee_weapon")
treasurer.register_treasure("default:sword_bronze",0.015,6,nil,nil,"melee_weapon")
treasurer.register_treasure("default:sword_mese",0.007,8,nil,nil,"melee_weapon")
treasurer.register_treasure("default:sword_diamond",0.0035,9,nil,nil,"melee_weapon")

treasurer.register_treasure("default:rail",0.01,5,15,nil,"vehicle_structure")
treasurer.register_treasure("default:rail",0.02,5,{1,5},nil,"vehicle_structure")
treasurer.register_treasure("default:fence_wood",0.1,4,{1,7},nil,"building_block")

treasurer.register_treasure("default:sign_wall",0.1,4,nil,nil,"deco")
treasurer.register_treasure("default:ladder",0.1,3,{1,2},nil,"ladder")
treasurer.register_treasure("default:torch",0.2,2,{1,5},nil,"light")

treasurer.register_treasure("default:stonebrick",0.002,4,{1,5},nil,"building_block")
treasurer.register_treasure("default:desert_stonebrick",0.009,4,{1,10},nil,"building_block")
treasurer.register_treasure("default:sandstone",0.009,3,{1,3},nil,"building_block")
treasurer.register_treasure("default:sandstonebrick",0.0001,4,{1,10},nil,"building_block")
treasurer.register_treasure("default:junglewood",0.005,2,{1,20},nil,"building_block")
treasurer.register_treasure("default:wood",0.01,2,{1,20},nil,"building_block")
treasurer.register_treasure("default:cobble",0.05,1,{1,25},nil,"building_block")
treasurer.register_treasure("default:mossycobble",0.005,1,{1,5},nil,"building_block")

treasurer.register_treasure("default:cactus",0.002,1.5,{3,4},nil,"fuel")

treasurer.register_treasure("default:bookshelf",0.02,3.5,1,nil,"deco")
treasurer.register_treasure("default:glass",0.05,2,1,nil,"building_block")
treasurer.register_treasure("default:steelblock",0.002,4,1,nil,"building_block")
treasurer.register_treasure("default:copperblock",0.0015,3,1,nil,"building_block")
treasurer.register_treasure("default:bronzeblock",0.0005,5,1,nil,"building_block")
treasurer.register_treasure("default:goldblock",0.001,7,1,nil,"building_block")
treasurer.register_treasure("default:mese",0.0001,8,1,nil,"building_block")
treasurer.register_treasure("default:diamondblock",0.00002,10,1,nil,"building_block")
