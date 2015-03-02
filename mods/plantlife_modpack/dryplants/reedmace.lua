-----------------------------------------------------------------------------------------------
-- Grasses - Reedmace 0.1.1
-----------------------------------------------------------------------------------------------
-- by Mossmanikin
-- textures & ideas partly by Neuromancer

-- License (everything): 	WTFPL
-- Contains code from: 		plants_lib
-- Looked at code from:		default, trees				
-----------------------------------------------------------------------------------------------

-- NOTES (from wikipedia, some of this might get implemented)
-- rhizomes are edible
-- outer portion of young plants can be peeled and the heart can be eaten raw or boiled and eaten like asparagus
-- leaf bases can be eaten raw or cooked
-- sheath can be removed from the developing green flower spike, which can then be boiled and eaten like corn on the cob
-- pollen can be collected and used as a flour supplement or thickener
-- Typha stems and leaves can be used to make paper
-- The seed hairs were used by some Native American groups as tinder for starting fires

-----------------------------------------------------------------------------------------------
-- REEDMACE SHAPES
-----------------------------------------------------------------------------------------------

abstract_dryplants.grow_reedmace = function(pos)
	local size = math.random(1,3)
	local spikes = math.random(1,3)
	local pos_01 = {x = pos.x, y = pos.y + 1, z = pos.z}
	local pos_02 = {x = pos.x, y = pos.y + 2, z = pos.z}
	local pos_03 = {x = pos.x, y = pos.y + 3, z = pos.z}
	if minetest.get_node(pos_01).name == "air"  -- bug fix
	or minetest.get_node(pos_01).name == "dryplants:reedmace_sapling" then
		if minetest.get_node(pos_02).name ~= "air" then
			minetest.set_node(pos_01, {name="dryplants:reedmace_top"})
		elseif minetest.get_node(pos_03).name ~= "air" then
			minetest.set_node(pos_01, {name="dryplants:reedmace_height_2"})
		elseif size == 1 then
			minetest.set_node(pos_01, {name="dryplants:reedmace_top"})
		elseif size == 2 then
			minetest.set_node(pos_01, {name="dryplants:reedmace_height_2"})
		elseif size == 3 then
			if spikes == 1 then
				minetest.set_node(pos_01, {name="dryplants:reedmace_height_3_spikes"})
			else
				minetest.set_node(pos_01, {name="dryplants:reedmace_height_3"})
			end
		end
	end
end

abstract_dryplants.grow_reedmace_water = function(pos)
	local size = math.random(1,3)
	local spikes = math.random(1,3)
	local pos_01 = {x = pos.x, y = pos.y + 1, z = pos.z}
	local pos_02 = {x = pos.x, y = pos.y + 2, z = pos.z}
	local pos_03 = {x = pos.x, y = pos.y + 3, z = pos.z}
	local pos_04 = {x = pos.x, y = pos.y + 4, z = pos.z}
	minetest.add_entity(pos_01, "dryplants:reedmace_water_entity")
	if minetest.get_node(pos_02).name == "air" then -- bug fix
		if minetest.get_node(pos_03).name ~= "air" then
			minetest.set_node(pos_02, {name="dryplants:reedmace_top"})
		elseif minetest.get_node(pos_04).name ~= "air" then
			minetest.set_node(pos_02, {name="dryplants:reedmace_height_2"})
		elseif size == 1 then
			minetest.set_node(pos_02, {name="dryplants:reedmace_top"})
		elseif size == 2 then
			minetest.set_node(pos_02, {name="dryplants:reedmace_height_2"})
		elseif size == 3 then
			if spikes == 1 then
				minetest.set_node(pos_02, {name="dryplants:reedmace_height_3_spikes"})
			else
				minetest.set_node(pos_02, {name="dryplants:reedmace_height_3"})
			end	
		end
	end
end

-----------------------------------------------------------------------------------------------
-- REEDMACE SPIKES
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_spikes", {
	description = "Reedmace",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_spikes.png"},
	inventory_image = "dryplants_reedmace_spikes.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 1
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_top", {
	description = "Reedmace, height: 1",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_top.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 2
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_height_2", {
	description = "Reedmace, height: 2",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"dryplants_reedmace_height_2.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2--,
		--not_in_creative_inventory=1
	},
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 3
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_height_3", {
	description = "Reedmace, height: 3",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"dryplants_reedmace_height_3.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2--,
		--not_in_creative_inventory=1
	},
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE height: 3 & Spikes
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_height_3_spikes", {
	description = "Reedmace, height: 3 & Spikes",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"dryplants_reedmace_height_3_spikes.png"},
	inventory_image = "dryplants_reedmace_top.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2--,
		--not_in_creative_inventory=1
	},
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE STEMS
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace", {
	description = "Reedmace",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace.png"},
	inventory_image = "dryplants_reedmace.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "dryplants:reedmace_top"
		or node.name == "dryplants:reedmace_spikes" then 
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z}) 
            minetest.add_item(pos,"dryplants:reedmace_sapling")
        end
    end,
})
-----------------------------------------------------------------------------------------------
-- REEDMACE BOTTOM
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_bottom", {
	description = "Reedmace",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_bottom.png"},
	inventory_image = "dryplants_reedmace_bottom.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		not_in_creative_inventory=1
	},
	drop = 'dryplants:reedmace_sapling',
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "dryplants:reedmace" 
		or node.name == "dryplants:reedmace_top"
		or node.name == "dryplants:reedmace_spikes" then 
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z}) 
            minetest.add_item(pos,"dryplants:reedmace_sapling")
        end
    end,
})
-----------------------------------------------------------------------------------------------
-- REEDMACE "SAPLING" (the drop from the above)
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_sapling", {
	description = "Reedmace",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_sapling.png"},
	inventory_image = "dryplants_reedmace_sapling.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-- abm
minetest.register_abm({
	nodenames = "dryplants:reedmace_sapling",
	interval = REEDMACE_GROWING_TIME,
	chance = 100/REEDMACE_GROWING_CHANCE,
	action = function(pos, node, _, _)
		if string.find(minetest.get_node({x = pos.x + 1, y = pos.y, z = pos.z	 }).name, "default:water")
		or string.find(minetest.get_node({x = pos.x, 	 y = pos.y, z = pos.z + 1}).name, "default:water")
		or string.find(minetest.get_node({x = pos.x - 1, y = pos.y, z = pos.z	 }).name, "default:water")
		or string.find(minetest.get_node({x = pos.x, 	 y = pos.y, z = pos.z - 1}).name, "default:water") then
			if minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name == "air" then
				abstract_dryplants.grow_reedmace_water({x = pos.x, y = pos.y - 1, z = pos.z})
			end
			minetest.set_node({x=pos.x, y=pos.y, z=pos.z}, {name="default:water_source"})
		else
			abstract_dryplants.grow_reedmace({x = pos.x, y = pos.y - 1, z = pos.z})
		end
    end
})
-----------------------------------------------------------------------------------------------
-- REEDMACE WATER (for entity)
-----------------------------------------------------------------------------------------------
minetest.register_node("dryplants:reedmace_water", {
	description = "Reedmace",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"dryplants_reedmace_water.png"},
	inventory_image = "dryplants_reedmace_water.png",
	groups = {not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
})
-----------------------------------------------------------------------------------------------
-- REEDMACE WATER ENTITY
-----------------------------------------------------------------------------------------------
minetest.register_entity("dryplants:reedmace_water_entity",{
	visual = "mesh",
	mesh = "plantlike.obj",
	visual_size = {x=10, y=10},
	textures = {"dryplants_reedmace_water.png"},
	collisionbox = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	on_punch = function(self, puncher)
		if puncher:is_player() and puncher:get_inventory() then
			if not minetest.setting_getbool("creative_mode") then
				puncher:get_inventory():add_item("main", "dryplants:reedmace_sapling")
			end
			self.object:remove()
		end
	end,
})
-----------------------------------------------------------------------------------------------
-- SPAWN REEDMACE
-----------------------------------------------------------------------------------------------
--[[plantslib:spawn_on_surfaces({
	spawn_delay = 1200,
	spawn_plants = {"dryplants:reedmace_sapling"},
	spawn_chance = 400,
	spawn_surfaces = {
		"default:dirt_with_grass",
		"default:desert_sand",
		"default:sand",
		"dryplants:grass_short",
		"stoneage:grass_with_silex"
	},
	seed_diff = 329,
	near_nodes = {"default:water_source"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
})]]
-----------------------------------------------------------------------------------------------
-- GENERATE REEDMACE
-----------------------------------------------------------------------------------------------
-- near water or swamp
plantslib:register_generate_plant({
    surface = {
		"default:dirt_with_grass", 
		"default:desert_sand",
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = REEDMACE_NEAR_WATER_PER_MAPBLOCK,
    rarity = 101 - REEDMACE_NEAR_WATER_RARITY,
	--rarity = 60,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:water_source","sumpf:dirtywater_source","sumpf:sumpf"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace
)
-- in water
plantslib:register_generate_plant({
    surface = {
		"default:dirt",
		"default:dirt_with_grass", 
		--"default:desert_sand",
		--"stoneage:grass_with_silex",
		"stoneage:sand_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = REEDMACE_IN_WATER_PER_MAPBLOCK,
	rarity = 101 - REEDMACE_IN_WATER_RARITY,
    --rarity = 35,
    min_elevation = 0, -- a bit below sea level
	max_elevation = 0, -- ""
	near_nodes = {"default:water_source","sumpf:dirtywater_source"},
	near_nodes_size = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace_water
)
-- for oases & tropical beaches & tropical swamps
plantslib:register_generate_plant({
    surface = {
		"default:sand",
		"sumpf:sumpf"
	},
    max_count = REEDMACE_FOR_OASES_PER_MAPBLOCK,
    rarity = 101 - REEDMACE_FOR_OASES_RARITY,
	--rarity = 10,
    neighbors = {"default:water_source","sumpf:dirtywater_source","sumpf:sumpf"},
	ncount = 1,
    min_elevation = 1, -- above sea level
	near_nodes = {"default:desert_sand","sumpf:sumpf"},
	near_nodes_size = 2,
	near_nodes_vertical = 1,
	near_nodes_count = 1,
    plantlife_limit = -0.9,
  },
  abstract_dryplants.grow_reedmace
)
