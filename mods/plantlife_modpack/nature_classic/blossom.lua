-- Blossoms and such

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

minetest.register_node(":"..nature.blossom_node, {
    description = "Apple blossoms",
    drawtype = "allfaces_optional",
    tiles = nature.blossom_textures,
    paramtype = "light",
    groups = { snappy = 3, leafdecay = 3, flammable = 2, leafdecay = 3 },
    sounds = default.node_sound_leaves_defaults(),
	waving = 1
})

minetest.register_craft({
    type = "fuel",
    recipe = nature.blossom_node,
    burntime = 2,
})

-- these ABMs can get heavy, so just enqueue the nodes

-- Adding Blossoms
-- Limit mass changes after block has not been loaded for some time:
-- Run ABM with higher frequency, but don't enqueue all blocks
minetest.register_abm({
    nodenames = { nature.blossom_leaves },
    interval = nature.blossom_delay / nature.leaves_blossom_chance,
    chance = nature.leaves_blossom_chance,

    action = function(pos, node, active_object_count, active_object_count_wider)
			if math.random(nature.leaves_blossom_chance) == 1 then
				nature.enqueue_node(pos, node, nature.blossom_node)
			end
    end
})

-- Removing blossoms
-- Limit mass changes after block has not been loaded for some time:
-- Run ABM with higher frequency, but don't enqueue all blocks
minetest.register_abm({
    nodenames = { nature.blossom_node },
    interval = nature.blossom_delay / nature.blossom_leaves_chance,
    chance = nature.blossom_leaves_chance,

    action = function(pos, node, active_object_count, active_object_count_wider)
			if math.random(nature.blossom_leaves_chance) == 1 then
				nature.enqueue_node(pos, node, nature.blossom_leaves)
			end
    end
})

-- Spawning apples
-- Limit mass changes after block has not been loaded for some time:
-- spawn apples with 25% chance, but with 4 times higher frequency
minetest.register_abm({
    nodenames = { nature.blossom_node },
    interval = nature.apple_delay / 4,
    chance = nature.apple_chance,

    action = function(pos, node, active_object_count, active_object_count_wider)
		if math.random(4) == 1 and nature.dtime < 0.2 and not minetest.find_node_near(pos, nature.apple_spread, { "default:apple" }) then
			spawn_apple_under(pos)
		end
    end
})
