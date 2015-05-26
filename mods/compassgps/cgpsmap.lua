--original code for storing bookmarks outside of the compass by TeTpaAka
--modifications by Kilarin and Miner59
--wall mounted maps by Miner59

--set growing_wall_maps to true and wall mounted maps will get bigger the further
--away the target is.
local growing_wall_maps=false


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end


local selected_cgpsmap = {}
local textlist_bookmark = {}
local selected_bookmark = {}

function write_to_cgpsmap(itemstack, user)
  --print("write_to_cgpsmap")
	selected_cgpsmap[user:get_player_name()] = itemstack
	local list,bkmrkidx=compassgps.bookmark_loop("M", user:get_player_name())
	if list == "" then
		return nil
	end
	textlist_bookmark[user:get_player_name()] = list
	local formspec = "size[9,10;]"..
			"button_exit[2,2;5,0.5;write;"..S("Write to cgpsmap").."]"..
			"textlist[0,3.0;9,6;bookmark_list;"..list..";"..bkmrkidx.."]"
	minetest.show_formspec(user:get_player_name(), "compassgps:write", formspec)
  --print("write_to_cgpsmap end")
end


function read_from_cgpsmap(itemstack, user, meta)
  --print("read_from_cgpsmap")
	local formspec = "size[9,5]"..
			"button_exit[2,3;5,0.5;read;"..S("copy bookmark to your compassgps").."]"
	if itemstack~=nil then
		formspec=formspec.. "button_exit[3.1,4;2.6,0.8;rename;"..S("rename bookmark").."]"
	else
	    itemstack=ItemStack("compassgps:cgpsmap_marked 1")
	    if meta then
		itemstack:set_metadata(minetest.serialize(meta))
	    end
	end
	if not meta then  --marked map from creative or /giveme has no meta!
	    meta={bkmrkname="default",x=0,y=0,z=0}
		itemstack:set_metadata(minetest.serialize(meta))
	end
	selected_cgpsmap[user:get_player_name()] = itemstack

      formspec=formspec.."label[2,0.5;"..S("bookmark pos:").." ("..meta["x"]..","..meta["y"]..","..meta["z"]..")]"..
	      "field[2,2;5,0.5;name;"..S("bookmark name:")..";"..meta["bkmrkname"].."]"
	minetest.show_formspec(user:get_player_name(), "compassgps:read", formspec)
  --print("read_from_cgpsmap end")
end



minetest.register_craft({
	output = 'compassgps:cgpsmap',
	recipe = {
		{'default:paper', '', 'default:paper'},
		{'', 'default:paper', ''},
		{'default:paper', '', 'default:paper'}
	}
})

minetest.register_craft({
	output = 'compassgps:cgpsmap',
	recipe = {
		{'compassgps:cgpsmap_marked'},
	}
})

minetest.register_craftitem("compassgps:cgpsmap", {
	description = S("CompassGPS Map (blank)"),
	inventory_image = "cgpsmap-blank.png",
	--groups = {book = 1},
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		write_to_cgpsmap(itemstack, user)
		return
	end
})

minetest.register_craftitem("compassgps:cgpsmap_marked", {
	description = "CompassGPS Map (marked)",
	inventory_image = "cgpsmap-marked.png",
	groups = {not_in_creative_inventory = 1},
	stack_max = 1,

	on_use = function(itemstack, user, pointed_thing)
		local meta = minetest.deserialize(itemstack:get_metadata())
		read_from_cgpsmap(itemstack, user, meta)
		return nil
	end,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type=="node" and pointed_thing.above then
			local pos=pointed_thing.above
			local ppos=placer:getpos()
			local facedir=minetest.dir_to_facedir(vector.direction(ppos,pointed_thing.under))
			local x=pos.x
			local y=pos.y
			local z=pos.z
			if facedir~=nil and itemstack:get_name()=="compassgps:cgpsmap_marked"
			   and (not minetest.is_protected(pos,placer:get_player_name())) then
				minetest.set_node(pos,{name="compassgps:cgpsmap_wall",param2=facedir})
				local mapdata = itemstack:get_metadata()
				local meta=minetest.get_meta(pos)
				meta:set_string("mapdata",mapdata)
				if mapdata~=nil then
					local data=minetest.deserialize(mapdata)
					if data~=nil then
						meta:set_string("infotext", data["bkmrkname"])
						x=data["x"]
						y=data["y"]
						z=data["z"]
					end
				end
				if facedir==1 then
					pos={x=pos.x+0.3,y=pos.y,z=pos.z}
				elseif facedir==3 then
					pos={x=pos.x-0.3,y=pos.y,z=pos.z}
				elseif facedir==0 then
					pos={x=pos.x,y=pos.y,z=pos.z+0.3}
				elseif facedir==2 then
					pos={x=pos.x,y=pos.y,z=pos.z-0.3}
				end
				local e = minetest.env:add_entity(pos,"compassgps:cgpsmap_item")
				local yaw = math.pi*2 - facedir * math.pi/2
				e:setyaw(yaw)
				local dist=math.abs(pos.x-x)+math.abs(pos.y-y)+math.abs(pos.z-z)
				if growing_wall_maps == false then
					e:set_properties({visual_size={x=0.85,y=0.85}})									
				elseif dist>30000 then
					e:set_properties({visual_size={x=3.45,y=3.45}})
				elseif dist>15000 then
					e:set_properties({visual_size={x=2.95,y=2.95}})
				elseif dist>5000 then
					e:set_properties({visual_size={x=2.45,y=2.45}})
				elseif dist>3000 then
					e:set_properties({visual_size={x=1.45,y=1.45}})
				elseif dist>2000 then
					e:set_properties({visual_size={x=1.2,y=1.2}})
				elseif dist>1000 then
					e:set_properties({visual_size={x=1,y=1}})
				elseif dist>500 then
					e:set_properties({visual_size={x=0.85,y=0.85}})
				end--else default (0.7)

				itemstack:take_item()
			end
		end
		return itemstack
	end,
})

minetest.register_node("compassgps:cgpsmap_wall",{
	description = "CompassGPS Map (wallmounted)",
	drawtype = "nodebox",
	node_box = { type = "fixed", fixed = {-0.5, -0.5, 7/16, 0.5, 0.5, 0.5} },
	selection_box = { type = "fixed", fixed = {-0.7, -0.7, 7/16, 0.7, 0.7, 0.7} },
	tiles = {"compassgps_blank.png"},
	inventory_image = "cgpsmap_marked.png",
	wield_image = "cgpsmap_marked.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	groups = { choppy=2,dig_immediate=2,not_in_creative_inventory=1,not_in_craft_guide=1 },
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_punch = function(pos,node,puncher)
		local meta = minetest.env:get_meta(pos)
		local mapdata=meta:get_string("mapdata")

		if minetest.is_protected(pos,puncher:get_player_name()) then
			--don't take map, instead open formspec to add coordinates in compassgps
			if mapdata~=nil then
				read_from_cgpsmap(nil, puncher, minetest.deserialize(mapdata))
			end
			return
		end
		local inv = puncher:get_inventory()

		local objs = nil
		objs = minetest.env:get_objects_inside_radius(pos, .5)
		if objs then
			for _, obj in ipairs(objs) do
				if obj and obj:get_luaentity() and obj:get_luaentity().name == "compassgps:cgpsmap_item" then
					obj:remove()
				end
			end
		end
		local itemstack=ItemStack("compassgps:cgpsmap_marked 1")
		itemstack:set_metadata(mapdata)
		if inv:room_for_item("main",itemstack) then
			inv:add_item("main",itemstack)
		else
			minetest.env:add_item(pos, itemstack)
		end
		minetest.remove_node(pos)
	end,
})

minetest.register_entity("compassgps:cgpsmap_item",{
	hp_max = 1,
	visual="wielditem",
	visual_size={x=0.7,y=0.7},
	collisionbox = {0,0,0,0,0,0},
	physical=false,
	textures={"compassgps:cgpsmap_marked"},
})

minetest.register_abm({
	nodenames = { "compassgps:cgpsmap_wall" },
	interval = 600,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if #minetest.get_objects_inside_radius(pos, 0.5) > 0 then return end
		local meta=minetest.get_meta(pos)
		local x=pos.x
		local y=pos.y
		local z=pos.z
		local mapdata=meta:get_string("mapdata",mapdata)
		if mapdata~=nil then
			local data=minetest.deserialize(mapdata)
			if data~=nil then
				x=data["x"]
				y=data["y"]
				z=data["z"]
			end
		end
		local facedir=node.param2
		if facedir==1 then
			pos={x=pos.x+0.3,y=pos.y,z=pos.z}
		elseif facedir==3 then
			pos={x=pos.x-0.3,y=pos.y,z=pos.z}
		elseif facedir==0 then
			pos={x=pos.x,y=pos.y,z=pos.z+0.3}
		elseif facedir==2 then
			pos={x=pos.x,y=pos.y,z=pos.z-0.3}
		end
		local e = minetest.env:add_entity(pos,"compassgps:cgpsmap_item")
		local yaw = math.pi*2 - facedir * math.pi/2
		e:setyaw(yaw)
		local dist=math.abs(pos.x-x)+math.abs(pos.y-y)+math.abs(pos.z-z)
		if dist>30000 then
			e:set_properties({visual_size={x=3.45,y=3.45}})
		elseif dist>15000 then
			e:set_properties({visual_size={x=2.95,y=2.95}})
		elseif dist>5000 then
			e:set_properties({visual_size={x=2.45,y=2.45}})
		elseif dist>3000 then
			e:set_properties({visual_size={x=1.45,y=1.45}})
		elseif dist>2000 then
			e:set_properties({visual_size={x=1.2,y=1.2}})
		elseif dist>1000 then
			e:set_properties({visual_size={x=1,y=1}})
		elseif dist>500 then
			e:set_properties({visual_size={x=0.85,y=0.85}})
		end--else default (0.7)

	end
})


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if (formname == "compassgps:write") then
		if not player then
			return
		end
		local playername = player:get_player_name();
		if (playername ~= "") then
			if (selected_cgpsmap[playername] == nil) then
				return
			end
			if fields["bookmark_list"] then
				-- to get the currently selected
				local id = minetest.explode_textlist_event(fields["bookmark_list"])
				selected_bookmark[playername] = id.index
			end
			if fields["write"] then
        --print("***cgpsmap fields=write***")
				if selected_bookmark[playername] == nil then
					return nil
				end
        local bkmrk=textlist_bkmrks[playername][selected_bookmark[playername]]
        local write = { ["bkmrkname"] = bkmrk.bkmrkname,
                        x = bkmrk.x,
                        y = bkmrk.y,
                        z = bkmrk.z}
        --print("dump(write)="..dump(write))
      	selected_cgpsmap[playername]:set_name("compassgps:cgpsmap_marked")
				selected_cgpsmap[playername]:set_metadata(minetest.serialize(write))
				player:set_wielded_item(selected_cgpsmap[playername])
			end
		end
	end
	if (formname == "compassgps:read") then
		if not player then
			return
		end
		if (fields["read"]) then
      --print("***cgpsmap fields=read***")
			local meta = minetest.deserialize(selected_cgpsmap[player:get_player_name()]:get_metadata())
      --print("dump(meta)="..dump(meta))
      local bkmrkname = fields["name"]
      --print("bkmrkname from fields[name]="..bkmrkname)
			local pos = {	x = meta["x"] + 0,
					y = meta["y"] + 0,
					z = meta["z"] + 0 }
			local playername = player:get_player_name()
			--print(bkmrkname)
			compassgps.set_bookmark(playername, bkmrkname, "P", pos)
		end
	end

	if (selected_cgpsmap == nil) then
		return
	end
	local playername = player:get_player_name()
	if (playername == nil) then
		return
	end
	if (selected_cgpsmap[playername] == nil) then
		return
	end
	if fields["rename"] then
	      local bkmrkname = fields["name"]
		local meta = minetest.deserialize(selected_cgpsmap[player:get_player_name()]:get_metadata())
		if meta~=nil and bkmrkname~=nil then
			local pos = {	x = meta["x"] + 0,
				y = meta["y"] + 0,
				z = meta["z"] + 0 }
			selected_cgpsmap[playername]:set_metadata(minetest.serialize({ ["bkmrkname"] = bkmrkname,
                        x = pos.x,
                        y = pos.y,
                        z = pos.z}))
			player:set_wielded_item(selected_cgpsmap[playername]) --new name is saved in marked cpgsmap
			end
		end
	end)
