local autocrafterCache = {}  -- caches some recipe data to avoid to call the slow function minetest.get_craft_result() every second

local craft_time = 1

local function count_index(invlist)
	local index = {}
	for _, stack in pairs(invlist) do
		if not stack:is_empty() then
			local stack_name = stack:get_name()
			index[stack_name] = (index[stack_name] or 0) + stack:get_count()
		end
	end
	return index
end

local function get_item_info(stack)
	local name = stack:get_name()
	local def = minetest.registered_items[name]
	local description = def and def.description or "Unknown item"
	return description, name
end

local function get_craft(pos, inventory, hash)
	local hash = hash or minetest.hash_node_position(pos)
	local craft = autocrafterCache[hash]
	if not craft then
		local recipe = inventory:get_list("recipe")
		local output, decremented_input = minetest.get_craft_result({method = "normal", width = 3, items = recipe})
		craft = {recipe = recipe, consumption=count_index(recipe), output = output, decremented_input = decremented_input}
		autocrafterCache[hash] = craft
	end
	return craft
end

local function autocraft(inventory, craft)
	if not craft then return false end
	local output_item = craft.output.item

	-- check if we have enough room in dst
	if not inventory:room_for_item("dst", output_item) then	return false end
	local consumption = craft.consumption
	local inv_index = count_index(inventory:get_list("src"))
	-- check if we have enough material available
	for itemname, number in pairs(consumption) do
		if (not inv_index[itemname]) or inv_index[itemname] < number then return false end
	end
	-- consume material
	for itemname, number in pairs(consumption) do
		for i = 1, number do -- We have to do that since remove_item does not work if count > stack_max
			inventory:remove_item("src", ItemStack(itemname))
		end
	end

	-- craft the result into the dst inventory and add any "replacements" as well
	inventory:add_item("dst", output_item)
	for i = 1, 9 do
		inventory:add_item("dst", craft.decremented_input.items[i])
	end
	return true
end

-- returns false to stop the timer, true to continue running
-- is started only from start_autocrafter(pos) after sanity checks and cached recipe
local function run_autocrafter(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local inventory = meta:get_inventory()
	local craft = get_craft(pos, inventory)
	local output_item = craft.output.item
	-- only use crafts that have an actual result
	if output_item:is_empty() then
		meta:set_string("infotext", "unconfigured Autocrafter: unknown recipe")
		return false
	end

	for step = 1, math.floor(elapsed/craft_time) do
		local continue = autocraft(inventory, craft)
		if not continue then return false end
	end
	return true
end

local function start_crafter(pos)
	local meta = minetest.get_meta(pos)
	if meta:get_int("enabled") == 1 then
		local timer = minetest.get_node_timer(pos)
		if not timer:is_started() then
			timer:start(craft_time)
		end
	end
end

local function after_inventory_change(pos)
	start_crafter(pos)
end

-- note, that this function assumes allready being updated to virtual items
-- and doesn't handle recipes with stacksizes > 1
local function after_recipe_change(pos, inventory)
	local meta = minetest.get_meta(pos)
	-- if we emptied the grid, there's no point in keeping it running or cached
	if inventory:is_empty("recipe") then
		minetest.get_node_timer(pos):stop()
		autocrafterCache[minetest.hash_node_position(pos)] = nil
		meta:set_string("infotext", "unconfigured Autocrafter")
		return
	end
	local recipe_changed = false
	local recipe = inventory:get_list("recipe")

	local hash = minetest.hash_node_position(pos)
	local craft = autocrafterCache[hash]

	if craft then
		-- check if it changed
		local cached_recipe = craft.recipe
		for i = 1, 9 do
			if recipe[i]:get_name() ~= cached_recipe[i]:get_name() then
				autocrafterCache[hash] = nil -- invalidate recipe
				craft = nil
				break
			end
		end
	end

	craft = craft or get_craft(pos, inventory, hash)
	local output_item = craft.output.item
	local description, name = get_item_info(output_item)
	meta:set_string("infotext", string.format("'%s' Autocrafter (%s)", description, name))
	inventory:set_stack("output", 1, output_item)

	after_inventory_change(pos)
end

-- clean out unknown items and groups, which would be handled like unknown items in the crafting grid
-- if minetest supports query by group one day, this might replace them
-- with a canonical version instead
local function normalize(item_list)
	for i = 1, #item_list do
		local name = item_list[i]
		if not minetest.registered_items[name] then
			item_list[i] = ""
		end
	end
	return item_list
end

local function on_output_change(pos, inventory, stack)
	if not stack then
		inventory:set_list("output", {})
		inventory:set_list("recipe", {})
	else
		local input = minetest.get_craft_recipe(stack:get_name())
		if not input.items or input.type ~= "normal" then return end
		local items, width = normalize(input.items), input.width
		local item_idx, width_idx = 1, 1
		for i = 1, 9 do
			if width_idx <= width then
				inventory:set_stack("recipe", i, items[item_idx])
				item_idx = item_idx + 1
			else
				inventory:set_stack("recipe", i, ItemStack(""))
			end
			width_idx = (width_idx < 3) and (width_idx + 1) or 1
		end
		-- we'll set the output slot in after_recipe_change to the actual result of the new recipe
	end
	after_recipe_change(pos, inventory)
end

-- returns false if we shouldn't bother attempting to start the timer again after this
local function update_meta(meta, enabled)
	local state = enabled and "on" or "off"
	meta:set_int("enabled", enabled and 1 or 0)
	meta:set_string("formspec",
			"size[8,11]"..
			"list[context;recipe;0,0;3,3;]"..
			"image[3,1;1,1;gui_hb_bg.png^[colorize:#141318:255]"..
			"list[context;output;3,1;1,1;]"..
			"image_button[3,2;1,1;pipeworks_button_" .. state .. ".png;" .. state .. ";;;false;pipeworks_button_interm.png]" ..
			"list[context;src;0,3.5;8,3;]"..
			"list[context;dst;4,0;4,3;]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			default.get_hotbar_bg(0,7) ..
			"list[current_player;main;0,7;8,4;]" ..
			"listring[current_player;main]"..
			"listring[context;src]" ..
			"listring[context;dst]" ..
			"listring[current_player;main]"..
			"listring[context;recipe]" ..
			"listring[context;output]"
			)

	-- toggling the button doesn't quite call for running a recipe change check
	-- so instead we run a minimal version for infotext setting only
	-- this might be more written code, but actually executes less
	local output = meta:get_inventory():get_stack("output", 1)
	if output:is_empty() then -- doesn't matter if paused or not
		meta:set_string("infotext", "unconfigured Autocrafter")
		return false
	end

	local description, name = get_item_info(output)
	local infotext = enabled and string.format("'%s' Autocrafter (%s)", description, name)
				or string.format("paused '%s' Autocrafter", description)

	meta:set_string("infotext", infotext)
	return enabled
end

-- 1st version of the autocrafter had actual items in the crafting grid
-- the 2nd replaced these with virtual items, dropped the content on update and set "virtual_items" to string "1"
-- the third added an output inventory, changed the formspec and added a button for enabling/disabling
-- so we work out way backwards on this history and update each single case to the newest version
local function upgrade_autocrafter(pos, meta)
	local meta = meta or minetest.get_meta(pos)
	local inv = meta:get_inventory()

	if inv:get_size("output") == 0 then -- we are version 2 or 1
		inv:set_size("output", 1)
		-- migrate the old autocrafters into an "enabled" state
		update_meta(meta, true)

		if meta:get_string("virtual_items") == "1" then -- we are version 2
			-- we allready dropped stuff, so lets remove the metadatasetting (we are not being called again for this node)
			meta:set_string("virtual_items", "")
		else -- we are version 1
			local recipe = inv:get_list("recipe")
			if not recipe then return end
			for idx, stack in ipairs(recipe) do
				if not stack:is_empty() then
					minetest.add_item(pos, stack)
					stack:set_count(1)
					stack:set_wear(0)
					inv:set_stack("recipe", idx, stack)
				end
			end
		end

		-- update the recipe, cache, and start the crafter
		autocrafterCache[minetest.hash_node_position(pos)] = nil
		after_recipe_change(pos, inv)
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
			local added = inv:add_item("src", stack)
			after_inventory_change(pos)
			return added
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
		local inv = meta:get_inventory()
		inv:set_size("src", 3*8)
		inv:set_size("recipe", 3*3)
		inv:set_size("dst", 4*3)
		inv:set_size("output", 1)
		update_meta(meta, false)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		if not pipeworks.may_configure(pos, sender) then return end
		local meta = minetest.get_meta(pos)
		if fields.on then
			update_meta(meta, false)
			minetest.get_node_timer(pos):stop()
		elseif fields.off then
			if update_meta(meta, true) then
				start_crafter(pos)
			end
		end
	end,
	can_dig = function(pos, player)
		upgrade_autocrafter(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return (inv:is_empty("src") and inv:is_empty("dst"))
	end,
	after_place_node = pipeworks.scan_for_tube_objects,
	after_dig_node = function(pos)
		pipeworks.scan_for_tube_objects(pos)
	end,
	on_destruct = function(pos)
		autocrafterCache[minetest.hash_node_position(pos)] = nil
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if not pipeworks.may_configure(pos, player) then return 0 end
		upgrade_autocrafter(pos)
		local inv = minetest.get_meta(pos):get_inventory()
		if listname == "recipe" then
			stack:set_count(1)
			inv:set_stack(listname, index, stack)
			after_recipe_change(pos, inv)
			return 0
		elseif listname == "output" then
			on_output_change(pos, inv, stack)
			return 0
		end
		after_inventory_change(pos)
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if not pipeworks.may_configure(pos, player) then
			minetest.log("action", string.format("%s attempted to take from autocrafter at %s", player:get_player_name(), minetest.pos_to_string(pos)))
			return 0
		end
		upgrade_autocrafter(pos)
		local inv = minetest.get_meta(pos):get_inventory()
		if listname == "recipe" then
			inv:set_stack(listname, index, ItemStack(""))
			after_recipe_change(pos, inv)
			return 0
		elseif listname == "output" then
			on_output_change(pos, inv, nil)
			return 0
		end
		after_inventory_change(pos)
		return stack:get_count()
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if not pipeworks.may_configure(pos, player) then return 0 end
		upgrade_autocrafter(pos)
		local inv = minetest.get_meta(pos):get_inventory()
		local stack = inv:get_stack(from_list, from_index)

		if to_list == "output" then
			on_output_change(pos, inv, stack)
			return 0
		elseif from_list == "output" then
			on_output_change(pos, inv, nil)
			if to_list ~= "recipe" then
				return 0
			end -- else fall through to recipe list handling
		end

		if from_list == "recipe" or to_list == "recipe" then
			if from_list == "recipe" then
				inv:set_stack(from_list, from_index, ItemStack(""))
			end
			if to_list == "recipe" then
				stack:set_count(1)
				inv:set_stack(to_list, to_index, stack)
			end
			after_recipe_change(pos, inv)
			return 0
		end

		after_inventory_change(pos)
		return count
	end,
	on_timer = run_autocrafter
})

minetest.register_craft( {
	output = "pipeworks:autocrafter 2",
	recipe = {
	        { "default:steel_ingot", "default:mese_crystal", "default:steel_ingot" },
	        { "homedecor:plastic_sheeting", "default:steel_ingot", "homedecor:plastic_sheeting" },
	        { "default:steel_ingot", "default:mese_crystal", "default:steel_ingot" }
	},
})
