
-- Boilerplate to support localized strings if intllib mod is installed.
local S;
if (minetest.get_modpath("intllib")) then
    dofile(minetest.get_modpath("intllib").."/intllib.lua");
    S = intllib.Getter(minetest.get_current_modname());
else
    S = function ( s ) return s; end
end

local commands = { };

survival.register_command = function ( name, def )
    commands[name] = def;
end

minetest.register_chatcommand("survival", {
    params = S("<command> <args>...");
    description = S("Configuration of survival_lib");
    func = function ( name, param )
        local cmd = param:match("^%s*(%S+)%s*");
        if (not cmd) then
            minetest.chat_send_player(name, S("No subcommand specified."));
            return;
        end
        if (not commands[cmd]) then
            minetest.chat_send_player(name, S("Unknown subcommand `%s'."):format(cmd));
            return;
        end
        if (commands[cmd].privs) then
            local got, miss = minetest.check_player_privs(name, commands[cmd].privs);
            if (not got) then
                local text = S("Missing privileges: %s"):format(minetest.privs_to_string(miss));
                minetest.chat_send_player(name, text);
                return;
            end
        end
        local args = param:match("^%s*%S+%s+(.-)%s*$") or "";
        commands[cmd].func(name, args);
    end;
});

survival.register_command("help", {
    params = S("<subcommand>");
    description = S("Get help about a subcommand");
    privs = { };
    func = function ( name, args )
        local cmd = args:match("^%s*(%S+)");
        local send = minetest.chat_send_player;
        if (cmd and (cmd ~= "")) then
            if (not commands[cmd]) then
                send(name, S("Unknown subcommand `%s'."):format(cmd));
                return;
            end
            send(name, cmd.." "..(commands[cmd].params or ""));
            send(name, "  "..(commands[cmd].description or ""));
        else
            local cmds = "";
            for cmd in pairs(commands) do
                if (cmds ~= "") then cmds = cmds..", "; end
                cmds = cmds..cmd;
            end
            send(name, S("Available commands: %s"):format(cmds));
        end
    end;
});

survival.register_command("enable", {
    params = S("<state>");
    description = S("Enable a state");
    privs = { };
    func = function ( name, args )
        local stname = args:match("^%s*(%S+)");
        local send = minetest.chat_send_player;
        if (stname and (stname ~= "")) then
            if (not survival.registered_states[stname]) then
                send(name, S("Unknown state `%s'."):format(stname));
                return;
            end
            survival.registered_states[stname].enabled = true;
            send(name, S("State `%s' enabled."):format(stname));
        else
            minetest.chat_send_player(name, S("No state specified."));
            return;
        end
    end;
});

survival.register_command("disable", {
    params = S("<state>");
    description = S("Disable a state");
    privs = { };
    func = function ( name, args )
        local stname = args:match("^%s*(%S+)");
        local send = minetest.chat_send_player;
        if (stname and (stname ~= "")) then
            if (not survival.registered_states[stname]) then
                send(name, S("Unknown state `%s'."):format(stname));
                return;
            end
            survival.registered_states[stname].enabled = true;
            send(name, S("State `%s' disabled."):format(stname));
        else
            minetest.chat_send_player(name, S("No state specified."));
            return;
        end
    end;
});

survival.register_command("state", {
    params = S("<state>");
    description = S("Get the enabled/disabled flag of a state");
    privs = { };
    func = function ( name, args )
        local stname = args:match("^%s*(%S+)");
        local send = minetest.chat_send_player;
        if (stname and (stname ~= "")) then
            if (not survival.registered_states[stname]) then
                send(name, S("Unknown state `%s'."):format(stname));
                return;
            end
            local flag = survival.registered_states[stname].enabled;
            send(name, S("State `%s' is %s."):format(stname, (flag and S("Enabled")) or S("Disabled")));
        else
            minetest.chat_send_player(name, S("No state specified."));
            return;
        end
    end;
});

survival.register_command("list", {
    params = "";
    description = S("List available states and enabled/disabled flags");
    privs = { };
    func = function ( name, args )
        local send = minetest.chat_send_player;
        for _, def in ipairs(survival.registered_states) do
            send(name, S("%s(%s): %s"):format(
                (def.label or def.name),
                def.name,
                (def.enabled and S("Enabled")) or S("Disabled")
            ));
        end
    end;
});
