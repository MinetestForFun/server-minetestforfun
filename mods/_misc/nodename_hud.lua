local wield={}
local huds={}
local dtimes={}
local dlimit=60
local airhudmod = minetest.get_modpath("4air")

local function get_desc(item)
	if minetest.registered_nodes[item] then return minetest.registered_nodes[item]["description"] end
	if minetest.registered_items[item] then return minetest.registered_items[item]["description"] end
	if minetest.registered_craftitems[item] then return minetest.registered_craftitems[item]["description"] end
	if minetest.registered_tools[item] then return minetest.registered_tools[item]["description"] end
	return ""
end

minetest.register_globalstep(function(dtime)
local players = minetest.get_connected_players()
for i,player in ipairs(players) do
	local pll = player:get_player_name()
	local wstack = player:get_wielded_item():get_name()
	local shift = player:get_player_control()['sneak']
	local meta = player:get_wielded_item():get_metadata()
	local desc
	if not shift then
		desc = wstack
	else
		desc = wstack
	end
	if dtimes[pll] then dtimes[pll]=dtimes[pll]+dtime else dtimes[pll]=0 end
	if dtimes[pll]>dlimit then
		if huds[pll] then player:hud_remove(huds[pll]) end
		dtimes[pll]=dlimit+1
	end
	if wstack ~= wield[pll] then
		wield[pll]=wstack
		dtimes[pll]=0
		if huds[pll]
		then
				player:hud_remove(huds[pll])
		end
		local off = {x=0, y=-70}
		if airhudmod then off.y=off.y-20 end
		huds[pll] = player:hud_add({
										hud_elem_type = "text",
										position = {x=0.5, y=1},
										offset = off,
										alignment = {x=0, y=0},
										number = 0xFFFFFF ,
										text = desc,
										})
	end

end
end)