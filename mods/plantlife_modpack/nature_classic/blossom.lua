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
    groups = { snappy = 3, leafdecay = 3, flammable = 2 },
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
minetest.register_abm({
    nodenames = { nature.blossom_leaves },
    interval = nature.blossom_delay,
    chance = nature.blossom_chance,

    action = function(pos, node, active_object_count, active_object_count_wider)
			nature.enqueue_node(pos, node, true)
    end
})

-- Removing blossoms
minetest.register_abm({
    nodenames = { nature.blossom_node },
    interval = nature.blossom_delay,
    chance = nature.blossom_chance,

    action = function(pos, node, active_object_count, active_object_count_wider)
			nature.enqueue_node(pos, node, false)
    end
})

-- Spawning apples
minetest.register_abm({
    nodenames = { nature.blossom_node },
    interval = nature.blossom_delay,
    chance = nature.apple_chance,

    action = function(pos, node, active_object_count, active_object_count_wider)
		if nature.dtime < 0.2 and not minetest.find_node_near(pos, nature.apple_spread, { "default:apple" }) then
			spawn_apple_under(pos)
		end
    end
})
