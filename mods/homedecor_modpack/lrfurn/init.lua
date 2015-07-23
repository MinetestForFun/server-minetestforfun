lrfurn = {}
screwdriver = screwdriver or {}

lrfurn.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

function lrfurn.check_forward(pos, fdir, long, placer)
	if not fdir or fdir > 3 then fdir = 0 end

	local pos2 = { x = pos.x + lrfurn.fdir_to_fwd[fdir+1][1],     y=pos.y, z = pos.z + lrfurn.fdir_to_fwd[fdir+1][2]     }
	local pos3 = { x = pos.x + lrfurn.fdir_to_fwd[fdir+1][1] * 2, y=pos.y, z = pos.z + lrfurn.fdir_to_fwd[fdir+1][2] * 2 }

	local node2 = minetest.get_node(pos2)
	if node2 and node2.name ~= "air" then
		return false
	elseif minetest.is_protected(pos2, placer:get_player_name()) then
		if not long then
			minetest.chat_send_player(placer:get_player_name(), "Someone else owns the spot where other end goes!")
		else
			minetest.chat_send_player(placer:get_player_name(), "Someone else owns the spot where the middle or far end goes!")
		end
		return false
	end

	if long then
		local node3 = minetest.get_node(pos3)
		if node3 and node3.name ~= "air" then
			return false
		elseif minetest.is_protected(pos3, placer:get_player_name()) then
			minetest.chat_send_player(placer:get_player_name(), "Someone else owns the spot where the other end goes!")
			return false
		end
	end

	return true
end

dofile(minetest.get_modpath("lrfurn").."/longsofas.lua")
dofile(minetest.get_modpath("lrfurn").."/sofas.lua")
dofile(minetest.get_modpath("lrfurn").."/armchairs.lua")
dofile(minetest.get_modpath("lrfurn").."/coffeetable.lua")
dofile(minetest.get_modpath("lrfurn").."/endtable.lua")
