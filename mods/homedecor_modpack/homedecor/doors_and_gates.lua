-- Node definitions for Homedecor doors

local S = homedecor.gettext

-- doors

local function isSolid(pos,adj)
    local adj = {x=adj[1],y=adj[2],z=adj[3]}
    local node = minetest.get_node(vector.add(pos,adj))
    if node then
        local idef = minetest.registered_nodes[minetest.get_node(vector.add(pos,adj)).name]
        if idef then
            return idef.walkable
        end
    end
    return false
end

local function countSolids(pos,node,level)
    local solids = 0
    for x = -1, 1 do
        for z = -1, 1 do
            local y = (node.param2 == 5) and -level or level
            -- special cases when x == z == 0
            if x == 0 and z == 0 then
                if level == 1 then
                    -- when looking past the trap door, cannot be solid in center
                    if isSolid(pos,{x,y,z}) then
                        return false
                    end
                    -- no else. it doesn't matter if x == y == z is solid, that's us.
                end
            elseif isSolid(pos,{x,y,z}) then
                solids = solids + 1
            end
        end
    end
    return solids
end

local function calculateClosed(pos)
    local node = minetest.get_node(pos)
    -- the door is considered closed if it is closing off something.

    local solids = 0
    local direction = node.param2 % 6
    local isTrap = direction == 0 or direction == 5
    if isTrap then
        -- the trap door is considered closed when all nodes on its sides are solid
        -- or all nodes in the 3x3 above/below it are solid except the center
        for level = 0, 1 do
            local fail = false
            local solids = countSolids(pos,node,level)
            if solids == 8 then
                return true
            end
        end
        return false
    else
        -- the door is considered closed when the nodes on its sides are solid
        -- or the 3 nodes in its facing direction are solid nonsolid solid
        -- if the door has two levels (i.e. not a gate) then this must
        -- be true for the top node as well.

        -- sorry I dunno the math to figure whether to x or z
        if direction == 1 or direction == 2 then
            if isSolid(pos,{0,0,-1}) and isSolid(pos,{0,0,1}) then
                if string.find(node.name,'_bottom_') then
                    return calculateClosed({x=pos.x,y=pos.y+1,z=pos.z})
                else
                    return true
                end
            end
            local x = (direction == 1) and 1 or -1
            if isSolid(pos,{x,0,-1}) and not isSolid(pos,{x,0,0}) and isSolid(pos,{x,0,1}) then
                if string.find(node.name,'_bottom_') then
                    return calculateClosed({x=pos.x,y=pos.y+1,z=pos.z})
                else
                    return true
                end
            end
            return false
        else
            -- direction == 3 or 4
            if isSolid(pos,{-1,0,0}) and isSolid(pos,{1,0,0}) then
                if string.find(node.name,'_bottom_') then
                    return calculateClosed({x=pos.x,y=pos.y+1,z=pos.z})
                else
                    return true
                end
            end
            local z = (direction == 3) and 1 or -1
            if isSolid(pos,{-1,0,z}) and not isSolid(pos,{0,0,z}) and isSolid(pos,{1,0,z}) then
                if string.find(node.name,'_bottom_') then
                    return calculateClosed({x=pos.x,y=pos.y+1,z=pos.z})
                else
                    return true
                end
            end
            return false
        end
        error("What direction is this???",direction)
    end
end

-- isClosed flag, is 0 or 1 0 = open, 1 = closed
local function getClosed(pos)
    local isClosed = minetest.get_meta(pos):get_string('closed')
    if isClosed=='' then
	return calculateClosed(pos)
    else
        isClosed = tonumber(isClosed)
        -- may be closed or open (1 or 0)
        return isClosed == 1
    end
end

local function addDoorNode(pos,def,isClosed)
    minetest.set_node(pos, def)
    minetest.get_meta(pos):set_int('closed', isClosed and 1 or 0)
end

local sides = {"left", "right"}
local rsides = {"right", "left"}

for i in ipairs(sides) do
	local side = sides[i]
	local rside = rsides[i]

	for j in ipairs(homedecor.door_models) do
		local doorname =		homedecor.door_models[j][1]
		local doordesc =		homedecor.door_models[j][2]
		local nodeboxes_top =	homedecor.door_models[j][5]
		local nodeboxes_bottom =	homedecor.door_models[j][6]
		local texalpha = false
		if doorname == "exterior_fancy" or "woodglass" or "woodglass2" then
			texalpha = true
		end

		if side == "left" then
			nodeboxes_top =	homedecor.door_models[j][3]
			nodeboxes_bottom =	homedecor.door_models[j][4]
		end

		local lower_top_side = "homedecor_door_"..doorname.."_tb.png"
		local upper_bottom_side = "homedecor_door_"..doorname.."_tb.png"

		if doorname == "glass" or doorname == "wrought_iron" then
			lower_top_side = "homedecor_blanktile.png"
			upper_bottom_side = "homedecor_blanktile.png"
		end

		local tiles_upper = {
				"homedecor_door_"..doorname.."_tb.png",
				upper_bottom_side,
				"homedecor_door_"..doorname.."_lrt.png",
				"homedecor_door_"..doorname.."_lrt.png",
				"homedecor_door_"..doorname.."_"..rside.."_top.png",
				"homedecor_door_"..doorname.."_"..side.."_top.png",
				}

		local tiles_lower = {
				lower_top_side,
				"homedecor_door_"..doorname.."_tb.png",
				"homedecor_door_"..doorname.."_lrb.png",
				"homedecor_door_"..doorname.."_lrb.png",
				"homedecor_door_"..doorname.."_"..rside.."_bottom.png",
				"homedecor_door_"..doorname.."_"..side.."_bottom.png",
				}

		local selectboxes_top = {
				type = "fixed",
				fixed = { -0.5, -1.5, 6/16, 0.5, 0.5, 8/16}
			}

		local selectboxes_bottom = {
				type = "fixed",
				fixed = { -0.5, -0.5, 6/16, 0.5, 1.5, 8/16}
			}

		minetest.register_node("homedecor:door_"..doorname.."_top_"..side, {
			description = doordesc.." "..S("(Top Half, %s-opening)"):format(side),
			drawtype = "nodebox",
			tiles = tiles_upper,
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {snappy=3, not_in_creative_inventory=1},
			sounds = default.node_sound_wood_defaults(),
			use_texture_alpha = texalpha,
			selection_box = selectboxes_top,
			node_box = {
				type = "fixed",
				fixed = nodeboxes_top
			},
			drop = "homedecor:door_"..doorname.."_bottom_"..side,
			after_dig_node = function(pos, oldnode, oldmetadata, digger)
				if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "homedecor:door_"..doorname.."_bottom_"..side then
					minetest.remove_node({x=pos.x, y=pos.y-1, z=pos.z})
				end
			end,
			on_rightclick = function(pos, node, clicker)
				homedecor.flip_door({x=pos.x, y=pos.y-1, z=pos.z}, node, clicker, doorname, side)
			end
		})

		local dgroups = {snappy=3, not_in_creative_inventory=1}
		if side == "left" then
			dgroups = {snappy=3}
		end

		minetest.register_node("homedecor:door_"..doorname.."_bottom_"..side, {
			description = doordesc.." "..S("(%s-opening)"):format(side),
			drawtype = "nodebox",
			tiles = tiles_lower,
			inventory_image = "homedecor_door_"..doorname.."_left_inv.png",
			wield_image = "homedecor_door_"..doorname.."_left_inv.png",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = dgroups,
			sounds = default.node_sound_wood_defaults(),
			use_texture_alpha = texalpha,
			selection_box = selectboxes_bottom,
			node_box = {
				type = "fixed",
				fixed = nodeboxes_bottom
			},
			after_dig_node = function(pos, oldnode, oldmetadata, digger)
				if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "homedecor:door_"..doorname.."_top_"..side then
					minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
				end
			end,
			on_place = function(itemstack, placer, pointed_thing)
				return homedecor.stack_wing(itemstack, placer, pointed_thing,
					"homedecor:door_"..doorname.."_bottom_left", "homedecor:door_"..doorname.."_top_left",
					"homedecor:door_"..doorname.."_bottom_right", "homedecor:door_"..doorname.."_top_right")
			end,
			on_construct = function(pos)
				minetest.get_meta(pos):set_int("closed", 1)
			end,
			on_rightclick = function(pos, node, clicker)
				homedecor.flip_door(pos, node, clicker, doorname, side)
			end,
            -- both left and right doors may be used for open or closed doors
            -- so they have to have both action_on and action_off and just
            -- check when that action is invoked if to continue

            on_punch = function(pos, node, puncher)
                minetest.get_meta(pos):set_string('closed',nil)
            end,
			drop = "homedecor:door_"..doorname.."_bottom_left",
            mesecons = {
                effector = {
                    action_on = function(pos,node)
                        local isClosed = getClosed(pos)
                        if isClosed then
                            homedecor.flip_door(pos,node,nil,doorname,side,isClosed)
                        end
                    end,
                    action_off = function(pos,node)
                        local isClosed = getClosed(pos)
                        if not isClosed then
                            homedecor.flip_door(pos,node,nil,doorname,side,isClosed)
                        end
                    end
                }
            }
		})
	end
end

-- Gates

local gates_list = { "picket", "picket_white", "barbed_wire", "chainlink" }
local gate_names = { "Unpainted Picket", "White Picket", "Barbed Wire", "Chainlink" }

local gate_models_closed = {
	{{ -0.5, -0.5, 0.498, 0.5, 0.5, 0.498 }},

	{{ -0.5, -0.5, 0.498, 0.5, 0.5, 0.498 }},

	{{ -8/16, -8/16, 6/16, -6/16,  8/16,  8/16 },	-- left post
	 {  6/16, -8/16, 6/16,  8/16,  8/16,  8/16 }, 	-- right post
	 { -8/16,  7/16, 13/32, 8/16,  8/16, 15/32 },	-- top piece
	 { -8/16, -8/16, 13/32, 8/16, -7/16, 15/32 },	-- bottom piece
	 { -6/16, -8/16,  7/16, 6/16,  8/16,  7/16 }},	-- the wire

	{{ -8/16, -8/16,  6/16, -7/16,  8/16,  8/16 },	-- left post
	 {  6/16, -8/16,  6/16,  8/16,  8/16,  8/16 }, 	-- right post
	 { -8/16,  7/16, 13/32,  8/16,  8/16, 15/32 },	-- top piece
	 { -8/16, -8/16, 13/32,  8/16, -7/16, 15/32 },	-- bottom piece
	 { -8/16, -8/16,  7/16,  8/16,  8/16,  7/16 },	-- the chainlink itself
	 { -8/16, -3/16,  6/16, -6/16,  3/16,  8/16 }}	-- the lump representing the lock
}

local gate_models_open = {
	{{ 0.498, -0.5, -0.5, 0.498, 0.5, 0.5 }},

	{{ 0.498, -0.5, -0.5, 0.498, 0.5, 0.5 }},

	{{  6/16, -8/16, -8/16,  8/16,  8/16, -6/16 },	-- left post
	 {  6/16, -8/16,  6/16,  8/16,  8/16,  8/16 }, 	-- right post
	 { 13/32,  7/16, -8/16, 15/32,  8/16,  8/16 },	-- top piece
	 { 13/32, -8/16, -8/16, 15/32, -7/16,  8/16 },	-- bottom piece
	 {  7/16, -8/16, -6/16,  7/16,  8/16,  6/16 }},	-- the wire

	{{  6/16, -8/16, -8/16,  8/16,  8/16, -7/16 },	-- left post
	 {  6/16, -8/16,  6/16,  8/16,  8/16,  8/16 }, 	-- right post
	 { 13/32,  7/16, -8/16, 15/32,  8/16,  8/16 },	-- top piece
	 { 13/32, -8/16, -8/16, 15/32, -7/16,  8/16 },	-- bottom piece
	 {  7/16, -8/16, -8/16,  7/16,  8/16,  8/16 },	-- the chainlink itself
	 {  6/16, -3/16, -8/16,  8/16,  3/16, -6/16 }}	-- the lump representing the lock
}

for i in ipairs(gates_list) do

	local gate=gates_list[i]

    local def = {
		drawtype = "nodebox",
		description = S(gate_names[i].." Fence Gate"),
		tiles = {
			"homedecor_gate_"..gate.."_top.png",
			"homedecor_gate_"..gate.."_bottom.png",
			"homedecor_gate_"..gate.."_left.png",
			"homedecor_gate_"..gate.."_right.png",
			"homedecor_gate_"..gate.."_back.png",
			"homedecor_gate_"..gate.."_front.png"
		},
		paramtype = "light",
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
		paramtype2 = "facedir",
		selection_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
		},
		node_box = {
			type = "fixed",
			fixed = gate_models_closed[i]
		},
		on_rightclick = function(pos, node, clicker)
			homedecor.flip_gate(pos, node, clicker, gate, "closed")
		end,
        mesecons = {
            effector = {
                action_on = function(pos,node) homedecor.flip_gate(pos,node,player,gate, "closed") end
            }
        }
	}

    -- gates when placed default to closed, closed.

	minetest.register_node("homedecor:gate_"..gate.."_closed", def)

    -- this is either a terrible idea or a great one
    def = homedecor.table_copy(def)
    def.groups.not_in_creative_inventory = 1
    def.selection_box.fixed = { 0.4, -0.5, -0.5, 0.5, 0.5, 0.5 }
    def.tiles = {
		"homedecor_gate_"..gate.."_top.png",
		"homedecor_gate_"..gate.."_bottom.png",
		"homedecor_gate_"..gate.."_front.png",
		"homedecor_gate_"..gate.."_back.png",
		"homedecor_gate_"..gate.."_left.png",
        "homedecor_gate_"..gate.."_right.png"
    }
    def.node_box.fixed = gate_models_open[i]
    def.drop = "homedecor:gate_"..gate.."_closed"
	def.on_rightclick = function(pos, node, clicker)
        homedecor.flip_gate(pos, node, clicker, gate, "open")
	end
    def.mesecons.effector = {
        action_off = function(pos,node) homedecor.flip_gate(pos,node,player,gate, "open") end
    }

	minetest.register_node("homedecor:gate_"..gate.."_open", def)
end

minetest.register_alias("homedecor:fence_barbed_wire_gate_open",    "homedecor:gate_barbed_wire_open")
minetest.register_alias("homedecor:fence_barbed_wire_gate_closed",  "homedecor:gate_barbed_wire_closed")
minetest.register_alias("homedecor:fence_chainlink_gate_open",      "homedecor:gate_chainlink_open")
minetest.register_alias("homedecor:fence_chainlink_gate_closed",    "homedecor:gate_chainlink_closed")
minetest.register_alias("homedecor:fence_picket_gate_open",         "homedecor:gate_picket_open")
minetest.register_alias("homedecor:fence_picket_gate_closed",       "homedecor:gate_picket_closed")
minetest.register_alias("homedecor:fence_picket_gate_white_open",   "homedecor:gate_picket_white_open")
minetest.register_alias("homedecor:fence_picket_gate_white_closed", "homedecor:gate_picket_white_closed")

-- to open a door, you switch left for right and subtract from param2, or vice versa right for left
-- that is to say open "right" doors become left door nodes, and open left doors right door nodes.
-- also adjusting param2 so the node is at 90 degrees.

function homedecor.flip_door(pos, node, player, name, side, isClosed)
    if isClosed == nil then
        isClosed = getClosed(pos)
    end
    -- this is where we swap the isClosed status!
    -- i.e. if isClosed, we're adding an open door
    -- and if not isClosed, a closed door
    isClosed = not isClosed

	local rside = nil
	local nfdir = nil
	local ofdir = node.param2 or 0
	if side == "left" then
		rside = "right"
		nfdir=ofdir - 1
		if nfdir < 0 then nfdir = 3 end
	else
		rside = "left"
		nfdir=ofdir + 1
		if nfdir > 3 then nfdir = 0 end
	end
	local sound = isClosed and 'close' or 'open'
	minetest.sound_play("homedecor_door_"..sound, {
		pos=pos,
        max_hear_distance = 5,
		gain = 2,
	})
    -- XXX: does the top half have to remember open/closed too?
	minetest.add_node({x=pos.x, y=pos.y+1, z=pos.z}, { name =  "homedecor:door_"..name.."_top_"..rside, param2=nfdir})

    addDoorNode(pos,{ name = "homedecor:door_"..name.."_bottom_"..rside, param2=nfdir },isClosed)
end

function homedecor.flip_gate(pos, node, player, gate, oc)
    local isClosed = getClosed(pos);
    minetest.sound_play("homedecor_gate_open_close", {
		pos=pos,
		max_hear_distance = 5,
		gain = 2,
	})

	local fdir = node.param2 or 0

    -- since right facing gates use "open" nodes for closed, we need an
    -- isClosed flag to tell if it's "really" closed.

	local gateresult = nil
	if oc == "closed" then
		gateresult = "homedecor:gate_"..gate.."_open"
	else
		gateresult = "homedecor:gate_"..gate.."_closed"
	end

    local def = {name=gateresult, param2=fdir}

    addDoorNode(pos, def, isClosed)

    -- the following opens and closes gates below and above in sync with this one
    -- (without three gate open/close sounds)

    local above = {x=pos.x, y=pos.y+1, z=pos.z}
    local below = {x=pos.x, y=pos.y-1, z=pos.z}
    local nodeabove = minetest.get_node(above)
    local nodebelow = minetest.get_node(below)

	if string.find(nodeabove.name, "homedecor:gate_"..gate) then
        addDoorNode(above, def, isClosed)
	end

	if string.find(nodebelow.name, "homedecor:gate_"..gate) then
        addDoorNode(below, def, isClosed)
	end
end

-- "paper" door/wall

minetest.register_node("homedecor:japanese_wall_top", {
	tiles = {
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_top.png",
		"homedecor_japanese_wall_top.png"
	},
	description = "Japanese wall (top)",
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.03125, 0.5, 0.5, 0.03125}, -- NodeBox1
			{-0.5, -0.5, 0, -0.469, 0.5, 0.0625}, -- NodeBox2
			{0.469, -0.5, 0, 0.5, 0.5, 0.0625}, -- NodeBox3
			{-0.5, -0.5, 0, 0.5, -0.46875, 0.0625}, -- NodeBox4
			{-0.5, 0.219, 0, 0.5, 0.5, 0.0625}, -- NodeBox5
			{-0.031, -0.5, 0, 0.031, 0.5, 0.0625}, -- NodeBox6
			{-0.5, -0.031, 0, 0.5, 0.03125, 0.0625}, -- NodeBox7
			{-0.281, -0.5, 0, -0.219, 0.5, 0.0625}, -- NodeBox8
			{0.219, -0.5, 0, 0.281, 0.5, 0.0625}, -- NodeBox9
			{-0.5, -0.281, 0, 0.5, -0.21875, 0.0625}, -- NodeBox10
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.0625},
	}
})

minetest.register_node("homedecor:japanese_wall_middle", {
	tiles = {
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_middle.png",
		"homedecor_japanese_wall_middle.png"
	},
	description = "Japanese wall",
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.03125, 0.5, 0.5, 0.03125}, -- NodeBox1
			{-0.5, -0.5, 0, -0.469, 0.5, 0.0625}, -- NodeBox2
			{0.469, -0.5, 0, 0.5, 0.5, 0.0625}, -- NodeBox3
			{-0.5, -0.5, 0, 0.5, -0.46875, 0.0625}, -- NodeBox4
			{-0.5, 0.469, 0, 0.5, 0.5, 0.0625}, -- NodeBox5
			{-0.031, -0.5, 0, 0.031, 0.5, 0.0625}, -- NodeBox6
			{-0.5, -0.031, 0, 0.5, 0.03125, 0.0625}, -- NodeBox7
			{-0.281, -0.5, 0, -0.219, 0.5, 0.0625}, -- NodeBox8
			{0.219, -0.5, 0, 0.281, 0.5, 0.0625}, -- NodeBox9
			{-0.5, -0.281, 0, 0.5, -0.21875, 0.0625}, -- NodeBox10
			{-0.5, 0.219, 0, 0.5, 0.28125, 0.0625}, -- NodeBox11
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.0625},
	}
})

minetest.register_node("homedecor:japanese_wall_bottom", {
	tiles = {
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_bottom.png",
		"homedecor_japanese_wall_bottom.png"
	},
	description = "Japanese wall (bottom)",
	drawtype = "nodebox",
	paramtype = "light",
        paramtype2 = "facedir",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.03125, 0.5, 0.5, 0.03125}, -- NodeBox1
			{-0.5, -0.5, 0, -0.469, 0.5, 0.0625}, -- NodeBox2
			{0.469, -0.5, 0, 0.5, 0.5, 0.0625}, -- NodeBox3
			{-0.5, -0.5, 0, 0.5, -0.21875, 0.0625}, -- NodeBox4
			{-0.5, 0.469, 0, 0.5, 0.5, 0.0625}, -- NodeBox5
			{-0.031, -0.5, 0, 0.031, 0.5, 0.0625}, -- NodeBox6
			{-0.5, -0.031, 0, 0.5, 0.03125, 0.0625}, -- NodeBox7
			{-0.281, -0.5, 0, -0.219, 0.5, 0.0625}, -- NodeBox8
			{0.219, -0.5, 0, 0.281, 0.5, 0.0625}, -- NodeBox9
			{-0.5, 0.219, 0, 0.5, 0.28125, 0.0625}, -- NodeBox11
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.0625},
	}
})

minetest.register_node("homedecor:tatami_mat", {
	tiles = {
		"homedecor_tatami.png",
		"homedecor_tatami.png",
		"homedecor_tatami.png",
		"homedecor_tatami.png",
		"homedecor_tatami.png",
		"homedecor_tatami.png"
	},
	description = "Japanese tatami",
	drawtype = "nodebox",
	paramtype = "light",
        groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		}
	}
})

homedecor.register("jpn_door_bottom", {
	description = "Japanese-style door",
	inventory_image = "homedecor_jpn_door_inv.png",
	tiles = {
                "homedecor_japanese_wall_edges.png",
                "homedecor_japanese_wall_edges.png",
                "homedecor_japanese_wall_edges.png",
                "homedecor_japanese_wall_edges.png",
		"homedecor_japanese_door_bottom.png"
	},
	groups = { snappy = 3 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.03125, 0.5, 0.5, 0.03125}, -- NodeBox1
			{-0.5, -0.5, 0, -0.44, 0.5, 0.0625}, -- NodeBox2
			{0.44, -0.5, 0, 0.5, 0.5, 0.0625}, -- NodeBox3
			{-0.5, -0.5, 0, 0.5, -0.4065, 0.0625}, -- NodeBox4
			{-0.5, 0.469, 0, 0.5, 0.5, 0.0625}, -- NodeBox5
			{-0.5, 0.1565, 0, 0.5, 0.21875, 0.0625}, -- NodeBox6
			{-0.5, -0.185, 0, 0.5, -0.125, 0.0625}, -- NodeBox7
			{-0.2185, -0.5, 0, -0.1565, 0.5, 0.0625}, -- NodeBox8
			{0.1565, -0.5, 0, 0.2185, 0.5, 0.0625}, -- NodeBox9
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0, 0.5, 1.5, 0.0625},
	},
	expand = { top = "homedecor:jpn_door_top" },
	on_rightclick = function(pos, node, clicker)
		local fdir = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "homedecor:jpn_door_bottom_open", param2 = fdir})
		minetest.set_node({x = pos.x, y=pos.y + 1, z = pos.z}, {name = "homedecor:jpn_door_top_open", param2 = fdir})
	end
})

minetest.register_node("homedecor:jpn_door_top", {
	tiles = {
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_door_top.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3, not_in_creative_inventory = 1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.03125, 0.5, 0.5, 0.03125}, -- NodeBox1
			{-0.5, -0.5, 0, -0.44, 0.5, 0.0625}, -- NodeBox2
			{0.44, -0.5, 0, 0.5, 0.5, 0.0625}, -- NodeBox3
			{-0.5, -0.5, 0, 0.5, -0.469, 0.0625}, -- NodeBox4
			{-0.5, 0.4065, 0, 0.5, 0.5, 0.0625}, -- NodeBox5
			{-0.5, 0.1255, 0, 0.5, 0.1875, 0.0625}, -- NodeBox6
			{-0.5, -0.2185, 0, 0.5, -0.1565, 0.0625}, -- NodeBox7
			{-0.2185, -0.5, 0, -0.1565, 0.5, 0.0625}, -- NodeBox8
			{0.1565, -0.5, 0, 0.2185, 0.5, 0.0625}, -- NodeBox9
		}
	},
	selection_box = homedecor.nodebox.null,
})

minetest.register_node("homedecor:jpn_door_bottom_open", {
	tiles = {
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_door_bottom.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3, not_in_creative_inventory = 1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5, -0.5, -0.03125, -0.5, 0.5, -0.03125}, -- NodeBox1
			{-1.5, -0.5, -0.0625, -1.44, 0.5, 0}, -- NodeBox2
			{-0.5625, -0.5, -0.0625, -0.5, 0.5, 0}, -- NodeBox3
			{-1.5, -0.5, -0.0625, -0.5, -0.40625, 0}, -- NodeBox4
			{-1.5, 0.469, -0.0625, -0.5, 0.5, 0}, -- NodeBox5
			{-1.5, 0.1565, -0.0625, -0.5, 0.21875, 0}, -- NodeBox6
			{-1.5, -0.1865, -0.0625, -0.5, -0.125, 0}, -- NodeBox7
			{-1.21875, -0.5, -0.0625, -1.1565, 0.5, 0}, -- NodeBox8
			{-0.84375, -0.5, -0.0625, -0.7815, 0.5, 0}, -- NodeBox9
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-1.5, -0.5, -0.0625, 0.5, 1.5, 0},
	},
	on_rightclick = function(pos, node, clicker)
		local fdir = minetest.get_node(pos).param2
		minetest.set_node(pos, {name = "homedecor:jpn_door_bottom", param2 = fdir})
		minetest.set_node({x = pos.x, y=pos.y + 1, z = pos.z}, {name = "homedecor:jpn_door_top", param2 = fdir})
	end,
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		local pos2 = { x = pos.x, y=pos.y + 1, z = pos.z }
		if minetest.get_node(pos2).name == "homedecor:jpn_door_top_open" then
			minetest.remove_node(pos2)
		end
	end,
	drop = "homedecor:jpn_door_bottom",
})

minetest.register_node("homedecor:jpn_door_top_open", {
	tiles = {
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_wall_edges.png",
		"homedecor_japanese_door_top.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { snappy = 3, not_in_creative_inventory = 1 },
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5, -0.5, -0.03125, -0.5, 0.5, -0.03125}, -- NodeBox1
			{-1.5, -0.5, -0.0625, -1.44, 0.5, 0}, -- NodeBox2
			{-0.5625, -0.5, -0.0625, -0.5, 0.5, 0}, -- NodeBox3
			{-1.5, -0.5, -0.0625, -0.5, -0.469, 0}, -- NodeBox4
			{-1.5, 0.4065, -0.0625, -0.5, 0.5, 0}, -- NodeBox5
			{-1.5, 0.1253, -0.0625, -0.5, 0.1875, 0}, -- NodeBox6
			{-1.5, -0.2185, -0.0625, -0.5, -0.15625, 0}, -- NodeBox7
			{-1.21875, -0.5, -0.0625, -1.1565, 0.5, 0}, -- NodeBox8
			{-0.84375, -0.5, -0.0625, -0.7815, 0.5, 0}, -- NodeBox9
		}
	},
	selection_box = homedecor.nodebox.null,
})


