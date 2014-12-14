local NODE_YOUNG = "young"

local SETTING_TRUE = "true"
local SETTING_FALSE = "false"

local YOUTH_DELAY = 5

nature = {}

local function set_young_node(pos)
    local meta = minetest.get_meta(pos)

    meta:set_string(NODE_YOUNG, SETTING_TRUE)
    minetest.after(YOUTH_DELAY,
        function(pos)
            local meta = minetest.get_meta(pos)
            meta:set_string(NODE_YOUNG, SETTING_FALSE)
        end,
    pos)
end

local function is_not_young(pos)
    local meta = minetest.get_meta(pos)

    local young = meta:get_string(NODE_YOUNG)
    return young ~= SETTING_TRUE
end

function nature:grow_node(pos, nodename)
    if pos ~= nil then
        local light_enough = minetest.get_node_light(pos, nil)
                >= MINIMUM_GROWTH_LIGHT 

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
    return DISTANCE_FROM_WATER == -1 or minetest.find_node_near(pos, DISTANCE_FROM_WATER,
            { "default:water_source" }) ~= nil
end
