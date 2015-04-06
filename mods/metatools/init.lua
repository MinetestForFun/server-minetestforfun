-- Meta-tools mod ßý Mg --
-- License : GPLv2+
--

metatools = {}
meta_info = {}

metatools.handle_meta = function(name,value,username)

end

metatools.get_metalist = function(meta,username)
	for name,value in pairs(meta) do
		if (type(value) == "table") then
				metatools.get_metalist(value,username)
		else
			minetest.chat_send_player(username,name.." ==> "..value)
		end
	end
end

minetest.register_craftitem("metatools:stick",{
	description = "Meta stick",
	inventory_image = "metatools_stick.png",
	on_use = function(itemstack, user, pointed_thing)
		local username = user:get_player_name()
		local nodepos  = pointed_thing.under
		local nodename = minetest.get_node(nodepos).name
		local node	   = minetest.registered_nodes[nodename]
		local meta	   = minetest.get_meta(nodepos)
		local metalist = meta:to_table()
		meta_info[username] = {}
		meta_info[username]["depth"] = 0

		metatools.get_metalist(metalist.fields,username)
		minetest.chat_send_player(username,"Node located at "..minetest.pos_to_string(nodepos))
		minetest.log("action","[metatools] Player "..username.." saw metadatas of node at "..minetest.pos_to_string(nodepos))

	end,
})

minetest.register_chatcommand("meta", {
	privs = {server = true},
	params = "help | open (x,y,z) | show | enter name | quit name | close",
	description = "Manipulate metadatas",
	func = function(name,param)
		local paramlist = param:split(" ")
		if param == "" then
			minetest.chat_send_player(name,"- meta - Type /meta help for help")
			return true
		end


		if paramlist[1] == "help" then
			minetest.chat_send_player(name,"Meta help: /meta +")
			minetest.chat_send_player(name,"  help : show this help")
			minetest.chat_send_player(name,"  open (x,y,z) : open node at pos x,y,z")
			minetest.chat_send_player(name,"  show : show fields at node/depth")
			minetest.chat_send_player(name,"  enter name : enter in field name at node/depth")
			minetest.chat_send_player(name,"  quit name : quit field name at node/depth")
			--minetest.chat_send_player(name,"  set name value : set field name to value at node/depth")
			minetest.chat_send_player(name,"  close : close the current node")

		elseif paramlist[1] == "open" then
			if meta_info[name] and meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::open - You already have opened a node without closing it, use /meta close "..minetest.pos_to_string(meta_info[name]["node"]).." to close it and retry")
				minetest.log("action","[metatools] Player "..name.." failed opening node : already has one")
				return false
			end

			if not paramlist[2] then
				minetest.chat_send_player(name,"- meta::open - You must provide a position in the forme of (x,y,z)")
				minetest.log("action","[metatools] Player "..name.." failed opening node : no position given")
				return false
			end

			local position = minetest.string_to_pos(paramlist[2])
			if position == nil then
				minetest.chat_send_player(name,"- meta::open - Incorrect position format : "..paramlist[2]..", use (x,y,z)")
				minetest.log("action","[metatools] Player "..name.." failed opening node : invalid position given")
				return false
			end

			if minetest.get_node(position).name == "ignore" then
				minetest.chat_send_player(name,"- meta::open - You cannot write on ignore : load the nodes near "..paramlist[2].." then retry.")
				minetest.log("action","[metatools] Player "..name.." failed opening node at "..paramlist[2].." : node is ignore")
				return false
			end

			for i,k in ipairs(meta_info) do
				if meta_info[i]["node"] and minetest.pos_to_string(meta_info[i]["node"]) == paramlist[2] then
					minetest.chat_send_player(name,"- meta::open - Node at "..paramlist[2].." is being held by "..i..". You cannot open it")
					minetest.log("action","[metatools] Player "..name.." failed opening node at "..paramlist[2].." : node is held by player "..i)
					return false
				end
			end

			minetest.chat_send_player(name,"- meta::open - You opened node "..minetest.get_node(position).name.." at position "..paramlist[2])
			minetest.chat_send_player(name,"- meta::open - Use /close "..paramlist[2].." to close it")
			if not meta_info[name] then
				meta_info[name] = {}
			end
			meta_info[name]["node"] = position
			meta_info[name]["stratum"] = 0
			meta_info[name]["pointer"] = minetest.get_meta(position):to_table()
			meta_info[name]["path"] = {}
			meta_info[name]["path"][0] = meta_info[name]["pointer"]

			minetest.log("action","[metatools] Player "..name.." opened node "..minetest.get_node(position).name.." at pos "..paramlist[2])
			return true
		elseif paramlist[1] == "close" then
			if not meta_info[name] or not meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::close - You have no node open, use /meta open (x,y,z) to open one")
				minetest.log("action","[metatools] Player "..name.." failed closing node : no node opened")
				return false
			end

			minetest.chat_send_player(name,"- meta::close - You closed node "..minetest.get_node(meta_info[name]["node"]).name.." at position "..minetest.pos_to_string(meta_info[name]["node"]))
			minetest.log("action","[metatools] Player "..name.." closed his node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..minetest.pos_to_string(meta_info[name]["node"]))
			meta_info[name]["node"] = nil
			meta_info[name]["stratum"] = nil
			meta_info[name]["pointer"] = nil
			meta_info[name]["path"] = nil
			return true

		elseif paramlist[1] == "show" then
			if not meta_info[name] or not meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::show - You have no node open, use /meta open (x,y,z) to open one")
				minetest.log("action","[metatools] Player "..name.." failed showing node : no node opened")
				return false
			end

			local metalist = meta_info[name]["pointer"]
			local position = minetest.pos_to_string(meta_info[name]["node"])
			minetest.chat_send_player(name,"- meta::show - Showing ways at stratum "..meta_info[name]["stratum"].." : ")

			for key,value in pairs(metalist) do
				if type(value) == "table" then
					minetest.chat_send_player(name,key.." -> Stratum "..meta_info[name]["stratum"]+1)
				elseif type(value) ~= "userdata" then
					minetest.chat_send_player(name,key.." => "..value)
				else
					minetest.chat_send_player(name,key.." => <userdata>")
				end
			end
			minetest.chat_send_player(name,#metalist .. " items shown")
			minetest.log("action","[metatools] Player "..name.." saw datas of node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..position.." with stratum "..meta_info[name]["stratum"])

		elseif paramlist[1] == "enter" then
			if not meta_info[name] or not meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::enter - You have no node open, use /meta open (x,y,z) to open one")
				minetest.log("action","[metatools] Player "..name.." failed showing node : no node opened")
				return false
			end

			if not paramlist[2] then
				minetest.chat_send_player(name,"- meta::enter - You must provide a name for the stratum you want to enter in")
				minetest.log("action","[metatools] Player "..name.." failed entering in stratum : no name given")
				return false
			end

			local metalist = meta_info[name]["pointer"]
			for key,value in pairs(metalist) do
				if key == paramlist[2] and (type(value) == "table") then
					minetest.chat_send_player(name,"- meta::enter - Entering stratum "..meta_info[name]["stratum"]+1 .. " through "..paramlist[2])
					meta_info[name]["pointer"] = value
					meta_info[name]["path"][meta_info[name]["stratum"]+1] = value
					meta_info[name]["stratum"] = meta_info[name]["stratum"]+1
					minetest.log("action","[metatools] Player "..name.." entered stratum "..meta_info[name]["stratum"].." of node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..minetest.pos_to_string(meta_info[name]["node"]))
					return true
				end
			end

			minetest.chat_send_player(name,"- meta::enter - Cannot enter further stratum through "..paramlist[2])
			minetest.log("action","[metatools] Player "..name.." failed entering stratum "..meta_info[name]["stratum"].." of node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..minetest.pos_to_string(meta_info[name]["node"]))
			return false

		elseif paramlist[1] == "quit" then
			if not meta_info[name] or not meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::quit - You have no node open, use /meta open (x,y,z) to open one")
				minetest.log("action","[metatools] Player "..name.." failed quitting stratum : no node opened")
				return false
			end

			if meta_info[name]["stratum"] == 0 then
				minetest.chat_send_player(name,"- meta::quit - You are in the highest stratum, you cannot go back")
				minetest.log("action","[metatools] Player "..name.." tried quitting highest stratum")
				return false
			end

			meta_info[name]["stratum"] = meta_info[name]["stratum"] - 1
			meta_info[name]["pointer"] = meta_info[name]["path"][meta_info[name]["stratum"]]
			meta_info[name]["path"][meta_info[name]["stratum"] + 1] = nil

			minetest.chat_send_player(name,"- meta::quit -  Stratum "..meta_info[name]["stratum"] + 1 .." quitted. Actual stratum is "..meta_info[name]["stratum"])
			minetest.log("action","[metatools] Player "..name.." quited stratum "..meta_info[name]["stratum"]+1 .." of node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..minetest.pos_to_string(meta_info[name]["node"]))
			return true

--[[		elseif paramlist[1] == "set" then
			if not meta_info[name] or not meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::set - You have no node open, use /meta open (x,y,z) to open one")
				minetest.log("action","[metatools] Player "..name.." failed setting value : no node opened")
				return false
			end

			if not paramlist[2] or tonumber(paramlist[2]) == nil then
				minetest.chat_send_player(name,"- meta::set - You must provide a number of index for the value you want to set")
				minetest.log("action","[metatools] Player "..name.." failed setting value : no index given")
				return false
			end
			paramlist[2] = tonumber(paramlist[2])

			if not paramlist[3] then
				minetest.chat_send_player(name,"- meta::set - You must provide a value for the variable you want to set")
				minetest.log("action","[metatools] Player "..name.." failed setting variable ".. paramlist[3] .." : no value given")
				return false
			end

			local i = 4
			while (i < #paramlist) do
				paramlist[3] = paramlist[3] .. " " .. paramlist[i]
				paramlist[i] = nil
				i = i + 1
			end

			local metalist = meta_info[name]["pointer"]
			local keyring = 0
			for key,value in pairs(metalist) do
				print(keyring .."==".. paramlist[2])
				if keyring == paramlist[2] and type(value) ~= "table" and type(value) ~= "userdata" then
					minetest.chat_send_player(name,"- meta::set - Set variable "..key .. " with value "..paramlist[3])
					value = paramlist[3]
					minetest.log("action","[metatools] Player "..name .. " set variable ".. paramlist[2] .. " to " .. paramlist[3] .. " at stratum "..meta_info[name]["stratum"]+1 .." of node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..minetest.pos_to_string(meta_info[name]["node"]))
					VoxelManip():update_map()
					return true
				end
				keyring = keyring + 1
			end

			minetest.chat_send_player(name,"- meta::set - Variable at "..paramlist[2] .." not found")
			minetest.log("action","[metatools] Player "..name.." failed setting variable ".. paramlist[2] .." to value ".. paramlist[3] .." in stratum "..meta_info[name]["stratum"].." of node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..minetest.pos_to_string(meta_info[name]["node"]))
			return false]]
		else
			minetest.chat_send_player(name,"- meta - Subcommand " .. paramlist[1] .. " not known. Type /meta help for help")
			return false
		end
	end
})

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	if meta_info[name] then
		meta_info[name] = nil
		minetest.log("action","[metatools] Flushed datas of player "..name)
	end
end)
