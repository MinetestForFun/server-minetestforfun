
local CHECK_INTERVAL = 0.25;
local DAMAGE_INTERVAL = 1;
local WEAR_PER_HP = 400;

-- Boilerplate to support localized strings if intllib mod is installed.
local S;
if (minetest.get_modpath("intllib")) then
    dofile(minetest.get_modpath("intllib").."/intllib.lua");
    S = intllib.Getter(minetest.get_current_modname());
else
    S = function ( s ) return s; end
end

minetest.register_tool("survival_hazards:suit", {
    description = S("Hazard Suit");
    groups = { };
    inventory_image = "survival_hazards_suit.png";
});

minetest.register_craft({
    output = 'survival_hazards:suit';
    recipe = {
        { '', 'bucket:bucket_empty', '' },
        { 'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal' },
        { '', 'default:mese_crystal', '' },
    };
});

minetest.register_craft({
    type = "shapeless";
    output = 'survival_hazards:suit';
    recipe = {
        'survival_hazards:suit',
        'default:mese_crystal',
    };
});

local dtime_count = 0;

local function override ( name )
    local nodedef = minetest.registered_nodes[name];
    nodedef.damage_per_second = nil;
    minetest.register_node(":"..name, nodedef);
end

local materials = { };

survival.hazards = { };

survival.hazards.register_material = function ( nodename, matdef )
    matdef.damage = (
        matdef.damage
        or minetest.registered_nodes[nodenames].damage_per_second
        or 0
    );
    materials[nodename] = matdef;
    override(nodename);
end

survival.hazards.register_liquid = function ( nodename, matdef )
    survival.hazards.register_material(nodename.."_source", matdef);
    survival.hazards.register_material(nodename.."_flowing", matdef);
end

survival.hazards.get_material_damage = function ( nodename )
    return materials[nodename] or 0;
end

survival.hazards.register_liquid("default:lava", {
    damage = 8;
});

dofile(minetest.get_modpath("survival_hazards").."/toxicwaste.lua");

local players_in_hazard = { };

minetest.register_globalstep(function ( dtime )
    dtime_count = dtime_count + dtime;
    if (dtime_count >= CHECK_INTERVAL) then
        local count = dtime_count;
        dtime_count = 0;
        for _, player in pairs(minetest.get_connected_players()) do
            local pos = player:getpos();
            local nodey0 = minetest.get_node(pos).name;
            local nodey1 = minetest.get_node({ x=pos.x, y=pos.y+1, z=pos.z }).name;
            local name = player:get_player_name();
            local dmg0 = (materials[nodey0] and materials[nodey0].damage);
            local dmg1 = (materials[nodey1] and materials[nodey1].damage);
            if (dmg0 or dmg1) then
                players_in_hazard[name] = (players_in_hazard[name] or 0) + count;
                if (players_in_hazard[name] >= DAMAGE_INTERVAL) then
                    players_in_hazard[name] = 0;
                    local damage;
                    local matdef;
                    dmg0 = dmg0 or 0;
                    dmg1 = dmg1 or 0;
                    if (dmg0 > dmg1) then
                        damage = dmg0;
                        matdef = materials[nodey0];
                    else
                        damage = dmg1;
                        matdef = materials[nodey1];
                    end
                    local wear = damage * WEAR_PER_HP;
                    local inv = player:get_inventory();
                    local stack;
                    local index;
                    for i = 1, inv:get_size("main") do
                        stack = inv:get_stack("main", i);
                        if ((stack:get_name() == "survival_hazards:suit")
                         and ((65535 - stack:get_wear()) > wear)) then
                            index = i;
                            break;
                        end
                    end
                    if (index) then
                        stack:add_wear(wear);
                        inv:set_stack("main", index, stack);
                        -- TODO: Add "use" sound.
                    else
                        player:set_hp(player:get_hp() - damage);
                        -- TODO: Add "damage" sound.
                    end
                end
            else
                players_in_hazard[name] = 0;
            end
        end
    end
end);
