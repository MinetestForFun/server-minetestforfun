local function delay(x)
	return (function() return x end)
end

local function set_filter_infotext(data, meta)
	local infotext = data.wise_desc.." Filter-Injector"
	if meta:get_int("slotseq_mode") == 2 then
		infotext = infotext .. " (slot #"..meta:get_int("slotseq_index").." next)"
	end
	meta:set_string("infotext", infotext)
end

local function set_filter_formspec(data, meta)
	local itemname = data.wise_desc.." Filter-Injector"

	local formspec
	if data.digiline then
		formspec = "size[8,2.7]"..
			"item_image[0,0;1,1;pipeworks:"..data.name.."]"..
			"label[1,0;"..minetest.formspec_escape(itemname).."]"..
			"field[0.3,1.5;8.0,1;channel;Channel;${channel}]"..
			fs_helpers.cycling_button(meta, "button[0,2;4,1", "slotseq_mode",
				{"Sequence slots by Priority",
				 "Sequence slots Randomly",
				 "Sequence slots by Rotation"})..
			fs_helpers.cycling_button(meta, "button[4,2;4,1", "exmatch_mode",
				{"Exact match - off",
				 "Exact match - on "})
	else
		local exmatch_button = ""
		if data.stackwise then
			exmatch_button =
				fs_helpers.cycling_button(meta, "button[4,3.5;4,1", "exmatch_mode",
					{"Exact match - off",
					 "Exact match - on "})
		end

		formspec = "size[8,8.5]"..
			"item_image[0,0;1,1;pipeworks:"..data.name.."]"..
			"label[1,0;"..minetest.formspec_escape(itemname).."]"..
			"label[0,1;Prefer item types:]"..
			"list[context;main;0,1.5;8,2;]"..
			fs_helpers.cycling_button(meta, "button[0,3.5;4,1", "slotseq_mode",
				{"Sequence slots by Priority",
				 "Sequence slots Randomly",
				 "Sequence slots by Rotation"})..
			exmatch_button..
			"list[current_player;main;0,4.5;8,4;]"
	end
	meta:set_string("formspec", formspec)
end

-- todo SOON: this function has *way too many* parameters
local function grabAndFire(data,slotseq_mode,exmatch_mode,filtmeta,frominv,frominvname,frompos,fromnode,filterfor,fromtube,fromdef,dir,fakePlayer,all)
	local sposes = {}
	for spos,stack in ipairs(frominv:get_list(frominvname)) do
		local matches
		if filterfor == "" then
			matches = stack:get_name() ~= ""
		else
			matches = stack:get_name() == filterfor.name
		end
		if matches then table.insert(sposes, spos) end
	end
	if #sposes == 0 then return false end
	if slotseq_mode == 1 then
		for i = #sposes, 2, -1 do
			local j = math.random(i)
			local t = sposes[j]
			sposes[j] = sposes[i]
			sposes[i] = t
		end
	elseif slotseq_mode == 2 then
		local headpos = filtmeta:get_int("slotseq_index")
		table.sort(sposes, function (a, b)
			if a >= headpos then
				if b < headpos then return true end
			else
				if b >= headpos then return false end
			end
			return a < b
		end)
	end
	for _, spos in ipairs(sposes) do
			local stack = frominv:get_stack(frominvname, spos)
			local doRemove = stack:get_count()
			if fromtube.can_remove then
				doRemove = fromtube.can_remove(frompos, fromnode, stack, dir)
			elseif fromdef.allow_metadata_inventory_take then
				doRemove = fromdef.allow_metadata_inventory_take(frompos, frominvname,spos, stack, fakePlayer)
			end
			-- stupid lack of continue statements grumble
			if doRemove > 0 then
				if slotseq_mode == 2 then
					local nextpos = spos + 1
					if nextpos > frominv:get_size(frominvname) then
						nextpos = 1
					end
					filtmeta:set_int("slotseq_index", nextpos)
					set_filter_infotext(data, filtmeta)
				end
				local item
				local count
				if all then
					count = math.min(stack:get_count(), doRemove)
					if filterfor.count and filterfor.count > 1 then
						if exmatch_mode ~= 0 and filterfor.count > count then
							return false
						else
							count = math.min(filterfor.count, count)
						end
					end
				else
					count = 1
				end
				if fromtube.remove_items then
					-- it could be the entire stack...
					item = fromtube.remove_items(frompos, fromnode, stack, dir, count)
				else
					item = stack:take_item(count)
					frominv:set_stack(frominvname, spos, stack)
					if fromdef.on_metadata_inventory_take then
						fromdef.on_metadata_inventory_take(frompos, frominvname, spos, item, fakePlayer)
					end
				end
				local pos = vector.add(frompos, vector.multiply(dir, 1.4))
				local start_pos = vector.add(frompos, dir)
				local item1 = pipeworks.tube_inject_item(pos, start_pos, dir, item)
				return true-- only fire one item, please
			end
	end
	return false
end

local function punch_filter(data, filtpos, filtnode, msg)
	local filtmeta = minetest.get_meta(filtpos)
	local filtinv = filtmeta:get_inventory()
	local owner = filtmeta:get_string("owner")
	local fakePlayer = {
		get_player_name = delay(owner),
		is_fake_player = ":pipeworks",
	} -- TODO: use a mechanism as the wielder one
	local dir = minetest.facedir_to_right_dir(filtnode.param2)
	local frompos = vector.subtract(filtpos, dir)
	local fromnode = minetest.get_node(frompos)
	if not fromnode then return end
	local fromdef = minetest.registered_nodes[fromnode.name]
	if not fromdef then return end
	local fromtube = fromdef.tube
	if not (fromtube and fromtube.input_inventory) then return end

	local slotseq_mode
	local exact_match

	local filters = {}
	if data.digiline then
		local t_msg = type(msg)
		if t_msg == "table" then
			local slotseq = msg.slotseq
			local t_slotseq = type(slotseq)
			if t_slotseq == "number" and slotseq >= 0 and slotseq <= 2 then
				slotseq_mode = slotseq
			elseif t_slotseq == "string" then
				slotseq = string.lower(slotseq)
				if slotseq == "priority" then
					slotseq_mode = 0
				elseif slotseq == "random" then
					slotseq_mode = 1
				elseif slotseq == "rotation" then
					slotseq_mode = 2
				end
			end

			local exmatch = msg.exmatch
			local t_exmatch = type(exmatch)
			if t_exmatch == "number" and exmatch >= 0 and exmatch <= 1 then
				exact_match = exmatch
			elseif t_exmatch == "boolean" then
				exact_match = exmatch and 1 or 0
			end

			local slotseq_index = msg.slotseq_index
			if type(slotseq_index) == "number" then
				-- This should allow any valid index, but I'm not completely sure what
				-- constitutes a valid index, so I'm only allowing resetting it to 1.
				if slotseq_index == 1 then
					filtmeta:set_int("slotseq_index", slotseq_index)
					set_filter_infotext(data, filtmeta)
				end
			end

			if slotseq_mode ~= nil then
				filtmeta:set_int("slotseq_mode", slotseq_mode)
			end

			if exact_match ~= nil then
				filtmeta:set_int("exmatch_mode", exact_match)
			end

			if slotseq_mode ~= nil or exact_match ~= nil then
				set_filter_formspec(data, filtmeta)
			end

			if msg.nofire then
				return
			end

			if type(msg.name) == "string" then
				table.insert(filters, {name = msg.name, count = tonumber(msg.count) or 1})
			else
				for _, filter in ipairs(msg) do
					local t_filter = type(filter)
					if t_filter == "table" then
						if type(filter.name) == "string" then
							table.insert(filters, {name = filter.name, count = tonumber(filter.count) or 1})
						end
					elseif t_filter == "string" then
						local filterstack = ItemStack(filter)
						local filtername = filterstack:get_name()
						local filtercount = filterstack:get_count()
						if filtername ~= "" then table.insert(filters, {name = filtername, count = filtercount}) end
					end
				end
			end
		elseif t_msg == "string" then
			local filterstack = ItemStack(msg)
			local filtername = filterstack:get_name()
			local filtercount = filterstack:get_count()
			if filtername ~= "" then table.insert(filters, {name = filtername, count = filtercount}) end
		end
	else
		for _, filterstack in ipairs(filtinv:get_list("main")) do
			local filtername = filterstack:get_name()
			local filtercount = filterstack:get_count()
			if filtername ~= "" then table.insert(filters, {name = filtername, count = filtercount}) end
		end
	end
	if #filters == 0 then table.insert(filters, "") end

	if slotseq_mode == nil then
		slotseq_mode = filtmeta:get_int("slotseq_mode")
	end

	if exact_match == nil then
		exact_match = filtmeta:get_int("exmatch_mode")
	end

	local frommeta = minetest.get_meta(frompos)
	local frominv = frommeta:get_inventory()
	if fromtube.before_filter then fromtube.before_filter(frompos) end
	for _, frominvname in ipairs(type(fromtube.input_inventory) == "table" and fromtube.input_inventory or {fromtube.input_inventory}) do
		local done = false
		for _, filterfor in ipairs(filters) do
			if grabAndFire(data, slotseq_mode, exact_match, filtmeta, frominv, frominvname, frompos, fromnode, filterfor, fromtube, fromdef, dir, fakePlayer, data.stackwise) then
				done = true
				break
			end
		end
		if done then break end
	end
	if fromtube.after_filter then fromtube.after_filter(frompos) end
end

for _, data in ipairs({
	{
		name = "filter",
		wise_desc = "Itemwise",
		stackwise = false,
	},
	{
		name = "mese_filter",
		wise_desc = "Stackwise",
		stackwise = true,
	},
	{ -- register even if no digilines
		name = "digiline_filter",
		wise_desc = "Digiline",
		stackwise = true,
		digiline = true,
	},
}) do
	local node = {
		description = data.wise_desc.." Filter-Injector",
		tiles = {
			"pipeworks_"..data.name.."_top.png",
			"pipeworks_"..data.name.."_top.png",
			"pipeworks_"..data.name.."_output.png",
			"pipeworks_"..data.name.."_input.png",
			"pipeworks_"..data.name.."_side.png",
			"pipeworks_"..data.name.."_top.png",
		},
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, mesecon = 2},
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
			local inv = meta:get_inventory()
			inv:set_size("main", 8*2)
		end,
		after_place_node = function (pos, placer)
			minetest.get_meta(pos):set_string("owner", placer:get_player_name())
			pipeworks.after_place(pos)
		end,
		after_dig_node = pipeworks.after_dig,
		allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if not pipeworks.may_configure(pos, player) then return 0 end
			return stack:get_count()
		end,
		allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			if not pipeworks.may_configure(pos, player) then return 0 end
			return stack:get_count()
		end,
		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			if not pipeworks.may_configure(pos, player) then return 0 end
			return count
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:is_empty("main")
		end,
		tube = {connect_sides = {right = 1}},
	}

	if data.digiline then
		node.groups.mesecon = nil
		if not minetest.get_modpath("digilines") then
			node.groups.not_in_creative_inventory = 1
		end

		node.on_receive_fields = function(pos, formname, fields, sender)
			if not pipeworks.may_configure(pos, sender) then return end
			fs_helpers.on_receive_fields(pos, fields)

			if fields.channel then
				minetest.get_meta(pos):set_string("channel", fields.channel)
			end

			local meta = minetest.get_meta(pos)
			--meta:set_int("slotseq_index", 1)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
		end
		node.digiline = {
			effector = {
				action = function(pos, node, channel, msg)
					local meta = minetest.get_meta(pos)
					local setchan = meta:get_string("channel")
					if setchan ~= channel then return end

					punch_filter(data, pos, node, msg)
				end,
			},
		}
	else
		node.on_receive_fields = function(pos, formname, fields, sender)
			if not pipeworks.may_configure(pos, sender) then return end
			fs_helpers.on_receive_fields(pos, fields)
			local meta = minetest.get_meta(pos)
			meta:set_int("slotseq_index", 1)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
		end
		node.mesecons = {
			effector = {
				action_on = function(pos, node)
					punch_filter(data, pos, node)
				end,
			},
		}
		node.on_punch = function (pos, node, puncher)
			punch_filter(data, pos, node)
		end
	end



	minetest.register_node("pipeworks:"..data.name, node)
end

minetest.register_craft( {
	output = "pipeworks:filter 2",
	recipe = {
	        { "default:steel_ingot", "default:steel_ingot", "homedecor:plastic_sheeting" },
	        { "group:stick", "default:mese_crystal", "homedecor:plastic_sheeting" },
	        { "default:steel_ingot", "default:steel_ingot", "homedecor:plastic_sheeting" }
	},
})

minetest.register_craft( {
	output = "pipeworks:mese_filter 2",
	recipe = {
	        { "default:steel_ingot", "default:steel_ingot", "homedecor:plastic_sheeting" },
	        { "group:stick", "default:mese", "homedecor:plastic_sheeting" },
	        { "default:steel_ingot", "default:steel_ingot", "homedecor:plastic_sheeting" }
	},
})

if minetest.get_modpath("digilines") then
	minetest.register_craft( {
		output = "pipeworks:digiline_filter 2",
		recipe = {
			{ "default:steel_ingot", "default:steel_ingot", "homedecor:plastic_sheeting" },
			{ "group:stick", "digilines:wire_std_00000000", "homedecor:plastic_sheeting" },
			{ "default:steel_ingot", "default:steel_ingot", "homedecor:plastic_sheeting" }
		},
	})
end
