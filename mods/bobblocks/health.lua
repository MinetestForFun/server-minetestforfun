local is_healthpack = function(node)
    if node.name == 'bobblocks:health_off' or node.name == 'health_on' then
        return true
    end
    return false
end

local update_healthpack = function (pos, node)
    local nodename=""
    local param2=""
    --Switch HealthPack State
    if node.name == 'bobblocks:health_off' then
        nodename = 'bobblocks:health_on'
    elseif node.name == 'bobblocks:health_on' then
        nodename = 'bobblocks:health_off'
    end
    minetest.add_node(pos, {name = nodename})
end

local toggle_healthpack = function (pos, node)
    if not is_healthgate(node) then return end
    update_healthpack (pos, node, state)
end

local on_healthpack_punched = function (pos, node, puncher)
    if node.name == 'bobblocks:health_off' or node.name == 'bobblocks:health_on' then
        update_healthpack(pos, node)
    end
end

-- Healing Node

minetest.register_node("bobblocks:health_off", {
	description = "Health Pack 1 Off",
    tile_images = {"bobblocks_health_off.png"},
    inventory_image = "bobblocks_health_off.png",
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    is_ground_content = true,
    walkable = false,
    climbable = false,
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:health_on"
		}}
})

minetest.register_node("bobblocks:health_on", {
	description = "Health Pack 1 On",
    tile_images = {"bobblocks_health_on.png"},
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
    light_source = default.LIGHT_MAX-1,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    is_ground_content = true,
        walkable = false,
    climbable = false,
    drop = "bobblocks:health_off",
        mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:health_off"
		}}
})


minetest.register_abm(
	{nodenames = {"bobblocks:health_on"},
    interval = 1.0,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
    local objs = minetest.get_objects_inside_radius(pos, 1)
        for k, obj in pairs(objs) do
        minetest.sound_play("bobblocks_health",
	    {pos = pos, gain = 1.0, max_hear_distance = 32,})
        obj:set_hp(obj:get_hp()+5)     -- give 2.5HP
        minetest.remove_node(pos)  -- remove the node after use
    end
    end,

})

--- Health

minetest.register_craft({
	output = "bobblocks:health_off",
	type = "shapeless",
	recipe = {
		"default:dirt", "default:paper", "default:apple", "default:apple"
	},
})


minetest.register_on_punchnode(on_healthpack_punched)

