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
	description = S("Wooden Shutter ("..desc..")"),
	tiles = { "homedecor_window_shutter_"..name..".png" },
	inventory_image = "homedecor_window_shutter_"..name..".png",
	wield_image = "homedecor_window_shutter_"..name..".png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.44, 0.5, -0.3125, 0.5}, -- NodeBox1
			{-0.5, -0.5, 0.44, -0.3125, 0.5, 0.5}, -- NodeBox2
			{-0.5, 0.3125, 0.44, 0.5, 0.5, 0.5}, -- NodeBox3
			{0.3125, -0.5, 0.44, 0.5, 0.5, 0.5}, -- NodeBox4
			{-0.3125, 0.1875, 0.46, 0.3125, 0.25, 0.48}, -- NodeBox5
			{-0.3125, 0.0625, 0.46, 0.3125, 0.125, 0.48}, -- NodeBox6
			{-0.3125, -0.0625, 0.46, 0.3125, 0, 0.48}, -- NodeBox7
			{-0.3125, -0.1875, 0.46, 0.3125, -0.125, 0.48}, -- NodeBox8
	                {-0.3125, -0.3125, 0.46, 0.3125, -0.25, 0.48}, -- NodeBox9
		}
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, 0.44, 0.5, 0.5, 0.5 }
	},
})
end

minetest.register_alias("homedecor:shutter_purple", "homedecor:shutter_violet")
