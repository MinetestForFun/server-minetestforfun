------------------
-- PClasses' API
--

-- Various utility functions

-- Register the class (basic registration)
function pclasses.api.register_class(cname, def)
	if not cname then
		minetest.log("error", "[PClasses] Error registering unamed class")
		return
	elseif not def then
		minetest.log("error", "[PClasses] Error registering class " ..
			cname .. ". Reason : no definition table.")
		return
	end
	if cname == "infos" then
	   minetest.log("error", "[PClasses] Error registering class with reserved name : infos")
	   return
	end
	pclasses.register_class_switch(cname, def.switch_params)

	pclasses.classes[cname] = def
	return true
end

------------------------
-- Getters and Setters
--

-- Get class specs by name
function pclasses.api.get_class_by_name(cname)
	return pclasses.classes[cname]
end


-- Get single player
function pclasses.api.get_player_class(pname)
	return pclasses.data.players[pname]
end

-- Get all players for a class
function pclasses.api.get_class_players(cname)
	local pnames = {}
	if pclasses.api.get_class_by_name(cname) then
		for p,c in ipairs(pclasses.data.players) do
			if c == cname then
				table.insert(pnames, table.getn(pnames)+1)
			end
		end
	end
end

-- Set single player
function pclasses.api.set_player_class(pname, cname, inform)
	if pclasses.api.get_class_by_name(cname) then
		if pclasses.api.get_player_class(pname) then
			pclasses.api.get_class_by_name(pclasses.api.get_player_class(pname)).on_unassigned(pname)
		end
		pclasses.data.players[pname] = cname
		pclasses.api.get_class_by_name(cname).on_assigned(pname, inform)
	
		local ref = minetest.get_player_by_name(pname)
		local armor_inv = minetest.get_inventory({type = "detached", name = pname .. "_armor"})
		local inv = ref:get_inventory()
		vacuum_inventory(pname, inv, "armor", true)
		vacuum_inventory(pname, armor_inv, "armor", false) -- Don't move to the graveyard
		armor:set_player_armor(ref)
		armor:update_inventory(ref)

		pclasses.api.vacuum_graveyard(minetest.get_player_by_name(pname))
		return true
	end
	return false
end

-- Util function(s)

pclasses.api.util.does_wear_full_armor = function(pname, material, noshield)
	local inv = minetest.get_inventory({type = "detached", name = pname .. "_armor"})
	if not inv or inv:is_empty("armor") then
		return false
	end
	local full_armor = true
	for _, piece in pairs({"chestplate", "leggings", "boots", "helmet"}) do
		full_armor = full_armor and inv:contains_item("armor", "3d_armor:" .. piece .. "_" .. material)
	end
	return full_armor and (inv:contains_item("armor", "shields:shield_" .. material) or noshield)
end

function pclasses.api.util.can_have_item(pname, itemname)
	if not pclasses.data.reserved_items[itemname] or (pclasses.conf.superuser_class and pclasses.api.get_player_class(pname) == pclasses.conf.superuser_class) then
		return true
	end
	for index, class in pairs(pclasses.data.reserved_items[itemname]) do
		if pclasses.api.get_player_class(pname) == class then
			return true
		end
	end
	return false
end

function pclasses.api.util.on_update(pname)
	local cname = pclasses.api.get_player_class(pname)
	if cname ~= nil and pclasses.api.get_class_by_name(cname) and pclasses.api.get_class_by_name(cname).on_update then
		pclasses.api.get_class_by_name(cname).on_update(pname)
	end
end

-- TEMPORARY CLASS SHIFT SYSTEM
-- Used to test on local servers
--

minetest.register_privilege("class_shifter", "Able to shift between classes")

minetest.register_chatcommand("switch_class", {
	args = "<class>",
	privs = {class_shifter = true},
	func = function(name, param)
		pclasses.api.set_player_class(name, param)
	end
})

-------------------
-- Reserved items
--
function pclasses.api.reserve_item(cname, itemstring)
	pclasses.data.reserved_items[itemstring] = pclasses.data.reserved_items[itemstring] or {}
	table.insert(pclasses.data.reserved_items[itemstring], cname)
end


-------------------------------------------
-- Determination and reserved items tick --
-------------------------------------------

function vacuum_inventory(name, inv, invname, bury)
	local ref = minetest.get_player_by_name(name)
	for i = 1, inv:get_size(invname) do
		local stack = inv:get_stack(invname, i)
		if pclasses.data.reserved_items[stack:get_name()] then
			if not pclasses.api.util.can_have_item(name, stack:get_name()) then
				inv:set_stack(invname, i, "")
				if bury then
					local grave_inv = pclasses.api.create_graveyard_inventory(ref)
					if grave_inv and grave_inv:room_for_item("graveyard", stack) then
						grave_inv:add_item("graveyard", stack)
						inv:add_item("graveyard", stack)
						-- ^ Because add_item doesn't trigger on_put, nonsense
					else
						minetest.add_item(ref:getpos(), stack)
					end
				end
			end
		end
	end
end

local function tick()
	for id, ref in ipairs(minetest.get_connected_players()) do
		local name = ref:get_player_name()
		local inv = ref:get_inventory()
		vacuum_inventory(name, inv, "main", true)
	end
	minetest.after(2, tick)
end

tick()
