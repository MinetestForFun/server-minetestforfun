local serverguide_Book_title="The server guide"

local serverguide_Tab_Text_1=[[
	Server info
	MinetestForFun Server (hardcore)
	Base server (classic) of the MinetestForFun Team
]]
local serverguide_Tab_Text_2= [[
	1) No intentional try to disturb the server's stability will be tolerated.
	2) Cheating (hack, modified client, ...) is forbidden on this server.
	Be fair-play and learn to play according to the rules.
	3) On the server, PVP is authorized and theft/grief as well, to the exception
	of public buildings. (remember to use the areas mod to protect your buildings)
	4) Please do not spam or flood.
	5) Each player is responsible of his/her own account, we can't be held
	liable for any illegitimate use of it.
	6) Try to avoid 1x1 towers and overall destroying the environment, anywhere
	that is. This way the server will stay as beautiful, wild and
	natural as possible.
	7) Do not ask to be a member of the server staff.
	8) Swearing, racism, hate speech and the like is strictly prohibited.
]]
local serverguide_Tab_Text_3= [[
	Rulers info (moderator or admins)
	Adminitrator : Darcidride
	Moderators :  Cyberpangolin, crabman, Mg
]]
local serverguide_Tab_Text_4=[[
	Commands:
	- /guide : show this guide
]]
local serverguide_Tab_Text_5=[[
	Help info
	Help you self
	Call moderators/administrator if you have questions on the server
	or need specific help.
]]

local serverguide_Tab_1="Server"
local serverguide_Tab_2="Rules"
local serverguide_Tab_3="Rulers"
local serverguide_Tab_4="Commands"
local serverguide_Tab_5="Help"

local function serverguide_guide(user,text_to_show)
local text=""
if text_to_show==1 then text=serverguide_Tab_Text_1 end
if text_to_show==2 then text=serverguide_Tab_Text_2 end
if text_to_show==3 then text=serverguide_Tab_Text_3 end
if text_to_show==4 then text=serverguide_Tab_Text_4 end
if text_to_show==5 then text=serverguide_Tab_Text_5 end

local form="size[8.5,9]" ..default.gui_bg..default.gui_bg_img..
	"button[0,0;1.5,1;tab1;" .. serverguide_Tab_1 .. "]" ..
	"button[1.5,0;1.5,1;tab2;" .. serverguide_Tab_2 .. "]" ..
	"button[3,0;1.5,1;tab3;" .. serverguide_Tab_3 .. "]" ..
	"button[4.5,0;1.5,1;tab4;" .. serverguide_Tab_4 .. "]" ..
	"button[6,0;1.5,1;tab5;" .. serverguide_Tab_5 .. "]" ..
	"button_exit[7.5,0; 1,1;tab6;X]" ..
	"label[0,1;"..text .."]"
minetest.show_formspec(user:get_player_name(), "serverguide",form)
end

minetest.register_on_player_receive_fields(function(player, form, pressed)
	if form=="serverguide" then
	if pressed.tab1 then serverguide_guide(player,1) end
	if pressed.tab2 then serverguide_guide(player,2) end
	if pressed.tab3 then serverguide_guide(player,3) end
	if pressed.tab4 then serverguide_guide(player,4) end
	if pressed.tab5 then serverguide_guide(player,5) end
	end
end)


minetest.register_tool("serverguide:book", {
	description = serverguide_Book_title,
	inventory_image = "default_book.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			local pos = pointed_thing.under
			local node = minetest.get_node_or_nil(pos)
			local def = node and minetest.registered_nodes[node.name]
			if def and def.on_punch then
				minetest.registered_nodes[node.name].on_punch(pos, node, user, pointed_thing)
				return itemstack
			end
		end
		serverguide_guide(user,1)
		return itemstack
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		local node = minetest.get_node_or_nil(pos)
		local def = node and minetest.registered_nodes[node.name]
		if not def or not def.buildable_to then
			pos = pointed_thing.above
			node = minetest.get_node_or_nil(pos)
			def = node and minetest.registered_nodes[node.name]
			if not def or not def.buildable_to then return itemstack end
		end
		if minetest.is_protected(pos, placer:get_player_name()) then return itemstack end
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		minetest.set_node(pos, {name = "serverguide:guide",param2 = fdir,})
		itemstack:take_item()
		return itemstack
	end
})
minetest.register_alias("guide", "serverguide:book")
minetest.register_craft({output = "serverguide:book",recipe = {{"default:stick","default:stick"},}})


minetest.register_node("serverguide:guide", {
	description = serverguide_Book_title,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	drop="serverguide:book",
	node_box = {
		type = "fixed",
		fixed = {0.35,-0.3,0.45,-0.35,-0.5,-0.45},
	},
	tiles = {
	"default_gold_block.png^default_book.png",
	"default_gold_block.png",
	"default_gold_block.png",
	"default_gold_block.png",
	"default_gold_block.png",
	"default_gold_block.png",},
	groups = {cracky=1,oddly_breakable_by_hand=3},
	sounds=default.node_sound_wood_defaults(),
on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", serverguide_Book_title)
end,
on_rightclick = function(pos, node, clicker)
	serverguide_guide(clicker,1)
end

})

minetest.register_on_newplayer(function(player)
player:get_inventory():add_item("main", "serverguide:book")
end)

minetest.register_chatcommand("guide", {
	params = "",
	description = serverguide_Book_title,
	func = function(name, param)
		serverguide_guide(minetest.get_player_by_name(name),1)
		return true
	end
})
