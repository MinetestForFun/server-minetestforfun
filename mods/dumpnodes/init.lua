local function nd_get_tiles(nd)
    if nd.tiles then
            return nd.tiles
        elseif nd.tile_images then
            return nd.tile_images
        end
        return nil
end

minetest.register_chatcommand("dumpnodes", {
    params = "",
    description = "",
    privs = {server = true},
    func = function(plname, param)
        local n = 0
        local ntbl = {}
        for nn, nd in pairs(minetest.registered_nodes) do
            local prefix, name = nn:match('(.*):(.*)')
            if prefix == nil or name == nil or prefix == '' or name == '' then
                -- nothing
            else
                if ntbl[prefix] == nil then
                    ntbl[prefix] = {}
                end
                ntbl[prefix][name] = nd
            end
        end
        local out, err = io.open('nodes.txt', 'wb')
        if not out then
            return minetest.chat_send_player(plname, 'io.open: ' .. err)
        end
        for prefix, i in pairs(ntbl) do
            out:write('# ' .. prefix .. '\n')
            for name, nd in pairs(i) do
                if nd.drawtype ~= 'airlike' and nd_get_tiles(nd) ~= nil then
                    local tl = nd_get_tiles(nd)[1]
                    if type(tl) == 'table' then
                        tl = tl.name
                    end
                    tl = (tl .. '^'):match('(.-)^')
                    out:write(prefix .. ':' .. name .. ' ' .. tl .. '\n')
                    n = n + 1
                end
            end
            out:write('\n')
        end
        out:close()
        minetest.chat_send_player(plname, n .. " nodes dumped.")
    end,
})
