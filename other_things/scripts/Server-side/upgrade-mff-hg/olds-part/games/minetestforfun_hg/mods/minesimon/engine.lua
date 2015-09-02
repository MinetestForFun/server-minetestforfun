
--function str position, {x,y,z} to "x_y_z"
function minesimon.get_name_pos(pos)
	local str_pos =  pos.x.."_"..pos.y.."_"..pos.z
	return str_pos
end


--function return position of node 1
function minesimon.get_one_pos(pos, dir, i)
	if i == 1 then return pos end
	local onepos
	if dir == 0 then
		if i == 2 then
			onepos = {x=pos.x-1, y=pos.y, z=pos.z}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y-1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x-1, y=pos.y-1, z=pos.z}
		end
	elseif dir == 1 then
		if i == 2 then
			onepos = {x=pos.x, y=pos.y, z=pos.z+1}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y-1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x, y=pos.y-1, z=pos.z+1}
		end
	elseif dir == 2 then
		if i == 2 then
			onepos = {x=pos.x+1, y=pos.y, z=pos.z}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y-1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x+1, y=pos.y-1, z=pos.z}
		end
	elseif dir == 3 then
		if i == 2 then
			onepos = {x=pos.x, y=pos.y, z=pos.z-1}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y-1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x, y=pos.y-1, z=pos.z-1}
		end
	end
	return onepos
end


--function return position of node i
function minesimon.get_abs_pos(pos, dir, i)
	if i == 1 then return pos end
	local onepos
	if dir == 0 then
		if i == 2 then
			onepos = {x=pos.x+1, y=pos.y, z=pos.z}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y+1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x+1, y=pos.y+1, z=pos.z}
		end
	elseif dir == 1 then
		if i == 2 then
			onepos = {x=pos.x, y=pos.y, z=pos.z-1}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y+1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x, y=pos.y+1, z=pos.z-1}
		end
	elseif dir == 2 then
		if i == 2 then
			onepos = {x=pos.x-1, y=pos.y, z=pos.z}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y+1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x-1, y=pos.y+1, z=pos.z}
		end
	elseif dir == 3 then
		if i == 2 then
			onepos = {x=pos.x, y=pos.y, z=pos.z+1}
		elseif i == 3 then
			onepos = {x=pos.x, y=pos.y+1, z=pos.z}
		elseif i == 4 then
			onepos = {x=pos.x, y=pos.y+1, z=pos.z+1}
		end
	end
	return onepos
end


--function reset nodes if not off
function minesimon.reset_node(pos, dir)
	for i=1,4 do
		local pos1 = minesimon.get_abs_pos(pos, dir, i)
		local node = minetest.get_node_or_nil(pos1)
		if not node or node.name ~= "minesimon:note_"..i.."_off" then
			minetest.set_node(pos1, {name = "minesimon:note_"..i.."_off", param2 = dir})
		end
	end
end

--function start new game if game free and player has not already started a game
function minesimon.start_game(playername, onepos, str_pos, pos, dir, i)
	if not minesimon["games"][str_pos] or minesimon["games"][str_pos]["ingame"] ~= true then
		if not minesimon["players"][playername] and not minesimon["players"][playername] ~= str_pos then
			local t1 = os.clock()
			minesimon["games"][str_pos] = {str_pos=str_pos, pos=onepos, dir=dir, notes={}, current=1,player=playername, ingame=true, wait=true, last_punch=t1}
			minesimon["players"][playername] = str_pos
			minetest.chat_send_player(playername, "Game started!")
			minesimon.reset_node(onepos, dir)
			minesimon.add_notes(playername, str_pos)
		else
			minetest.chat_send_player(playername, "You have already started a game!")
		end
	else
		minetest.chat_send_player(playername, "A Game is already started!")
	end
end


-- function play note and swap node
function minesimon.play_note(pos, dir, i)
	minetest.sound_play("minesimon_note_"..i, {pos=pos, gain=0.6, max_hear_distance = 5})
	minetest.swap_node(pos, {name = "minesimon:note_"..i.."_on", param2 = dir})
	minetest.after(0.8, function()
		minetest.swap_node(pos, {name = "minesimon:note_"..i.."_off", param2 = dir})
	end)
end


--function add new note and play all
function minesimon.add_notes(playername, str_pos)
	if not minesimon["games"][str_pos] then return end
	if not minesimon["games"][str_pos]["notes"] then
		minesimon["games"][str_pos]["notes"] = {}
	end
	table.insert(minesimon["games"][str_pos]["notes"], math.random(1,4))
	minesimon["games"][str_pos]["current"] = 1
	minesimon.play_all_notes(playername, minesimon["games"][str_pos], 1)
end


-- function play all notes if allways ingame
function minesimon.play_all_notes(playername, p, note)
	local pos = p["pos"]
	local dir = p["dir"]
	local str_pos = p["str_pos"]
	local notes = minesimon["games"][str_pos]["notes"]
	minetest.after(1.1, function()
		if not minesimon["games"][str_pos]["ingame"] then return end
		minesimon.play_note(minesimon.get_abs_pos(pos, dir, notes[note]), dir, notes[note])
		if note < #minesimon["games"][str_pos]["notes"] then
			minesimon.play_all_notes(playername, p, note+1)
		else
			minesimon["games"][str_pos]["wait"] = false
		end
	end)
end


--function test if punched note is correct
function minesimon.get_correct(playername, str_pos, i)
	minesimon["games"][str_pos]["last_punch"] = os.clock()
	local p = minesimon["games"][str_pos]
	local current = minesimon["games"][str_pos]["current"]
	if p["notes"][current] == i then
		minesimon.play_note(minesimon.get_abs_pos(p["pos"], p["dir"], i), p["dir"], i)
		minesimon["games"][str_pos]["current"] = current+1
		if minesimon["games"][str_pos]["current"] > #minesimon["games"][str_pos]["notes"] then
			minesimon["games"][str_pos]["wait"] = true
			minetest.after(1, function()
				minesimon.add_notes(playername, str_pos)
			end)
		end
	else
		local max = #minesimon["games"][str_pos]["notes"]
		minetest.chat_send_player(playername,"You lost, score:"..max)
		minetest.sound_play("minesimon_lost", {pos=p["pos"], gain=0.6, max_hear_distance = 5})
		minesimon["games"][str_pos]["ingame"] = false
		minesimon["games"][str_pos]["player"] = false
		minesimon["players"][playername] = false
	end
end


minetest.register_on_leaveplayer(function(player)
	local playername = player:get_player_name()
	if  minesimon["players"][playername] then
		minesimon["games"][minesimon["players"][playername]]["ingame"] = false
		minesimon["games"][minesimon["players"][playername]]["player"] = false
		minesimon["players"][playername] = nil
	end
end)
