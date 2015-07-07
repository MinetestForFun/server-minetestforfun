local time_interval = 300.0
local fifo_path = "/tmp/mt_players_fifo"

function players_data()
    local ps = {}
    for _, player in ipairs(minetest.get_connected_players()) do
        local pos = player:getpos()
        local pname = player:get_player_name()
        local data = {
            name = pname,
            x = pos.x,
            y = pos.y,
            z = pos.z }
        table.insert(ps, data)
    end
    if table.getn(ps) == 0 then
        return '[]\n'
    end
    return minetest.write_json(ps) .. '\n'
end

function time_interval_func()
    local players = players_data()
    local fifo = io.open(fifo_path, 'w')
    if (fifo ~= nil) then
        fifo:write(players)
        fifo:close()
    end
    minetest.after(time_interval, time_interval_func)
end

minetest.after(time_interval, time_interval_func)
