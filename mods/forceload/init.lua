local _pts = minetest.pos_to_string
function minetest.pos_to_string(pos)
	if not pos then
		return "(-,-,-)"
	end
	return _pts(pos)
end

-- Makes sure that force load areas are handled correctly
function ForceloadManager(filetoopen, hide_file_errors)
	local blocks = {}
	if filetoopen ~= nil then
		local file = io.open(filetoopen, "r")
		if file then
			local table = minetest.deserialize(file:read("*all"))
			file:close()
			if type(table) == "table" then
				blocks = table
			end
		elseif not hide_file_errors then
			minetest.log("error", "File "..filetoopen.." does not exist!")
		end
	end
	for i = 1, #blocks do
		if not minetest.forceload_block(blocks[i]) then			
			minetest.log("error", "Failed to load block " .. minetest.pos_to_string(blocks[i]))
		end
	end
	return {
		_blocks = blocks,
		load = function(self, pos)
			if minetest.forceload_block(pos) then
				table.insert(self._blocks, vector.new(pos))
				return true
			end
			minetest.log("error", "Failed to load block " .. minetest.pos_to_string(pos))
			return false
		end,
		unload = function(self, pos)
			for i = 1, #self._blocks do
				if vector.equals(pos, self._blocks[i]) then					
					minetest.forceload_free_block(pos)
					table.remove(self._blocks, i)
					return true
				end
			end
			return false
		end,
		save = function(self, filename)
			local file = io.open(filename, "w")
			if file then
				file:write(minetest.serialize(self._blocks))
				file:close()
			end
		end,
		verify = function(self)
			return self:verify_each(function(pos, block)				
				local name = "ignore"
				if block ~= nil then
					name = block.name
				end

				if name == "ignore" then	
					if not pos.last or elapsed_time > pos.last + 15 then
						pos.last = elapsed_time
						if not minetest.forceload_block(pos) then							
							minetest.log("error", "Failed to force load " .. minetest.pos_to_string(pos))
							pos.remove = true
						end
					end
					return false
				elseif name == "forceload:anchor" then
					pos.last = elapsed_time
					return true
				else	
					minetest.log("error", minetest.pos_to_string(pos) .. " shouldn't be loaded")
					pos.remove = true
					return false		
				end
			end)
		end,
		verify_each = function(self, func)
			local not_loaded = {}			
			for i = 1, #self._blocks do
				local res = minetest.get_node(self._blocks[i])
				if not func(self._blocks[i], res) then
					--[[table.insert(not_loaded, {
						pos = self._blocks[i],
						i = i,
						b = res })]]--
				end
			end
			return not_loaded
		end,
		clean = function(self)
			local i = 1
			while i <= #self._blocks do
				if self._blocks[i].remove then
					minetest.forceload_free_block(self._blocks[i])
					table.remove(self._blocks, i)
				else
					i = i + 1
				end
			end
		end
	}
end

local flm = ForceloadManager(minetest.get_worldpath().."/flm.json", true)

minetest.register_privilege("forceload", "Allows players to use forceload block anchors")

minetest.register_node("forceload:anchor",{
	description = "Block Anchor",
	walkable = false,
	tiles = {"forceload_anchor.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	after_destruct = function(pos)
		flm:unload(pos)
		flm:save(minetest.get_worldpath().."/flm.json")
	end,
	after_place_node = function(pos, placer)
		if not minetest.check_player_privs(placer:get_player_name(),
				{forceload = true}) then
			minetest.chat_send_player(placer:get_player_name(), "The forceload privilege is required to do that.")
		elseif flm:load(pos) then			
			flm:save(minetest.get_worldpath().."/flm.json")
			return
		end		
		minetest.set_node(pos, {name="air"})
		return true
	end
})

minetest.register_craft({
	output = "forceload:anchor",
	recipe = {
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
		{"default:mese_crystal", "wool:blue", "default:mese_crystal"},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"}
	}
})

local elapsed_time = 0
local count = 0
minetest.register_globalstep(function(dtime)
	count = count + dtime
	elapsed_time = elapsed_time + dtime
	if count > 5 then
		count = 0
		--print("Verifying...")
		flm:verify()
		flm:clean()
	end
end)

