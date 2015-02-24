-- helper functions

minetest.register_globalstep(function(dtime)
	nature.dtime = dtime
	if #nature.blossomqueue > 0 and dtime < 0.2 then
		local pos  = nature.blossomqueue[1][1]
		local node = nature.blossomqueue[1][2]
		if (nature.blossomqueue[1][3] and not nature:is_near_water(pos)) then
			table.remove(nature.blossomqueue, 1) -- don't grow if it's not near water, pop from queue.
			return
		end
		nature:grow_node(pos, nature.blossom_node) -- now actually grow it.
		table.remove(nature.blossomqueue, 1)
	end
end)

function nature.enqueue_node(pos, node, fcn)
	local idx = #nature.blossomqueue
	nature.blossomqueue[idx+1] = {}
	nature.blossomqueue[idx+1][1] = pos
	nature.blossomqueue[idx+1][2] = node
	nature.blossomqueue[idx+1][3] = fcn
end

local function set_young_node(pos)
    local meta = minetest.get_meta(pos)

    meta:set_string(nature.node_young, nature.setting_true)
    minetest.after(nature.youth_delay,
        function(pos)
            local meta = minetest.get_meta(pos)
            meta:set_string(nature.node_young, nature.setting_false)
        end,
    pos)
end

local function is_not_young(pos)
    local meta = minetest.get_meta(pos)

    local young = meta:get_string(nature.node_young)
    return young ~= nature.setting_true
end

function nature:grow_node(pos, nodename)
    if pos ~= nil then
        local light_enough = (minetest.get_node_light(pos, nil) or 0)
                >= nature.minimum_growth_light 

        if is_not_young(pos) and light_enough then
            minetest.remove_node(pos)
            minetest.set_node(pos, { name = nodename })
            set_young_node(pos)

            minetest.log("info", nodename .. " has grown at " .. pos.x .. ","
                .. pos.y .. "," .. pos.z)
        end
    end
end

function nature:is_near_water(pos)
    return nature.distance_from_water == -1 or minetest.find_node_near(pos, nature.distance_from_water,
            { "default:water_source" }) ~= nil
end
