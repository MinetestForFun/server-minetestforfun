-- Raw Fish (Thanks to Altairas for her Fish image on DeviantArt)
minetest.register_craftitem("fishing:fish_raw", {
	description = "Raw Fish",
	inventory_image = "fish_raw.png",
	on_use = minetest.item_eat(2),
})

-- Cooked Fish
minetest.register_craftitem("fishing:fish_cooked", {
	description = "Cooked Fish",
	inventory_image = "fish_cooked.png",
	on_use = minetest.item_eat(5),
})

-- Worm
minetest.register_craftitem("fishing:worm", {
	description = "Worm",
	inventory_image = "worm.png",
})

-- Fishing Rod
minetest.register_craftitem("fishing:fishing_rod", {
	description = "Fishing Rod",
	inventory_image = "fishing_rod.png",
	stack_max = 1,
	liquids_pointable = true,
})

-- Fishing Rod (Baited)
minetest.register_craftitem("fishing:fishing_rod_baited", {
	description = "Baited Fishing Rod",
	inventory_image = "fishing_rod_baited.png",
	wield_image = "fishing_rod_wield.png",
	stack_max = 1,
	liquids_pointable = true,
	on_use = function (itemstack, user, pointed_thing)
		if pointed_thing and pointed_thing.under then
			local node = minetest.env:get_node(pointed_thing.under)
			if string.find(node.name, "default:water_source") then
				if math.random(1, 100) < 5 then
					local inv = user:get_inventory()
					if inv:room_for_item("main", {name="fishing:fish_raw"}) then
						inv:add_item("main", {name="fishing:fish_raw"})
						return {name="fishing:fishing_rod"}
					else
				minetest.chat_send_player(user:get_player_name(), "Your Fish Got Away! Inventory Too Full")
					end
				end
			end
		end
	end,
})

-- Fishing Rod
minetest.register_craft({
	output = "fishing:fishing_rod",
	recipe = {
			{"","","default:stick"},
			{"", "default:stick", "farming:string"},
			{"default:stick", "", "farming:string"},
		}
})

-- Sift through 4 Dirt Blocks to find Worm
minetest.register_craft({
	output = "fishing:worm",
	recipe = {
		{"default:dirt","default:dirt"},
		{"default:dirt","default:dirt"},
	}
})

-- Cooking Fish
minetest.register_craft({
	type = "cooking",
	output = "fishing:fish_cooked",
	recipe = "fishing:fish_raw",
	cooktime = 2,
})

-- Baiting Fishing Rod
minetest.register_craft({
	type = "shapeless",
	output = "fishing:fishing_rod_baited",
	recipe = {"fishing:fishing_rod", "fishing:worm"},
})
