-- Various kinds of window shutters

local S = homedecor.gettext

local shutters = {
	{"oak", "Unpainted oak"},
	{"mahogany", "Mahogany"},
	{"red", "Red"},
	{"yellow", "Yellow"},
	{"forest_green", "Forest green"},
	{"light_blue", "Light blue"},
	{"violet", "Violet"},
	{"black", "Black"},
	{"dark_grey", "Dark grey"},
	{"grey", "Grey"},
	{"white", "White"},
}

local shutter_cbox = {
	type = "wallmounted",
	wall_top =		{ -0.5,  0.4375, -0.5,  0.5,     0.5,    0.5 },
	wall_bottom =	{ -0.5, -0.5,    -0.5,  0.5,    -0.4375, 0.5 },
	wall_side =		{ -0.5, -0.5,    -0.5, -0.4375,  0.5,    0.5 },
}

for i in ipairs(shutters) do
	local name = shutters[i][1]
	local desc = shutters[i][2]

	homedecor.register("shutter_"..name, {
		mesh = "homedecor_window_shutter.obj",
		tiles = { "homedecor_window_shutter_"..name..".png" },
		description = S("Wooden Shutter ("..desc..")"),
		inventory_image = "homedecor_window_shutter_"..name.."_inv.png",
		wield_image = "homedecor_window_shutter_"..name.."_inv.png",
		paramtype = "light",
		paramtype2 = "wallmounted",
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = shutter_cbox,
		node_box = shutter_cbox,
			-- collision_box doesn't accept type="wallmounted", but node_box
			-- does.  Said nodeboxes create a custom collision box but are
			-- invisible themselves because drawtype="mesh".
	})
end

minetest.register_alias("homedecor:shutter_purple", "homedecor:shutter_violet")
