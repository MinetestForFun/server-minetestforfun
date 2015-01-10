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

for i in ipairs(shutters) do
	local name = shutters[i][1]
	local desc = shutters[i][2]

minetest.register_node("homedecor:shutter_"..name, {
	drawtype = "mesh",
	mesh = "homedecor_window_shutter.obj",
	tiles = { "homedecor_window_shutter_"..name..".png" },
	description = S("Wooden Shutter ("..desc..")"),
	inventory_image = "homedecor_window_shutter_"..name.."_inv.png",
	wield_image = "homedecor_window_shutter_"..name.."_inv.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "wallmounted",
--		wall_side = { -0.5, -0.5, 0.44, 0.5, 0.5, 0.5 }
	},
})
end

minetest.register_alias("homedecor:shutter_purple", "homedecor:shutter_violet")
