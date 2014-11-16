
-- Redefine grass and dirt nodes

minetest.override_item("default:dirt", {
	drop = {
		max_items = 2,
		items = {
			{
				items = {"mushroom:spore1"},
				rarity = 40,
			},
			{
				items = {"mushroom:spore2"},
				rarity = 40,
			},
			{
				items = {"default:dirt"},
			}
		}
	}
})

minetest.override_item("default:dirt_with_grass", {
	drop = {
		max_items = 2,
		items = {
			{
				items = {"mushroom:spore1"},
				rarity = 40,
			},
			{
				items = {"mushroom:spore2"},
				rarity = 40,
			},
			{
				items = {"default:dirt"},
			}
		}
	}
})

