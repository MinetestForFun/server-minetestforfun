
minetest.register_tool("lavatemple:darkpick", {
	description = "Dark Pickaxe",
	inventory_image = "lavatemple_tool_darkpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			dark = {times={[1]=0.25}, uses=0, maxlevel=1},
		},
		damage_groups = {},
	},
})

minetest.register_craftitem("lavatemple:teleport_orb", {
	description = "Teleport'orb (does nothing yet)",
	inventory_image = "lavatemple_teleport_orb.png",
	on_place = function(itemstack, placer, pointed_thing)
	end,
})


-- MODIFICATION MADE FOR MFF
minetest.register_craft({
	output = "lavatemple:ladder 4",
	recipe = {
		{"default:obsidianbrick", "dye:red", "default:obsidianbrick"},
		{"default:obsidianbrick", "default:obsidianbrick", "default:obsidianbrick"},
		{"default:obsidianbrick", "", "default:obsidianbrick"}
	}
})
