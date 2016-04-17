-- BobBlocks mod by RabbiBob
-- State Changes

local bobblock_colours = {"red", "orange", "yellow", "green", "blue", "indigo", "violet", "white"}

local function update_bobblock(pos, node)
	--Switch Block State
	minetest.add_node(pos, {name = 'bobblocks:'..node})
	minetest.sound_play("bobblocks_glassblock", {
		pos = pos,
		gain = 1.0,
		max_hear_distance = 32,
	})
end


-- Nodes
-- Misc Node

minetest.register_node("bobblocks:btm", {
	description = "Bobs TransMorgifier v5",
	tiles = {"bobblocks_btm_sides.png", "bobblocks_btm_sides.png", "bobblocks_btm_sides.png",
		"bobblocks_btm_sides.png", "bobblocks_btm_sides.png", "bobblocks_btm.png"},
	inventory_image = "bobblocks_btm.png",
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},

})



for _, colour in ipairs(bobblock_colours) do


--Blocks

minetest.register_node("bobblocks:"..colour.."block", {
	description = colour.." Block",
	drawtype = "glasslike",
	tiles = {"bobblocks_"..colour.."block.png"},
	inventory_image = minetest.inventorycube("bobblocks_"..colour.."block.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX-0,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	on_punch = function(pos)
		update_bobblock(pos, colour.."block_off")
	end,
	mesecons = {
		conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:"..colour.."block_off"
		}
	}
})

minetest.register_node("bobblocks:"..colour.."block_off", {
	description = colour.." Block",
	tiles = {"bobblocks_"..colour.."block.png"},
	is_ground_content = true,
	alpha = 160,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = 'bobblocks:'..colour..'block',
	on_punch = function(pos)
		update_bobblock(pos, colour.."block")
	end,
	mesecons = {
		conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:"..colour.."block"
		}
	}
})


--Poles

minetest.register_node("bobblocks:"..colour.."pole", {
	description = colour.." Pole",
	drawtype = "fencelike",
	tiles = {"bobblocks_"..colour.."block.png"},
	inventory_image = ("bobblocks_inv"..colour.."pole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX-0,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	on_punch = function(pos)
		update_bobblock(pos, colour.."pole_off")
	end,
	mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:"..colour.."pole_off"
		}}
})

minetest.register_node("bobblocks:"..colour.."pole_off", {
	description = colour.." Pole",
	drawtype = "fencelike",
	tiles = {"bobblocks_"..colour.."block.png"},
	inventory_image = ("bobblocks_inv"..colour.."pole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX-10,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = 'bobblocks:'..colour..'pole',
	on_punch = function(pos)
		update_bobblock(pos, colour.."pole")
	end,
	mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:"..colour.."pole"
		}}

})


--Crafts

minetest.register_craft({
	output = "bobblocks:"..colour.."pole",
	recipe = {
		{"bobblocks:"..colour.."block", "default:stick"},

	},
})
end

minetest.register_node("bobblocks:greyblock", {
	description = "Grey Block",
	drawtype = "glasslike",
	tiles = {"bobblocks_greyblock.png"},
	inventory_image = minetest.inventorycube("bobblocks_greyblock.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX-0,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	mesecons = {conductor={
			state = mesecon.state.on,
			offstate = "bobblocks:greyblock_off"
		}}
})

minetest.register_node("bobblocks:greyblock_off", {
	description = "Grey Block",
	tiles = {"bobblocks_greyblock.png"},
	is_ground_content = true,
	alpha = 160,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	drop = 'bobblocks:greyblock',
	mesecons = {conductor={
			state = mesecon.state.off,
			onstate = "bobblocks:greyblock"
		}}

})

minetest.register_node("bobblocks:greypole", {
	description = "Grey Pole",
	drawtype = "fencelike",
	tiles = {"bobblocks_greyblock.png"},
	inventory_image = ("bobblocks_invgreypole.png"),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
	--light_source = default.LIGHT_MAX-0,
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


local bobblocks_crafts_list = {
	{
		{"grey", "cobble"},
		{"red", "brick"},
		{"yellow", "sand"},
		{"blue", "gravel"},
		{"white", "dirt"},
	},
	{
		{"orange", "red", "yellow"},
		{"violet", "red", "blue"},
		{"green", "blue", "yellow"},
	},
}

for _,items in ipairs(bobblocks_crafts_list[1]) do
	minetest.register_craft({
		output = "bobblocks:"..items[1].."block 2",
		recipe = {
			{"default:glass", "default:torch", "default:"..items[2]},
		},
	})
end

for _,items in ipairs(bobblocks_crafts_list[2]) do
	minetest.register_craft({
		output = "bobblocks:"..items[1].."block 2",
		recipe = {
			{"bobblocks:"..items[2].."block", "bobblocks:"..items[3].."block"},
		},
	})
end

minetest.register_craft({
	output = "bobblocks:indigoblock 3",
	recipe = {
		{"bobblocks:redblock", "bobblocks:blueblock", "bobblocks:whiteblock"},

	},
})

-- Poles

minetest.register_craft({
	output = 'bobblocks:greypole',
	recipe = {
		{"bobblocks:greyblock", "default:stick"},

	},
})


-- MESECON
-- Add jeija to bobblocks\default.txt and paste the below in at the bottom of bobblocks\blocks.lua

