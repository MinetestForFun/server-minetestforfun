-- Functions
--

function whoison.functions.load(param)
    --[[
        Values for param :
            * `E` : Everyone
            * <name> : name
    ]]--

    if param == "E" then
        for line in whoison.presence_file:lines() do
            local datas = minetest.deserialize(line)
            if not datas then
                minetest.log("error", "[whoison] Cannot load line (" .. line ..
                    ") : invalid line")
                return false
            end
            return {[datas.name] = datas.time}
        end
        return table
    elseif minetest.get_player_by_name(param) then
        for line in whoison.presence_file:lines() do
            local datas = minetest.deserialize(line)
            if datas then
                if datas.name == param then
                    return datas.time
                end
            end
        end
        minetest.log("error", "[whoison] Cannot load datas for " .. param ..
            " : player not registered")
        return false
    else
        minetest.log("error", "[whoison] Cannot load datas for " .. param ..
            " : not a player nor 'Everyone'")
        return false
    end
end

function whoison.functions.save(param)
    --[[
        Values for param :
            * <name> : name
    ]]--

    for line in whoison.presence_file:lines() do
        local datas = minetest.deserialize(line)
        if datas then
            if datas.name == param then
                -- Erase line
                local i = 0
                whoison.presence_file:seek(string.len(line),"cur")
                print("removing " .. string.len(line))
                while i < string.len(line) do
                    whoison.presence_file:write("\b")
                    i = i + 1
                end
                whoison.presence_file:write(minetest.serialize(
                    {name = param, time = whoison.datas[param]}
                ) .. "\n")
                return true
            end
        end
    end
    whoison.presence_file:write(minetest.serialize(
        {name = param, time = whoison.datas[param]}
    ) .. "\n")
    return true
end
