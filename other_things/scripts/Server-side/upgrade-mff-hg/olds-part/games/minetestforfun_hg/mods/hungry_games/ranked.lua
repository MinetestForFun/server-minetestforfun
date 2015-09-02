

ranked.players_ranking_file = minetest.get_worldpath() .. "/players_rankings.txt"
ranked.players_ranks = {["nb_quit"] = {}, ["nb_games"] = {}, ["nb_wins"] = {}, ["nb_lost"] = {}}
ranked.top_ranks = {}
ranked.formspec = ""

top = {}
dofile(minetest.get_modpath("hungry_games").."/top.lua")

-- save ranked table
function ranked.save_players_ranks()
	local input, err = io.open(ranked.players_ranking_file, "w")
	if input then
		input:write(minetest.serialize(ranked.players_ranks))
		input:close()
	else
		minetest.log("error", "open(" .. ranked.players_ranking_file .. ", 'w') failed: " .. err)
	end
end


-- load ranked table
function ranked.load_players_ranks()
	local time = os.date("%d %H %M"):split(" ")
	local day = tonumber(time[1])
	local hour = tonumber(time[2])
	local min = tonumber(time[3])
	if day == 1 and hour == 4
		and min >= 25 and min <= 40 then
		ranked.save_players_ranks()
		return ranked.players_ranks
	end
	local file = io.open(ranked.players_ranking_file, "r")
	if file then
		local t = minetest.deserialize(file:read("*all"))
		file:close()
		if t and type(t) == "table" then
			return t
		end
	end
	return {["nb_games"] = {}, ["nb_wins"] = {}, ["nb_lost"] = {}, ["nb_quit"] = {} }
end
ranked.players_ranks = ranked.load_players_ranks()

-- ranked table[key] +=1
function ranked.inc(name, key)
	if not ranked.players_ranks[key] then
		ranked.players_ranks[key] = {}
	end
	ranked.players_ranks[key][name] = (ranked.players_ranks[key][name] or 0 ) + 1
end


-- inventory_plus ranked menu
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if inventory_plus.is_called(fields, "hgranks", player) then
		local formspec = "size[9,8.5]"..
				default.inventory_background..
				default.inventory_listcolors..
				inventory_plus.get_tabheader(player, "hgranks")..
				ranked.get_player_ranks_formspec(player:get_player_name())..
				ranked.formspec..
				"label[2.1,8;Ranks are reset the first day of every month]"
		inventory_plus.set_inventory_formspec(player, formspec)
	end

end)

-- return info player ranks
function ranked.get_players_info(name)
	local t = {["nb_games"] = 0, ["nb_wins"] = 0, ["nb_lost"] = 0, ["nb_quit"] = 0,["wins_pct"] = 0}
	if ranked.players_ranks["nb_games"][name] then
		t["nb_games"] = ranked.players_ranks["nb_games"][name]
	end

	if ranked.players_ranks["nb_wins"][name] then
		t["nb_wins"] = ranked.players_ranks["nb_wins"][name]
	end

	if ranked.players_ranks["nb_lost"][name] then
		t["nb_lost"] = ranked.players_ranks["nb_lost"][name]
	end
	if ranked.players_ranks["nb_quit"][name] then
		t["nb_quit"] = ranked.players_ranks["nb_quit"][name]
	end

	if t["nb_wins"] > 0 and t["nb_games"] >0 then
		t["wins_pct"] = tonumber(math.floor(t["nb_wins"]*100/t["nb_games"]))
		if t["wins_pct"] > 100 then
			t["wins_pct"] = 100
		end
	end
	return t
end

-- sort table
function ranked.spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- set top 10 table
function ranked.set_top_players()
	local top_ranks = {}
	if ranked.players_ranks["nb_wins"] ~= nil then
		local i = 1
		-- this uses an custom sorting function ordering by score descending
		for k,v in ranked.spairs(ranked.players_ranks["nb_wins"], function(t,a,b) return t[b] < t[a] end) do
			top_ranks[i] = k
			i=i+1
			if #top_ranks >= 10 then
				break
			end
		end
	end
	return top_ranks
end


function ranked.set_ranked_formspec()
	local formspec = {"label[2.9,0;Hunger Games Rankings]"}
	table.insert(formspec, "label[0,0.5;Rank]") --rank
	table.insert(formspec, "label[0.9,0.5;Name]") --name
	table.insert(formspec, "label[3.4,0.5;Games]") --nbgames
	table.insert(formspec, "label[4.6,0.5;Wins]") --nbwins
	table.insert(formspec, "label[5.6,0.5;Lost]") --nblost
	table.insert(formspec, "label[6.6,0.5;Quit]") --nbquit
	table.insert(formspec, "label[7.6,0.5;Wins %]") --pct
	if ranked.top_ranks ~= nil then
		local Y = 2
		for i ,name in pairs(ranked.top_ranks) do
			local info = ranked.get_players_info(name)
			table.insert(formspec, "label[0,"..Y..";"..tostring(i).."]") -- rank
			table.insert(formspec, "label[0.9,"..Y..";"..tostring(name).."]") -- playername
			table.insert(formspec, "label[3.4,"..Y..";"..tostring(info["nb_games"]).."]") -- nbgames
			table.insert(formspec, "label[4.6,"..Y..";"..tostring(info["nb_wins"]).."]") -- nbwins
			table.insert(formspec, "label[5.6,"..Y..";"..tostring(info["nb_lost"]).."]") -- nblost
			table.insert(formspec, "label[6.6,"..Y..";"..tostring(info["nb_quit"]).."]") -- nbquit
			table.insert(formspec, "label[7.6,"..Y..";"..tostring(info["wins_pct"]).." %]") -- pct
			Y = Y + 0.6
		end
	end
	return table.concat(formspec)
end

-- update top 10 formspec
function ranked.update_formspec()
	ranked.top_ranks = ranked.set_top_players()
	ranked.formspec = ranked.set_ranked_formspec()
	minetest.after(2, top.update_name, 1) -- update top name wall
	minetest.after(5, top.update_name, 2)
	minetest.after(8, top.update_name, 3)
end

ranked.update_formspec()


-- get player ranks formspec
function ranked.get_player_ranks_formspec(name)
	local formspec = {}
	local info = ranked.get_players_info(name)
	table.insert(formspec, "label[0,1;-]") -- rank
	table.insert(formspec, "label[0.9,1;You]") -- playername
	table.insert(formspec, "label[3.4,1;"..tostring(info["nb_games"]).."]") -- nbgames
	table.insert(formspec, "label[4.6,1;"..tostring(info["nb_wins"]).."]") -- nbwins
	table.insert(formspec, "label[5.6,1;"..tostring(info["nb_lost"]).."]") -- nblost
	table.insert(formspec, "label[6.6,1;"..tostring(info["nb_quit"]).."]") -- nbquit
	table.insert(formspec, "label[7.6,1;"..tostring(info["wins_pct"]).." %]") -- pct
	return table.concat(formspec)
end

minetest.after(20, ranked.update_formspec)

-- Ranks
minetest.register_chatcommand("top3", {
	description = "Show the top 3 players",
	privs = {},
	params = "",
	func = function(name)
		local topstr = "Top 3 players : "
		if ranked.top_ranks[1] then
			topstr = topstr .. ranked.top_ranks[1] .. " is first; "
			if ranked.top_ranks[2] then
				topstr = topstr .. ranked.top_ranks[2] .. " is second; "
				if ranked.top_ranks[3] then
					topstr = topstr .. "and " .. ranked.top_ranks[3] .. " is third."
				else
					topstr = topstr .. "and that's it."
				end
			else
				topstr = topstr .. "and that's it."
			end
		else
			topstr = "Nobody is ranked at the moment."
		end
		return true, topstr
	end,
})
