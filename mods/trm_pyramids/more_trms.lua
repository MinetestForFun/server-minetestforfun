-- Fuel group --
treasurer.register_treasure("bucket:bucket_lava", 0.008, 6, 1)
treasurer.register_treasure("default:coalblock", 0.008, 4, {1,2})
treasurer.register_treasure("default:wood", 0.075, 2, {1,15})
treasurer.register_treasure("default:tree", 0.07, 3, {1,5})
treasurer.register_treasure("default:cactus", 0.06, 2, {1,7})
treasurer.register_treasure("homedecor:oil_extract", 0.02, 4, {1,20})
treasurer.register_treasure("default:grass_1", 0.09, 1, {1,30})
treasurer.register_treasure("default:leaves", 0.099, 1, {1,20})
treasurer.register_treasure("default:junglegrass", 0.085, 1, {1,20})
treasurer.register_treasure("default:dry_shrub", 0.085, 1, {1,10})

-- Food group --
treasurer.register_treasure("food:bowl", 0.07, 5, 1)
treasurer.register_treasure("food:milk", 0.075, 5, 1)
treasurer.register_treasure("bushes:mixed_berry_pie_raw", 0.06, 5, {1,3})
treasurer.register_treasure("bushes:blackberry_pie_raw", 0.064, 5, {1,4})
treasurer.register_treasure("bushes:blueberry_pie_raw", 0.064, 5, {1,4})
treasurer.register_treasure("bushes:strawberry_pie_raw", 0.064, 5, {1,4})
treasurer.register_treasure("bushes:raspberry_pie_raw", 0.064, 5, {1,4})
treasurer.register_treasure("farming:bread", 0.07, 5, {1,2})
treasurer.register_treasure("farming:flour", 0.075, 5, {1,3})
treasurer.register_treasure("farming:carrot", 0.071, 5, {1,4})
treasurer.register_treasure("farming:donut", 0.068, 5, {1,3})
treasurer.register_treasure("farming:melon_slice", 0.074, 5, {1,6})
treasurer.register_treasure("farming:tomato", 0.075, 5, {1,6})
treasurer.register_treasure("fishing:fish_raw", 0.063, 5, {1,2})
treasurer.register_treasure("maptools:superapple", 0.002, 5, 1})
treasurer.register_treasure("mobs:chicken_raw", 0.060, 5, {1,4})
treasurer.register_treasure("mobs:meat_raw", 0.065, 5, {1,4})
treasurer.register_treasure("moretrees:coconut", 0.055, 5, {1,2})
treasurer.register_treasure("mushroom:poison", 0.059, 5, {1,5})
treasurer.register_treasure("farming:blueberries", 0.05, 5, {1,10})

-- Melee weapons --
treasurer.register_treasure("building_blocks:knife", 0.05, 2, 1})
treasurer.register_treasure("moreores:sword_silver", 0.01, 2, 1})
treasurer.register_treasure("nether:sword_sywtonic", 0.0025, 10, 1})
treasurer.register_treasure("nether:sword_netherrack_blue", 0.0025, 4, 1})
treasurer.register_treasure("nether:sword_netherrack", 0.0025, 3, 1})
treasurer.register_treasure("default:sword_nyan", 0.005, 9, 1})


-- Tools --
treasurer.register_treasure("default:axe_nyan", 0.0000121, 8, 1})
treasurer.register_treasure("default:shovel_nyan", 0.000121, 8, 1})
treasurer.register_treasure("default:pick_nyan", 0.000121, 8, 1}
treasurer.register_treasure("default:hoe_wood", 0.02, 1, 1})
treasurer.register_treasure("default:hoe_stone", 0.004, 2, 1})
treasurer.register_treasure("default:hoe_steel", 0.002, 3, 1})
treasurer.register_treasure("default:hoe_bronze", 0.0008, 5, 1})
treasurer.register_treasure("default:hoe_mese", 0.0002, 7, 1})
treasurer.register_treasure("default:hoe_diamond", 0.000121, 10, 1})
treasurer.register_treasure("fishing:pole", 0.05, 1, 1})
treasurer.register_treasure("markers:mark", 0.034, 1, 1})
treasurer.register_treasure("moreores:axe_silver", 0.0001, 6, 1})
treasurer.register_treasure("moreores:hoe_silver", 0.00013, 6, 1})
treasurer.register_treasure("moreores:pick_silver", 0.00009, 6, 1})
treasurer.register_treasure("moreores:shovel_silver", 0.00014, 6, 1})
treasurer.register_treasure("screwdriver:screwdriver", 0.001, 1, 1})
treasurer.register_treasure("moreblocks:circular_saw", 0.002, 1, 1})

-- Deco group --
treasurer.register_treasure("coloredwood:fence_light_sky_blue", 0.025, 5, {1,6})
treasurer.register_treasure("coloredwood:fence_dark_redviolet", 0.025, 5, {1,6})
treasurer.register_treasure("coloredwood:stick_dark_cyan", 0.02, 5, {1,4})
treasurer.register_treasure("coloredwood:fence_yellow", 0.025, 5, {1,6})
treasurer.register_treasure("darkage:chain", 0.025, 3, {1,10})
treasurer.register_treasure("columnia:column_mid_brick", 0.025, 4, {1,7})
treasurer.register_treasure("darkage:wood_shelves", 0.02, 3, {1,2})
treasurer.register_treasure("default:fence_cobble", 0.03, 2, {1,20})
treasurer.register_treasure("dryplants:grass", 0.04, 1, {1,8})
treasurer.register_treasure("fake_fire:embers", 0.015, 8, {1,3})
treasurer.register_treasure("fence:fencegate", 0.02, 4, {1,2})
treasurer.register_treasure("flowers:potted_tulip", 0.02, 1, {1,4})
treasurer.register_treasure("itemframes:pedestal_junglewood", 0.012, 3, {1,3})
treasurer.register_treasure("moreblocks:plankstone", 0.025, 3, {1,6})
treasurer.register_treasure("moreblocks:iron_check", 0.02, 5, {1,3})
treasurer.register_treasure("stained_glass:2_9", 0.02, 6, {1,4})
treasurer.register_treasure("stained_glass:7_5_6", 0.02, 6, {1,4})

light:
-- Is a light source.
-- Preciousness is based on the brightness. For the maximum brightness (before sun brightness), preciousness should be 3.

treasurer.register_treasure("moreblocks:super_glow_glass", 0.005, 10, {1,5}) 			--rare
treasurer.register_treasure("moreblocks:glow_glass", 0.005, 9, {1,5}) 					--rare
treasurer.register_treasure("glow:lamp", 0.01, 7, {1,5}) 								--uncommun
treasurer.register_treasure("glow:stone", 0.01, 7, {1,5}) 								--uncommun
treasurer.register_treasure("bobblocks:blueblock", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:bluepole", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:greenblock", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("bobblocks:greenpole", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:greyblock", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:greypole", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:indigoblock", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("bobblocks:indigopole", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("bobblocks:orangeblock", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("bobblocks:orangepole", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("bobblocks:redblock", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:redpole", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:whiteblock", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("bobblocks:whitepole", 0.02, 6, {1,5}) 						--uncommun
treasurer.register_treasure("bobblocks:yellowblock", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("bobblocks:yellowpole", 0.02, 6, {1,5}) 					--uncommun
treasurer.register_treasure("building_blocks:fireplace", 0.02, 6, {1,5}) 				--uncommun
treasurer.register_treasure("sealamps:lantern", 0.02, 6,{1,10}) 						--uncommun
treasurer.register_treasure("sealamps:torch", 0.02, 6,{1,10}) 							--uncommun
treasurer.register_treasure("default:torch", 0.1, 1,{1,30}) 							--commun
treasurer.register_treasure("homedecor:torch_wall", 0.05, 3, {1,10}) 					--commun
treasurer.register_treasure("chains:chandelier", 0.025, 3, 1)							--commun
treasurer.register_treasure("homedecor:standing_lamp_off", 0.01, 4, {1,2}) 				--commun
treasurer.register_treasure("homedecor:table_lamp_off", 0.01, 4, {1,2}) 				--commun
treasurer.register_treasure("homedecor:glowlight_half_white", 0.01, 4, {1,2}) 			--commun
treasurer.register_treasure("homedecor:glowlight_half_yellow", 0.01, 4, {1,2}) 			--commun
treasurer.register_treasure("homedecor:glowlight_quarter_white", 0.01, 4, {1,2}) 		--commun
treasurer.register_treasure("homedecor:glowlight_quarter_yellow", 0.01, 4, {1,2}) 		--commun
treasurer.register_treasure("homedecor:glowlight_small_cube_white", 0.01, 4, {1,2}) 	--commun
treasurer.register_treasure("homedecor:glowlight_small_cube_yellow", 0.01, 4, {1,2}) 	--commun
treasurer.register_treasure("homedecor:lattice_lantern_large", 0.02, 3, {1,3}) 			--commun
treasurer.register_treasure("homedecor:lattice_lantern_small", 0.02, 3, {1,3}) 			--commun
treasurer.register_treasure("homedecor:hanging_lantern", 0.02, 3, {1,3})	 			--commun
treasurer.register_treasure("homedecor:ground_lantern", 0.02, 3, {1,3}) 				--commun
treasurer.register_treasure("homedecor:celling_lantern", 0.02, 3, {1,3}) 				--commun
treasurer.register_treasure("homedecor:oil_lamp", 0.02, 3, {1,2}) 						--commun
treasurer.register_treasure("homedecor:candle_thin", 0.02, 3, {1,10}) 					--commun
treasurer.register_treasure("homedecor:candle", 0.02, 3, {1,10}) 						--commun
treasurer.register_treasure("lantern:candle", 0.02, 3, {1,10}) 							--commun
treasurer.register_treasure("lavalamp:red", 0.02, 5, 1)									--commun
treasurer.register_treasure("lavalamp:orange", 0.02, 5, 1)								--commun
treasurer.register_treasure("lavalamp:green", 0.02, 5, 1) 								--commun
treasurer.register_treasure("lavalamp:blue", 0.02, 5, 1) 								--commun
treasurer.register_treasure("lavalamp:violet", 0.02, 5, 1) 								--commun
treasurer.register_treasure("lavalamp:yellow", 0.02, 5, 1) 								--commun
treasurer.register_treasure("christmas_craft:christmas_lights", 0.02, 2, {1,15}) 		--commun

building_block:
-- A block for buildings. Includes stairs, slabs, fences and similar things.
-- Excludes all natural blocks.
-- Preciousness should be roughly based on the “cost” to craft the block.

treasurer.register_treasure("nether:white", 0.0025, 10, 1) 								--rare --siwtonic
treasurer.register_treasure("default:diamondblock", 0.0025, 9, 1) 						--rare
treasurer.register_treasure("default:mese", 0.0025, 9, 1) 								--rare
treasurer.register_treasure("default:goldblock", 0.005, 8, 1) 							--rare
treasurer.register_treasure("default:silverblock", 0.005, 8, 1) 						--rare
treasurer.register_treasure("default:bronzeblock", 0.005, 8, {1,2}) 					--rare
treasurer.register_treasure("default:copperblock", 0.005, 8, {1,2}) 					--rare
treasurer.register_treasure("default:steelblock", 0.005, 8, {1,2}) 						--rare
treasurer.register_treasure("default:tinblock", 0.005, 8, {1,2}) 						--rare
treasurer.register_treasure("building_blocks:grate", 0.005, 7, {5,10}) 					--uncommon
treasurer.register_treasure("moreblocks:iron_stone_bricks", 0.005, 7, {5,10}) 			--uncommon
treasurer.register_treasure("default:coalblock", 0.01, 7, {1,5}) 						--uncommon
treasurer.register_treasure("moreblocks:coal_stone_bricks", 0.005, 4, {10,20}) 			--uncommon
treasurer.register_treasure("moreblocks:all_faces_jungle_tree", 0.005, 6, {10,20}) 		--uncommon
treasurer.register_treasure("moreblocks:all_faces_tree", 0.005, 6, {10,20}) 			--uncommon
treasurer.register_treasure("building_blocks:marble", 0.01, 6, {10,20}) 				--uncommon
treasurer.register_treasure("building_blocks:hardwood", 0.005, 5, {10,20}) 				--uncommon
treasurer.register_treasure("darkage:ors_brick", 0.005, 6, {10,20}) 					--uncommon
treasurer.register_treasure("darkage:marble", 0.005, 6, {10,20}) 						--uncommon
treasurer.register_treasure("darkage:gneiss_cobble", 0.005, 6, {10,20}) 				--uncommon
treasurer.register_treasure("darkage:gneiss_brick", 0.005, 6, {10,20}) 					--uncommon
treasurer.register_treasure("darkage:gneiss", 0.005, 6, {10,20}) 						--uncommon
treasurer.register_treasure("darkage:basalt_cobble", 0.005, 5, {10,20}) 				--uncommon
treasurer.register_treasure("colouredstonebricks:grey", 0.01, 5, {5,20}) 				--commun
treasurer.register_treasure("colouredstonebricks:red", 0.01, 5, {5,20}) 				--commun
treasurer.register_treasure("colouredstonebricks:dark_blue", 0.01, 5, {5,20}) 			--commun
treasurer.register_treasure("colouredstonebricks:pink", 0.01, 5, {5,20}) 				--commun
treasurer.register_treasure("colouredstonebricks:orange", 0.01, 5, {5,20}) 				--commun
treasurer.register_treasure("colouredstonebricks:black", 0.01, 5, {5,20}) 				--commun
treasurer.register_treasure("moreblocks:grey_brick", 0.01, 5, {10,20}) 					--commun
treasurer.register_treasure("moreblocks:cactus_brick", 0.005, 4, {4,20}) 				--commun
treasurer.register_treasure("default:brick", 0.005, 4, {4,20}) 							--commun
treasurer.register_treasure("moreblocks:stone_tile", 0.005, 4, {10,20}) 				--commun
treasurer.register_treasure("building_blocks:tar", 0.005, 3, {5,20}) 					--commun
treasurer.register_treasure("christmas_craft:snowman", 0.005, 3, 1) 					--commun
treasurer.register_treasure("default:snowblock", 0.005, 2, {1,3}) 						--commun
treasurer.register_treasure("default:mossycobble", 0.005, 2, {10,50}) 					--commun
treasurer.register_treasure("default:sandstonebrick", 0.025, 1, {50,99}) 				--commun
treasurer.register_treasure("default:cobble", 0.05, 1, {50,99}) 						--commun
treasurer.register_treasure("default:desert_sand", 0.05, 1, {50,99}) 					--commun
treasurer.register_treasure("default:sand", 0.05, 1, {50,99}) 							--commun
treasurer.register_treasure("default:dirt", 0.05, 1, {50,99}) 							--commun

seed:
-- Seeds and saplings.
-- Preciousness is based on the percieved “usefulness” of what can grow from the seed.
treasurer.register_treasure("farming_seed_wheat", 0.5, 1, {1,30})						--commun
treasurer.register_treasure("farming:seed_cotton", 0.5, 1, {1,30})						--commun

transport_vehicle
-- A vehicle to transport players and stuff, i.e. a cart or a boat.
-- Preciousness is hard to determine, maybe speed?
treasurer.register_treasure("carts:cart", 0.5, 3, {1,2})								--uncommun
treasurer.register_treasure("boats:boat", 0.5, 2, {1,2})								--commun

transport_structure
-- A fixed structure which is neccessary for a transport vehicle to operate, i.e. rails.
-- Preciousness is hard to dertermine …
treasurer.register_treasure("carts:rail_power", 0.15, 6, {3,6})							--uncommon
treasurer.register_treasure("carts:rail_brake", 0.15, 5, {2,4})							--uncommon
treasurer.register_treasure("homedecor:fence_brass", 0.1, 3, {4,8})						--commun
treasurer.register_treasure("homedecor:fence_wrought_iron", 0.1, 3, {4,8})				--commun
treasurer.register_treasure("carts:rail_copper", 0.25, 3, {10,20})						--commun
treasurer.register_treasure("default:rail", 0.25, 2, {10,20})							--commun

ladder
-- A ladder.
-- treasurer.register_treasure("lavatemple:ladder", 0.25, 1, {3,6})						--uncommun --Désactivé pour l'instant car n'a pas de recette de craft, et on ne sait pas s'il est diggable
treasurer.register_treasure("default:ladder", 0.5, 1, {8,24})							--commun


default:
-- This is the group your treasure get assigned to if you don’t specify a group.
