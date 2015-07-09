--more_signs by addi
--Code and Textures are under the CC by-sa 3.0 licence
--see: http://creativecommons.org/licenses/by-sa/3.0/



arrow_signs={}

arrow_signs.formspec = "field[text;Sign text:;${text}]";

arrow_signs_on_place = function(itemstack, placer, pointed_thing)

	local posabove = pointed_thing.above
	local posunder = pointed_thing.under
	local vector = placer:get_look_dir()
	local place = true

	if posabove.y>posunder.y then
		if(vector.z>0.5 and vector.z<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 10})
		elseif (vector.x>0.5 and vector.x<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 19})
		elseif(-0.5>vector.z and -1<=vector.z) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 4})
		elseif (-0.5>vector.x and -1<=vector.x) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 13})
		else
			place = false
		end
	elseif posabove.y<posunder.y then
		if(vector.z>0.5 and vector.z<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 8})
		elseif (vector.x>0.5 and vector.x<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 17})
		elseif(-0.5>vector.z and -1<=vector.z) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 6})
		elseif (-0.5>vector.x and -1<=vector.x) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 15})
		else
			place = false
		end
	elseif posabove.z>posunder.z then
		if(vector.y>0.75 and vector.y<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 22})
		elseif (vector.y>=-1 and vector.y<-0.75) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 2})
		elseif (vector.x>=0 and vector.x<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 18})
		elseif (vector.x<0 and vector.x>=-1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 14})
		else
			place = false
		end
	elseif posabove.z<posunder.z then
		if(vector.y>0.75 and vector.y<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 20})
		elseif (vector.y>=-1 and vector.y<-0.75) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 0})
		elseif (vector.x>=0 and vector.x<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 16})
		elseif (vector.x<0 and vector.x>=-1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 12})
		else
			place = false
		end
	elseif posabove.x>posunder.x then
		if(vector.y>0.75 and vector.y<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 21})
		elseif (vector.y>=-1 and vector.y<-0.75) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 3})
		elseif (vector.z>=0 and vector.z<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 11})
		elseif (vector.z<0 and vector.z>=-1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 7})
		else
			place = false
		end
	elseif posabove.x<posunder.x then
		if(vector.y>0.75 and vector.y<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 23})
		elseif (vector.y>=-1 and vector.y<-0.75) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 1})
		elseif (vector.z>=0 and vector.z<=1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 9})
		elseif (vector.z<0 and vector.z>=-1) then
			minetest.add_node(posabove,{name = itemstack:get_name(), param2 = 5})
		else
			place = false
		end
	else
		place = false
	end

	if not(place) then
		minetest.rotate_node(itemstack, placer, pointed_thing)
	else
		itemstack:take_item()
	end

	if not minetest.setting_getbool("creative_mode") then
		return itemstack
	end

end

 function arrow_signs:savetext(pos, formname, fields, sender)

		if not minetest.get_player_privs(sender:get_player_name())["interact"] then
			minetest.chat_send_player(sender:get_player_name(), "error: you don't have permission to edit the sign. you need the interact priv")
		return
		end
		local meta = minetest.get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		text = arrow_signs:create_lines(fields.text)
		meta:set_string("infotext", '"'..text..'"')
		i=0
		for wort in text:gfind("\n") do
		i=i+1
        end
		if i > 4 then
		minetest.chat_send_player(sender:get_player_name(),"\tInformation: \nYou've written more than 5 lines. \n it may be that not all lines are displayed. \n Please remove the last entry")
		end
	return true
	end

function arrow_signs:create_lines(text)
	text = text:gsub("/", "\"\n\"")
	text = text:gsub("|", "\"\n\"")
	return text
end

minetest.override_item("default:sign_wall", {
    groups = {choppy=2,dig_immediate=2,attached_node=1,sign=1},
})

--Sign arrow
minetest.register_node("arrow_signs:wall", {
	description = "Arrow signs",
	drawtype = "mesh",
	mesh = "arrow_sign.obj",
	selection_box = {
		type = "fixed",
		fixed = {
			{ 0.25, -0.25, 0.5, -0.25, 0.5, 0.47},
			{ 0.1875, -0.3125, 0.5, -0.1875, -0.25, 0.47},
			{ 0.125, -0.3125, 0.5, -0.125, -0.375, 0.47},
			{ 0.0625, -0.375, 0.5, -0.0625, -0.437, 0.47}
		}
	},
	tiles = {"arrow_sign.png", "arrow_sign_border_down.png", "arrow_sign_border_left.png", "arrow_sign_border_right.png", "arrow_sign_border_up.png"},
	inventory_image = "arrow_sign.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	groups = {choppy=2,dig_immediate=2,sign=1},
	sounds = default.node_sound_defaults(),
	on_place = arrow_signs_on_place,
	on_construct = function(pos)
		--local n = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", arrow_signs.formspec)
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		arrow_signs:savetext(pos, formname, fields, sender)
	end,
})

--Recipes
minetest.register_craft({
	type = 'shapeless',
	output = 'arrow_signs:wall',
	recipe = {'default:sign_wall', 'default:stick'},
})
minetest.register_craft({
	output = 'default:sign_wall',
	recipe = {
		{'arrow_signs:wall'},
	}
})

--Redefinition
minetest.register_abm({
	nodenames = {"arrow_signs:wall_right", "arrow_signs:wall_left", "arrow_signs:wall_up", "arrow_signs:wall_down",
		"more_signs:wall_right","more_signs:wall_left","more_signs:wall_up"	,"more_signs:wall_down"
	},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local convert_facedir={
			["arrow_signs:wall_right"]	=	{6,4,5,11,16,14},
			["arrow_signs:wall_left"]	=	{8,10,9,7,12,18},
			["arrow_signs:wall_up"]		=	{15,19,23,21,20,22},
			["arrow_signs:wall_down"]	=	{17,13,1,3,0,2},
			-- For old mod
			["more_signs:wall_right"] 	=	{6,4,5,11,16,14},
			["more_signs:wall_left"] 	=	{8,10,9,7,12,18},
			["more_signs:wall_up"] 		=	{15,19,23,21,20,22},
			["more_signs:wall_down"] 	=	{17,13,1,3,0,2},
		}
		minetest.swap_node(pos, {name="arrow_signs:wall",param2=convert_facedir[node.name][node.param2+1]})
	end,
})
