future_ban_list = {}

local file = io.open(minetest.get_worldpath().."/future_banlist.txt", "r")
if file then
    future_ban_list = minetest.deserialize(file:read("*all"))
    file:close()
    if not future_ban_list then
        future_ban_list = {}
    end
end

local function save_file()
    local file = io.open(minetest.get_worldpath().."/future_banlist.txt", "w")
    if file then
        file:write(minetest.serialize(future_ban_list))
        file:close()
    end
end

minetest.register_chatcommand("future_ban", {
    params = "<playername> | leave playername out to see the future ban list",
    description = "The player will be banned when trying to join",
    privs = {ban=true},
    func = function(name, param)
        if param == "" then
            minetest.chat_send_player(name, "Future ban list: " .. dump(future_ban_list))
            return
        end
        if not minetest.get_player_by_name(param) then
            table.insert(future_ban_list, param)
            minetest.chat_send_player(name, param .. " to future ban list added.")
            minetest.log("action", name .. " added " .. param .. " to future ban list.")
            save_file()
            return
        end
        if not minetest.ban_player(param) then
            table.insert(future_ban_list, param)
            minetest.chat_send_player(name, desc .. " to future ban list added.")
            minetest.log("action", name .. " added " .. desc .. " to future ban list.")
            save_file()
        else
            local desc = minetest.get_ban_description(param)
            minetest.chat_send_player(name, "Banned " .. desc .. ".")
            minetest.log("action", name .. " bans " .. desc .. ".")
        end
    end
})

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    for i,n in ipairs(future_ban_list) do
        if n == name then
            if not minetest.ban_player(name) then
                minetest.chat_send_player(name, "Failed to ban player " .. name .. " (from future ban list).")
            else
                local desc = minetest.get_ban_description(name)
                minetest.log("action", desc .. " banned (from future ban list).")
                table.remove(future_ban_list, i)
                save_file()
            end
        end
    end
end)
