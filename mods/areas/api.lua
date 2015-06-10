
--plants to place in openfarming
local plants = { ["farming:blueberries"]=1, ["farming:carrot"]=1, ["farming:coffee_beans"]=1, ["farming:corn"]=1, ["farming:cucumber"]=1,
				 ["farming:melon_slice"]=1, ["farming:potato"]=1, ["farming:pumpkin_slice"]=1, ["farming:raspberries"]=1, ["farming:rhubarb"]=1,
				 ["farming:tomato"]=1, ["farming:seed_cotton"]=1, ["farming:seed_wheat"]=1,["default:papyrus"]=1
				}

--tools to dig in openfarming
local in_hand = { ["hand"]=1, ["mobs:shears"]=1,
				  ["default:sword_bronze"]=1, ["default:sword_diamond"]=1, ["default:sword_gold"]=1, ["default:sword_mese"]=1, ["default:sword_nyan"]=1,
				  ["default:sword_steel"]=1, ["default:sword_stone"]=1, ["default:sword_wood"]=1, ["moreores:sword_mithril"]=1, ["moreores:sword_silver"]=1,
				  ["nether:sword_netherrack"]=1, ["nether:sword_netherrack_blue"]=1, ["nether:sword_white"]=1,
				  ["default:axe_bronze"]=1, ["default:axe_diamond"]=1, ["default:axe_gold"]=1, ["default:axe_mese"]=1, ["default:axe_nyan"]=1,
				  ["default:axe_steel"]=1, ["default:axe_stone"]=1, ["default:axe_wood"]=1, ["moreores:axe_mithril"]=1, ["moreores:axe_silver"]=1,
				  ["nether:axe_netherrack"]=1, ["nether:axe_netherrack_blue"]=1, ["nether:axe_white"]=1
				}


-- Returns a list of areas that include the provided position
function areas:getAreasAtPos(pos)
	local a = {}
	local px, py, pz = pos.x, pos.y, pos.z
	for id, area in pairs(self.areas) do
		local ap1, ap2 = area.pos1, area.pos2
		if px >= ap1.x and px <= ap2.x and
		   py >= ap1.y and py <= ap2.y and
		   pz >= ap1.z and pz <= ap2.z then
			a[id] = area
		end
	end
	return a
end

-- Checks if the area is unprotected or owned by you
function areas:canInteract(pos, name)
	if minetest.check_player_privs(name, self.adminPrivs) then
		return true
	end
	local owned = false
		if pos == nil  then return not owned end -- pour éviter crash avec nénuphar
	for _, area in pairs(self:getAreasAtPos(pos)) do
		if area.owner == name or area.open then
			return true
		elseif area.openfarming then
			-- if area is openfarming
			local node = minetest.get_node(pos).name
			if not minetest.registered_nodes[node] then return false end
			local player = minetest.get_player_by_name(name)
			if not player then return false end
			local wstack = player:get_wielded_item():get_name()
			if wstack == "" then wstack = "hand" end

			--on_place
			if node == "air" and plants[wstack] ~= nil then
				return true
			end

			--on_dig
			if minetest.get_item_group(node, "plant") == 1 and in_hand[wstack] ~= nil then
				return true
			end

			owned = true
		else
			owned = true
		end
	end
	return not owned
end

-- Returns a table (list) of all players that own an area
function areas:getNodeOwners(pos)
	local owners = {}
	for _, area in pairs(self:getAreasAtPos(pos)) do
		table.insert(owners, area.owner)
	end
	return owners
end

--- Checks if the area intersects with an area that the player can't interact in.
-- Note that this fails and returns false when the specified area is fully
-- owned by the player, but with multiple protection zones, none of which
-- cover the entire checked area.
-- @param name (optional) player name.  If not specified checks for any intersecting areas.
-- @param allow_open Whether open areas should be counted as is they didn't exist.
-- @return Boolean indicating whether the player can interact in that area.
-- @return Un-owned intersecting area id, if found.
function areas:canInteractInArea(pos1, pos2, name, allow_open)
	if name and minetest.check_player_privs(name, self.adminPrivs) then
		return true
	end
	areas:sortPos(pos1, pos2)
	-- First check for a fully enclosing owned area.
	if name then
		for id, area in pairs(self.areas) do
			-- A little optimization: isAreaOwner isn't necessary
			-- here since we're iterating through all areas.
			if area.owner == name and
					self:isSubarea(pos1, pos2, id) then
				return true
			end
		end
	end
	-- Then check for intersecting (non-owned) areas.
	for id, area in pairs(self.areas) do
		local p1, p2 = area.pos1, area.pos2
		if (p1.x <= pos2.x and p2.x >= pos1.x) and
		   (p1.y <= pos2.y and p2.y >= pos1.y) and
		   (p1.z <= pos2.z and p2.z >= pos1.z) then
			-- Found an intersecting area.
			-- Return if the area is closed or open areas aren't
			-- allowed, and the area isn't owned.
			if (not allow_open or not area.open) and
					(not name or not areas:isAreaOwner(id, name)) then
				return false, id
			end
		end
	end
	return true
end

