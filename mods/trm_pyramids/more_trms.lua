-- Fuel group --
treasurer.register_treasure("bucket:bucket_lava",0.008,3,1)
treasurer.register_treasure("default:coalblock",0.008,2,{1,2})
treasurer.register_treasure("default:wood",0.075,2,{1,15})
treasurer.register_treasure("default:tree",0.07,2,{1,5})
treasurer.register_treasure("default:cactus",0.06,{1,7})
treasurer.register_treasure("homedecor:oil_extract",0.02,2,{1,20})
treasurer.register_treasure("default:grass_1",0.09,2,{1,30})
treasurer.register_treasure("default:leaves",0.099,2,{1,20})
treasurer.register_treasure("default:junglegrass",0.085,2,{1,20})
treasurer.register_treasure("default:dry_shrub",0.085,2,{1,10})

-- Food group --
treasurer.register_treasure("food:bowl",0.07,2,1)
treasurer.register_treasure("food:milk",0.075,2,1)
treasurer.register_treasure("bushes:mixed_berry_pie_raw",0.06,2,{1,3})
treasurer.register_treasure("bushes:blackberry_pie_raw",0.064,2,{1,4})
treasurer.register_treasure("bushes:blueberry_pie_raw", 0.064,2,{1,4})
treasurer.register_treasure("bushes:strawberry_pie_raw", 0.064,2,{1,4})
treasurer.register_treasure("bushes:raspberry_pie_raw", 0.064,2,{1,4})
treasurer.register_treasure("farming:bread", 0.07,2,{1,2})
treasurer.register_treasure("farming:flour", 0.075,2,{1,3})
treasurer.register_treasure("farming:carrot", 0.071,2,{1,4})
treasurer.register_treasure("farming:donut", 0.068,2,{1,3})
treasurer.register_treasure("farming:melon_slice", 0.074,2,{1,6})
treasurer.register_treasure("farming:tomato", 0.075,2,{1,6})
treasurer.register_treasure("fishing:fish_raw", 0.063,2,{1,2})
treasurer.register_treasure("maptools:superapple", 0.002,2,1})
treasurer.register_treasure("mobs:chicken_raw", 0.060,2,{1,4})
treasurer.register_treasure("mobs:meat_raw", 0.065,2,{1,4})
treasurer.register_treasure("moretrees:coconut", 0.055,2,{1,2})
treasurer.register_treasure("mushroom:poison", 0.059,2,{1,5})
treasurer.register_treasure("farming:blueberries", 0.05,2,{1,10})

-- Melee weapons --
treasurer.register_treasure("building_blocks:knife", 0.045,2,1})
treasurer.register_treasure("moreores:sword_silver", 0.0002,2,1})
treasurer.register_treasure("nether:sword_sywtonic", 0.0001,2,1})
treasurer.register_treasure("nether:sword_netherrack_blue", 0.001,2,1})
treasurer.register_treasure("nether:sword_netherrack", 0.001,2,1})
treasurer.register_treasure("default:sword_nyan", 0.0000121,1})


-- Tools --
treasurer.register_treasure("default:axe_nyan", 0.0000121,1,1})
treasurer.register_treasure("default:shovel_nyan", 0.000121,1,1})
treasurer.register_treasure("default:pick_nyan", 0.000121,1,1}
treasurer.register_treasure("default:hoe_wood", 0.02,1, 1})
treasurer.register_treasure("default:hoe_stone", 0.004,1,1})
treasurer.register_treasure("default:hoe_steel", 0.002,1,1})
treasurer.register_treasure("default:hoe_bronze", 0.0008,1,1})
treasurer.register_treasure("default:hoe_mese", 0.0002,1, 1})
treasurer.register_treasure("default:hoe_diamond", 0.000121,1,1})
treasurer.register_treasure("fishing:pole", 0.05,1, 1})
treasurer.register_treasure("markers:mark", 0.034,1, 1})
treasurer.register_treasure("moreores:axe_silver", 0.0001,1, 1})
treasurer.register_treasure("moreores:hoe_silver", 0.00013,1, 1})
treasurer.register_treasure("moreores:pick_silver", 0.00009,1, 1})
treasurer.register_treasure("moreores:shovel_silver", 0.00014,1, 1})
treasurer.register_treasure("screwdriver:screwdriver", 0.001,1, 1})
treasurer.register_treasure("moreblocks:circular_saw", 0.002,1, 1})

-- Deco group --
treasurer.register_treasure("bobblocks:redblock", 0.02,1, {1,5})
treasurer.register_treasure("bobblocks:greypole", 0.02,1, {1,5})
treasurer.register_treasure("coloredwood:fence_light_sky_blue", 0.025,1, {1,6})
treasurer.register_treasure("coloredwood:fence_dark_redviolet", 0.025,1, {1,6})
treasurer.register_treasure("coloredwood:stick_dark_cyan", 0.02,1, {1,4})
treasurer.register_treasure("coloredwood:fence_yellow", 0.025,1, {1,6})
treasurer.register_treasure("colouredstonebricks:brown", 0.03,1, {1,10})
treasurer.register_treasure("colouredstonebricks:yellow", 0.03,1, {1,10})
treasurer.register_treasure("darkage:chain", 0.025,1, {1,10})
treasurer.register_treasure("columnia:column_mid_brick", 0.025,1, {1,7})
treasurer.register_treasure("darkage:wood_shelves", 0.02,1, {1,2})
treasurer.register_treasure("default:fence_cobble", 0.03,1, {1,20})
treasurer.register_treasure("dryplants:grass", 0.04,1, {1,8})
treasurer.register_treasure("fake_fire:embers", 0.015,1, {1,3})
treasurer.register_treasure("fence:fencegate", 0.02,1, {1,2})
treasurer.register_treasure("flowers:potted_tulip", 0.02,1, {1,4})
treasurer.register_treasure("itemframes:pedestal_junglewood", 0.012,1, {1,3})
treasurer.register_treasure("lantern:candle", 0.03,1, {1,15})
treasurer.register_treasure("lavatemple:ladder", 0.018,1, {1,8})
treasurer.register_treasure("moreblocks:plankstone", 0.025,1, {1,6})
treasurer.register_treasure("moreblocks:iron_check", 0.02,1, {1,3})
treasurer.register_treasure("stained_glass:2_9", 0.02,1, {1,4})
treasurer.register_treasure("stained_glass:7_5_6", 0.02,1, {1,4})

light:
-- Is a light source.
-- Preciousness is based on the brightness. For the maximum brightness (before sun brightness), preciousness should be 3.

"moreblocks:super_glow_glass" 				--rare
"moreblocks:glow_glass" 					--rare
"glow:lamp" 								--uncommun
"glow:stone" 								--uncommun
"bobblocks:blueblock" 						--uncommun
"bobblocks:bluepole" 						--uncommun
"bobblocks:greenblock" 						--uncommun
"bobblocks:greenpole" 						--uncommun
"bobblocks:greyblock" 						--uncommun
"bobblocks:greypole" 						--uncommun
"bobblocks:indigoblock" 					--uncommun
"bobblocks:indigopole" 						--uncommun
"bobblocks:orangeblock" 					--uncommun
"bobblocks:orangepole" 						--uncommun
"bobblocks:redblock" 						--uncommun
"bobblocks:redpole" 						--uncommun
"bobblocks:whiteblock" 						--uncommun
"bobblocks:whitepole" 						--uncommun
"bobblocks:yellowblock" 					--uncommun
"bobblocks:yellowpole" 						--uncommun
"building_blocks:fireplace" 				--uncommun
"sealamps:lantern" 							--uncommun
"sealamps:torch" 							--uncommun
"default:torch" 							--commun
"homedecor:torch_wall" 						--commun
"chains:chandelier" 						--commun
"homedecor:standing_lamp_off" 				--commun
"homedecor:table_lamp_off" 					--commun
"homedecor:glowlight_half_white" 			--commun
"homedecor:glowlight_half_yellow" 			--commun
"homedecor:glowlight_quarter_white" 		--commun
"homedecor:glowlight_quarter_yellow" 		--commun
"homedecor:glowlight_small_cube_white" 		--commun
"homedecor:glowlight_small_cube_yellow" 	--commun
"homedecor:lattice_lantern_large" 			--commun
"homedecor:lattice_lantern_small" 			--commun
"homedecor:hanging_lantern" 				--commun
"homedecor:ground_lantern" 					--commun
"homedecor:celling_lantern" 				--commun
"homedecor:oil_lamp" 						--commun
"homedecor:candle_thin" 					--commun
"homedecor:candle" 							--commun
"lantern:candle" 							--commun
"lavalamp:red" 								--commun
"lavalamp:orange" 							--commun
"lavalamp:green" 							--commun
"lavalamp:blue" 							--commun
"lavalamp:violet" 							--commun
"lavalamp:yellow" 							--commun
"christmas_craft:christmas_lights" 			--commun

building_block:
-- A block for buildings. Includes stairs, slabs, fences and similar things.
-- Excludes all natural blocks.
-- Preciousness should be roughly based on the “cost” to craft the block.

"nether:white" 								--siwtonic
"default:diamondblock" 						--rare
"default:mese" 								--rare
"default:goldblock" 						--rare
"default:silverblock" 						--rare
"default:bronzeblock" 						--rare
"default:copperblock" 						--rare
"default:steelblock" 						--rare
"default:tinblock" 							--rare
"building_blocks:grate" 					--uncommon
"moreblocks:iron_stone_bricks" 				--uncommon
"default:coalblock" 						--uncommon
"moreblocks:coal_stone_bricks" 				--uncommon
"moreblocks:all_faces_jungle_tree" 			--uncommon
"moreblocks:all_faces_tree" 				--uncommon
"building_blocks:marble" 					--uncommon
"building_blocks:hardwood" 					--uncommon
"darkage:ors_brick" 						--uncommon
"darkage:marble" 							--uncommon
"darkage:gneiss_cobble" 					--uncommon
"darkage:gneiss_brick" 						--uncommon
"darkage:gneiss" 							--uncommon
"darkage:basalt_cobble" 					--uncommon
"colouredstonebricks:grey" 					--commun
"colouredstonebricks:red" 					--commun
"colouredstonebricks:dark_blue" 			--commun
"colouredstonebricks:pink" 					--commun
"colouredstonebricks:orange" 				--commun
"colouredstonebricks:black" 				--commun
"moreblocks:grey_brick" 					--commun
"moreblocks:cactus_brick" 					--commun
"default:brick" 							--commun
"moreblocks:stone_tile" 					--commun
"building_blocks:tar" 						--commun
"christmas_craft:snowman" 					--commun
"default:snowblock" 						--commun
"default:mossycobble" 						--commun
"default:cobble" 							--commun
"default:sandstonebrick" 					--commun
"default:desert_sand" 						--commun
"default:sand" 								--commun
"default:dirt" 								--commun

seed:
-- Seeds and saplings.
-- Preciousness is based on the percieved “usefulness” of what can grow from the seed.
"farming_seed_wheat"						--commun
"farming:seed_cotton"						--commun

transport_vehicle
-- A vehicle to transport players and stuff, i.e. a cart or a boat.
-- Preciousness is hard to determine, maybe speed?
"carts:cart"								--uncommun
"boats:boat"								--commun

transport_structure
-- A fixed structure which is neccessary for a transport vehicle to operate, i.e. rails.
-- Preciousness is hard to dertermine …
"carts:rail_power"							--uncommon
"carts:rail_brake"							--uncommon
"homedecor:fence_brass"						--commun
"homedecor:fence_wrought_iron"				--commun
"carts:rail_copper"							--commun
"default:rail"								--commun

ladder
-- A ladder.
"default:ladder"							--commun

default:
-- This is the group your treasure get assigned to if you don’t specify a group.

