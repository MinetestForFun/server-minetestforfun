local path = minetest.get_modpath("mobs")

-- Mob Api
dofile(path.."/api.lua")

-- Animals
dofile(path.."/chicken.lua") -- JKmurray
dofile(path.."/cow.lua") -- KrupnoPavel
dofile(path.."/sheep.lua") -- PilzAdam
dofile(path.."/pig.lua") -- farfadet46
dofile(path.."/bee.lua") -- KrupnoPavel
dofile(path.."/bunny.lua") -- ExeterDad
dofile(path.."/kitten.lua") -- Jordach/BFD
dofile(path.."/goat.lua") -- ???
dofile(path.."/shark.lua") -- blert2112 (animal_modpack)

-- Monsters
dofile(path.."/dirtmonster.lua") -- PilzAdam
dofile(path.."/dungeonmaster.lua") -- PilzAdam
dofile(path.."/oerkki.lua") -- PilzAdam
dofile(path.."/sandmonster.lua") -- PilzAdam
dofile(path.."/stonemonster.lua") -- PilzAdam
dofile(path.."/treemonster.lua") -- PilzAdam
dofile(path.."/wolf.lua") -- PilzAdam
dofile(path.."/dog.lua") -- CProgrammerRU
dofile(path.."/mese_monster.lua") -- Zeg9
dofile(path.."/spider.lua") -- AspireMint
dofile(path.."/greenslimes.lua") -- davedevils/TomasJLuis/TenPlus1
dofile(path.."/lavaslimes.lua") -- davedevils/TomasJLuis/TenPlus1
dofile(path.."/zombie.lua") -- ???
dofile(path.."/yeti.lua") -- ???
dofile(path.."/minotaur.lua") -- Kalabasa

-- The bosses
dofile(path.."/pumpkins.lua")
--dofile(path.."/mese_dragon.lua") NOT YET DONE

-- begin slimes mobs compatibility changes
-- cannot find mesecons?, craft glue instead
if not minetest.get_modpath("mesecons_materials") then
	minetest.register_craftitem(":mesecons_materials:glue", {
		image = "mesecons_glue.png",
		description = "Glue",
	})
end

if minetest.setting_get("log_mods") then minetest.log("action", "Slimes loaded") end
-- end slimes mobs compatibility changes

-- NPC
dofile(path.."/npc.lua") -- TenPlus1
dofile(path.."/npc_female.lua") -- nuttmeg20

-- Creeper (fast impl by davedevils)
dofile(path.."/creeper.lua")

-- Mob Items
dofile(path.."/crafts.lua")

-- Spawner
dofile(path.."/spawner.lua")

-- Mob menu spawner special MFF
dofile(path.."/mff_menu.lua")

minetest.register_alias("mobs:rat","mobs:chicken") -- aliases removed rat
minetest.register_alias("mobs:rat_cooked", "mobs:chicken_cooked")


local function remove_old(name)
	minetest.register_entity(name, {
		name = name,
		on_activate = function(self, staticdata, dtime_s)
			self.object:remove()
			return
		end,
	})
end

remove_old("mobs:pumba")
remove_old("mobs:rat")


minetest.log("action", "[MOD] Mobs Redo loaded")
