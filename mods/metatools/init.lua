-- Meta-tools mod ßý Mg --
-- License : GPLv3+
--

metatools = {}
meta_info = {}

metatools.actualize_metalist = function(name)
	-- We need to actualize the tables
	local counter = 1
	meta_info[name]["pointer"] = minetest.get_meta(meta_info[name]["node"]):to_table()
	while (counter < meta_info[name]["stratum"]+1) do
		for k,v in pairs(meta_info[name]["pointer"]) do
			if k == meta_info[name]["pathname"][counter] then
				counter = counter + 1
				meta_info[name]["pointer"] = v
				break
			end
		end
	end
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
		if not nodepos or not minetest.get_node(nodepos) then return end
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
			minetest.chat_send_player(name,"  quit : quit actual field at node/depth")
			minetest.chat_send_player(name,"  set name value : set field name to value at node/depth")
			minetest.chat_send_player(name,"  itemstack <subcommand>")
			minetest.chat_send_player(name,"    read <field> : send you the itemstring, and amount of items in <field>")
			minetest.chat_send_player(name,"    erase <field> : set to empty stack <field>")
			minetest.chat_send_player(name,"    write <field> <itemstring> [amount]: set the itemstack <field>")
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
			meta_info[name]["pathname"] = {}
			meta_info[name]["pathname"][0] = "Node"

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
			meta_info[name] = nil
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
					meta_info[name]["pathname"][meta_info[name]["stratum"]+1] = paramlist[2]
					meta_info[name]["stratum"] = meta_info[name]["stratum"]+1
					metatools.actualize_metalist(name)
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
			meta_info[name]["pathname"][meta_info[name]["stratum"] + 1] = nil
			metatools.actualize_metalist(name)

			minetest.chat_send_player(name,"- meta::quit -  Stratum "..meta_info[name]["stratum"] + 1 .." quitted. Actual stratum is "..meta_info[name]["stratum"])
			minetest.log("action","[metatools] Player "..name.." quited stratum "..meta_info[name]["stratum"]+1 .." of node "..minetest.get_node(meta_info[name]["node"]).name.." at pos "..minetest.pos_to_string(meta_info[name]["node"]))
			return true

		elseif paramlist[1] == "set" then
			if not meta_info[name] or not meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::set - You have no node open, use /meta open (x,y,z) to open one")
				minetest.log("action","[metatools] Player "..name.." failed setting value : no node opened")
				return false
			end

			if not paramlist[2] then
				minetest.chat_send_player(name,"- meta::set - You must provide a variable name for the value you want to set")
				minetest.log("action","[metatools] Player "..name.." failed setting value : no variable name given")
				return false
			end

			if not paramlist[3] then
				minetest.chat_send_player(name,"- meta::set - You must provide a value for the variable you want to set")
				minetest.log("action","[metatools] Player "..name.." failed setting variable ".. paramlist[3] .." : no value given")
				return false
			end

			local i = 4
			while (true) do
				if paramlist[i] ~= nil then
					paramlist[3] = paramlist[3] .. " " .. paramlist[i]
				else
					break
				end
				i = i + 1
			end

			local meta = minetest.get_meta(meta_info[name]["node"])
			if tonumber(paramlist[3]) ~= nil then
				if tonumber(paramlist[3]) % 1 == 0 then
					meta:set_int(paramlist[2],tonumber(paramlist[3]))
				else
					meta:set_float(paramlist[2],tonumber(paramlist[3]))
				end
			elseif type(paramlist[3]) == "string" then
				meta:set_string(paramlist[2],paramlist[3])
			end

			minetest.chat_send_player(name,"- meta::set - Variable set")
			minetest.log("action","[metatools] Player " .. name .. " set variable " .. paramlist[2] .. " to value " .. paramlist[3] .. " in stratum " .. meta_info[name]["stratum"] .. " of node " .. minetest.get_node(meta_info[name]["node"]).name .. " at pos " .. minetest.pos_to_string(meta_info[name]["node"]))
			metatools.actualize_metalist(name)
			return true

		elseif paramlist[1] == "itemstack" then
			if not meta_info[name] or not meta_info[name]["node"] then
				minetest.chat_send_player(name,"- meta::itemstack - You have no node open, use /meta open (x,y,z) to open one")
				minetest.log("action","[metatools] Player "..name.." failed itemstack : no node opened")
				return false
			end

			if not paramlist[2] then
				minetest.chat_send_player(name,"- meta::itemstack - You must provide a subcommand for the itemstack subcommand")
				minetest.log("action","[metatools] Player "..name.." failed itemstack : no subcommand")
				return false
			end

			if not (meta_info[name]["stratum"] > 1 and meta_info[name]["pathname"][meta_info[name]["stratum"]-1] == "inventory") then
				minetest.chat_send_player(name,"- meta::itemstack - Itemstack must only exist in inventory fields")
				minetest.log("action","[metatools] Player " .. name .. " tried to access itemstack out of inventory's fields")
				return false
			end

			if paramlist[2] == "read" then

				if not paramlist[3] then
					minetest.chat_send_player(name,"- meta::itemstack::read - You must provide a field name (eg. a number) to read")
					minetest.log("action","[metatools] Player " .. name .. " failed itemstack reading : no field name")
					return false
				end

				for key,value in pairs(meta_info[name]["pointer"]) do
					if key ~= nil and key.."" == paramlist[3] then -- Forced conversion to string type
						local itemstack = value
						if not itemstack:get_name() or not itemstack:get_count() then
							minetest.chat_send_player(name,"- meta::itemstack::read - Itemstack recognition failed. Field content isn't an itemstack")
							minetest.log("action","[metatools] Player " .. name .. " tried to access field " .. key .. " which is not an itemstack")
						end
						local itemname  = itemstack:get_name()
						local itemcount = itemstack:get_count()
						if itemname == "" then
							minetest.chat_send_player(name,"- meta::itemstack::read - Itemstack of field ".. key .." is empty")
							minetest.log("action","[metatools] Player ".. name .. " read itemstack of field ".. key .." : empty stack")
						else
							minetest.chat_send_player(name,"- meta::itemstack::read - Itemstack of field ".. key .." : "..itemstack:get_name().." "..itemstack:get_count())
							minetest.log("action","[metatools] Player ".. name .. " read itemstack of field ".. key .." : "..itemname.." "..itemcount)
						end
						return true
					end
				end

				minetest.chat_send_player(name,"- meta::itemstack::read - Field " .. paramlist[3] .. " doesn't exist")
				minetest.log("action","[metatools] Player " .. name .. " tried to access itemstack in unknown field " .. paramlist[3])

			elseif paramlist[2] == "erase" then

				if not paramlist[3] then
					minetest.chat_send_player(name,"- meta::itemstack::write - You must provide a field name (eg. a number) to erase")
					minetest.log("action","[metatools] Player " .. name .. " failed itemstack erasing : no field name")
					return false
				end

				local meta = minetest.get_meta(meta_info[name]["node"])
				local inv  = meta:get_inventory()
				for key,value in pairs(meta_info[name]["pointer"]) do
					if key ~= nil and key.."" == paramlist[3] then -- Forced conversion to string type
						local itemstack = value
						inv:set_stack(meta_info[name]["pathname"][meta_info[name]["stratum"]],key+0,nil)
						minetest.chat_send_player(name,"- meta::itemstack::erase - Itemstack of field ".. key .." cleared")
						minetest.log("action","[metatools] Player ".. name .. " cleared itemstack of field ".. key)
						return true
					end
				end

				minetest.chat_send_player(name,"- meta::itemstack::erase - Field " .. paramlist[3] .. " doesn't exist")
				minetest.log("action","[metatools] Player " .. name .. " tried to erase itemstack in unknown field " .. paramlist[3])

			elseif paramlist[2] == "write" then

				if not paramlist[3] then
					minetest.chat_send_player(name,"- meta::itemstack::write - You must provide a field name (eg. a number) to write to")
					minetest.log("action","[metatools] Player " .. name .. " failed itemstack writing : no field name")
					return false
				end
				if not paramlist[4] then
					minetest.chat_send_player(name,"- meta::itemstack::write - You must provide an itemstring (eg. 'default:chest') for the itemstack to write")
					minetest.log("action","[metatools] Player " .. name .. " failed itemstack writing : no itemstring")
					return false
				end

				if paramlist[5] and paramlist[5] == 0 then
					minetest.chat_send_player(name,"- meta::itemstack::write - It is useless to write 0 items. Use meta erase "..paramlist[3].." instead")
					minetest.log("action","[metatools] Player ".. name .. " wanted to write 0 items in " .. paramlist[3] .. " inventory field")
					return false
				end

				local itemstring = paramlist[4]
				local itemcount  = paramlist[5] or 1

				local meta = minetest.get_meta(meta_info[name]["node"])
				local inv  = meta:get_inventory()
				for key,value in pairs(meta_info[name]["pointer"]) do
					if key ~= nil and key.."" == paramlist[3] then -- Forced conversion to string type
						inv:set_stack(meta_info[name]["pathname"][meta_info[name]["stratum"]],key+0,ItemStack({name = itemstring,count = itemcount}))
						minetest.chat_send_player(name,"- meta::itemstack::write - Itemstack written in field ".. key)
						minetest.log("action","[metatools] Player ".. name .. " wrote itemstack '".. itemstring.. " " ..itemcount.."' in field ".. key)
						return true
					end
				end

				minetest.chat_send_player(name,"- meta::itemstack::write - Field " .. paramlist[3] .. " doesn't exist")
				minetest.log("action","[metatools] Player " .. name .. " tried to write itemstack in unknown field " .. paramlist[3])

			else
				minetest.chat_send_player("- meta::itemstack - Subcommand " .. paramlist[2] .. " unknown. Typ /meta help for help")
				return false
			end
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
