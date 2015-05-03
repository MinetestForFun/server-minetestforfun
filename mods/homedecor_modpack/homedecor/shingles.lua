local S = homedecor.gettext

minetest.register_node("homedecor:skylight", {
	description = S("Glass Skylight"),
	drawtype = "raillike",
	tiles = { "default_glass.png" },
	wield_image = "default_glass.png",
	inventory_image = "homedecor_skylight_inv.png",
	groups = { snappy = 3 },
	sounds = default.node_sound_glass_defaults(),
	selection_box = homedecor.nodebox.slab_y(0.1),
})

minetest.register_node("homedecor:skylight_frosted", {
	description = S("Glass Skylight Frosted"),
	drawtype = "raillike",
	tiles = { "homedecor_skylight_frosted.png" },
	wield_image = "homedecor_skylight_frosted.png",
	inventory_image = "homedecor_skylight_frosted_inv.png",
	use_texture_alpha = true,
	groups = { snappy = 3 },
	sounds = default.node_sound_glass_defaults(),
	selection_box = homedecor.nodebox.slab_y(0.1),
})

local materials = {"asphalt", "terracotta", "wood"}

for _, s in ipairs(materials) do
minetest.register_node("homedecor:shingles_"..s, {
	description = S("Shingles ("..s..")"),
	drawtype = "raillike",
	tiles = { "homedecor_shingles_"..s..".png" },
	wield_image = "homedecor_shingles_"..s..".png",
	inventory_image = "homedecor_shingles_"..s.."_inv.png",
	paramtype = "light",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	selection_box = homedecor.nodebox.slab_y(0.1),
})
end
