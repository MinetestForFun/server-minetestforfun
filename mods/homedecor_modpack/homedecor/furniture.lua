local S = homedecor.gettext

local table_colors = { "", "mahogany", "white" }

for _, i in ipairs(table_colors) do
	local color = "_"..i
	local color2 = "_"..i
	local desc = S("Table ("..i..")")

	if i == "" then
		color = ""
		color2 = "_beech"
		desc = S("Table")
	end

	homedecor.register("table"..color, {
		description = desc,
		tiles = { "homedecor_generic_wood"..color2..".png" },
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.4, -0.5, -0.4, -0.3,  0.4, -0.3 },
				{  0.3, -0.5, -0.4,  0.4,  0.4, -0.3 },
				{ -0.4, -0.5,  0.3, -0.3,  0.4,  0.4 },
				{  0.3, -0.5,  0.3,  0.4,  0.4,  0.4 },
				{ -0.5,  0.4, -0.5,  0.5,  0.5,  0.5 },
				{ -0.4, -0.2, -0.3, -0.3, -0.1,  0.3 },
				{  0.3, -0.2, -0.4,  0.4, -0.1,  0.3 },
				{ -0.3, -0.2, -0.4,  0.4, -0.1, -0.3 },
				{ -0.3, -0.2,  0.3,  0.3, -0.1,  0.4 },
			},
		},
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		sounds = default.node_sound_wood_defaults(),
	})
end

local chaircolors = {
	{ "", "plain" },
	{ "black", "Black" },
	{ "red", "Red" },
	{ "pink", "Pink" },
	{ "violet", "Violet" },
	{ "blue", "Blue" },
	{ "dark_green", "Dark Green" },
}

local kc_cbox = {
	type = "fixed",
	fixed = { -0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125 },
}

local ac_cbox = {
	type = "fixed",
	fixed = { 
		{-0.5, -0.5, -0.5, 0.5, 0, 0.5 },
		{-0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
	}
}

for i in ipairs(chaircolors) do

	local color = "_"..chaircolors[i][1]
	local color2 = chaircolors[i][1]
	local name = S(chaircolors[i][2])
	local chairtiles = {
		"homedecor_generic_wood_beech.png",
		"wool"..color..".png",
	}

	if chaircolors[i][1] == "" then
		color = ""
		chairtiles = {
			"homedecor_generic_wood_beech.png",
			"homedecor_generic_wood_beech.png"
		}
	end

	homedecor.register("chair"..color, {
		description = S("Kitchen chair (%s)"):format(name),
		mesh = "homedecor_kitchen_chair.obj",
		tiles = chairtiles,
		selection_box = kc_cbox,
		collision_box = kc_cbox,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		sounds = default.node_sound_wood_defaults(),
		--[[
		on_rightclick = function(pos, node, clicker)
			pos.y = pos.y-0 -- player's sit position.
			homedecor.sit_exec(pos, node, clicker)
		end,
		--]]
	})

	if color ~= "" then
		homedecor.register("armchair"..color, {
			description = S("Armchair (%s)"):format(name),
			mesh = "forniture_armchair.obj",
			tiles = {
				"wool"..color..".png",
				"wool_dark_grey.png",
				"default_wood.png"
			},
			groups = {snappy=3},
			sounds = default.node_sound_wood_defaults(),
			node_box = ac_cbox
		})

		minetest.register_craft({
			output = "homedecor:armchair"..color.." 2",
			recipe = {
			{ "wool:"..color2,""},
			{ "group:wood","group:wood" },
			{ "wool:"..color2,"wool:"..color2 },
			},
		})
	end
end

local ob_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0.5 }
}

minetest.register_node(":homedecor:openframe_bookshelf", {
	description = "Bookshelf (open-frame)",
	drawtype = "mesh",
	mesh = "homedecor_openframe_bookshelf.obj",
	tiles = {
		"homedecor_openframe_bookshelf_books.png",
		"default_wood.png"
	},
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = ob_cbox,
	collision_box = ob_cbox,
})

homedecor.register("wall_shelf", {
	description = "Wall Shelf",
	tiles = {
		"homedecor_wood_table_large_edges.png",
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4, 0.47, 0.5, 0.47, 0.5},
			{-0.5, 0.47, -0.1875, 0.5, 0.5, 0.5}
		}
	}
})

local ofchairs_sbox = {
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, 29/32, 8/16 }
	}

local ofchairs_cbox = {
		type = "fixed",
		fixed = {
			{ -5/16,   1/16, -7/16,  5/16,   4/16,  7/16 }, -- seat
			{ -5/16,   4/16,  4/16,  5/16,  29/32, 15/32 }, -- seatback
			{ -1/16, -11/32, -1/16,  1/16,   1/16,  1/16 }, -- cylinder
			{ -8/16,  -8/16, -8/16,  8/16, -11/32,  8/16 }  -- legs/wheels
		}
	}

local ofchairs = {"basic", "upscale"}

for _, c in ipairs(ofchairs) do

homedecor.register("office_chair_"..c, {
	description = "Office chair ("..c..")",
	drawtype = "mesh",
	tiles = { "homedecor_office_chair_"..c..".png" },
	mesh = "homedecor_office_chair_"..c..".obj",
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	selection_box = ofchairs_sbox,
	collision_box = ofchairs_cbox,
	expand = { top = "air" },
})

end

-- Sitting functions disabled for now because of buggyness.

--[[
function homedecor.sit(pos, node, clicker)
	local name = clicker:get_player_name()
	local meta = minetest:get_meta(pos)
	local param2 = node.param2
	if clicker:get_player_name() == meta:get_string("player") then
		meta:set_string("player", "")
		pos.y = pos.y-0.5
		clicker:setpos(pos)
		clicker:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand", 30)
	else
		meta:set_string("player", clicker:get_player_name())
		clicker:set_eye_offset({x=0,y=-7,z=2}, {x=0,y=0,z=0})
		clicker:set_physics_override(0, 0, 0)
		default.player_attached[name] = true
		if param2 == 1 then
			clicker:set_look_yaw(7.9)
		elseif param2 == 3 then
			clicker:set_look_yaw(4.75)
		elseif param2 == 0 then
			clicker:set_look_yaw(3.15)
		else
			clicker:set_look_yaw(6.28)
		end
	end
end

function homedecor.sit_exec(pos, node, clicker) -- don't move these functions inside sit()
	if not clicker or not clicker:is_player()
		or clicker:get_player_control().up == true or clicker:get_player_control().down == true
		or clicker:get_player_control().left == true or clicker:get_player_control().right == true
		or clicker:get_player_control().jump == true then  -- make sure that the player is immobile.
	return end
	homedecor.sit(pos, node, clicker)
	clicker:setpos(pos)
	default.player_set_animation(clicker, "sit", 30)
end
--]]

-- Aliases for 3dforniture mod.

minetest.register_alias("3dforniture:table", "homedecor:table")
minetest.register_alias("3dforniture:chair", "homedecor:chair")
minetest.register_alias("3dforniture:armchair", "homedecor:armchair_black")
minetest.register_alias("homedecor:armchair", "homedecor:armchair_black")

minetest.register_alias('table', 'homedecor:table')
minetest.register_alias('chair', 'homedecor:chair')
minetest.register_alias('armchair', 'homedecor:armchair')
