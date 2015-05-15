-- Various kinds of window shutters

local S = homedecor.gettext

local shutters = {
	{"oak",          "Unpainted oak", "#bf8a51:200" },
	{"mahogany",     "Mahogany",      "#822606:200" },
	{"red",          "Red",           "#d00000:150" },
	{"yellow",       "Yellow",        "#ffff00:150" },
	{"forest_green", "Forest green",  "#006000:150" },
	{"light_blue",   "Light blue",    "#1963c7:150" },
	{"violet",       "Violet",        "#6000ff:150" },
	{"black",        "Black",         "#000000:200" },
	{"dark_grey",    "Dark grey",     "#202020:200" },
	{"grey",         "Grey",          "#c0c0c0:150" },
	{"white",        "White",         "#ffffff:150" },
}

local shutter_cbox = {
	type = "wallmounted",
	wall_top =		{ -0.5,  0.4375, -0.5,  0.5,     0.5,    0.5 },
	wall_bottom =	{ -0.5, -0.5,    -0.5,  0.5,    -0.4375, 0.5 },
	wall_side =		{ -0.5, -0.5,    -0.5, -0.4375,  0.5,    0.5 }
}

for i in ipairs(shutters) do
	local name = shutters[i][1]
	local desc = shutters[i][2]
	local hue  = shutters[i][3]

	local tile = "homedecor_window_shutter.png^[colorize:"..hue
	local inv  = "homedecor_window_shutter_inv.png^[colorize:"..hue

	homedecor.register("shutter_"..name, {
		mesh = "homedecor_window_shutter.obj",
		tiles = { tile },
		description = S("Wooden Shutter ("..desc..")"),
		inventory_image = inv,
		wield_image = inv,
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

