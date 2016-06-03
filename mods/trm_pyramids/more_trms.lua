-- "fuel" group --
-- total loot chance = 0.85
treasurer.register_treasure("default:coalblock", 0.05, 7, {1,4}, nil, fuel) 					--rare
treasurer.register_treasure("bucket:bucket_lava", 0.05, 6, 1, nil, fuel) 						--rare
treasurer.register_treasure("default:tree", 0.075, 3, {10,30}, nil, fuel)						--uncommon
treasurer.register_treasure("default:wood", 0.075, 2, {5,40}, nil, fuel)						--uncommon
treasurer.register_treasure("default:cactus", 0.1, 2, {1,7}, nil, fuel)							--common
treasurer.register_treasure("homedecor:oil_extract", 0.1, 4, {1,20}, nil, fuel)					--common
treasurer.register_treasure("default:grass_1", 0.1, 1, {1,30}, nil, fuel)						--common
treasurer.register_treasure("default:leaves", 0.1, 1, {1,20}, nil, fuel)						--common
treasurer.register_treasure("default:junglegrass", 0.1, 1, {1,20}, nil, fuel)					--common
treasurer.register_treasure("default:dry_shrub", 0.1, 1, {1,10}, nil, fuel)						--common

-- "food" and "raw_food" group --
-- preciousness = hunger restaured
-- total loot chance = 0.87
-- "food" group --
treasurer.register_treasure("maptools:superapple", 0.01, 10, {1,2}, nil, food)					--rare
treasurer.register_treasure("food:bowl", 0.02, 5, {1,5}, nil, food)								--common
treasurer.register_treasure("food:milk", 0.02, 5, {1,5}, nil, food)								--common
treasurer.register_treasure("bushes:mixed_berry_pie_raw", 0.02, 5, {1,5}, nil, food)			--common
treasurer.register_treasure("bushes:blackberry_pie_raw", 0.02, 5, {1,5}, nil, food)				--common
treasurer.register_treasure("bushes:blueberry_pie_raw", 0.02, 5, {1,5}, nil, food)				--common
treasurer.register_treasure("bushes:strawberry_pie_raw", 0.02, 5, {1,5}, nil, food)				--common
treasurer.register_treasure("bushes:raspberry_pie_raw", 0.02, 5, {1,5}, nil, food)				--common
treasurer.register_treasure("fishing:fish_raw", 0.02, 5, {1,5}, nil, food)						--common
treasurer.register_treasure("maptools:superapple", 0.02, 5, {1,5}, nil, food)					--common
treasurer.register_treasure("mobs:chicken_raw", 0.02, 5, {1,5}, nil, food)						--common
treasurer.register_treasure("mobs:meat_raw", 0.02, 5, {1,5}, nil, food)							--common
treasurer.register_treasure("moretrees:coconut_milk", 0.02, 1, {1,5}, nil, food)				--common
treasurer.register_treasure("moretrees:raw_coconut", 0.02, 2, {1,5}, nil, food)					--common
treasurer.register_treasure("moretrees:acorn_muffin", 0.02, 3, {1,5}, nil, food)				--common
treasurer.register_treasure("moretrees:spruce_nuts", 0.02, 1, {1,5}}, nil, food)				--common
treasurer.register_treasure("moretrees:pine_nuts", 0.02, 1, {1,5}, nil, food)					--common
treasurer.register_treasure("moretrees:fir_nuts", 0.02, 1, {1,5}, nil, food)					--common
treasurer.register_treasure("mushroom:poison", 0.02, 1, {1,5}, nil, food) 						--common	--1 de preciousness exeptionnel car empoisonné
treasurer.register_treasure("farming:bread", 0.02, 5, {1,5}, nil, food)							--common
treasurer.register_treasure("farming:potato", 0.02, 1, {1,5}, nil, food)						--common
treasurer.register_treasure("farming:baked_potato", 0.02, 5, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:cucumber", 0.02, 3, {1,5}, nil, food)						--common
treasurer.register_treasure("farming:tomato", 0.02, 3, {1,5}, nil, food)						--common
treasurer.register_treasure("farming:carrot", 0.02, 3, {1,5}, nil, food)						--common
treasurer.register_treasure("farming:carrot_gold", 0.02, 3, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:corn", 0.02, 3, {1,5}, nil, food)							--common
treasurer.register_treasure("farming:corn_cob", 0.02, 5, {1,5}, nil, food)						--common
treasurer.register_treasure("farming:melon_slice", 0.02, 2, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:pumpkin_slice", 0.02, 1, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:pumpkin_bread", 0.02, 7, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:coffee_cup", 0.02, 2, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:coffee_cup_hot", 0.02, 3, {1,5}, nil, food)				--common
treasurer.register_treasure("farming:cookie", 0.02, 2, {1,5}, nil, food)						--common
treasurer.register_treasure("farming:chocolate_dark", 0.02, 3, {1,5}, nil, food)				--common
treasurer.register_treasure("farming:donut", 0.02, 4, {1,5}, nil, food)							--common
treasurer.register_treasure("farming:donut_chocolate", 0.02, 5, {1,5}, nil, food)				--common
treasurer.register_treasure("farming:donut_apple", 0.02, 5, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:raspberries", 0.02, 1, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:blueberries", 0.02, 1, {1,5}, nil, food)					--common
treasurer.register_treasure("farming:muffin_blueberry", 0.02, 4, {1,5}, nil, food)				--common
treasurer.register_treasure("farming:smoothie_raspberry", 0.02, 2, {1,5}, nil, food)			--common
treasurer.register_treasure("farming:rhubarb", 0.02, 1, {1,5}, nil, food)						--common
treasurer.register_treasure("farming:rhubarb_pie", 0.02, 5, {1,5}, nil, food)					--common
-- "raw_food" group --
treasurer.register_treasure("maptools:superapple", 0.01, 10, {1,2}, nil, raw_food)				--rare
treasurer.register_treasure("food:bowl", 0.02, 5, {1,5}, nil, raw_food)							--common
treasurer.register_treasure("food:milk", 0.02, 5, {1,5}, nil, raw_food)							--common
treasurer.register_treasure("bushes:mixed_berry_pie_raw", 0.02, 5, {1,5}, nil, raw_food)		--common
treasurer.register_treasure("bushes:blackberry_pie_raw", 0.02, 5, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("bushes:blueberry_pie_raw", 0.02, 5, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("bushes:strawberry_pie_raw", 0.02, 5, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("bushes:raspberry_pie_raw", 0.02, 5, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("fishing:fish_raw", 0.02, 5, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("maptools:superapple", 0.02, 5, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("mobs:chicken_raw", 0.02, 5, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("mobs:meat_raw", 0.02, 5, {1,5}, nil, raw_food)						--common
treasurer.register_treasure("moretrees:coconut_milk", 0.02, 1, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("moretrees:raw_coconut", 0.02, 2, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("moretrees:acorn_muffin", 0.02, 3, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("moretrees:spruce_nuts", 0.02, 1, {1,5}}, nil, raw_food)			--common
treasurer.register_treasure("moretrees:pine_nuts", 0.02, 1, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("moretrees:fir_nuts", 0.02, 1, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("mushroom:poison", 0.02, 1, {1,5}, nil, raw_food) 					--common	--1 de preciousness exeptionnel car empoisonné
treasurer.register_treasure("farming:bread", 0.02, 5, {1,5}, nil, raw_food)						--common
treasurer.register_treasure("farming:potato", 0.02, 1, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("farming:baked_potato", 0.02, 5, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:cucumber", 0.02, 3, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("farming:tomato", 0.02, 3, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("farming:carrot", 0.02, 3, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("farming:carrot_gold", 0.02, 3, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:corn", 0.02, 3, {1,5}, nil, raw_food)						--common
treasurer.register_treasure("farming:corn_cob", 0.02, 5, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("farming:melon_slice", 0.02, 2, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:pumpkin_slice", 0.02, 1, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:pumpkin_bread", 0.02, 7, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:coffee_cup", 0.02, 2, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:coffee_cup_hot", 0.02, 3, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("farming:cookie", 0.02, 2, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("farming:chocolate_dark", 0.02, 3, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("farming:donut", 0.02, 4, {1,5}, nil, raw_food)						--common
treasurer.register_treasure("farming:donut_chocolate", 0.02, 5, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("farming:donut_apple", 0.02, 5, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:raspberries", 0.02, 1, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:blueberries", 0.02, 1, {1,5}, nil, raw_food)				--common
treasurer.register_treasure("farming:muffin_blueberry", 0.02, 4, {1,5}, nil, raw_food)			--common
treasurer.register_treasure("farming:smoothie_raspberry", 0.02, 2, {1,5}, nil, raw_food)		--common
treasurer.register_treasure("farming:rhubarb", 0.02, 1, {1,5}, nil, raw_food)					--common
treasurer.register_treasure("farming:rhubarb_pie", 0.02, 5, {1,5}, nil, raw_food)				--common

-- "melee_weapons" and "ranged_weapon" group --
-- preciousness = weapons damage/durability (look at the .ODS spreedsheat)
-- total loot chance = 0.775
-- "melee_weapons" group --
treasurer.register_treasure("nether:sword_sywtonic", 0.05, 8, 1, nil, melee_weapons)			--rare
treasurer.register_treasure("default:sword_nyan", 0.05, 6, nil, melee_weapons)					--rare
treasurer.register_treasure("nether:sword_netherrack_blue", 0.075, 6, nil, melee_weapons)		--uncommon
treasurer.register_treasure("default:sword_silver", 0.075, 5, nil, melee_weapons)				--uncommon
treasurer.register_treasure("default:sword_bronze", 0.075, 5, nil, melee_weapons)				--uncommon
treasurer.register_treasure("default:sword_steel", 0.15, 4, nil, melee_weapons)					--common
treasurer.register_treasure("nether:sword_netherrack", 0.15, nil, melee_weapons)					--common
treasurer.register_treasure("default:sword_stone", 0.15, 3, nil, melee_weapons)					--common
-- "ranged_weapon" group --
treasurer.register_treasure("nether:sword_sywtonic", 0.1, 8, 1, nil, ranged_weapon)				--rare
treasurer.register_treasure("default:sword_nyan", 0.1, 6, 1, nil, ranged_weapon)				--rare
treasurer.register_treasure("nether:sword_netherrack_blue", 0.1, 6, 1, nil, ranged_weapon)		--uncommon
treasurer.register_treasure("default:sword_silver", 0.1, 5, 1, nil, ranged_weapon)				--uncommon
treasurer.register_treasure("default:sword_bronze", 0.1, 5, 1, nil, ranged_weapon)				--uncommon
treasurer.register_treasure("default:sword_steel", 0.1, 4, 1, nil, ranged_weapon)				--common
treasurer.register_treasure("nether:sword_netherrack", 0.1, 1, nil, ranged_weapon)				--common
treasurer.register_treasure("default:sword_stone", 0.1, 3, 1, nil, ranged_weapon)				--common

-- "minetool" group --
-- preciousness = weapons efficacity/durability (look at the .ODS spreedsheat)
-- total loot chance = 0.75
treasurer.register_treasure("default:pick_diamond", 0.025, 7, 1, nil, minetool)					--rare
treasurer.register_treasure("default:shovel_mese", 0.025, 6, 1, nil, minetool)					--rare
treasurer.register_treasure("farming:hoe_mese", 0.05, 6, 1, nil, minetool)						--uncommon
treasurer.register_treasure("default:pick_nyan", 0.05, 6, 1, nil, minetool)						--uncommon
treasurer.register_treasure("default:axe_nyan", 0.05, 6, 1, nil, minetool)						--uncommon
treasurer.register_treasure("default:pick_silver", 0.05, 5, 1, nil, minetool)					--uncommon
treasurer.register_treasure("default:axe_silver", 0.05, 5, 1, nil, minetool)					--uncommon
treasurer.register_treasure("default:shovel_silver", 0.05, 5, 1, nil, minetool)				--uncommon
treasurer.register_treasure("farming:hoe_bronze", 0.1, 5, 1, nil, minetool)						--common
treasurer.register_treasure("default:axe_steel", 0.1, 4, 1, nil, minetool)						--common
treasurer.register_treasure("default:shovel_stone", 0.1, 3, 1, nil, minetool)					--common
treasurer.register_treasure("farming:hoe_wood", 0.1, 2, 1, nil, minetool)						--common

-- "tool" group --
-- preciousness = material/craft cost
-- total loot chance = 0.8
treasurer.register_treasure("fishing:pole", 0.2, 1, nil, tool)									--common
treasurer.register_treasure("markers:mark", 0.2, 1, nil, tool)									--common
treasurer.register_treasure("screwdriver:screwdriver", 0.2, 1, nil, tool)						--common
treasurer.register_treasure("moreblocks:circular_saw", 0.2, 1, nil, tool)						--common

-- "deco" group --
-- preciousness = material/craft cost
-- total loot chance = 0.85
treasurer.register_treasure("coloredwood:fence_light_sky_blue", 0.05, 5, {3,6}, nil, deco)		--common
treasurer.register_treasure("coloredwood:fence_dark_redviolet", 0.05, 5, {3,6}, nil, deco)		--common
treasurer.register_treasure("coloredwood:stick_dark_cyan", 0.05, 5, {5,10}, nil, deco)			--common
treasurer.register_treasure("coloredwood:fence_yellow", 0.05, 5, {3,6}, nil, deco)				--common
treasurer.register_treasure("darkage:chain", 0.05, 3, {4,8}, nil, deco)							--common
treasurer.register_treasure("columnia:column_mid_brick", 0.05, 4, {2,4}, nil, deco)				--common
treasurer.register_treasure("darkage:wood_shelves", 0.05, 3, {2,4}, nil, deco)					--common
treasurer.register_treasure("default:fence_cobble", 0.05, 2, {3,6}, nil, deco)					--common
treasurer.register_treasure("dryplants:grass", 0.05, 1, {4,8}), nil, deco)						--common
treasurer.register_treasure("fake_fire:embers", 0.05, 8, {2,4}, nil, deco)						--common
treasurer.register_treasure("fence:fencegate", 0.05, 4, {1,2}, nil, deco)						--common
treasurer.register_treasure("flowers:potted_tulip", 0.05, 1, {1,2}, nil, deco)					--common
treasurer.register_treasure("itemframes:pedestal_junglewood", 0.05, 3, {1,2}, nil, deco)		--common
treasurer.register_treasure("moreblocks:plankstone", 0.05, 3, {3,6}, nil, deco)					--common
treasurer.register_treasure("moreblocks:iron_check", 0.05, 5, {1,2}, nil, deco)					--common
treasurer.register_treasure("stained_glass:2_9", 0.05, 6, {2,4}, nil, deco)						--common
treasurer.register_treasure("stained_glass:7_5_6", 0.05, 6, {2,4}, nil, deco)					--common

-- "light" group --
-- preciousness = material/craft cost and light value
-- total loot chance = 0.85
treasurer.register_treasure("moreblocks:super_glow_glass", 0.005, 10, {1,2}, nil, light) 			--rare
treasurer.register_treasure("moreblocks:glow_glass", 0.005, 9, {3,5}, nil, light) 					--rare
treasurer.register_treasure("glow:lamp", 0.01, 7, {1,3}, nil, light) 								--uncommun
treasurer.register_treasure("glow:stone", 0.01, 7, {1,3}, nil, light) 								--uncommun
treasurer.register_treasure("bobblocks:blueblock", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:bluepole", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:greenblock", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("bobblocks:greenpole", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:greyblock", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:greypole", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:indigoblock", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("bobblocks:indigopole", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("bobblocks:orangeblock", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("bobblocks:orangepole", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("bobblocks:redblock", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:redpole", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:whiteblock", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("bobblocks:whitepole", 0.02, 6, {1,3}, nil, light) 						--uncommun
treasurer.register_treasure("bobblocks:yellowblock", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("bobblocks:yellowpole", 0.02, 6, {1,3}, nil, light) 					--uncommun
treasurer.register_treasure("building_blocks:fireplace", 0.02, 6, {1,3}, nil, light) 				--uncommun
treasurer.register_treasure("sealamps:lantern", 0.02, 6,{1,3}, nil, light) 							--uncommun
treasurer.register_treasure("sealamps:torch", 0.02, 6,{1,3}, nil, light) 							--uncommun
treasurer.register_treasure("lavalamp:red", 0.02, 5, 1, nil, light)									--commun
treasurer.register_treasure("lavalamp:orange", 0.02, 5, 1, nil, light)								--commun
treasurer.register_treasure("lavalamp:green", 0.02, 5, 1, nil, light) 								--commun
treasurer.register_treasure("lavalamp:blue", 0.02, 5, 1, nil, light) 								--commun
treasurer.register_treasure("lavalamp:violet", 0.02, 5, 1, nil, light) 								--commun
treasurer.register_treasure("lavalamp:yellow", 0.02, 5, 1, nil, light) 								--commun
treasurer.register_treasure("default:torch", 0.1, 5,{5,20}, nil, light) 							--commun
treasurer.register_treasure("homedecor:torch_wall", 0.05, 3, {1,10}, nil, light) 					--commun
treasurer.register_treasure("chains:chandelier", 0.025, 3, 1, nil, light)							--commun
treasurer.register_treasure("homedecor:standing_lamp_off", 0.01, 4, {1,2}, nil, light) 				--commun
treasurer.register_treasure("homedecor:table_lamp_off", 0.01, 4, {1,2}, nil, light) 				--commun
treasurer.register_treasure("homedecor:glowlight_half_white", 0.01, 4, {1,2}, nil, light) 			--commun
treasurer.register_treasure("homedecor:glowlight_half_yellow", 0.01, 4, {1,2}, nil, light) 			--commun
treasurer.register_treasure("homedecor:glowlight_quarter_white", 0.01, 4, {1,2}, nil, light) 		--commun
treasurer.register_treasure("homedecor:glowlight_quarter_yellow", 0.01, 4, {1,2}, nil, light) 		--commun
treasurer.register_treasure("homedecor:glowlight_small_cube_white", 0.01, 4, {1,2}, nil, light) 	--commun
treasurer.register_treasure("homedecor:glowlight_small_cube_yellow", 0.01, 4, {1,2}, nil, light)	--commun
treasurer.register_treasure("homedecor:lattice_lantern_large", 0.02, 3, {1,3}, nil, light) 			--commun
treasurer.register_treasure("homedecor:lattice_lantern_small", 0.02, 3, {1,3}, nil, light) 			--commun
treasurer.register_treasure("homedecor:hanging_lantern", 0.02, 3, {1,3}, nil, light)	 			--commun
treasurer.register_treasure("homedecor:ground_lantern", 0.02, 3, {1,3}, nil, light) 				--commun
treasurer.register_treasure("homedecor:celling_lantern", 0.02, 3, {1,3}, nil, light) 				--commun
treasurer.register_treasure("homedecor:oil_lamp", 0.02, 3, {1,2}, nil, light) 						--commun
treasurer.register_treasure("homedecor:candle_thin", 0.02, 3, {1,5}, nil, light) 					--commun
treasurer.register_treasure("homedecor:candle", 0.02, 3, {1,5}, nil, light) 						--commun
treasurer.register_treasure("lantern:candle", 0.02, 3, {1,5}, nil, light) 							--commun
treasurer.register_treasure("christmas_craft:christmas_lights", 0.02, 2, {4,8}, nil, light) 		--commun

-- "building_block" group --
-- preciousness = material/craft cost
-- total loot chance = 0.7525
treasurer.register_treasure("nether:white", 0.0025, 10, 1, nil, building_block) 						--rare --siwtonic bloc
treasurer.register_treasure("default:diamondblock", 0.0025, 9, 1, nil, building_block) 					--rare
treasurer.register_treasure("default:mese", 0.0025, 9, 1, nil, building_block) 							--rare
treasurer.register_treasure("default:goldblock", 0.005, 8, 1, nil, building_block)						--rare
treasurer.register_treasure("default:silverblock", 0.005, 8, 1, nil, building_block) 					--rare
treasurer.register_treasure("default:bronzeblock", 0.005, 8, 1, nil, building_block) 					--rare
treasurer.register_treasure("default:copperblock", 0.005, 8, 1, nil, building_block) 					--rare
treasurer.register_treasure("default:steelblock", 0.005, 8, 1, nil, building_block)						--rare
treasurer.register_treasure("default:tinblock", 0.005, 8, 1, nil, building_block) 						--rare
treasurer.register_treasure("building_blocks:grate", 0.005, 7, {4,8}, nil, building_block) 				--uncommon
treasurer.register_treasure("moreblocks:iron_stone_bricks", 0.005, 7, {4,8}, nil, building_block) 		--uncommon
treasurer.register_treasure("moreblocks:coal_stone_bricks", 0.005, 4, {4,8}, nil, building_block) 		--uncommon
treasurer.register_treasure("moreblocks:all_faces_jungle_tree", 0.005, 6, {4,8}, nil, building_block)	--uncommon
treasurer.register_treasure("moreblocks:all_faces_tree", 0.005, 6, {4,8}, nil, building_block) 			--uncommon
treasurer.register_treasure("building_blocks:marble", 0.01, 6, {4,8}, nil, building_block)				--uncommon
treasurer.register_treasure("building_blocks:hardwood", 0.005, 5, {4,8}, nil, building_block) 			--uncommon
treasurer.register_treasure("darkage:ors_brick", 0.005, 6, {4,8}, nil, building_block) 					--uncommon
treasurer.register_treasure("darkage:marble", 0.005, 6, {4,8}, nil, building_block)						--uncommon
treasurer.register_treasure("darkage:gneiss_cobble", 0.005, 6, {4,8}, nil, building_block) 				--uncommon
treasurer.register_treasure("darkage:gneiss_brick", 0.005, 6, {4,8}, nil, building_block) 				--uncommon
treasurer.register_treasure("darkage:gneiss", 0.005, 6, {4,8}, nil, building_block) 					--uncommon
treasurer.register_treasure("darkage:basalt_cobble", 0.005, 5, {4,8}, nil, building_block) 				--uncommon
treasurer.register_treasure("colouredstonebricks:grey", 0.01, 5, {3,6}, nil, building_block) 			--commun
treasurer.register_treasure("colouredstonebricks:red", 0.01, 5, {3,6}, nil, building_block) 			--commun
treasurer.register_treasure("colouredstonebricks:dark_blue", 0.01, 5, {3,6}, nil, building_block) 		--commun
treasurer.register_treasure("colouredstonebricks:pink", 0.01, 5, {3,6}, nil, building_block) 			--commun
treasurer.register_treasure("colouredstonebricks:orange", 0.01, 5, {3,6}, nil, building_block) 			--commun
treasurer.register_treasure("colouredstonebricks:black", 0.01, 5, {3,6}, nil, building_block) 			--commun
treasurer.register_treasure("moreblocks:grey_brick", 0.01, 5, {3,6}, nil, building_block)				--commun
treasurer.register_treasure("moreblocks:cactus_brick", 0.005, 4, {3,6}, nil, building_block) 			--commun
treasurer.register_treasure("default:brick", 0.005, 4, {3,6}, nil, building_block) 						--commun
treasurer.register_treasure("moreblocks:stone_tile", 0.005, 4, {3,6}, nil, building_block) 				--commun
treasurer.register_treasure("building_blocks:tar", 0.005, 3, {4,8}, nil, building_block) 				--commun
treasurer.register_treasure("christmas_craft:snowman", 0.005, 3, 1, nil, building_block) 				--commun
treasurer.register_treasure("default:snowblock", 0.005, 2, {1,2}, nil, building_block) 					--commun
treasurer.register_treasure("default:mossycobble", 0.005, 2, {10,50}, nil, building_block) 				--commun
treasurer.register_treasure("default:sandstonebrick", 0.025, 1, {50,99}, nil, building_block) 			--commun
treasurer.register_treasure("default:cobble", 0.05, 1, {50,99}, nil, building_block) 					--commun
treasurer.register_treasure("default:desert_sand", 0.05, 1, {50,99}, nil, building_block) 				--commun
treasurer.register_treasure("default:sand", 0.05, 1, {50,99}, nil, building_block) 						--commun
treasurer.register_treasure("default:dirt", 0.05, 1, {50,99}, nil, building_block) 						--commun

-- "seed" group --
-- preciousness = seeds and sapling usefull
-- total loot chance = 0.90
treasurer.register_treasure("farming_seed_wheat", 0.45, 1, {1,20}, nil, seed)					--commun
treasurer.register_treasure("farming:seed_cotton", 0.45, 1, {1,20}, nil, seed)					--commun

-- "transport_vehicle" group --
-- preciousness = material/craft cost
-- total loot chance = 0.85
treasurer.register_treasure("carts:cart", 0.35, 5, {1,2}, nil, transport_vehicle)				--uncommun
treasurer.register_treasure("boats:boat", 0.50, 2, {1,2}, nil, transport_vehicle)				--commun

-- "transport_structure" group --
-- preciousness = material/craft cost
-- total loot chance = 0.75
treasurer.register_treasure("carts:rail_power", 0.05, 6, {2,4}, nil, transport_structure)				--uncommon
treasurer.register_treasure("carts:rail_brake", 0.05, 5, {2,4}, nil, transport_structure)				--uncommon
treasurer.register_treasure("homedecor:fence_brass", 0.1, 3, {3,6}, nil, transport_structure)			--commun
treasurer.register_treasure("homedecor:fence_wrought_iron", 0.1, 3, {3,6}, nil, transport_structure)	--commun
treasurer.register_treasure("carts:rail_copper", 0.25, 3, {6,12}), nil, transport_structure)			--commun
treasurer.register_treasure("default:rail", 0.25, 2, {6,12}, nil, transport_structure)					--commun

-- "ladder" group --
-- preciousness = material/craft cost
-- total loot chance = 0.75
treasurer.register_treasure("lavatemple:ladder", 0.25, 1, {2,4}, nil, ladder)					--uncommun
treasurer.register_treasure("default:ladder", 0.5, 1, {6,12}, nil, ladder)						--commun

-- "default" --
-- This is the group your treasure get assigned to if you don’t specify a group.
