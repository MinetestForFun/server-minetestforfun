
local config;
local config_modified;

local function do_load_config ( f )

    for line in f:lines() do
        line = line:trim();
        local c1 = line:sub(1, 1);
        local eq_pos = line:find("=", 1, true);
        if ((c1 ~= "#") and (c1 ~= ";") and eq_pos) then
            local name = line:sub(1, eq_pos - 1):trim();
            local value = line:sub(eq_pos + 1):trim();
            config[name] = value;
        end
    end

end

local CONF_FILE = minetest.get_worldpath().."/survival_lib.conf";

local config_files = {
    minetest.get_modpath("survival_lib").."/survival_lib.conf",
    CONF_FILE,
};

local function load_config ( )

    config = { };

    for _,file in ipairs(config_files) do
        local f = io.open(file);
        if (f) then
            do_load_config(f);
            f:close();
            minetest.log("action", "survival_lib: Loaded config from `"..file.."'");
        end
    end

    config_modified = false;

end

load_config();

survival.conf_set = function ( name, value )
    config[name] = tostring(value);
    config_modified = true;
end

-- Just an alias
survival.conf_setnum = survival.conf_set;

survival.conf_setbool = function ( name, value )
    config[name] = (value and "true") or "false";
    config_modified = true;
end

survival.conf_setpos = function ( name, value )
    config[name] = minetest.pos_to_string(value);
    config_modified = true;
end

survival.conf_get = function ( name, default )
    return (config[name] or default);
end

survival.conf_getnum = function ( name, default )
    return (tonumber(config[name]) or default);
end

survival.conf_getpos = function ( name, default )
    return ((config[name] and minetest.string_to_pos(config[name])) or default);
end

survival.conf_getbool = function ( name, default )
    local val = config[name];
    if (not val) then return default; end
    val = val:lower();
    return (
        (val == "true")
     or (val == "on")
     or (val == "enabled")
     or (val == "yes")
     or (tonumber(val) and (tonumber(val) ~= 0))
    );
end
