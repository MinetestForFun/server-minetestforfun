lrfurn = {}
screwdriver = screwdriver or {}

lrfurn.fdir_to_fwd = {
	{  0,  1 },
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
}

function lrfurn.check_forward(pos, fdir, long)

	if not fdir or fdir > 3 then fdir = 0 end

	local pos2 = { x = pos.x + lrfurn.fdir_to_fwd[fdir+1][1],     y=pos.y, z = pos.z + lrfurn.fdir_to_fwd[fdir+1][2]     }
	local pos3 = { x = pos.x + lrfurn.fdir_to_fwd[fdir+1][1] * 2, y=pos.y, z = pos.z + lrfurn.fdir_to_fwd[fdir+1][2] * 2 }

	local node2 = minetest.get_node(pos2)
	if node2 and node2.name ~= "air" then return false end

	if long then
		local node3 = minetest.get_node(pos3)
		if node3 and node3.name ~= "air" then return false end
	end

	return true
end

dofile(minetest.get_modpath("lrfurn").."/longsofas.lua")
dofile(minetest.get_modpath("lrfurn").."/sofas.lua")
dofile(minetest.get_modpath("lrfurn").."/armchairs.lua")
dofile(minetest.get_modpath("lrfurn").."/coffeetable.lua")
dofile(minetest.get_modpath("lrfurn").."/endtable.lua")
