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
	local formspec = "size[8,8.5]"..
			"item_image[0,0;1,1;pipeworks:"..data.name.."]"..
			"label[1,0;"..minetest.formspec_escape(itemname).."]"..
			"label[0,1;Prefer item types:]"..
			"list[context;main;0,1.5;8,2;]"..
			fs_helpers.cycling_button(meta, "button[0,3.5;4,1", "slotseq_mode",
				{"Sequence slots by Priority",
				 "Sequence slots Randomly",
				 "Sequence slots by Rotation"})..
			"list[current_player;main;0,4.5;8,4;]"
	meta:set_string("formspec", formspec)
end

-- todo SOON: this function has *way too many* parameters
local function grabAndFire(data,slotseq_mode,filtmeta,frominv,frominvname,frompos,fromnode,filterfor,fromtube,fromdef,dir,fakePlayer,all)
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
						count = math.min(filterfor.count, count)
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

local function punch_filter(data, filtpos, filtnode)
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
	local filters = {}
	for _, filterstack in ipairs(filtinv:get_list("main")) do
		local filtername = filterstack:get_name()
		local filtercount = filterstack:get_count()
		if filtername ~= "" then table.insert(filters, {name = filtername, count = filtercount}) end
	end
	if #filters == 0 then table.insert(filters, "") end
	local slotseq_mode = filtmeta:get_int("slotseq_mode")
	local frommeta = minetest.get_meta(frompos)
	local frominv = frommeta:get_inventory()
	if fromtube.before_filter then fromtube.before_filter(frompos) end
	for _, frominvname in ipairs(type(fromtube.input_inventory) == "table" and fromtube.input_inventory or {fromtube.input_inventory}) do
		local done = false
		for _, filterfor in ipairs(filters) do
			if grabAndFire(data, slotseq_mode, filtmeta, frominv, frominvname, frompos, fromnode, filterfor, fromtube, fromdef, dir, fakePlayer, data.stackwise) then
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
}) do
	minetest.register_node("pipeworks:"..data.name, {
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
		on_receive_fields = function(pos, formname, fields, sender)
			if not pipeworks.may_configure(pos, sender) then return end
			fs_helpers.on_receive_fields(pos, fields)
			local meta = minetest.get_meta(pos)
			meta:set_int("slotseq_index", 1)
			set_filter_formspec(data, meta)
			set_filter_infotext(data, meta)
		end,
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
		mesecons = {
			effector = {
				action_on = function(pos, node)
					punch_filter(data, pos, node)
				end,
			},
		},
		tube = {connect_sides = {right = 1}},
		on_punch = function (pos, node, puncher)
			punch_filter(data, pos, node)
		end,
	})
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
