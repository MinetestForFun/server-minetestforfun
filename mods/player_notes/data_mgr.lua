-- Created by Krock
-- License: WTFPL

player_notes.load_data = function()
	local file = io.open(player_notes.data_file, "r")
	if not file then
		return
	end
	for line in file:lines() do
		if line ~= "" then
			local data = string.split(line, "|")
			--[1] player_name, [2] key 1, [3] notice 1, [?] key X, [?+1] notice X
			if #data > 1 then
				player_notes.player[data[1]] = {}
				local index = 2
				while index <= #data do
					if data[index] ~= "" then
						-- if not empty
						player_notes.player[data[1]][data[index]] = data[index + 1]
					end
					index = index + 2
				end
			end
		end
	end
	io.close(file)
end

-- Load late, because not much used
minetest.after(3, player_notes.load_data)

player_notes.save_data = function()
	local file = io.open(player_notes.data_file, "w")
	for player, notes in pairs(player_notes.player) do
		local str = ""
		for key, _note in pairs(notes) do
			local note = string.gsub(_note, "|", "/")
			str = str..key.."|"..note.."|"
		end
		if string.len(str) > 2 then
			file:write(player.."|"..str.."\n")
		end
	end
	io.close(file)
end

player_notes.add_note = function(name, target, note)
	if not name or not target or not note then
		return "ERROR: Name, target or note == NIL"
	end
	if not minetest.auth_table[target] then
		return "Unknown player: "..target
	end
	if string.len(note) < 2 or string.len(note) > 60 then
		return "Note is too short or too long to add. Sorry."
	end
	if not player_notes.player[target] then
		player_notes.player[target] = {}
	end
	-- generate random key
	local key = tostring(math.random(player_notes.key_min, player_notes.key_max))
	if player_notes.enable_timestamp ~= "" then
		player_notes.player[target][key] = "<"..name.." ("..os.date(player_notes.enable_timestamp)..")> "..note
	else
		player_notes.player[target][key] = "<"..name.."> "..note
	end
	return nil
end

player_notes.rm_note = function(target, key)
	if not target or not key then
		return "ERROR: Target or key == NIL"
	end
	if not player_notes.player[target] then
		return "Player has no notes so far."
	end
	-- must be unique key
	key = tonumber(key)
	if not key then
		return "Key must be a number!"
	end
	if not player_notes.player[target][tostring(key)] then
		return "Key does not exist. Can not remove unknown note."
	end
	player_notes.player[target][tostring(key)] = nil
	local delete = true
	for key, note in pairs(player_notes.player[target]) do
		if string.len(note) > 2 then
			delete = false
			break
		end
	end
	-- remove empty players
	if delete then
		player_notes.player[target] = nil
	end
	return nil
end