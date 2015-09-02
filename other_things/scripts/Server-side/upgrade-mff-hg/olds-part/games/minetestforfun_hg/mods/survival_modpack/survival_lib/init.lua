
survival = { };
survival.active = false

local player_states = { };
local hudbar_active = {}

-- Boilerplate to support localized strings if intllib mod is installed.
local S;
if (minetest.get_modpath("intllib")) then
    dofile(minetest.get_modpath("intllib").."/intllib.lua");
    S = intllib.Getter(minetest.get_current_modname());
else
    S = function ( s ) return s; end
end

survival.distance3d = function ( p1, p2 )
    local lenx = math.abs(p2.x - p1.x);
    local leny = math.abs(p2.y - p1.y);
    local lenz = math.abs(p2.z - p1.z);
    local hypotxz = math.sqrt((lenx * lenx) + (lenz * lenz));
    return math.sqrt((hypotxz * hypotxz) + (leny * leny));
end

dofile(minetest.get_modpath("survival_lib").."/config.lua");
dofile(minetest.get_modpath("survival_lib").."/chatcmds.lua");

survival.registered_states = { };

survival.register_state = function ( name, def )
    if (def.command_name) then
        local lbl = (def.label or def.command_name);
        def.command_func = function ( name, param )
            local val = math.floor(def.get_scaled_value(player_states[name][def.name]));
            local val2 = math.max(0, math.min(val / 10, 10));
            minetest.chat_send_player(name, lbl..": ["..val.."%] "..string.rep("|", val2));
        end;
        minetest.register_chatcommand(def.command_name, {
            params = "";
            description = S("Display %s"):format(lbl);
            func = def.command_func;
        });
    end
    if (def.enabled == nil) then
        def.enabled = true;
    end
    def.name = name;
    hb.register_hudbar(name, 0xFFFFFF, def.label, {icon = def.hud.image, bar = def.hud.bar}, def.default_scaled_value, 100, false, "%s: %d%%")
    survival.registered_states[name] = def;
    survival.registered_states[#survival.registered_states + 1] = def;
end

survival.enable = function()
    for _,player in pairs(minetest.get_connected_players()) do
        local inv = player:get_inventory();
        local plname = player:get_player_name();
        for i, def in ipairs(survival.registered_states) do
            if (def.enabled) then
                local name = def.name;
                survival.reset_player_state(plname, name);
                if hudbar_active[plname] then
                    hb.unhide_hudbar(player, name);
                end
            end
        end
    end
    survival.active = true
end

survival.disable = function()
    for _,player in pairs(minetest.get_connected_players()) do
        local inv = player:get_inventory();
        local plname = player:get_player_name();
        for i, def in ipairs(survival.registered_states) do
            if (def.enabled) then
                local name = def.name;
                survival.reset_player_state(plname, name);
                local state = player_states[plname][name];
                if hudbar_active[plname] then
                    hb.change_hudbar(player, name, math.floor(def.get_scaled_value(state)));
                    hb.hide_hudbar(player, name);
                end
            end
        end
    end
    survival.active = false
end


survival.player_hide_hudbar = function(plname)
	local player = minetest.get_player_by_name(plname)
	if not player then return end
	for i, def in ipairs(survival.registered_states) do
		if (def.enabled) then
			local name = def.name;
			survival.reset_player_state(plname, name);
			local state = player_states[plname][name];
			if hudbar_active[plname] then
				hb.change_hudbar(player, name, math.floor(def.get_scaled_value(state)));
				hb.hide_hudbar(player, name);
			end
		end
	end
end



survival.get_player_state = function ( name, stname )
    if (name and stname and player_states[name]) then
        return player_states[name][stname];
    else
        return nil;
    end
end

survival.set_player_state = function ( name, stname, state )
    if (name and stname and state) then
        if (not player_states[name]) then
            player_states[name] = { };
        end
        player_states[name][stname] = state;
    end
end

survival.reset_player_state = function ( name, stname )
    if (name and stname and survival.registered_states[stname] and player_states[name]) then
        player_states[name][stname] = survival.registered_states[stname].get_default(player_states[name][stname].hudid);
    end
end

local chat_cmd_def = {
    params = "";
    description = S("Display all player stats");
    func = function ( name, param )
        for i, def in ipairs(survival.registered_states) do
            if (not def.not_in_plstats) then
                local val = math.floor(def.get_scaled_value(player_states[name][def.name]));
                local val2 = math.max(0, math.min(val / 10, 10));
                minetest.chat_send_player(name, def.label..": ["..val.."%] "..string.rep("|", val2));
            end
        end
    end;
};

minetest.register_chatcommand("s", chat_cmd_def);

local timer = 0;
local MAX_TIMER = 0.5;

minetest.register_globalstep(function ( dtime )

    timer = timer + dtime;
    if (timer < MAX_TIMER) then return; end
    local tmr = timer;
    timer = 0;

    for _,player in pairs(minetest.get_connected_players()) do
        local inv = player:get_inventory();
        local plname = player:get_player_name();
        for i, def in ipairs(survival.registered_states) do
            if (def.enabled) then
                local name = def.name;
                local state = player_states[plname][name];
                if (survival.active and def.on_update) then
                    def.on_update(tmr, player, state);
                end
                if hudbar_active[plname] then
                    hb.change_hudbar(player, name, math.floor(def.get_scaled_value(state)));
                end
            end
        end
    end

end);

local HUD_DEFAULTS = {
    pos = {x=0.525, y=0.903};
    scale = {x=0.5, y=0.5};
    image = "default_stone.png";
    number = 20;
};

minetest.register_on_joinplayer(function ( player )
    local plname = player:get_player_name();
    if (not player_states[plname]) then
        player_states[plname] = { };
    end
    for i, def in ipairs(survival.registered_states) do
        local name = def.name;
        if (not player_states[plname][name]) then
            player_states[plname][name] = def.get_default(nil);
        end
    end
    minetest.after(0.5, function ( self )
        for i, def in ipairs(survival.registered_states) do
            local name = def.name;
            hb.init_hudbar(player, name, math.floor(def.get_scaled_value(player_states[plname][def.name])), 100, not survival.active);
            hudbar_active[plname] = true;
        end
    end);
end);

minetest.register_on_leaveplayer(function ( player )
   hudbar_active[player:get_player_name()] = false;
end);

local event_listeners = { };

survival.register_on_event = function ( event, func )
    if (not event_listeners[event]) then
        event_listeners[event] = { };
    end
    event_listeners[event][#event_listeners[event]] = func;
end

survival.post_event = function ( event, ... )
    if (not event_listeners[event]) then return; end
    for _,func in ipairs(event_listeners[event]) do
        local r = func(...);
        if (r ~= nil) then return r; end
    end
end

local STATEFILE = minetest.get_worldpath().."/survival_lib.states";

local function load_table ( lines, index )
    local t = { };
    while (index <= #lines) do
        local line = lines[index];
        index = index + 1;
        local c = line:sub(1, 1);
        if (c == "{") then
            local k = line:sub(2);
            t[k], index = load_table(lines, index);
        elseif (c == "}") then
            return t, index;
        elseif (c == "=") then
            line = line:sub(2);
            local p = line:find("=", 1, true);
            local k = line:sub(1, p - 1);
            local fullv = line:sub(p + 1);
            local typ = fullv:sub(1, 1);
            local v = fullv:sub(3);
            if (typ == "S") then
                -- `v' is unchanged
            elseif (typ == "N") then
                v = tonumber(v) or 0;
            elseif (typ == "B") then
                v = (v:lower() == "true");
            end
            t[k] = v;
        end
    end
    return t, index;
end

local function load_states ( )
    local f = io.open(STATEFILE);
    if (not f) then return; end
    local r = { };
    local stack = { r };
    local lines = { };
    for line in f:lines() do
        lines[#lines + 1] = line;
    end
    player_states = load_table(lines, 1);
    f:close();
end

local function save_table ( f, t, name )
    f:write("{"..name.."\n");
    for k, v in pairs(t) do
        if (type(v) == "table") then
            save_table(f, v, k);
        elseif (type(v) == "string") then
            f:write("="..k.."=S:"..v.."\n");
        elseif (type(v) == "number") then
            f:write("="..k.."=N:"..v.."\n");
        elseif (type(v) == "boolean") then
            f:write("="..k.."=B:"..((v and "true") or "false").."\n");
        end
    end
    f:write("}\n");
end

local function save_states ( )
    local f = io.open(STATEFILE, "w");
    if (not f) then return; end
    for k, v in pairs(player_states) do
        save_table(f, v, k);
    end
    f:close();
end

minetest.register_on_shutdown(save_states);
load_states();
