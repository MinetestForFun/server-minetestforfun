--------------------------------------
-- Rollbacks, go Out of those FiLes!
-- ROFL
--

local filepath = minetest.get_worldpath() .. "/rollback/"
local patchsegs = 0
local patchtotp = 100

local function none(v)
	if not v or v == "None" then
		return nil
	else
		return v
	end
end

local function metaread(v)

--[[

	Eg. : channel-in="keyboard",channel-out="terminal",formspec="field[text;;${command}]"

]]

	if not v or v == "None" or v == "[]" then return nil end
	v = string.sub(v,2,string.len(v)-1)
	-- Meta extraction
	local cursor = 0
	local metas = {}
	while cursor <= string.len(v) do
		local key, value
		local keybeg, keyend, valbeg, valend = cursor, cursor, cursor, cursor

		keyend = string.find(v, "=\"", cursor)-1
		key = string.sub(v,keybeg,keyend)

		valbeg = keyend+3
		valend = (string.find(v, "\",", valbeg) or string.len(v))-1
		value = string.sub(v,valbeg,valend)

		cursor = valend+3
		metas[key] = value
	end
	return metas
end

local function parser(fields)

end

minetest.register_chatcommand("rofl", {
	description = "Save MFF",
	privs = {server = true},
	func = function(name, param)
		-- Alert
		minetest.chat_send_all("*** Server Freezing")

		-- The main loop
		local i = 0
		if tonumber(param) then
			i = tonumber(param)
		end
		local vm = minetest.get_voxel_manip()
		while true do
			local file = io.open(filepath .. "/database-output." .. i .. ".txt", "r")
			if not file then
				break
			end
			minetest.log("action", "[ROFL] Opened file database-output." .. i .. ".txt ... Extracting datas")
			-- [
			--	id=155,actor=Mg,type=1;
			--	list=None,index=None,add=None,stacknode=None,stackquantity=None,nodemeta=None;
			--	x=-18,y=29,z=31;
			--	newnode=air,newparam1=13,newparam2=None,newmeta=None
			-- ]
			for fields in file:lines() do
				local id = tonumber(string.sub(fields, string.find(fields, "id=")+string.len("id="), string.find(fields, ",actor")-1))
				local actor = string.sub(fields, string.find(fields, "actor=")+string.len("actor="), string.find(fields, ",type")-1)
				local action_type = tonumber(string.sub(fields, string.find(fields, "type=")+string.len("type="), string.find(fields, ";list")-1))

				local list = none(string.sub(fields, string.find(fields, "list=")+string.len("list="), string.find(fields, ",index")-1))
				local index = none(tonumber(string.sub(fields, string.find(fields, "index=")+string.len("index="), string.find(fields, ",add")-1)))
				local add = none(tonumber(string.sub(fields, string.find(fields, "add=")+string.len("add="), string.find(fields, ",stacknode")-1)))
				local stacknode = none(string.sub(fields, string.find(fields, "stacknode=")+string.len("stacknode="), string.find(fields, ",stackquantity")-1))
				local stackquantity = none(tonumber(string.sub(fields, string.find(fields, "stackquantity=")+string.len("stackquantity="), string.find(fields, ";x=")-1)))

				local x = none(tonumber(string.sub(fields, string.find(fields, ";x=")+string.len(";x="), string.find(fields, ",y=")-1)))
				local y = none(tonumber(string.sub(fields, string.find(fields, ",y=")+string.len(",y="), string.find(fields, ",z=")-1)))
				local z = none(tonumber(string.sub(fields, string.find(fields, ",z=")+string.len(",z="), string.find(fields, ";newnode=")-1)))

				local newnode = none(string.sub(fields, string.find(fields, "newnode=")+string.len("newnode="), string.find(fields, ",newparam1")-1))
				local newparam1 = none(tonumber(string.sub(fields, string.find(fields, "newparam1=")+string.len("newparam1="), string.find(fields, ",newparam2")-1)))
				local newparam2 = none(tonumber(string.sub(fields, string.find(fields, "newparam2=")+string.len("newparam2="), string.find(fields, ",newmeta=")-1)))
				local newmeta = none(metaread(string.sub(fields, string.find(fields, ",newmeta=")+string.len(",newmeta="), string.len(fields)-1)))

				minetest.log("action","[ROFL] Applying id = " .. id)
				if patchsegs % patchtotp == 0 then
					minetest.get_player_by_name(name):setpos({x = x, y = y, z = z})
					patchsegs = 0
				end
				if action_type == 1 then -- TYPE_SETNODE
					local forced = minetest.forceload_block({x = x, y = y, z = z})
					if forced then
						minetest.set_node({x = x, y = y, z = z}, {name = newnode, param1 = newparam1, param2 = newparam2})
						minetest.forceload_free_block({x = x, y = y, z = z})
					else
						minetest.log("error", "[ROFL] Couldn't forceplace block " .. minetest.pos_to_string({x = x, y = y, z = z}))
					end
					if newmeta then
						local meta = minetest.get_meta({x = x, y = y, z = z})
						for key,value in ipairs(newmeta) do
							if tonumber(value) then
								meta:set_int(key, value)
							else
								meta:set_string(key,value)
							end
						end
					end

				elseif action_type == 2 then -- TYPE_MODIFY_INVENTORY_STACK
					local inv = minetest.get_meta({x = x, y = y, z = z}):get_inventory()
					local stack = inv:get_stack(list, index)
					if add == 1 then
						stack:set_name(stacknode)
						stack:set_count(stackquantity)
					else
						stack:take_item(stackquantity)
					end
					inv:set_stack(list, index, stack)

				else -- TYPE_NOTHING
					print("W.T.F. is type " .. (action_type or "nil"))
				end
				patchsegs = patchsegs + 1
			end
			i = i + 1
			io.close(file)
			if tonumber(param) then
				break
			end
		end
		minetest.chat_send_all("*** Server Up")
	end,
})
