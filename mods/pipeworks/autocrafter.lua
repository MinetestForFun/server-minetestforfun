local autocrafterCache = {}  -- caches some recipe data to avoid to call the slow function minetest.get_craft_result() every second

local function make_inventory_cache(invlist)
	local l = {}
	for _, stack in ipairs(invlist) do
		l[stack:get_name()] = (l[stack:get_name()] or 0) + stack:get_count()
	end
	return l
end

local function autocraft(inventory, pos)
	local recipe = inventory:get_list("recipe")
	local recipe_last
	local result
	local new

	if autocrafterCache[minetest.hash_node_position(pos)] == nil then
		recipe_last = {}
		for i = 1, 9 do
			recipe_last[i] = recipe[i]
			recipe[i] = ItemStack({name = recipe[i]:get_name(), count = 1})
		end
		result, new = minetest.get_craft_result({method = "normal", width = 3, items = recipe})
		autocrafterCache[minetest.hash_node_position(pos)] = {["recipe"] = recipe, ["result"] = result, ["new"] = new}
	else
		local autocrafterCacheEntry = autocrafterCache[minetest.hash_node_position(pos)]
		recipe_last = autocrafterCacheEntry["recipe"]
		result = autocrafterCacheEntry["result"]
		new = autocrafterCacheEntry["new"]
		local recipeUnchanged = true
		for i = 1, 9 do
			if recipe[i]:get_name() ~= recipe_last[i]:get_name() then
				recipeUnchanged = false
				break
			end
			if recipe[i]:get_count() ~= recipe_last[i]:get_count() then
				recipeUnchanged = false
				break
			end
		end
		if recipeUnchanged then
		else
			for i = 1, 9 do
					recipe_last[i] = recipe[i]
					recipe[i] = ItemStack({name = recipe[i]:get_name(), count = 1})
			end
			result, new = minetest.get_craft_result({method = "normal", width = 3, items = recipe})
			autocrafterCache[minetest.hash_node_position(pos)] = {["recipe"] = recipe, ["result"] = result, ["new"] = new}
		end
	end

	if result.item:is_empty() then return end
	result = result.item
	if not inventory:room_for_item("dst", result) then return end
	local to_use = {}
	for _, item in ipairs(recipe) do
		if item~= nil and not item:is_empty() then
			if to_use[item:get_name()] == nil then
				to_use[item:get_name()] = 1
			else
				to_use[item:get_name()] = to_use[item:get_name()]+1
			end
		end
	end
	local invcache = make_inventory_cache(inventory:get_list("src"))
	for itemname, number in pairs(to_use) do
		if (not invcache[itemname]) or invcache[itemname] < number then return end
	end
	for itemname, number in pairs(to_use) do
		for i = 1, number do -- We have to do that since remove_item does not work if count > stack_max
			inventory:remove_item("src", ItemStack(itemname))
		end
	end
	inventory:add_item("dst", result)
	for i = 1, 9 do
		inventory:add_item("dst", new.items[i])
	end
end

local function update_autocrafter(pos)
	local meta = minetest.get_meta(pos)
	if meta:get_string("virtual_items") == "" then
		meta:set_string("virtual_items", "1")
		local inv = meta:get_inventory()
		for _, stack in ipairs(inv:get_list("recipe")) do
			minetest.item_drop(stack, "", pos)
		end
	end
end

minetest.register_node("pipeworks:autocrafter", {
	description = "Autocrafter", 
	drawtype = "normal", 
	tiles = {"pipeworks_autocrafter.png"}, 
	groups = {snappy = 3, tubedevice = 1, tubedevice_receiver = 1}, 
	tube = {insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("src", stack)
		end, 
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("src", stack)
		end, 
		input_inventory = "dst", 
		connect_sides = {left = 1, right = 1, front = 1, back = 1, top = 1, bottom = 1}}, 
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,11]"..
				"list[current_name;recipe;0,0;3,3;]"..
				"list[current_name;src;0,3.5;8,3;]"..
				"list[current_name;dst;4,0;4,3;]"..
				"list[current_player;main;0,7;8,4;]")
		meta:set_string("infotext", "Autocrafter")
		meta:set_string("virtual_items", "1")
		local inv = meta:get_inventory()
		inv:set_size("src", 3*8)
		inv:set_size("recipe", 3*3)
		inv:set_size("dst", 4*3)
	end,
	on_punch = update_autocrafter,
	can_dig = function(pos, player)
		update_autocrafter(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return (inv:is_empty("src") and inv:is_empty("dst"))
	end, 
	after_place_node = function(pos)
		pipeworks.scan_for_tube_objects(pos)
	end,
	after_dig_node = function(pos)
		pipeworks.scan_for_tube_objects(pos)
		autocrafterCache[minetest.hash_node_position(pos)] = nil
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		update_autocrafter(pos)
		local inv = minetest.get_meta(pos):get_inventory()
		if listname == "recipe" then
			local stack_copy = ItemStack(stack)
			stack_copy:set_count(1)
			inv:set_stack(listname, index, stack_copy)
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		update_autocrafter(pos)
		local inv = minetest.get_meta(pos):get_inventory()
		if listname == "recipe" then
			inv:set_stack(listname, index, ItemStack(""))
			return 0
		else
			return stack:get_count()
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		update_autocrafter(pos)
		local inv = minetest.get_meta(pos):get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		stack:set_count(count)
		if from_list == "recipe" then
			inv:set_stack(from_list, from_index, ItemStack(""))
			return 0
		elseif to_list == "recipe" then
			local stack_copy = ItemStack(stack)
			stack_copy:set_count(1)
			inv:set_stack(to_list, to_index, stack_copy)
			return 0
		else
			return stack:get_count()
		end
	end,
})

minetest.register_abm({nodenames = {"pipeworks:autocrafter"}, interval = 1, chance = 1, 
			action = function(pos, node)
				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()
				autocraft(inv, pos)
			end
})
