-- BobBlocks mod by RabbiBob
-- State Changes

local update_bobblock = function (pos, node)
    local nodename=""
    local param2=""
    --Switch Block State
    if 
    -- Start Blocks
        node.name == 'bobblocks:redblock_off' then nodename = 'bobblocks:redblock'
    elseif node.name == 'bobblocks:redblock' then nodename = 'bobblocks:redblock_off'
    elseif node.name == 'bobblocks:orangeblock_off' then nodename = 'bobblocks:orangeblock'
    elseif node.name == 'bobblocks:orangeblock' then nodename = 'bobblocks:orangeblock_off'
    elseif node.name == 'bobblocks:yellowblock_off' then nodename = 'bobblocks:yellowblock'
    elseif node.name == 'bobblocks:yellowblock' then nodename = 'bobblocks:yellowblock_off'
    elseif node.name == 'bobblocks:greenblock_off' then nodename = 'bobblocks:greenblock'
    elseif node.name == 'bobblocks:greenblock' then nodename = 'bobblocks:greenblock_off'        
    elseif node.name == 'bobblocks:blueblock_off' then nodename = 'bobblocks:blueblock'
    elseif node.name == 'bobblocks:blueblock' then nodename = 'bobblocks:blueblock_off'
    elseif node.name == 'bobblocks:indigoblock_off' then nodename = 'bobblocks:indigoblock'
    elseif node.name == 'bobblocks:indigoblock' then nodename = 'bobblocks:indigoblock_off'    
    elseif node.name == 'bobblocks:violetblock_off' then nodename = 'bobblocks:violetblock'
    elseif node.name == 'bobblocks:violetblock' then nodename = 'bobblocks:violetblock_off'
    elseif node.name == 'bobblocks:whiteblock_off' then nodename = 'bobblocks:whiteblock'
    elseif node.name == 'bobblocks:whiteblock' then nodename = 'bobblocks:whiteblock_off'    
    -- Start Poles
    elseif node.name == 'bobblocks:redpole_off' then nodename = 'bobblocks:redpole'
    elseif node.name == 'bobblocks:redpole' then nodename = 'bobblocks:redpole_off'
    elseif node.name == 'bobblocks:orangepole_off' then nodename = 'bobblocks:orangepole'
    elseif node.name == 'bobblocks:orangepole' then nodename = 'bobblocks:orangepole_off'
    elseif node.name == 'bobblocks:yellowpole_off' then nodename = 'bobblocks:yellowpole'
    elseif node.name == 'bobblocks:yellowpole' then nodename = 'bobblocks:yellowpole_off'
    elseif node.name == 'bobblocks:greenpole_off' then nodename = 'bobblocks:greenpole'
    elseif node.name == 'bobblocks:greenpole' then nodename = 'bobblocks:greenpole_off'        
    elseif node.name == 'bobblocks:bluepole_off' then nodename = 'bobblocks:bluepole'
    elseif node.name == 'bobblocks:bluepole' then nodename = 'bobblocks:bluepole_off'
    elseif node.name == 'bobblocks:indigopole_off' then nodename = 'bobblocks:indigopole'
    elseif node.name == 'bobblocks:indigopole' then nodename = 'bobblocks:indigopole_off'    
    elseif node.name == 'bobblocks:violetpole_off' then nodename = 'bobblocks:violetpole'
    elseif node.name == 'bobblocks:violetpole' then nodename = 'bobblocks:violetpole_off'
    elseif node.name == 'bobblocks:whitepole_off' then nodename = 'bobblocks:whitepole'
    elseif node.name == 'bobblocks:whitepole' then nodename = 'bobblocks:whitepole_off' 
    end
    minetest.env:add_node(pos, {name = nodename})
    minetest.sound_play("bobblocks_glassblock",
	{pos = pos, gain = 1.0, max_hear_distance = 32,})
end

    
-- Punch Blocks    
local on_bobblock_punched = function (pos, node, puncher)
    if 
       -- Start Blocks
       node.name == 'bobblocks:redblock_off' or node.name == 'bobblocks:redblock' or 
       node.name == 'bobblocks:orangeblock_off' or node.name == 'bobblocks:orangeblock' or
       node.name == 'bobblocks:yellowblock_off' or node.name == 'bobblocks:yellowblock' or
       node.name == 'bobblocks:greenblock_off' or node.name == 'bobblocks:greenblock' or
       node.name == 'bobblocks:blueblock_off' or node.name == 'bobblocks:blueblock' or
       node.name == 'bobblocks:indigoblock_off' or node.name == 'bobblocks:indigoblock' or
       node.name == 'bobblocks:violetblock_off' or node.name == 'bobblocks:violetblock' or
       node.name == 'bobblocks:whiteblock_off' or node.name == 'bobblocks:whiteblock' or
       --Start Poles
       node.name == 'bobblocks:redpole_off' or node.name == 'bobblocks:redpole' or 
       node.name == 'bobblocks:orangepole_off' or node.name == 'bobblocks:orangepole' or
       node.name == 'bobblocks:yellowpole_off' or node.name == 'bobblocks:yellowpole' or
       node.name == 'bobblocks:greenpole_off' or node.name == 'bobblocks:greenpole' or
       node.name == 'bobblocks:bluepole_off' or node.name == 'bobblocks:bluepole' or
       node.name == 'bobblocks:indigopole_off' or node.name == 'bobblocks:indigopole' or
       node.name == 'bobblocks:violetpole_off' or node.name == 'bobblocks:violetpole' or
       node.name == 'bobblocks:whitepole_off' or node.name == 'bobblocks:whitepole' 
    then
        update_bobblock(pos, node)
    end
end

minetest.register_on_punchnode(on_bobblock_punched)

-- Nodes
-- Misc Node

minetest.register_node("bobblocks:btm", {
	description = "Bobs TransMorgifier v5",
    tile_images = {"bobblocks_btm_sides.png", "bobblocks_btm_sides.png", "bobblocks_btm_sides.png",
		"bobblocks_btm_sides.png", "bobblocks_btm_sides.png", "bobblocks_btm.png"},
    inventory_image = "bobblocks_btm.png",
	paramtype2 = "facedir",
	material = minetest.digprop_dirtlike(1.0),
	legacy_facedir_simple = true,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    
})


-- Start Block Nodes
minetest.register_node("bobblocks:redblock", {
	description = "Red Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_redblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_redblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:redblock_off"
		}}
})

minetest.register_node("bobblocks:redblock_off", {
	description = "Red Block",
    tile_images = {"bobblocks_redblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:redblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:redblock"
		}}
    
})

minetest.register_node("bobblocks:orangeblock", {
	description = "Orange Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_orangeblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_orangeblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:orangeblock_off"
		}}
})

minetest.register_node("bobblocks:orangeblock_off", {
	description = "Orange Block",
    tile_images = {"bobblocks_orangeblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:orangeblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:orangeblock"
		}}
    
})

minetest.register_node("bobblocks:yellowblock", {
	description = "Yellow Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_yellowblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_yellowblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:yellowblock_off"
		}}
})

minetest.register_node("bobblocks:yellowblock_off", {
	description = "Yellow Block",
    tile_images = {"bobblocks_yellowblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:yellowblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:yellowblock"
		}}
    
})

minetest.register_node("bobblocks:greenblock", {
	description = "Green Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_greenblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_greenblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:greenblock_off"
		}}
})

minetest.register_node("bobblocks:greenblock_off", {
	description = "Green Block",
    tile_images = {"bobblocks_greenblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:greenblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:greenblock"
		}}
    
})


minetest.register_node("bobblocks:blueblock", {
	description = "Blue Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_blueblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_blueblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:blueblock_off"
		}}
})

minetest.register_node("bobblocks:blueblock_off", {
	description = "Blue Block",
    tile_images = {"bobblocks_blueblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:blueblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:blueblock"
		}}
    
})

minetest.register_node("bobblocks:indigoblock", {
	description = "Indigo Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_indigoblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_indigoblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:indigoblock_off"
		}}
})

minetest.register_node("bobblocks:indigoblock_off", {
	description = "Indigo Block",
    tile_images = {"bobblocks_indigoblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:indigoblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:indigoblock"
		}}
    
})


minetest.register_node("bobblocks:violetblock", {
	description = "Violet Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_violetblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_violetblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:violetblock_off"
		}}
})

minetest.register_node("bobblocks:violetblock_off", {
	description = "Violet Block",
    tile_images = {"bobblocks_violetblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:violetblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:violetblock"
		}}
    
})

minetest.register_node("bobblocks:whiteblock", {
	description = "White Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_whiteblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_whiteblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:whiteblock_off"
		}}
})

minetest.register_node("bobblocks:whiteblock_off", {
	description = "White Block",
    tile_images = {"bobblocks_whiteblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:whiteblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:whiteblock"
		}}
    
})


minetest.register_node("bobblocks:greyblock", {
	description = "Grey Block",
	drawtype = "glasslike",
	tile_images = {"bobblocks_greyblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_greyblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:greyblock_off"
		}}
})

minetest.register_node("bobblocks:greyblock_off", {
	description = "Grey Block",
    tile_images = {"bobblocks_greyblock.png"},
    is_ground_content = true,
    alpha = WATER_ALPHA,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:greyblock',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:greyblock"
		}}
    
})


-- Block Poles
minetest.register_node("bobblocks:redpole", {
	description = "Red Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_redblock.png"},
	inventory_image = ("bobblocks_invredpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:redpole_off"
		}}
})

minetest.register_node("bobblocks:redpole_off", {
	description = "Red Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_redblock.png"},
	inventory_image = ("bobblocks_invredpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:redpole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:redpole"
		}}
    
})

minetest.register_node("bobblocks:orangepole", {
	description = "Orange Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_orangeblock.png"},
	inventory_image = ("bobblocks_invorangepole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:orangepole_off"
		}}
})

minetest.register_node("bobblocks:orangepole_off", {
	description = "Orange Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_orangeblock.png"},
	inventory_image = ("bobblocks_invorangepole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:orangepole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:orangepole"
		}}
    
})

minetest.register_node("bobblocks:yellowpole", {
	description = "Yellow Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_yellowblock.png"},
	inventory_image = ("bobblocks_invyellowpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:yellowpole_off"
		}}
})

minetest.register_node("bobblocks:yellowpole_off", {
	description = "Yellow Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_yellowblock.png"},
	inventory_image = ("bobblocks_invyellowpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:yellowpole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:yellowpole"
		}}
    
})

minetest.register_node("bobblocks:greenpole", {
	description = "Green Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_greenblock.png"},
	inventory_image = ("bobblocks_invgreenpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:greenpole_off"
		}}
})

minetest.register_node("bobblocks:greenpole_off", {
	description = "Green Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_greenblock.png"},
	inventory_image = ("bobblocks_invgreenpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:greenpole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:greenpole"
		}}
    
})

minetest.register_node("bobblocks:bluepole", {
	description = "Blue Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_blueblock.png"},
	inventory_image = ("bobblocks_invbluepole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:bluepole_off"
		}}
})

minetest.register_node("bobblocks:bluepole_off", {
	description = "Blue Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_blueblock.png"},
	inventory_image = ("bobblocks_invbluepole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:bluepole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:bluepole"
		}}
    
})

minetest.register_node("bobblocks:indigopole", {
	description = "Indigo Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_indigoblock.png"},
	inventory_image = ("bobblocks_invindigopole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:indigopole_off"
		}}
})

minetest.register_node("bobblocks:indigopole_off", {
	description = "Indigo Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_indigoblock.png"},
	inventory_image = ("bobblocks_invindigopole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:indigopole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:indigopole"
		}}
    
})

minetest.register_node("bobblocks:violetpole", {
	description = "Violet Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_violetblock.png"},
	inventory_image = ("bobblocks_invvioletpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:violetpole_off"
		}}
})

minetest.register_node("bobblocks:violetpole_off", {
	description = "Violet Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_violetblock.png"},
	inventory_image = ("bobblocks_invvioletpole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:violetpole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:violetpole"
		}}
    
})

minetest.register_node("bobblocks:whitepole", {
	description = "White Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_whiteblock.png"},
	inventory_image = ("bobblocks_invwhitepole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-0,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:whitepole_off"
		}}
})

minetest.register_node("bobblocks:whitepole_off", {
	description = "White Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_whiteblock.png"},
	inventory_image = ("bobblocks_invwhitepole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    light_source = LIGHT_MAX-10,
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
    drop = 'bobblocks:whitepole',
    mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:whitepole"
		}}
    
})

minetest.register_node("bobblocks:greypole", {
	description = "Grey Pole",
	drawtype = "fencelike",
	tile_images = {"bobblocks_greyblock.png"},
	inventory_image = ("bobblocks_invgreypole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
    groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
    --light_source = LIGHT_MAX-0,
})



-- Crafts
-- BTM
minetest.register_craft({
	output = 'NodeItem "bobblocks:btm" 1',
	recipe = {
		{'node "default:glass" 1', 'node "default:torch" 1', 'node "default:leaves" 1',
        'node "default:mese" 1','node "default:rat" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:greyblock" 2', 
	recipe = {
		{'node "default:glass" 1', 'node "default:torch" 1', 'node "default:cobble" 1'},
	},
})

-- Red / Yellow / Blue / White
-- Red / Yellow -> Orange
-- Red / Blue -> Violet
-- Blue / Yellow -> Green
-- Red / Yellow / White -> Indigo

minetest.register_craft({
	output = 'NodeItem "bobblocks:redblock" 2', 
	recipe = {
		{'node "default:glass" 1', 'node "default:torch" 1', 'node "default:brick" 1'},
	},
})
minetest.register_craft({
	output = 'NodeItem "bobblocks:yellowblock" 2', 
	recipe = {
		{'node "default:glass" 1', 'node "default:torch" 1', 'node "default:sand" 1'},
	},
})
minetest.register_craft({
	output = 'NodeItem "bobblocks:blueblock" 2', 
	recipe = {
		{'node "default:glass" 1', 'node "default:torch" 1', 'node "default:gravel" 1'},
	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:whiteblock" 2', 
	recipe = {
		{'node "default:glass" 1', 'node "default:torch" 1', 'node "default:dirt" 1'},
	},
})


minetest.register_craft({
	output = 'NodeItem "bobblocks:orangeblock" 2',
	recipe = {
		{'node "bobblocks:redblock" 1', 'node "bobblocks:yellowblock" 1'},

	},
})


minetest.register_craft({
	output = 'NodeItem "bobblocks:violetblock" 2',
	recipe = {
		{'node "bobblocks:redblock" 1', 'node "bobblocks:blueblock" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:greenblock" 2',
	recipe = {
		{'node "bobblocks:blueblock" 1', 'node "bobblocks:yellowblock" 1'},

	},
})


minetest.register_craft({
	output = 'NodeItem "bobblocks:indigoblock" 3',
	recipe = {
		{'node "bobblocks:redblock" 1', 'node "bobblocks:blueblock" 1', 'node "bobblocks:whiteblock" 1'},

	},
})

-- Poles

minetest.register_craft({
	output = 'NodeItem "bobblocks:redpole" 1',
	recipe = {
		{'node "bobblocks:redblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:yellowpole" 1',
	recipe = {
		{'node "bobblocks:yellowblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:bluepole" 1',
	recipe = {
		{'node "bobblocks:blueblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:whitepole" 1',
	recipe = {
		{'node "bobblocks:whiteblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:orangepole" 1',
	recipe = {
		{'node "bobblocks:orangeblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:violetpole" 1',
	recipe = {
		{'node "bobblocks:violetblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:greenpole" 1',
	recipe = {
		{'node "bobblocks:greenblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:indigopole" 1',
	recipe = {
		{'node "bobblocks:indigoblock" 1', 'node "default:stick" 1'},

	},
})

minetest.register_craft({
	output = 'NodeItem "bobblocks:greypole" 1',
	recipe = {
		{'node "bobblocks:greyblock" 1', 'node "default:stick" 1'},

	},
})


-- MESECON
-- Add jeija to bobblocks\default.txt and paste the below in at the bottom of bobblocks\blocks.lua

