--compassgps 2.1

--This fork was written by Kilarin (Donald Hines)
--Original code by Echo, PilzAdam, and TeTpaAka is WTFPL.
--My changes are CC0 (No rights reserved)
--textures: original compass textures: CC BY-SA by Echo
--          compass b textures: CC BY-SA by Bas080 (slight modifications by Kilarin)
--          compass c textures: CC BY-SA by Andre Goble mailto:spootonium@gmail.com
--                              (slight modifications by Kilarin)

--fixed bug that caused compass to jump around in inventory
--fixed bug causing removed bookmarks not to be saved
--expanded bookmark list from dropdown to textlist
--added pos and distance to display list
--added hud showing current pos -> target pos : distance

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  S = intllib.Getter()
else
  S = function ( s ) return s end
end

local hud_default_x=0.4
local hud_default_y=0.01
local hud_default_color="FFFF00"
local compass_default_type="a"
local compass_valid_types={"a","b","c"}
local activewidth=8 --until I can find some way to get it from minetest
local max_shared=10 --how many shared bookmarks a user with shared_bookmarks priv can make.
local show_shared_on_singleplayer=false --show shared and admin checkboxes on singleplayer
--the ONLY reason to change this variable to true is for testing.  shared and admin bookmarks
--make no sense in a single player game.

minetest.register_privilege("shared_bookmarks",
  S("Can create shared bookmarks for use by anyone with a compassgps"))
--minetest.register_privilege("shared_bookmarks", {
--	description = "Can create shared bookmarks for use by anyone with a compassgps",
--	give_to_singleplayer = false,})

compassgps = { }
local player_hud = { };
local bookmarks = { }
local point_to = {}
local sort_function = {}
local distance_function ={}
local hud_pos = {}
local hud_color = {}
local compass_type = {}
local view_type_P = {}
local view_type_S = {}
local view_type_A = {}
local textlist_clicked = {}
textlist_bkmrks = {}
local singleplayer = false
local target = {}
local pos = {}
local dir = 90
local default_bookmark = {}
local backwardscompatsave = "NO"


print(S("compassgps reading bookmarks"))
local file = io.open(minetest.get_worldpath().."/bookmarks", "r")
if file then
	bookmarks = minetest.deserialize(file:read("*all"))
	file:close()
end

--local remove


--the sort functions and distance functions have to be defined ABOVE the
--"main" block or will be nil

function compassgps.sort_by_distance(table,a,b,player)
  --print("sort_by_distance a="..compassgps.pos_to_string(table[a]).." b="..pos_to_string(table[b]))
  local playerpos = player:getpos()
  local name=player:get_player_name()
  --return compassgps.distance3d(playerpos,table[a]) < compassgps.distance3d(playerpos,table[b])
  if distance_function[name] then
    return distance_function[name](playerpos,table[a]) <
           distance_function[name](playerpos,table[b])
  else
    return false  --this should NEVER happen
  end
end --sort_by_distance

function compassgps.sort_by_name(table,a,b,player)
  local atype="P"  --default to P
  if table[a].type then atype=table[a].type end
  local btype="P"
  if table[b].type then btype=table[b].type end
  if atype == btype then
    local aplayer=""
    if table[a].player then aplayer=table[a].player end
    local bplayer=""
    if table[b].player then bplayer=table[b].player end
    if aplayer == bplayer then
      return a < b  --compare on bookmark name
    else
      return aplayer < bplayer --compare on player name
    end --compare player name
  else
    return atype < btype  --compare on bookmark type
  end -- compare type
end --sort_by_name


function compassgps.distance2d(pos1in,pos2in)
local pos1=compassgps.round_digits_vector(pos1in,0)
local pos2=compassgps.round_digits_vector(pos2in,0)
return math.sqrt((pos2.x-pos1.x)^2+(pos2.z-pos1.z)^2)
end --distance2d


--calculate distance between two points
function compassgps.distance3d(pos1in,pos2in)
--round to nearest node
--print("  pos1in="..compassgps.pos_to_string(pos1in).." pos2in="..compassgps.pos_to_string(pos2in))
local pos1=compassgps.round_digits_vector(pos1in,0)
local pos2=compassgps.round_digits_vector(pos2in,0)
return math.sqrt((pos2.x-pos1.x)^2+(pos2.z-pos1.z)^2+(pos2.y-pos1.y)^2)
end --distance3d



-- **********************************************************
print(S("compassgps reading settings"))
if minetest.is_singleplayer() and show_shared_on_singleplayer==false then
  singleplayer=true
else
  singleplayer=false
end

local settings = { }
local file = io.open(minetest.get_worldpath().."/compassgps_settings", "r")
if file then
	settings = minetest.deserialize(file:read("*all"))
	file:close()
end
--now transfer these to the correct variables
for name,stng in pairs(settings) do
  --if settings[name].point_name then
  --  point_name[name]=settings[name].point_name
  --end
  if settings[name].point_to and settings[name].point_to.bkmrkname then
    point_to[name]=settings[name].point_to
  else
    point_to[name]=nil
  end
  if settings[name].sort_function then
    if settings[name].sort_function == "name" then
      sort_function[name]=compassgps.sort_by_name
    else
      sort_function[name]=compassgps.sort_by_distance
    end
  end
  if settings[name].distance_function then
    if settings[name].distance_function == "2d" then
      distance_function[name]=compassgps.distance2d
    else
      distance_function[name]=compassgps.distance3d
    end
  end
  if settings[name].hud_pos then
    hud_pos[name]=settings[name].hud_pos
  end
  if settings[name].hud_color then
    hud_color[name]=settings[name].hud_color
  end
  if settings[name].compass_type then
    compass_type[name]=settings[name].compass_type
  end
  --saved as strings so its easier to check for nil
  if settings[name].view_type_P then
    view_type_P[name]=settings[name].view_type_P
  else
    view_type_P[name]="true"
  end --view_type_P
  if settings[name].view_type_S then
    view_type_S[name]=settings[name].view_type_S
  else
    view_type_S[name]="false"
  end --view_type_S
  if settings[name].view_type_A then
    view_type_A[name]=settings[name].view_type_A
  else
    view_type_A[name]="false"
  end --view_type_A

  if singleplayer then
    view_type_P[name]="true"
    view_type_A[name]="false"
    view_type_S[name]="false"
  end--override view types

end --for


function compassgps.bookmark_to_string(bkmrk)
  if not bkmrk then return "{nil}" end
  local str="{"
  if bkmrk.player then str=str..bkmrk.player
  else str=str.."player=nil" end
  str=str.." : "
  if bkmrk.bkmrkname then str=str..bkmrk.bkmrkname
  else str=str.."bkmrkname=nil" end
  str=str.." : "..compassgps.pos_to_string(bkmrk).." : "
  if bkmrk.type then str=str..bkmrk.type
  else str=str.."type=nil" end
  str=str.."}"
  return str
  end -- bookmark_to_string


function compassgps.bookmark_name_string(bkmrk)
  --print("bookmark_name_string: "..compassgps.bookmark_to_string(bkmrk))
  if bkmrk.type=="A" then
    return "*admin*:"..bkmrk.player.."> "..bkmrk.bkmrkname
  elseif bkmrk.type=="S" then
    return "*shared*:"..bkmrk.player.."> "..bkmrk.bkmrkname
  else
    return bkmrk.bkmrkname
  end
end --bookmark_name_string


function compassgps.bookmark_name_pos_dist(bkmrk,playername,playerpos)
  if distance_function[playername] == nil then
	return ""
  end
  return compassgps.bookmark_name_string(bkmrk).." : "..compassgps.pos_to_string(bkmrk)..
      " : "..compassgps.round_digits(distance_function[playername](playerpos,bkmrk),2)
end --gookmark_name_pos_dist


function compassgps.count_shared(playername)
  local c=0
  for k,v in pairs(bookmarks) do
    if v.player and v.player==playername and v.type and v.type=="S" then
      c=c+1
    end --if
  end --for
  return c
end--count_shared



--*********************************************************
--mode "L" create list for displaying bookmarks in gui
--mode "C" display private bookmarks only in chat
--mode "M" similar to "L" but with current position (for maps)
function compassgps.bookmark_loop(mode,playername,findidx)
  --print("bookmark_loop top")
  local player = minetest.get_player_by_name(playername)
  local playerpos = player:getpos()
  local list=""
  local bkmrkidx=1
  local i=1
  if mode=="L" or mode=="M" then
    local spawnbkmrk=compassgps.get_default_bookmark(playername,1)
    textlist_bkmrks[playername]={}
    if mode=="M" then
      local cpos=compassgps.round_pos(playerpos)
      list = S("current position : ")..compassgps.pos_to_string({x=cpos.x,y=cpos.y,z=cpos.z,player=playername,type="P",bkmrkname=playername.."'s map"})..","..
      compassgps.bookmark_name_pos_dist(spawnbkmrk,playername,playerpos)
      textlist_bkmrks[playername][1]={x=cpos.x,y=cpos.y,z=cpos.z,player=playername,type="P",bkmrkname=S("%s's map"):format(playername)}
      textlist_bkmrks[playername][2]=spawnbkmrk
      i=2
      mode="L"
    else
      list = compassgps.bookmark_name_pos_dist(spawnbkmrk,playername,playerpos)
      textlist_bkmrks[playername][1]=spawnbkmrk
    end --initialize list

  	--add all spawn position from beds mod, sethome mod and the default spawn point
	spawnbkmrk=compassgps.get_default_bookmark(playername,2)
	if spawnbkmrk~=nil then
		i=i+1
	        list = list..","..compassgps.bookmark_name_pos_dist(spawnbkmrk,playername,playerpos)
	        textlist_bkmrks[playername][i]=spawnbkmrk
	end
	spawnbkmrk=compassgps.get_default_bookmark(playername,3)
	if spawnbkmrk~=nil then
		i=i+1
	        list = list..","..compassgps.bookmark_name_pos_dist(spawnbkmrk,playername,playerpos)
	        textlist_bkmrks[playername][i]=spawnbkmrk
	end
      textlist_clicked[playername]=1
  end

  --bkmrkidx will be used to highlight the currently selected item in the list
  backwardscompatsave="NO"

  for k,v in spairs(bookmarks,sort_function[playername],player) do
    --backwards compatibility
    --since version 1.5, all bookmarks will have a player and type, but
    --bookmarks from the old compass mods and previous versions of this
    --mod will not.  Because the original mod did not put a seperator between
    --the playername and the bookmark name, the only way to seperate them
    --is when you have the player name.  this if says that if v.player is
    --not defined and the begining of the bookmark matches the playername
    --then set v.player and v.type and set a flag to save the bookmarks
    --print("bookmark_loop unmod "..compassgps.bookmark_to_string(v))
    if not v.player then --if playername is not set, fix it
  		local pos1, pos2 = string.find(k, playername, 0)
      if pos1==1 and pos2 then --add playername and type to bookmark
        v.player=playername
        v.type="P"
        v.bkmrkname=string.sub(k,string.len(v.player)+1)
        backwardscompatsave="YES"
      end --if pos1==1
    end --if not v.player backwards compatibility

    --even though we set v.player above, that was for bookmarks that match
    --this playername, so there could still be other players bookmarks that
    --do not have v.player defined, thats why we have to check it again.
    local vplayernm=""
    if v.player then vplayernm=v.player end
    local vtype="P"
    if v.type then vtype=v.type end
    local vbkmrkname=k
    if v.bkmrkname then vbkmrkname=v.bkmrkname end
    --now vplayernm,vtype,vbkmrkname are guaranteed to be defined

    --admin and shared bookmarks
    if (mode=="L") and
       ( (vtype=="A" and view_type_A[playername]=="true") or
         (vtype=="S" and view_type_S[playername]=="true") ) then
      i=i+1
      list = list..","..compassgps.bookmark_name_pos_dist(v,playername,playerpos)
      textlist_bkmrks[playername][i]=v
      --print("bookmark_loop AS "..i.." "..compassgps.bookmark_to_string(textlist_bkmrks[playername][i]))
    --private bookmarks
    elseif vtype=="P" and vplayernm==playername and view_type_P[playername]=="true" then
      i=i+1
      if mode=="L" then
        list = list..","..compassgps.bookmark_name_pos_dist(v,playername,playerpos)
  			--list = list..","..vbkmrkname.." : "..compassgps.pos_to_string(v)..
        --  " : "..compassgps.round_digits(distance_function[playername](playerpos,v),2)
        textlist_bkmrks[playername][i]=v
        --print("bookmark_loop P "..i.." "..compassgps.bookmark_to_string(textlist_bkmrks[playername][i]))
      elseif mode=="C" then
        --minetest.chat_send_player(playername, vbkmrkname..": "..compassgps.pos_to_string(v))
        minetest.chat_send_player(playername, compassgps.bookmark_name_pos_dist(v,playername,playerpos))
      end
		end --if vtype

    --print("bookmark_loop mode="..mode.." bkmrkidx="..bkmrkidx.." vbkmkrname="..vbkmrkname.." point_to="..point_to[playername].bkmrkname.." vplayer="..vplayer.." point_to="..point_to[playername].player)
	  --set testlist_clicked to the currently selected item in the list
    if point_to[playername]~=nil then -- don't crash when point_to[playername] is nil
      if mode=="L" and bkmrkidx==1 and vbkmrkname==point_to[playername].bkmrkname
          and vplayernm==point_to[playername].player then
        bkmrkidx=i
        textlist_clicked[playername]=i
        --point_to is the bookmark this player's compass is already pointing to
        --when we open the list, if we found a bookmark that matches that item, we want
        --to highlight it (by setting bkmrkidx to the index to highlight) and we want
        --to set textlist_clicked to match that item.  We need textlist_clicked because
        --textlist does not return the currently selected item when you click a button,
        --so we must keep the currently selected item in memory
      --elseif mode=="I" and i==findidx then
      --  return bkmrkname --found the item we were looking for, we are done.
      end --if mode=L
  	end --for spairs
  end --point_to[playername]~=nil

  if backwardscompatsave=="YES" then compassgps.write_bookmarks() end

  if mode=="L" then
    return list,bkmrkidx
  --elseif mode=="I" then
  --  return "default" --didn't find it, so return default.
	end --if mode=="L"

end --bookmark_loop






function compassgps.get_confirm_formspec(playername,bkmrkidx)
  --print("get_confirm_remove_formspec")
	local player = minetest.get_player_by_name(playername)
  if not compassgps.verify_bookmark_parms("remove_bookmark",player,playername,bkmrkidx)
    then return end
  local bkmrk=textlist_bkmrks[playername][bkmrkidx]

	return "compassgps:confirm_remove", "size[8,2;]"..
    "label[0,0.2;"..S("Remove bookmark: ")..compassgps.bookmark_name_string(bkmrk).." ?]"..
		"button[0,0.7;4,1;confirm_remove_yes;"..S("Yes").."]"..
    "button[4,0.7;4,1;confirm_remove_no;"..S("No").."]"
end


function compassgps.check_view_type_all_blank(playername)
  --view_type values are not all set when you first bring up the form
  --so we check to ensure that view_type_A and S are default false for sp and true for mp
  --and that if all values are false we set view_type_P to true
  local defaultvalue="true"
  if singleplayer then
    defaultvalue="false"
  end
  if (not view_type_A[playername]) then
    view_type_A[playername]=defaultvalue
  end
  if (not view_type_S[playername]) then
    view_type_S[playername]=defaultvalue
  end
  if (not view_type_P[playername])
      or (view_type_P[playername]=="false" and view_type_S[playername]=="false"
      and view_type_A[playername]=="false") then
    view_type_P[playername]="true"
  end
end --check_view_type_all_blank



minetest.register_on_player_receive_fields(function(player,formname,fields)
	if (not player) then
		return false;
	end

	local playername = player:get_player_name();
	if (playername ~= "" and formname == "compassgps:bookmarks") then
    --"bookmark" field is set EVERY time.  I would like to detect someone hitting
    --enter in that field, but the problem is, if someone types something into
    --the bookmark field, and then clicks on a bookmark in the textlist,
    --I would get back bookmark as set.  So, the only way to detect that
    --enter has been hit in the bookmark field is to check bookmark, and ensure
    --every other field is NOT set.
    --this leaves open the possibility of someone typing in the hudx or hudy
    --field and hitting enter after typing in the bookmark field.  Not likely
		if (fields["new_bookmark"] and fields["bookmark"]) --hit the bookmark button
      or ( (fields["bookmark"]) and (fields["bookmark"]~="")   --bookmark field not blank
          and (not fields["remove_bookmark"]) and (not fields["find_bookmark"])
          and (not fields["bookmark_list"]) and (not fields["sort_type"])
          and (not fields["distance_type"]) and (not fields["settings"])
          and (not fields["teleport"]) and (not fields["show_private"])
          and (not fields["show_shared"]) and (not fields["show_admin"])
          )
      then
      local type="P"
      if fields["new_shared_bookmark"] then
        type="S"
      elseif fields["new_admin_bookmark"] then
        type="A"
      end --shared or admin
			compassgps.set_bookmark(playername, fields["bookmark"],type)
  	  minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    elseif fields["remove_bookmark"] and textlist_clicked[playername] then
      local bkmrkidx=textlist_clicked[playername]
      if textlist_bkmrks[playername][bkmrkidx].player ~= playername then
        --only admins can delete someone elses shared bookmark
        --check to see if the player has "privs" privliges
        local player_privs
        player_privs = minetest.get_player_privs(playername)
        if not player_privs["privs"] then
          minetest.chat_send_player(playername,S("you can not remove someone elses bookmark:")..
              compassgps.bookmark_name_string(textlist_bkmrks[playername][bkmrkidx]))
          return
        end --if not player_privs
      end -- if player~=playername

	-- you can't remove default bookmarks (bed, home, spawnpoint)
	if textlist_bkmrks[playername][bkmrkidx].bkmrkname==nil or textlist_bkmrks[playername][bkmrkidx].player==nil then
		return
	end
	if bookmarks[textlist_bkmrks[playername][bkmrkidx].player..textlist_bkmrks[playername][bkmrkidx].bkmrkname]==nil then
		return
	end

      --if they got here, they have authority to del the bookmark, show confirm dialog
      minetest.show_formspec(playername, compassgps.get_confirm_formspec(playername, bkmrkidx))
    elseif fields["find_bookmark"] and textlist_clicked[playername] then
       --print("compassgps.fields find_bookmark triggered, playername="..playername.." textlist_clicked="..textlist_clicked[playername])
      compassgps.find_bookmark(playername,textlist_clicked[playername])
 		elseif fields["bookmark_list"] then
      local idx=tonumber(string.sub(fields["bookmark_list"],5))
      --textlist_clicked[playername]=compassgps.bookmark_from_idx(playername,idx)
      --textlist_clicked[playername]=compassgps.bookmark_loop("I",playername,idx)
      textlist_clicked[playername]=idx
      --print("bookmark_list triggered  textlist idx="..idx.." tlc="..textlist_clicked[playername])
    elseif fields["sort_type"] then
      local idx=tonumber(string.sub(fields["sort_type"],5))
      if idx==1 then
        sort_function[playername]=compassgps.sort_by_name
      else
        sort_function[playername]=compassgps.sort_by_distance
      end --if name else distance
  		minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    elseif fields["distance_type"] then
      local idx=tonumber(string.sub(fields["distance_type"],5))
      if idx==1 then
        distance_function[playername]=compassgps.distance3d
      else
        distance_function[playername]=compassgps.distance2d
      end --if 2d else 3d
  		minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    elseif fields["show_private"] then
      view_type_P[playername]=tostring(fields["show_private"])
      compassgps.check_view_type_all_blank(playername)
      minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    elseif fields["show_shared"] then
      view_type_S[playername]=tostring(fields["show_shared"])
      compassgps.check_view_type_all_blank(playername)
      minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    elseif fields["show_admin"] then
      view_type_A[playername]=tostring(fields["show_admin"])
      compassgps.check_view_type_all_blank(playername)
      minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    elseif fields["teleport"] then
   		-- Teleport player.
      compassgps.teleport_bookmark(playername, textlist_clicked[playername])
    elseif fields["settings"] then
      --bring up settings screen
      minetest.show_formspec(playername, compassgps.get_settings_formspec(playername))
		end --compassgps formspec
  elseif (playername ~= "" and formname == "compassgps:settings") then
    if fields["hud_pos"] then --and fields["hudx"] and fields["hudy"] then
      --minetest.chat_send_all("hud_pos triggered")
      if tonumber(fields["hudx"]) and tonumber(fields["hudy"]) then
        hud_pos[playername].x=fields["hudx"]
        hud_pos[playername].y=fields["hudy"]
        if tonumber(hud_pos[playername].x)<0 or tonumber(hud_pos[playername].x)>1
           or tonumber(hud_pos[playername].y)<0 or tonumber(hud_pos[playername].y)>1 then
        minetest.chat_send_player(playername,S("compassgps: hud coords out of range, hud will not be displayed.  Change to between 0 and 1 to restore"))
        --compassgps.write_settings() --no need to save until you quit
        end
      else --not numbers
        minetest.chat_send_player(playername,S("compassgps: hud coords are not numeric.  Change to between 0 and 1"))
      end --if x,y valid
      if tonumber(fields["hudcolor"],16) then
        hud_color[playername]=fields["hudcolor"]
      else
        minetest.chat_send_player(playername,S("compassgps: hud color not valid hex number"))
      end --if color valid
    elseif fields["compass_type_a"] then
      compass_type[playername]="a"
    elseif fields["compass_type_b"] then
      compass_type[playername]="b"
    elseif fields["compass_type_c"] then
      compass_type[playername]="c"
    end --if fields["hud_pos"]
  elseif (playername ~= "" and formname == "compassgps:confirm_remove") then
    if fields["confirm_remove_yes"] then
      compassgps.remove_bookmark(playername, textlist_clicked[playername])
  		minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    elseif fields["confirm_remove_no"] then
  		minetest.show_formspec(playername, compassgps.get_compassgps_formspec(playername))
    end -- if fields["confirm_remove_yes"]
	end -- form if
end)


--saves the bookmark list in minetest/words/<worldname>/bookmarks
function compassgps.write_bookmarks()
	local file = io.open(minetest.get_worldpath().."/bookmarks", "w")
	if file then
		file:write(minetest.serialize(bookmarks))
		file:close()
	end
end --write_bookmarks


--saves the settings in minetest/words/<worldname>/compassgps_settings
function compassgps.write_settings()
  --loop through players and set settings
  --(less error prone than trying to keep settings in sync all the time
  print(S("compassgps writing settings"))
  local players  = minetest.get_connected_players()
	for i,player in ipairs(players) do
    local name = player:get_player_name();
    local sort_short="name"
    --if you save the actual sort_function or distance_function, it saves the
    --whole function in the serialized file!  not what I wanted, and doesn't work right.
    if sort_function[name] and sort_function[name]==compassgps.sort_by_distance then
      sort_short="distance"
    end
    local dist_short="2d"
    if distance_function[name] and distance_function[name]==compassgps.distance3d then
      dist_short="3d"
    end
    settings[name]={point_to=point_to[name],
                    hud_pos=hud_pos[name],
                    sort_function=sort_short,
                    distance_function=dist_short,
                    hud_color=hud_color[name],
                    compass_type=compass_type[name],
                    view_type_P=view_type_P[name],
                    view_type_S=view_type_S[name],
                    view_type_A=view_type_A[name]}
	end
  --now write to file
	local file = io.open(minetest.get_worldpath().."/compassgps_settings", "w")
	if file then
		file:write(minetest.serialize(settings))
		file:close()
	end
end --write_settings


minetest.register_on_leaveplayer(function(player)
  compassgps.write_settings()
  end)

minetest.register_on_shutdown(compassgps.write_settings)


function compassgps.clean_string(str)
  --remove dangerous characters that will mess up the list of bookmarks
  --the file can handle these fine, but the LIST for the textlist
  --will interpret these as seperators
  str=string.gsub(str,",",".")
  str=string.gsub(str,";",".")
  str=string.gsub(str,"%[","(")
  str=string.gsub(str,"%]",")")
  return str
end --clean_string



function compassgps.set_bookmark(playername, bkmrkname, type, predefinedpos)
	local player = minetest.get_player_by_name(playername)
	if not player then
		return
	end

	local pos = player:getpos()
	if predefinedpos ~= nil then
		pos = predefinedpos
	end
  --we are marking a NODE, no need to keep all those fractions
  pos=compassgps.round_pos(pos)

  bkmrkname=compassgps.clean_string(bkmrkname)

	if bkmrkname == "" then
		minetest.chat_send_player(playername, S("Give the bookmark a name."))
		return
	end
	if bkmrkname == "default" or bkmrkname == "bed" or bkmrkname == "sethome"
       or string.sub(bkmrkname,1,8) == "*shared*"
       or string.sub(bkmrkname,1,7)=="*admin*" then
		minetest.chat_send_player(playername, S("A bookmark with the name '%s' can't be created."):format(bkmrkname))
		return
	end
	if bookmarks[playername..bkmrkname] then
		minetest.chat_send_player(playername, S("You already have a bookmark with that name."))
		return
	end

  pos.type=type or "P" --Private Shared Admin

  if pos.type=="S" and compassgps.count_shared(playername) >= max_shared then
		minetest.chat_send_player(playername, S("The maximum number of shared bookmarks any user can create is %d."):format(max_shared))
    return
	end

  pos.bkmrkname=bkmrkname
  pos.player=playername

	bookmarks[playername..bkmrkname] = pos

  compassgps.write_bookmarks()
	minetest.chat_send_player(playername, S("Bookmark '%s' added at %s type=%s"):format(bkmrkname, compassgps.pos_to_string(pos), pos.type))
end


minetest.register_chatcommand("set_bookmark", {
	params = "<bookmark_name>",
	description = S("set_bookmark: Sets a location bookmark for the player"),
	func = function (playername, bkmrkname)
		compassgps.set_bookmark(playername, bkmrkname, "P")
	end,
})



--returns a pos that is rounded special case.  round 0 digits for X and Z,
--round 1 digit for Y
function compassgps.round_pos(pos)
  pos.x=compassgps.round_digits(pos.x,0)
  pos.y=compassgps.round_digits(pos.y,1)
  pos.z=compassgps.round_digits(pos.z,0)
  return pos
end --round_pos



function compassgps.round_digits(num,digits)
	if num >= 0 then return math.floor(num*(10^digits)+0.5)/(10^digits)
  else return math.ceil(num*(10^digits)-0.5)/(10^digits)
  end
end --round_digits

function compassgps.round_digits_vector(vec,digits)
	return {x=compassgps.round_digits(vec.x,digits),y=compassgps.round_digits(vec.y,digits),
	        z=compassgps.round_digits(vec.z,digits)}
end --round_digits_vector


--because built in pos_to_string doesn't handle nil, and commas mess up textlist
--this rounds same rules as for setting bookmark or teleporting
--that way what you see in the hud matches where you teleport or bookmark
function compassgps.pos_to_string(pos)
	if pos==nil then return "(nil)"
	else
    pos=compassgps.round_pos(pos)
    return "("..pos.x.." "..pos.y.." "..pos.z..")"
	end --pos==nill
end --pos_to_string



minetest.register_chatcommand("list_bookmarks", {
	params = "",
	description = S("list_bookmarks: Lists all bookmarks of a player"),
	func = function(name, param)
      compassgps.bookmark_loop("C",name)
	end,
})


function compassgps.verify_bookmark_parms(from_function,player,playername,bkmrkidx)
	--just being paranoid, probably none of these checks are necessary
	if not player then
    print(S("compassgps.%s player not found"):format(from_function))
    if not playername then print(S("  playername=nil"))
    else print(S("  playername=%s"):format(playername))
    end --if not playername
    return false
  end --if not player
  if not tonumber(bkmrkidx) then
    print(S("compassgps.%s invalid bkrmkidx"):format(from_funtion))
    if not bkmrkidx then print(S("  bkmrkidx=nil"))
    else print("  bkmrkidx="..bkmrkidx)
    end --if not bkmrkidx
    return false
  end --if not tonumber(bkmrkidx)
  if not textlist_bkmrks[playername][bkmrkidx] then
    print(S("compassgps.%s invalid bookmark playername=%s bkmrkid=%s"):format(from_function, playername, bkmrkidx))
    minetest.chat_send_player(playername,S("compassgps:%s invalid bookmark"):format(from_function))
    return false
  end   --if not textlist_bkmrks
  return true --if you got here it is all good
end --verify_bookmark_parms



function compassgps.remove_bookmark(playername, bkmrkidx)
	local player = minetest.get_player_by_name(playername)
  if not compassgps.verify_bookmark_parms("remove_bookmark",player,playername,bkmrkidx)
    then return end



  print(S("remove bookmark playername=%s bkmrkidx=%s"):format(playername, bkmrkidx))
	minetest.chat_send_player(playername, S("removed %s"):format(
      compassgps.bookmark_name_string(textlist_bkmrks[playername][bkmrkidx])))
  bookmarks[textlist_bkmrks[playername][bkmrkidx].player..
      textlist_bkmrks[playername][bkmrkidx].bkmrkname] = nil
  compassgps.write_bookmarks()
end --remove_bookmarks



function compassgps.remove_bookmark_byname(playername, bkmrkname)
	local player = minetest.get_player_by_name(playername)
	if not player then
		return
	end
	if bkmrkname == "" then
		minetest.chat_send_player(name, S("No bookmark was specified."))
		return
	end
	if not bookmarks[playername..bkmrkname] then
		minetest.chat_send_player(playername, S("You have no bookmark with this name."))
		return
	end
	bookmarks[playername..bkmrkname] = nil
  compassgps.write_bookmarks()
	minetest.chat_send_player(playername, S("The bookmark "..bkmrkname.." has been successfully removed."))
end



minetest.register_chatcommand("remove_bookmark", {
	params = "<bookmark_name>",
	description = S("Removes the bookmark specified by <bookmark_name>"),
	func = function(name, bkmrkname)
		compassgps.remove_bookmark_byname(name,bkmrkname)
	end,
})


function compassgps.teleport_bookmark(playername, bkmrkidx)
	local player = minetest.get_player_by_name(playername)
  if not compassgps.verify_bookmark_parms("teleport_bookmark",player,playername,bkmrkidx)
      then return end
  print(S("compassgps teleporting player %s to %s"):format(playername,
      compassgps.bookmark_name_string(textlist_bkmrks[playername][bkmrkidx])))
	minetest.chat_send_player(playername, S("Teleporting to %s"):format(
      compassgps.bookmark_name_string(textlist_bkmrks[playername][bkmrkidx])))
  player:setpos(textlist_bkmrks[playername][bkmrkidx])
end --teleport_bookmark



function compassgps.find_bookmark_byname(playername, bkmrkname)
	local player = minetest.get_player_by_name(playername)
	if not player then
		return
	end
	if not bkmrkname or bkmrkname == "" then
		minetest.chat_send_player(playername, S("No bookmark was specified."))
		return
	end
	if bkmrkname == "default" then
		minetest.chat_send_player(playername, S("Pointing at default location."))
		point_to[playername] = compassgps.get_default_bookmark(playername,1)
		return
	end
	if not bookmarks[playername..bkmrkname] then
		minetest.chat_send_player(playername, S("You have no bookmark with this name."))
		return
	end
	point_to[playername] = bookmarks[playername..bkmrkname]
	minetest.chat_send_player(playername, S("Pointing at %s."):format(bkmrkname))
end



function compassgps.find_bookmark(playername, bkmrkidx)
	local player = minetest.get_player_by_name(playername)
  if not compassgps.verify_bookmark_parms("find_bookmark",player,playername,bkmrkidx)
      then return end
	point_to[playername] = textlist_bkmrks[playername][bkmrkidx]
	minetest.chat_send_player(playername, S("Pointing at %s."):format(point_to[playername].bkmrkname))
end


minetest.register_chatcommand("find_bookmark", {
	params = "<bookmark_name>",
	description = S("Lets the compassgps point to the bookmark"),
	func = function(playername, bkmrkname)
		compassgps.find_bookmark_byname(playername,bkmrkname)
	end,
})





-- compassgps mod




-- default to static spawnpoint
local static_spawnpoint = minetest.setting_get_pos("static_spawnpoint")
-- default to 0/0/0 if spawnpoint is not present or invalid
local default_spawn = static_spawnpoint or {x=0, y=0, z=0}

local last_time_spawns_read = "default"
local beds_spawns = {}
local sethome_spawns = {}
function read_spawns()
	-- read BlockMen beds-mod positions (added to default minetest game)
	local beds_file = io.open(minetest.get_worldpath().."/beds_spawns", "r")
	if beds_file then
		while true do
			local x = beds_file:read("*n")
			if x == nil then
				break
			end
			local y = beds_file:read("*n")
			local z = beds_file:read("*n")
			local name = beds_file:read("*l")
			beds_spawns[name:sub(2)] = {x = x, y = y, z = z}
		end
		io.close(beds_file)
	else
	-- read PilzAdams beds-mod positions
	beds_file = io.open(minetest.get_worldpath().."/beds_player_spawns", "r")
		if beds_file then
			beds_spawns = minetest.deserialize(beds_file:read("*all"))
			beds_file:close()
		end
	end

	-- read sethome-mod positions
	if minetest.get_modpath('sethome') then
		local sethome_file = io.open(minetest.get_modpath('sethome')..'/homes', "r")
		if sethome_file then
			while true do
				local x = sethome_file:read("*n")
				if x == nil then
					break
				end
				local y = sethome_file:read("*n")
				local z = sethome_file:read("*n")
				local name = sethome_file:read("*l")
				sethome_spawns[name:sub(2)] = {x = x, y = y, z = z}
			end
			io.close(sethome_file)
		end
	end
end


function compassgps.compass_type_name(playername,imagenum,ctypein)
  local ctype="a"
  if ctypein then
    ctype=ctypein
  end
  if playername~="" and compass_type[playername] then
    ctype=compass_type[playername]
  end
  if ctype=="a" then
    ctype=""
  end
  --print("compass type name return "..ctype..imagenum)
  return ctype..imagenum
end


function compassgps.get_default_bookmark(name,num)
	-- try to get position from beds-mod spawn
	local pos = beds_spawns[name]
	local posname="bed"
	if pos~=nil and num==1 then
	   default_bookmark={x=pos.x,y=pos.y,z=pos.z,player=name,type="P",bkmrkname=posname}
	   return default_bookmark
	elseif pos~=nil then
	   num=num-1
	end
	-- fallback to sethome position
	pos = sethome_spawns[name]
	posname="home"
	if pos~=nil and num==1 then
  	   default_bookmark={x=pos.x,y=pos.y,z=pos.z,player=name,type="P",bkmrkname=posname}
	   return default_bookmark
	elseif pos~=nil then
	   num=num-1
	end
	if num>1 then
	   return
	end

	-- fallback to default
	pos = default_spawn;
	posname="spawn"
	default_bookmark={x=pos.x,y=pos.y,z=pos.z,player=name,type="P",bkmrkname=posname}
	return default_bookmark
end --get_default_bookmark

function compassgps.get_default_pos_and_name(name)
	-- try to get position from PilzAdams bed-mod spawn
	local pos = beds_spawns[name]
  local posname="bed"
	-- fallback to sethome position
	if pos == nil then
		pos = sethome_spawns[name]
    posname="sethome"
	end
	-- fallback to default
	if pos == nil then
		pos = default_spawn;
    posname="default"
	end
default_bookmark={x=pos.x,y=pos.y,z=pos.z,player=name,type="P"}
return pos,posname
end --get_compassgps_target_pos




minetest.register_globalstep(function(dtime)
	if last_time_spawns_read ~= os.date("%M") then
		last_time_spawns_read = os.date("%M")
		read_spawns()
	end
	local players  = minetest.get_connected_players()
	for i,player in ipairs(players) do
    local playername = player:get_player_name();

    local gotacompass=false
    local wielded=false
    local activeinv=nil
    local stackidx=0
    --first check to see if the user has a compass, because if they don't
    --there is no reason to waste time calculating bookmarks or spawnpoints.
		local wielded_item = player:get_wielded_item():get_name()
		if string.sub(wielded_item, 0, 11) == "compassgps:" and string.sub(wielded_item, 0, 18) ~= "compassgps:cgpsmap" then
      --if the player is wielding a compass, change the wielded image
      wielded=true
      stackidx=player:get_wield_index()
      gotacompass=true
		else
      --check to see if compass is in active inventory
      if player:get_inventory() then
        --is there a way to only check the activewidth items instead of entire list?
        --problem being that arrays are not sorted in lua
        for i,stack in ipairs(player:get_inventory():get_list("main")) do
          if i<=activewidth and string.sub(stack:get_name(), 0, 11) == "compassgps:" and string.sub(stack:get_name(),0,18) ~= "compassgps:cgpsmap" then
            activeinv=stack  --store the stack so we can update it later with new image
            stackidx=i --store the index so we can add image at correct location
            gotacompass=true
            break
          end --if i<=activewidth
        end --for loop
      end -- get_inventory
    end --if wielded else


    --dont mess with the rest of this if they don't have a compass
    if gotacompass then
      --if they don't have a bookmark set, use the default
      point_to[playername]=point_to[playername] or compassgps.get_default_bookmark(playername,1)
      target=point_to[playername] --just to take up less space
      pos = player:getpos()
      dir = player:get_look_yaw()
      local angle_north = math.deg(math.atan2(target.x - pos.x, target.z - pos.z))
      if angle_north < 0 then angle_north = angle_north + 360 end
      local angle_dir = 90 - math.deg(dir)
      local angle_relative = (angle_north - angle_dir) % 360
      local compass_image = math.floor((angle_relative/30) + 0.5)%12


      --update compass image to point at target
      if wielded then
        player:set_wielded_item("compassgps:"..
            compassgps.compass_type_name(playername,compass_image))
      elseif activeinv then
        --player:get_inventory():remove_item("main", activeinv:get_name())
        player:get_inventory():set_stack("main",stackidx,"compassgps:"..
            compassgps.compass_type_name(playername,compass_image))
      end --if wielded elsif activin


      --update the hud with playerpos -> target pos : distance to target
      distance_function[playername]=distance_function[playername] or compassgps.distance3d
      --if distance_function[playername]==nil then
      --  distance_function[playername]=compassgps.distance3d
      --end


      local hudx=tonumber(hud_default_x)
      local hudy=tonumber(hud_default_y)
      if hud_pos[playername] then
        hudx=tonumber(hud_pos[playername].x)
        hudy=tonumber(hud_pos[playername].y)
      else
        hud_pos[playername]={x=hud_default_x, y=hud_default_y}
      end

      local hudcolor=tonumber(hud_default_color, 16)
      if hud_color[playername] then
        hudcolor=tonumber(hud_color[playername], 16)
      else
        hud_color[playername]=hud_default_color
      end

      local compasstype=compass_default_type
      if compass_type[playername] and
         (compass_type[playername]=="a" or compass_type[playername]=="b" or compass_type[playername]=="c") then
        compasstype=compass_type[playername]
      else
        compass_type[playername]=compass_default_type
      end

      local h=nil
      if hudx>=0 and hudx<=1 and hudy>=0 and hudy<=1 then
        h = player:hud_add({
          hud_elem_type = "text";
          position = {x=hudx, y=hudy};
          text = compassgps.pos_to_string(pos).." -> "..
              compassgps.bookmark_name_pos_dist(target,playername,pos);
          --text = compassgps.pos_to_string(pos).." -> "..target.bkmrkname..
          --       " "..compassgps.pos_to_string(target).." : "..
          --       compassgps.round_digits(distance_function[playername](pos,target),2);
          number = hudcolor;
          scale = 20;
          });
        end --if x and y in range
      if (player_hud[playername]) then
        --remove the previous element
        player:hud_remove(player_hud[playername]);
      end
      player_hud[playername] = h; --store this element for removal next time
    --this elseif is triggered if gotacompass=false
    elseif (player_hud[playername]) then  --remove the hud if player no longer has compass
      player:hud_remove(player_hud[playername]);
      player_hud[playername]=nil
    end --if gotacompass
  end --for i,player in ipairs(players)
end) -- register_globalstep









function compassgps.sort_by_coords(table,a,b)
    if table[a].x==table[b].x then
       if table[a].z==table[b].z then
         return table[a].y<table[b].y
       else
         return table[a].z<table[b].z
       end
    else
      return table[a].x < table[b].x
    end
end --sort_by_coords


--this handy bit of code modified from Michal Kottman
--http://stackoverflow.com/questions/15706270/sort-a-table-in-lua
function spairs(t, order, player)
    --print("spairs top")
    --print("spairs top player="..player:get_player_name())
    --if order==compassgps.sort_by_distance then print("spairs order=sort_by_distance")
    --else print("spairs order=sort_by_name")
    --end
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end
    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b, player) end)
    else
        table.sort(keys)
    end
    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end--spairs






function compassgps.get_compassgps_formspec(name)
  local player = minetest.get_player_by_name(name)
  local playerpos = player:getpos()
  --print("get_compassgps_formspec spawn="..compassgps.pos_to_string(store_spawn[name]))
  --local list = "default "..compassgps.pos_to_string(compassgps.get_default_pos_and_name(name))
  --    .." : "..
  --    compassgps.round_digits(distance_function[name](playerpos,
  --         compassgps.get_default_pos_and_name(name)),2)
  --local k
  --local v
  --print("get_compassgps_formspec player "..name)

  local sortdropdown=1
  if sort_function[name] then
    if sort_function[name]==compassgps.sort_by_distance then
      sortdropdown=2
    end
  else
    sort_function[name]=compassgps.sort_by_name
  end

  local distdropdown=1
  if distance_function[name] then
    if distance_function[name]==compassgps.distance2d then
      distdropdown=2
    end
  else
    distance_function[name]=compassgps.distance3d
  end

  compassgps.check_view_type_all_blank(name)

  local bkmrkidx=1
  local list={}
  list,bkmrkidx=compassgps.bookmark_loop("L",name)


  --check to see if the player has teleport privliges
  local player_privs
  if core then player_privs = core.get_player_privs(name)
  else player_privs = minetest.get_player_privs(name)
  end
  local telebutton=""
  if player_privs["teleport"] then
    telebutton="button[4,9.3;3,1;teleport;"..S("teleport to bookmark").."]"
  end
  local sharedbutton=""
  if player_privs["shared_bookmarks"] and not singleplayer then
    sharedbutton="button[2.3,0.7;2.3,1;new_shared_bookmark;"..S("create shared").."]"
  end
  local adminbutton=""
  if player_privs["privs"] and not singleplayer then
    adminbutton="button[4.6,0.7;2.3,1;new_admin_bookmark;"..S("create admin").."]"
  end

  local checkboxes=""
  if not singleplayer then
    checkboxes="label[3.65,1.75;"..S("Show:").."]"..
    "checkbox[4.35,1.4;show_private;"..S("Private")..";"..view_type_P[name].."]"..
    "checkbox[4.35,1.7;show_shared;"..S("Shared")..";"..view_type_S[name].."]"..
    "checkbox[4.35,2.0;show_admin;"..S("Admin")..";"..view_type_A[name].."]"
  end

  return "compassgps:bookmarks", "size[9,10;]"..
    "field[0,0.2;5,1;bookmark;"..S("bookmark")..":;]"..
    "button[5.5,0;2.25,0.8;settings;"..S("Settings").."]"..
    "button[0,0.7;2.3,1;new_bookmark;"..S("create bookmark").."]"..
    sharedbutton..
    adminbutton..
    "button[6.9,0.7;2.4,1;remove_bookmark;"..S("remove bookmark").."]"..
    "label[0,1.75;"..S("Sort by:").."]"..
    "textlist[1,1.75;1.2,1;sort_type;"..S("name")..","..S("distance")..";"..sortdropdown.."]"..
    "label[2.4,1.75;"..S("Dist:").."]"..
    "textlist[3,1.75;.5,1;distance_type;3d,2d;"..distdropdown.."]"..
    checkboxes..
    "textlist[0,3.0;9,6;bookmark_list;"..list..";"..bkmrkidx.."]"..
    "button[0,9.3;3,1;find_bookmark;"..S("find selected bookmark").."]"..
    telebutton

end --get_compassgps_formspec



function compassgps.get_settings_formspec(name)
  local player = minetest.get_player_by_name(name)

  return "compassgps:settings", "size[8,4;]"..
    "button[1,0.2;2.25,1;hud_pos;"..S("Change hud:").."]"..
    "field[3.6,0.5;1.2,1;hudx;X:("..hud_default_x..");"..hud_pos[name].x.."]"..
    "field[4.8,0.5;1.2,1;hudy;Y:("..hud_default_y..");"..hud_pos[name].y.."]"..
    "field[6.0,0.5;2,1;hudcolor;"..S("Color:").."("..hud_default_color..");"..hud_color[name].."]"..
    "label[1,1.5;"..S("Compass Type:").."]"..
    "image_button[3,1.5;1,1;compass_0.png;compass_type_a;]"..
    "image_button[4,1.5;1,1;compass_b0.png;compass_type_b;]"..
    "image_button[5,1.5;1,1;compass_c0.png;compass_type_c;]"

end --get_compassgps_formspec






local i
--for i,img in ipairs(images) do
for i=1,12 do
  for c,ctype in pairs(compass_valid_types) do
    local inv = 1
    if i == 1 and ctype=="a" then
      inv = 0
    end
    ctypename=compassgps.compass_type_name("",(i-1),ctype)
    img="compass_"..ctypename..".png"
    --print("registering compassgps:"..ctypename.." img="..img)
    minetest.register_tool("compassgps:"..ctypename, {
      description = S("compassgps"),
      inventory_image = img,
      wield_image = img, --.."^[transformR90"  didn't work
      on_use = function (itemstack, user, pointed_thing)
          local name = user:get_player_name()
          if (name ~= "") then
            minetest.show_formspec(name, compassgps.get_compassgps_formspec(name))
          end
        end,
      groups = {not_in_creative_inventory=inv}
    })
  end --for ctype
end --for i,img

minetest.register_craft({
  output = 'compassgps:0',
  recipe = {
    {'', 'default:steel_ingot', ''},
    {'default:steel_ingot', 'default:mese_crystal_fragment', 'default:steel_ingot'},
    {'', 'default:steel_ingot', ''}
  }
})

dofile(minetest.get_modpath("compassgps").."/cgpsmap.lua")



