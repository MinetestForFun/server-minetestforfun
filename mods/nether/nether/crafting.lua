minetest.register_craft({
	output = "nether:fim",
	recipe = {
		{"nether:shroom_head"},
		{"nether:fruit_no_leaf"},
		{"nether:shroom_head"},
	}
})

minetest.register_craft({
	output = "nether:fruit_leaves",
	recipe = {
		{"nether:fruit_leaf", "nether:fruit_leaf", "nether:fruit_leaf"},
		{"nether:fruit_leaf", "nether:fruit_leaf", "nether:fruit_leaf"},
		{"nether:fruit_leaf", "nether:fruit_leaf", "nether:fruit_leaf"},
	}
})

minetest.register_craft({
	output = "nether:pick_mushroom",
	recipe = {
		{"nether:shroom_head", "nether:shroom_head", "nether:shroom_head"},
		{"", "nether:shroom_stem", ""},
		{"", "nether:shroom_stem", ""},
	}
})

minetest.register_craft({
	output = "nether:pick_wood",
	recipe = {
		{"nether:wood_cooked", "nether:wood_cooked", "nether:wood_cooked"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

for _,m in pairs({"netherrack", "netherrack_blue", "white"}) do
	local input = "nether:"..m

	minetest.register_craft({
		output = "nether:pick_"..m,
		recipe = {
			{input, input, input},
			{"", "group:stick", ""},
			{"", "group:stick", ""},
		}
	})

	minetest.register_craft({
		output = "nether:axe_"..m,
		recipe = {
			{input, input},
			{input, "group:stick"},
			{"", "group:stick"},
		}
	})

	minetest.register_craft({
		output = "nether:sword_"..m,
		recipe = {
			{input},
			{input},
			{"group:stick"},
		}
	})

	minetest.register_craft({
		output = "nether:shovel_"..m,
		recipe = {
			{input},
			{"group:stick"},
			{"group:stick"},
		}
	})
end

minetest.register_craft({
	output = "nether:netherrack_brick 4",
	recipe = {
		{"nether:netherrack", "nether:netherrack"},
		{"nether:netherrack", "nether:netherrack"},
	}
})

minetest.register_craft({
	output = "nether:netherrack_brick_black 4",
	recipe = {
		{"nether:netherrack_black", "nether:netherrack_black"},
		{"nether:netherrack_black", "nether:netherrack_black"},
	}
})

minetest.register_craft({
	output = "nether:netherrack_brick_blue 4",
	recipe = {
		{"nether:netherrack_blue", "nether:netherrack_blue"},
		{"nether:netherrack_blue", "nether:netherrack_blue"},
	}
})

minetest.register_craft({
	output = "default:furnace",
	recipe = {
		{"nether:netherrack_brick", "nether:netherrack_brick", "nether:netherrack_brick"},
		{"nether:netherrack_brick", "", "nether:netherrack_brick"},
		{"nether:netherrack_brick", "nether:netherrack_brick", "nether:netherrack_brick"},
	}
})

minetest.register_craft({
	output = "nether:extractor",
	recipe = {
		{"nether:netherrack_brick", "nether:blood_top_cooked", "nether:netherrack_brick"},
		{"nether:blood_cooked", "nether:shroom_stem", "nether:blood_cooked"},
		{"nether:netherrack_brick", "nether:blood_stem_cooked", "nether:netherrack_brick"},
	}
})

minetest.register_craft({
	output = "nether:wood 4",
	recipe = {
		{"nether:blood_stem"},
	}
})

minetest.register_craft({
	output = "nether:wood_empty 4",
	recipe = {
		{"nether:blood_stem_empty"},
	}
})

minetest.register_craft({
	output = "nether:stick 4",
	recipe = {
		{"nether:wood_empty"},
	}
})

minetest.register_craft({
	output = "nether:forest_wood",
	recipe = {
		{"nether:forest_planks", "nether:forest_planks", "nether:forest_planks"},
		{"nether:forest_planks", "", "nether:forest_planks"},
		{"nether:forest_planks", "nether:forest_planks", "nether:forest_planks"},
	}
})

minetest.register_craft({
	output = "nether:forest_planks 8",
	recipe = {
		{"nether:forest_wood"},
	}
})

minetest.register_craft({ --crafting bad here, needs to become changed
	output = "nether:forest_planks 7",
	recipe = {
		{"nether:tree"},
	},
	replacements = {{"nether:tree", "nether:bark 4"}},
})

minetest.register_craft({
	output = "default:paper",
	recipe = {
		{"nether:grass_dried", "nether:grass_dried", "nether:grass_dried"},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "default:coal",
	recipe = "nether:tree",
})

minetest.register_craft({
	type = "cooking",
	output = "nether:grass_dried",
	recipe = "nether:grass",
})

minetest.register_craft({
	type = "cooking",
	output = "nether:pearl",
	recipe = "nether:fim",
})

minetest.register_craft({
	type = "cooking",
	output = "nether:hotbed",
	recipe = "nether:blood_extracted",
})

for  _,i in ipairs({"nether:blood", "nether:blood_top", "nether:blood_stem", "nether:wood"}) do
	local cooked = i.."_cooked"

	minetest.register_craft({
		type = "cooking",
		output = cooked,
		recipe = i,
	})

	minetest.register_craft({
		type = "fuel",
		recipe = cooked,
		burntime = 30,
	})
end
