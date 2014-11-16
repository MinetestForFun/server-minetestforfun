-- Blossom

local BLOSSOM_NODE = "nature:blossom"
local BLOSSOM_LEAVES = "default:leaves"
local BLOSSOM_TEXTURES = { "default_leaves.png^nature_blossom.png" }

if minetest.get_modpath("moretrees") then
	BLOSSOM_NODE = "moretrees:apple_blossoms"
	BLOSSOM_LEAVES = "moretrees:apple_tree_leaves"
	BLOSSOM_TEXTURES = { "moretrees_apple_tree_leaves.png^nature_blossom.png" }
	minetest.register_alias("nature:blossom", "default:leaves")
end

local BLOSSOM_CHANCE = 15
local BLOSSOM_DELAY = 3600

local APPLE_CHANCE = 10
local APPLE_SPREAD = 2

local function spawn_apple_under(pos)
    local below = {
		x = pos.x,
		y = pos.y - 1,
		z = pos.z,
	}
    if minetest.get_node(below).name == "air" then
		minetest.set_node(below, { name = "default:apple" })
    end
end

minetest.register_node(":"..BLOSSOM_NODE, {
    description = "Apple blossoms",
    drawtype = "allfaces_optional",
    tiles = BLOSSOM_TEXTURES,
    paramtype = "light",
    groups = { snappy = 3, leafdecay = 3, flammable = 2 },
    sounds = default.node_sound_leaves_defaults(),
	waving = 1
})

minetest.register_craft({
    type = "fuel",
    recipe = BLOSSOM_NODE,
    burntime = 2,
})

-- Blossoming
minetest.register_abm({
    nodenames = { BLOSSOM_LEAVES },
    interval = BLOSSOM_DELAY,
    chance = BLOSSOM_CHANCE,

    action = function(pos, node, active_object_count, active_object_count_wider)
		if nature:is_near_water(pos) then
			nature:grow_node(pos, BLOSSOM_NODE)
		end
    end
})

-- Removing blossom
minetest.register_abm({
    nodenames = { BLOSSOM_NODE },
    interval = BLOSSOM_DELAY,
    chance = BLOSSOM_CHANCE,

    action = function(pos, node, active_object_count, active_object_count_wider)
		nature:grow_node(pos, BLOSSOM_LEAVES)
    end
})

-- Spawning apples
minetest.register_abm({
    nodenames = { BLOSSOM_NODE },
    interval = BLOSSOM_DELAY,
    chance = APPLE_CHANCE,

    action = function(pos, node, active_object_count, active_object_count_wider)
		if not minetest.find_node_near(pos, APPLE_SPREAD, { "default:apple" }) then
			spawn_apple_under(pos)
		end
    end
})
