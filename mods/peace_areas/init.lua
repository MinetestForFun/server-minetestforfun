--
-- Peaceful areas
-- Where hitting is impossible
--

peace_areas = {areas = {}}

function is_in_peace_area(player)
	local pos = player:getpos() 
	if pos == nil then return false end
	for name, positions in pairs(peace_areas.areas) do
		local pos1 = positions["pos1"]
		local pos2 = positions["pos2"]
		local minp = {
			x = math.min(pos1.x, pos2.x),
			y = math.min(pos1.y, pos2.y),
			z = math.min(pos1.z, pos2.z)
		}
		local maxp = {
			x = math.max(pos1.x, pos2.x),
			y = math.max(pos1.y, pos2.y),
			z = math.max(pos1.z, pos2.z)
		}
		if minp.x < pos.x and pos.x < maxp.x and
			minp.y < pos.y and pos.y < maxp.y and
			minp.z < pos.z and pos.z < maxp.z then
			return true
		end
	end
	return false
end

function peace_area(pos)
	for name, positions in pairs(peace_areas.areas) do
		local pos1 = positions["pos1"]
		local pos2 = positions["pos2"]
		local minp = {
			x = math.min(pos1.x, pos2.x),
			y = math.min(pos1.y, pos2.y),
			z = math.min(pos1.z, pos2.z)
		}
		local maxp = {
			x = math.max(pos1.x, pos2.x),
			y = math.max(pos1.y, pos2.y),
			z = math.max(pos1.z, pos2.z)
		}
		if minp.x < pos.x and pos.x < maxp.x and
			minp.y < pos.y and pos.y < maxp.y and
			minp.z < pos.z and pos.z < maxp.z then
			return name
		end
	end
end

minetest.register_on_punchplayer(function(player, hitter)
	if is_in_peace_area(player) and hitter:is_player() then
		minetest.chat_send_player(hitter:get_player_name(), "You cannot punch player " ..
			player:get_player_name() .. ". They are in area '" .. peace_area(player:getpos()) .. "'.")
		return true
		--[[
		Note:
			This use of the callback register_on_punchplayer may prevent other
			instance of it to work correctly. Please take note of it.
		]]--
	end
end)

function peace_areas.register_area(area_name, def)
	peace_areas.areas[area_name] = def
end

peace_areas.register_area("spawn", {
	["pos1"] = {x = 16, y = 0, z = 12},
	["pos2"] = {x = 42, y = 100, z = -14},
})
