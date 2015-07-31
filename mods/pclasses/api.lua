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
	pclasses.register_class_switch_orb(cname, def.orb_color)

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
function pclasses.api.set_player_class(pname, cname)
	if pclasses.api.get_class_by_name(cname) then
		if pclasses.api.get_player_class(pname) ~= cname then
			if pclasses.api.get_player_class(pname) and pclasses.classes[pclasses.api.get_player_class(pname)].on_unassigned then
				pclasses.api.get_class_by_name(pclasses.api.get_player_class(pname)).on_unassigned(pname)
			end
			pclasses.data.players[pname] = cname
			pclasses.api.get_class_by_name(cname).on_assigned(pname)
		end
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

local function tick()
	for id, ref in ipairs(minetest.get_connected_players()) do
		local name = ref:get_player_name()
		local inv = minetest.get_inventory({type="player", name = name})
		for i = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if pclasses.data.reserved_items[stack:get_name()] then
				local drop_stack = true
				for index, class in pairs(pclasses.data.reserved_items[stack:get_name()]) do
					if pclasses.api.get_player_class(name) == class then
						drop_stack = false
					end
				end
				if drop_stack then
					inv:set_stack("main", i, "")
					local pos = ref:getpos()
					pos.y = pos.y+2
					pos.x = pos.x + math.random(-6,6)
					pos.z = pos.z + math.random(-6,6)
					minetest.after(1, function()
						local item = minetest.add_item(pos, stack)
						if item then
							item:setvelocity({x = math.random(-5,5), y = math.random(1,7), z = math.random(-5,5)})
						end
					end)
				end
			end
		end
	end
	minetest.after(2, tick)
end

tick()