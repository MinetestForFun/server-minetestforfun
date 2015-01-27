local filename=minetest.get_worldpath() .. "/teleport_tubes"

local tp_tube_db = nil -- nil forces a read
local tp_tube_db_version = 2.0

local function hash(pos)
	return string.format("%d", minetest.hash_node_position(pos))
end

local function save_tube_db()
	local file, err = io.open(filename, "w")
	if file then
		tp_tube_db.version = tp_tube_db_version
		file:write(minetest.serialize(tp_tube_db))
		tp_tube_db.version = nil
		io.close(file)
	else
		error(err)
	end
end

local function migrate_tube_db()
		local tmp_db = {}
		tp_tube_db.version = nil
		for key, val in pairs(tp_tube_db) do
			if(val.channel ~= "") then -- skip unconfigured tubes
				tmp_db[hash(val)] = val
			end
		end
		tp_tube_db = tmp_db
		save_tube_db()
end

local function read_tube_db()
	local file = io.open(filename, "r")
	if file ~= nil then
		local file_content = file:read("*all")
		io.close(file)

		if file_content and file_content ~= "" then
			tp_tube_db = minetest.deserialize(file_content)
			if(not tp_tube_db.version or tonumber(tp_tube_db.version) < tp_tube_db_version) then
				migrate_tube_db()
			end
			tp_tube_db.version = nil -- we add it back when saving
			return tp_tube_db -- we read sucessfully
		end
	end
	tp_tube_db = {}
	return tp_tube_db
end

-- updates or adds a tube
local function set_tube(pos, channel, can_receive)
	local tubes = tp_tube_db or read_tube_db()
	local hash = hash(pos)
	local tube = tubes[hash]
	if tube then
		tube.channel = channel
		tube.cr = can_receive
		save_tube_db()
		return
	end

	-- we haven't found any tp tube to update, so lets add it
	tp_tube_db[hash] = {x=pos.x,y=pos.y,z=pos.z,channel=channel,cr=can_receive}
	save_tube_db()
end

local function remove_tube(pos)
	local tubes = tp_tube_db or read_tube_db()
	tubes[hash(pos)] = nil
	save_tube_db()
end

local function read_node_with_vm(pos)
	local vm = VoxelManip()
	local MinEdge, MaxEdge = vm:read_from_map(pos, pos)
	local data = vm:get_data()
	local area = VoxelArea:new({MinEdge = MinEdge, MaxEdge = MaxEdge})
	return minetest.get_name_from_content_id(data[area:index(pos.x, pos.y, pos.z)])
end

local function get_receivers(pos, channel)
	local tubes = tp_tube_db or read_tube_db()
	local receivers = {}
	local dirty = false
	for key, val in pairs(tubes) do
		-- skip all non-receivers and the tube that it came from as early as possible, as this is called often
		if (val.cr == 1 and val.channel == channel and (val.x ~= pos.x or val.y ~= pos.y or val.z ~= pos.z)) then
			local is_loaded = (minetest.get_node_or_nil(val) ~= nil)
			local node_name = is_loaded and minetest.get_node(pos).name or read_node_with_vm(val)

			if minetest.registered_nodes[node_name] and minetest.registered_nodes[node_name].is_teleport_tube then
				table.insert(receivers, val)
			else
				tp_tube_db[key] = nil
				dirty = true
			end
		end
	end
	if dirty then
		save_tube_db()
	end
	return receivers
end

local teleport_noctr_textures={"pipeworks_teleport_tube_noctr.png","pipeworks_teleport_tube_noctr.png","pipeworks_teleport_tube_noctr.png",
		"pipeworks_teleport_tube_noctr.png","pipeworks_teleport_tube_noctr.png","pipeworks_teleport_tube_noctr.png"}
local teleport_plain_textures={"pipeworks_teleport_tube_plain.png","pipeworks_teleport_tube_plain.png","pipeworks_teleport_tube_plain.png",
		"pipeworks_teleport_tube_plain.png","pipeworks_teleport_tube_plain.png","pipeworks_teleport_tube_plain.png"}
local teleport_end_textures={"pipeworks_teleport_tube_end.png","pipeworks_teleport_tube_end.png","pipeworks_teleport_tube_end.png",
		"pipeworks_teleport_tube_end.png","pipeworks_teleport_tube_end.png","pipeworks_teleport_tube_end.png"}
local teleport_short_texture="pipeworks_teleport_tube_short.png"
local teleport_inv_texture="pipeworks_teleport_tube_inv.png"

local function set_teleport_tube_formspec(meta, can_receive)
	local cr = (can_receive ~= 0)
	meta:set_string("formspec","size[10.5,1;]"..
			"field[0,0.5;7,1;channel;Channel:;${channel}]"..
			"button[8,0;2.5,1;"..(cr and "cr0" or "cr1")..";"..
			(cr and "Send and Receive" or "Send only").."]")
end

pipeworks.register_tube("pipeworks:teleport_tube","Teleporting Pneumatic Tube Segment",teleport_plain_textures,
	teleport_noctr_textures,teleport_end_textures,teleport_short_texture,teleport_inv_texture, {
	is_teleport_tube = true,
	tube = {
		can_go = function(pos,node,velocity,stack)
			velocity.x = 0
			velocity.y = 0
			velocity.z = 0

			local channel = minetest.get_meta(pos):get_string("channel")
			if channel == "" then return {} end

			local target = get_receivers(pos, channel)
			if target[1] == nil then return {} end

			local d = math.random(1,#target)
			pos.x = target[d].x
			pos.y = target[d].y
			pos.z = target[d].z
			return pipeworks.meseadjlist
		end
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int("can_receive", 1)
		set_teleport_tube_formspec(meta, 1)
	end,
	on_receive_fields = function(pos,formname,fields,sender)
		if not fields.channel then
			return -- ignore escaping or clientside manipulation of the form
		end

		local meta = minetest.get_meta(pos)
		local can_receive = meta:get_int("can_receive")

		-- check for private channels each time before actually changing anything
		-- to not even allow switching between can_receive states of private channels
		if fields.channel ~= "" then
			local sender_name = sender:get_player_name()
			local name, mode = fields.channel:match("^([^:;]+)([:;])")
			if name and mode and name ~= sender_name then
				--channels starting with '[name]:' can only be used by the named player
				if mode == ":" then
					minetest.chat_send_player(sender_name, "Sorry, channel '"..fields.channel.."' is reserved for exclusive use by "..name)
					return
				
				--channels starting with '[name];' can be used by other players, but cannot be received from
				elseif mode == ";" and (fields.cr1 or (can_receive ~= 0 and not fields.cr0)) then
					minetest.chat_send_player(sender_name, "Sorry, receiving from channel '"..fields.channel.."' is reserved for "..name)
					return
				end
			end
		end

		local dirty = false

		-- test if a can_receive button was pressed
		if fields.cr0 and can_receive ~= 0 then
			can_receive = 0
			meta:set_int("can_receive", can_receive)
			dirty = true
		elseif fields.cr1 and can_receive ~= 1 then
			can_receive = 1
			meta:set_int("can_receive", can_receive)
			dirty = true
		end

		-- was the channel changed?
		local channel = meta:get_string("channel")
		if fields.channel ~= channel then
			channel = fields.channel
			meta:set_string("channel", channel)
			dirty = true
		end

		-- save if we changed something, handle the empty channel while we're at it
		if dirty then
			if channel ~= "" then
				set_tube(pos, channel, can_receive)
			else
				-- remove empty channel tubes, to not have to search through them
				remove_tube(pos)
			end
			set_teleport_tube_formspec(meta, can_receive)
		end
	end,
	on_destruct = function(pos)
		remove_tube(pos)
	end
})

if minetest.get_modpath("mesecons_mvps") ~= nil then
	mesecon.register_on_mvps_move(function(moved_nodes)
		for _, n in ipairs(moved_nodes) do
			if string.find(n.node.name, "pipeworks:teleport_tube") ~= nil then
				local meta = minetest.get_meta(n.pos)
				set_tube(n.pos, meta:get_string("channel"), meta:get_int("can_receive"))
			end
		end
	end)
end
