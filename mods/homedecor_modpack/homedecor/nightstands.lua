local S = homedecor.gettext
local woods = {"mahogany", "oak"}

for _, w in ipairs(woods) do

homedecor.register("nightstand_"..w.."_one_drawer", {
	description = S("Nightstand with One Drawer ("..w..")"),
	tiles = { 'homedecor_nightstand_'..w..'_top.png',
			'homedecor_nightstand_'..w..'_bottom.png',
			'homedecor_nightstand_'..w..'_right.png',
			'homedecor_nightstand_'..w..'_left.png',
			'homedecor_nightstand_'..w..'_back.png',
			'homedecor_nightstand_'..w..'_1_drawer_front.png'},
	selection_box = { type = "regular" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16,     0, -30/64,  8/16,  8/16,   8/16 },	-- top half
			{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64}, 	-- drawer face
			{ -8/16, -8/16, -30/64, -7/16,     0,   8/16 },	-- left
			{  7/16, -8/16, -30/64,  8/16,     0,   8/16 },	-- right
			{ -8/16, -8/16,   7/16,  8/16,     0,   8/16 },	-- back
			{ -8/16, -8/16, -30/64,  8/16, -7/16,   8/16 }	-- bottom
		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("One-drawer Nightstand"),
	inventory = {
		size=8,
	},
})

homedecor.register("nightstand_"..w.."_two_drawers", {
	description = S("Nightstand with Two Drawers ("..w..")"),
	tiles = { 'homedecor_nightstand_'..w..'_top.png',
			'homedecor_nightstand_'..w..'_bottom.png',
			'homedecor_nightstand_'..w..'_right.png',
			'homedecor_nightstand_'..w..'_left.png',
			'homedecor_nightstand_'..w..'_back.png',
			'homedecor_nightstand_'..w..'_2_drawer_front.png'},
	selection_box = { type = "regular" },
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -30/64,  8/16,  8/16,   8/16 },	-- main body
			{ -7/16,  1/16, -32/64,  7/16,  7/16, -29/64 },	-- top drawer face
			{ -7/16, -7/16, -32/64,  7/16, -1/16, -29/64 },	-- bottom drawer face

		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Two-drawer Nightstand"),
	inventory = {
		size=16,
	},
})

end
