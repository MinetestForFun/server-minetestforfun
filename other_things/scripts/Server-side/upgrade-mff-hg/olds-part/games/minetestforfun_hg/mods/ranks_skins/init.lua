--
-- Skins depending on ranks
--

-- For 3d_armor
ranks_skins = {skins = {}}

function update_rank_skin(player)
	local ptexture = "character.png"
	local name = player:get_player_name()
	if not ranked.top_ranks[1] then
		ranked.top_ranks = ranked.set_top_players()
	end
	for index, playerName in pairs(ranked.top_ranks) do
		if playerName == name then
			if index <= 3 then
				ptexture = "character_top3.png"
				break
			elseif index <= 10 then
				ptexture = "character_top10.png"
				break
			end
		end
	end
	print(ptexture)
	default.player_set_textures(player, {ptexture,})
	ranks_skins.skins[name] = ptexture
end

function update_rank_skins()
	for _, ref in pairs(minetest.get_connected_players()) do
		update_rank_skin(ref)
	end
end

minetest.register_on_joinplayer(update_rank_skin)
--minetest.register_on_joinplayer(function(player) minetest.after(2, update_rank_skin, player) end)
