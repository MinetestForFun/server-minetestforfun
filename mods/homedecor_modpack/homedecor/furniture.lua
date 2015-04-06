local S = homedecor.gettext

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

local table_colors = { "", "mahogany", "white" }

for _, i in ipairs(table_colors) do
	local color = "_"..i
	local desc = S("Table ("..i..")")

	if i == "" then
		color = ""
		desc = S("Table")
	end

	homedecor.register("table"..color, {
		description = desc,
		tiles = { "forniture_wood"..color..".png" },
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

for i in ipairs(chaircolors) do

	local color = "_"..chaircolors[i][1]
	local color2 = chaircolors[i][1]
	local name = S(chaircolors[i][2])
	local chairtiles = {
			"forniture_kitchen_chair_top"..color..".png",
			"forniture_wood.png",
			"forniture_kitchen_chair_sides"..color..".png",
			"forniture_kitchen_chair_sides"..color..".png^[transformFX",
			"forniture_kitchen_chair_back"..color..".png",
			"forniture_kitchen_chair_front"..color..".png",
	}
	if chaircolors[i][1] == "" then
		color = ""
		chairtiles = { "forniture_wood.png" }
	end

	homedecor.register("chair"..color, {
		description = S("Kitchen chair (%s)"):format(name),
		tiles = chairtiles,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.3125, -0.5, 0.1875, -0.1875, 0.5, 0.3125},
				{0.1875, -0.5, 0.1875, 0.3125, 0.5, 0.3125},
				{-0.3125, -0.5, -0.3125, -0.1875, 0, -0.1875},
				{0.1875, -0.5, -0.3125, 0.3125, 0, -0.1875},
				{-0.3125, -0.125, -0.3125, 0.3125, 0, 0.3125},
				{-0.25, 0.0625, 0.25, 0.25, 0.4375, 0.25},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
		},
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
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
			sunlight_propagates = true,
			groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
			--[[
			on_rightclick = function(pos, node, clicker)
				pos.y = pos.y-0.1 -- player's sit position.
				homedecor.sit_exec(pos, node, clicker)
				clicker:set_hp(20)
			end,
			--]]
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

minetest.register_node(":homedecor:openframe_bookshelf", {
	description = "Bookshelf (open-frame)",
	drawtype = "mesh",
	mesh = "homedecor_openframe_bookshelf.obj",
	tiles = { "homedecor_openframe_bookshelf.png" },
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=3,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0.5 }
	},
	collision_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0, 0.5, 0.5, 0.5 }
	},
})

local bedcolors = {
	"red",
	"green",
	"blue",
	"violet",
	"brown",
	"darkgrey",
	"orange",
	"yellow",
	"pink",
}

local function bed_extension(pos, color)

	local topnode = minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z})
	local thisnode = minetest.get_node(pos)
	local bottomnode = minetest.get_node({x=pos.x, y=pos.y-1.0, z=pos.z})

	local fdir = thisnode.param2

	if string.find(topnode.name, "homedecor:bed_.*_regular$") then
		if fdir == topnode.param2 then
			local newnode = string.gsub(thisnode.name, "_regular", "_extended")
			minetest.set_node(pos, { name = newnode, param2 = fdir})
		end
	end

	if string.find(bottomnode.name, "homedecor:bed_.*_regular$") then
		if fdir == bottomnode.param2 then
			local newnode = string.gsub(bottomnode.name, "_regular", "_extended")
			minetest.set_node({x=pos.x, y=pos.y-1.0, z=pos.z}, { name = newnode, param2 = fdir})
		end
	end
end

local function unextend_bed(pos, color)
	local bottomnode = minetest.get_node({x=pos.x, y=pos.y-1.0, z=pos.z})
	local fdir = bottomnode.param2
	if  string.find(bottomnode.name, "homedecor:bed_.*_extended$") then
		local newnode = string.gsub(bottomnode.name, "_extended", "_regular")
		minetest.set_node({x=pos.x, y=pos.y-1.0, z=pos.z}, { name = newnode, param2 = fdir})
	end
end

local bed_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 1.5 }
}

for _, color in ipairs(bedcolors) do
	local color2=color
	if color == "darkgrey" then
		color2 = "dark_grey"
	end
	homedecor.register("bed_"..color.."_regular", {
		mesh = "homedecor_bed_regular.obj",
		tiles = {
			"homedecor_bed_frame.png",
			"default_wood.png",
			"wool_white.png",
			"wool_"..color2..".png",
			"homedecor_bed_bottom.png",
			"wool_"..color2..".png^[brighten", -- pillow
		},
		inventory_image = "homedecor_bed_"..color.."_inv.png",
		description = S("Bed (%s)"):format(color),
		groups = {snappy=3},
		selection_box = bed_cbox,
		collision_box = bed_cbox,
		on_construct = function(pos)
			bed_extension(pos, color)
		end,
		expand = { forward = "air" },
		after_unexpand = function(pos)
			unextend_bed(pos, color)
		end,
	})

	homedecor.register("bed_"..color.."_extended", {
		mesh = "homedecor_bed_extended.obj",
		tiles = {
			"homedecor_bed_frame.png",
			"default_wood.png",
			"wool_white.png",
			"wool_"..color2..".png",
			"homedecor_bed_bottom.png",
			"wool_"..color2..".png^[brighten",
		},
		groups = {snappy=3, not_in_creative_inventory=1},
		selection_box = bed_cbox,
		collision_box = bed_cbox,
		expand = { forward = "air" },
		after_unexpand = function(pos)
			unextend_bed(pos, color)
		end,
		drop = "homedecor:bed_"..color.."_regular"
	})

	minetest.register_alias("homedecor:bed_"..color.."_foot",    "homedecor:bed_"..color.."_regular")
	minetest.register_alias("homedecor:bed_"..color.."_footext", "homedecor:bed_"..color.."_extended")
	minetest.register_alias("homedecor:bed_"..color.."_head",    "air")

end

local wd_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
}

homedecor.register("wardrobe_bottom", {
	mesh = "homedecor_bedroom_wardrobe.obj",
	tiles = {
		"forniture_wood.png",
		"homedecor_wardrobe_drawers.png",
		"homedecor_wardrobe_doors.png"
	},
	inventory_image = "homedecor_wardrobe_inv.png",
	description = "Wardrobe",
	groups = {snappy=3},
	selection_box = wd_cbox,
	collision_box = wd_cbox,
	expand = { top="air" },
	infotext = S("Wardrobe cabinet"),
	inventory = {
		size=24,
	},
})

minetest.register_alias("homedecor:wardrobe_bottom", "homedecor:wardrobe")
minetest.register_alias("homedecor:wardrobe_top", "air")

homedecor.register("wall_shelf", {
	description = "Wall Shelf",
	tiles = {
		"homedecor_wood_table_large_edges.png",
	},
	groups = { snappy = 3 },
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
	--[[
	on_rightclick = function(pos, node, clicker)
		pos.y = pos.y+0.14 -- player's sit position.
		homedecor.sit_exec(pos, node, clicker)
	end,
	--]]
})

end

-- Aliases for 3dforniture mod.

minetest.register_alias("3dforniture:table", "homedecor:table")
minetest.register_alias("3dforniture:chair", "homedecor:chair")
minetest.register_alias("3dforniture:armchair", "homedecor:armchair_black")
minetest.register_alias("homedecor:armchair", "homedecor:armchair_black")

minetest.register_alias('table', 'homedecor:table')
minetest.register_alias('chair', 'homedecor:chair')
minetest.register_alias('armchair', 'homedecor:armchair')
