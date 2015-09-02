--[[
	This is the config mod for the hungry_games game.
	You should edit this BEFORE generation of hungry_games worlds.
	Feilds Marked with [SAFE] are safe to edit if you already have worlds generated.
]]--

--load ranked
ranked = {}
dofile(minetest.get_modpath("hungry_games").."/ranked.lua")
dofile(minetest.get_modpath("hungry_games").."/engine.lua")
dofile(minetest.get_modpath("hungry_games").."/random_chests.lua")
dofile(minetest.get_modpath("hungry_games").."/spawning.lua")

-----------------------------------
--------Arena configuration--------

--Set size of the arena.
glass_arena.set_size(400)

--Set texture of the arena. [SAFE]
glass_arena.set_texture("default_glass.png")

--Set which blocks to replace with wall (remove table brackets "{}" for all blocks).
glass_arena.replace({
	"air",
	"ignore",
	"default:water_source",
	"default:water_flowing",
	"default:lava_source",
	"default:lava_flowing",
	"default:cactus",
	"default:leaves",
	"default:tree",
	"snow:snow",
	"default:snow"
})

-----------------------------------
-----Main Engine Configuration (engine.lua)----
hungry_games = {}

--Set countdown (in seconds) till players can leave their spawns.
hungry_games.countdown = 10

--Set grace period length in seconds (or 0 for no grace period)
hungry_games.grace_period = 75

--Set what happens when a player dies during a match.
--Possible values are: "spectate" or "lobby"
hungry_games.death_mode = "lobby"

--Set the interval at which chests are refilled during each match (seconds), set to -1 to only fill chests once at the beginning of the match
hungry_games.chest_refill_interval = 240

--Percentage of players that must have voted (/vote) for the match to start (0 is 0%, 0.5 is 50%, 1 is 100%) must be <1 and >0
hungry_games.vote_percent = 0.5

--If the number of connected players is less than or equal to this, the vote to start must be unaimous
hungry_games.vote_unanimous = 5

--If the number of votes is greater than or equal to 1, a timer will start that will automatically initiate the match in this many seconds (nil to disable)
hungry_games.vote_countdown = 120

--Specifies whether or not players are allowed to dig or not
hungry_games.allow_dig = false

-----------------------------------
--------Spawning Configuration (spawning.lua)--------

--Set spawn points. [SAFE]
--NOTE: is overiden by hg_admin commands and save file.
spawning.register_spawn("spawn",{
	mode = "static",
	pos = {x=0,y=0,z=0},
})
spawning.register_spawn("lobby",{
	mode = "static",
	pos = {x=0,y=0,z=0},
})

-----------------------------------
--------Random Chests Configuration (random_chests.lua)--------

--Enable chests to spawn in the world when generated.
--Pass false if you want to hide your own chests in the world in creative.
random_chests.enable()

--Set the boundary where chests are spawned
--Should be set to the same or smaller then the arena.
--Defaults to whole map.
random_chests.set_boundary(400)

--Set Chest Rarity.
--Rarity is how many chests per chunk.
random_chests.set_rarity(4)

--Set speed at which chests are refilled (chests per second)
random_chests.setrefillspeed(20)

--Register a new item that can be spawned in random chests. [SAFE]
--eg chest_item('default:torch', 4, 6) #has a 1 in 4 chance of spawning up to 6 torches.
--the last item is a group number/word which means if an item of that group number has already
--been spawned then don't add any more of those group types to the chest.
--items
local chest_item = random_chests.register_item
chest_item('default:apple', 4, 5)
chest_item('food:bread', 3, 1)
chest_item('food:bun', 5, 1)
chest_item('food:bread', 10, 1)

--Thirsty
chest_item('food:apple_juice', 6, 2)
chest_item('food:cactus_juice', 8, 2, "odd")
--Other
chest_item('survival_thirst:water_glass', 4, 2)

--Swords--
chest_item('default:sword_wood', 5, 1, "sword")
chest_item('default:sword_stone', 8, 1, "sword")
chest_item('default:sword_steel', 11, 1, "sword")
chest_item('default:sword_bronze', 14, 1, "sword")
chest_item('default:sword_mese', 17, 1, "sword")
chest_item('default:sword_diamond', 20, 1, "sword")

--Throwing--
--Bows
chest_item('throwing:bow_wood', 5, 1, "bow")
chest_item('throwing:bow_stone', 10, 1, "bow")
chest_item('throwing:bow_steel', 15, 1, "bow")
--Arrows
chest_item('throwing:arrow', 4, 15)
chest_item('throwing:arrow_fire', 12, 8)

--Armors--
--Helmet
chest_item('3d_armor:helmet_wood', 10, 1, "helmet")
chest_item('3d_armor:helmet_steel', 30, 1, "helmet")
chest_item('3d_armor:helmet_bronze', 20, 1, "helmet")
chest_item('3d_armor:helmet_diamond', 50, 1, "helmet")
chest_item('3d_armor:helmet_mithril', 40, 1, "helmet")
--Chestplate
chest_item('3d_armor:chestplate_wood', 10, 1, "chestplate")
chest_item('3d_armor:chestplate_steel', 30, 1, "chestplate")
chest_item('3d_armor:chestplate_bronze', 20, 1, "chestplate")
chest_item('3d_armor:chestplate_mithril', 40, 1, "chestplate")
chest_item('3d_armor:chestplate_diamond', 50, 1, "chestplate")
--Leggings
chest_item('3d_armor:leggings_wood', 10, 1, "leggings")
chest_item('3d_armor:leggings_steel', 30, 1, "leggings")
chest_item('3d_armor:leggings_bronze', 20, 1, "leggings")
chest_item('3d_armor:leggings_mithril', 40, 1, "leggings")
chest_item('3d_armor:leggings_diamond', 50, 1, "leggings")
--Boots
chest_item('3d_armor:boots_wood', 10, 1, "boots")
chest_item('3d_armor:boots_steel', 30, 1, "boots")
chest_item('3d_armor:boots_bronze', 20, 1, "boots")
chest_item('3d_armor:boots_mithril', 40, 1, "boots")
chest_item('3d_armor:boots_diamond', 50, 1, "boots")
--Shields
chest_item('shields:shield_wood', 10, 1, "shield")
chest_item('shields:shield_steel', 30, 1, "shield")
chest_item('shields:shield_bronze', 20, 1, "shield")
chest_item('shields:shield_diamond', 50, 1, "shield")
chest_item('shields:shield_mithril', 40, 1, "shield")

--Crafting items
chest_item('default:stick', 8, 10)
chest_item('default:steel_ingot', 15, 3)
chest_item('throwing:string', 7, 3)
chest_item('hungry_games:stones', 6, 3)
chest_item('hungry_games:planks', 5, 3)

--END OF CONFIG OPTIONS
if hungry_games.dig_mode ~= "normal" then
	dofile(minetest.get_modpath("hungry_games").."/weapons.lua")
end
