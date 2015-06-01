--[[
	This is an example Treasure Registration Mod (TRM) for the default mod.
	It is meant to use together with the default mod and the treasurer mod.

	This TRM registers a bunch of items found in the default mod.

	Note that the probabilities may not be very well balanced,
	this file is just there as an example. It, however, can
	still be used in actual gameplay.

	A TRM is really nothing more than a list of item names, probabilities,
	preciousnesses, and optionally a given amount and tool wear.
	The only function ever called is treasurer.register_treasure.
	See also treasurer’s documentation for more info.
]]

--[[ The following entries all use a rarity value and a count value in range
     format.
     Note that the range format is a table with two value, the first being
     the minimum and the second being the maximum value.
]]
--[[ The next entry means: this treasure consists of 1 to 10 gold ingots and has
a rarity of 0.01 and a preciousness of 7 (out of 10) ]]
treasurer.register_treasure("default:gold_ingot",0.01,7,{1,10})
-- The following entries are similar
treasurer.register_treasure("default:bronze_ingot",0.02,5,{1,16})
treasurer.register_treasure("default:copper_ingot",0.06,3,{1,17})
treasurer.register_treasure("default:steel_ingot",0.09,4,{1,20})
treasurer.register_treasure("default:clay_brick",0.1,5,{2,12})
treasurer.register_treasure("default:coal_lump",0.2,2,{3,10})
treasurer.register_treasure("default:obsidian_shard",0.05,5,{3,20})
treasurer.register_treasure("default:obsidian_shard",0.0005,5,{21,90})
treasurer.register_treasure("default:mese_crystal",0.008,9,{1,5})
treasurer.register_treasure("default:diamond",0.001,9,{1,3})

--[[ here is a constant (=non-random) count given
 with a rarity of 0.0001, exactly 4 diamonds spawn]]
treasurer.register_treasure("default:diamond",0.0001,9,4)

-- an example of a treasure with preciousness of 10
treasurer.register_treasure("default:diamond_block",0.00002,10,1)

-- by the way, as you see, it is not forbidden to register the same item twice.

treasurer.register_treasure("default:paper",0.1,2,{3,6})
treasurer.register_treasure("default:stick",0.1,2,{1,15})
treasurer.register_treasure("default:stick",0.05,2,{16,33})
treasurer.register_treasure("default:book",0.1,4,{1,2})

treasurer.register_treasure("default:mese_crystal_fragment",0.01,3,{1,9})
treasurer.register_treasure("default:sapling",0.05,2,{1,20})
treasurer.register_treasure("default:junglesapling",0.03,3,{1,5})
treasurer.register_treasure("default:apple",0.2,2,{1,7})

treasurer.register_treasure("default:shovel_wood",0.02,2)
treasurer.register_treasure("default:shovel_stone",0.050,3)
treasurer.register_treasure("default:shovel_steel",0.07,5)
treasurer.register_treasure("default:shovel_bronze",0.006,6)
treasurer.register_treasure("default:shovel_mese",0.0012,8)
treasurer.register_treasure("default:shovel_diamond",0.0008,9)

treasurer.register_treasure("default:axe_wood",0.02,2)
treasurer.register_treasure("default:axe_stone",0.045,3)
treasurer.register_treasure("default:axe_steel",0.05,5)
treasurer.register_treasure("default:axe_bronze",0.005,6)
treasurer.register_treasure("default:axe_mese",0.0002,8)
treasurer.register_treasure("default:axe_diamond",0.000125,9)

--[[ Here are some examples for wear. wear is the 5th parameter
the format of wear is identical to the format of count
note that the 3rd parameter (count) is nil which causes the script to use the default value
We could as well have written an 1 here.
]]
treasurer.register_treasure("default:axe_wood",0.04,1,nil,{100,10000})	-- wear = randomly between 100 and 10000
treasurer.register_treasure("default:axe_stone",0.09,2,nil,{500,11000})
treasurer.register_treasure("default:axe_steel",0.1,4,nil,{600,18643})
treasurer.register_treasure("default:axe_bronze",0.01,5,nil,{750,20000})
treasurer.register_treasure("default:axe_mese",0.0002,7,nil,{1000,22000})
treasurer.register_treasure("default:axe_diamond",0.0001,8,nil,{2000,30000})

treasurer.register_treasure("default:pick_wood",0.005,2)
treasurer.register_treasure("default:pick_stone",0.018,3)
treasurer.register_treasure("default:pick_steel",0.02,5)
treasurer.register_treasure("default:pick_bronze",0.004,6)
treasurer.register_treasure("default:pick_mese",0.008,8)
treasurer.register_treasure("default:pick_diamond",0.005,9)

treasurer.register_treasure("default:sword_wood",0.001,2)
treasurer.register_treasure("default:sword_stone",0.016,3)
treasurer.register_treasure("default:sword_steel",0.02,5)
treasurer.register_treasure("default:sword_bronze",0.015,6)
treasurer.register_treasure("default:sword_mese",0.007,8)
treasurer.register_treasure("default:sword_diamond",0.0035,9)

treasurer.register_treasure("default:rail",0.01,5,15)
treasurer.register_treasure("default:rail",0.02,5,{1,5})
treasurer.register_treasure("default:fence_wood",0.1,4,{1,7})

-- If the count is omitted, it deaults to 1.
treasurer.register_treasure("default:sign_wall",0.1,4)
treasurer.register_treasure("default:ladder",0.1,3,{1,2})
treasurer.register_treasure("default:torch",0.2,2,{1,5})
