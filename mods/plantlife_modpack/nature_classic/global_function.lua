-- helper functions

local function process_blossom_queue_item()
	local pos  = nature.blossomqueue[1][1]
	local node = nature.blossomqueue[1][2]
	local replace = nature.blossomqueue[1][3]
	if (nature.blossomqueue[1][3] == nature.blossom_node and not nature:is_near_water(pos)) then
		table.remove(nature.blossomqueue, 1) -- don't grow if it's not near water, pop from queue.
		return
	end
	nature:grow_node(pos, replace) -- now actually grow it.
	table.remove(nature.blossomqueue, 1)
end

minetest.register_globalstep(function(dtime)
	nature.dtime = dtime
	if #nature.blossomqueue > 0 and dtime < 0.2 then
		local i = 1
		if dtime < 0.1 then
			i = i + 4
		end
		if dtime < 0.05 then
			i = i + 10
		end
		while #nature.blossomqueue > 0 and i > 0 do
			process_blossom_queue_item()
			i = i - 1
		end
	end
end)

function nature.enqueue_node(pos, node, replace)
	local idx = #nature.blossomqueue
	if idx < nature.blossomqueue_max then
		local enqueue_prob = 0
		if idx < nature.blossomqueue_max * 0.8 then
			enqueue_prob = 1
		else
			-- Reduce queue growth as it gets closer to its max.
			enqueue_prob = 1 - (idx - nature.blossomqueue_max * 0.8) / (nature.blossomqueue_max * 0.2)
		end
		if enqueue_prob == 1 or math.random(100) <= 100 * enqueue_prob then
			nature.blossomqueue[idx+1] = {}
			nature.blossomqueue[idx+1][1] = pos
			nature.blossomqueue[idx+1][2] = node
			nature.blossomqueue[idx+1][3] = replace
		end
	end
end

local function set_young_node(pos)
    local meta = minetest.get_meta(pos)

    meta:set_int(nature.meta_blossom_time, minetest.get_gametime())
end

local function is_not_young(pos)
    local meta = minetest.get_meta(pos)

    local blossom_time = meta:get_int(nature.meta_blossom_time)
    return not (blossom_time and minetest.get_gametime() - blossom_time < nature.blossom_duration)
end

function nature:grow_node(pos, nodename)
    if pos ~= nil then
        local light_enough = (minetest.get_node_light(pos, nil) or 0)
                >= nature.minimum_growth_light

        if is_not_young(pos) and light_enough then
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
