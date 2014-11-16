--------------------------------------------------------------------------------------------------------
--Ambiance Configuration for version .16

local max_frequency_all = 1000 --the larger you make this number the lest frequent ALL sounds will happen recommended values between 100-2000.

--for frequencies below use a number between 0 and max_frequency_all
--for volumes below, use a number between 0.0 and 1, the larger the number the louder the sounds
local night_frequency = 20  --owls, wolves 
local night_volume = 0.9  
local night_frequent_frequency = 150  --crickets
local night_frequent_volume = 0.9
local day_frequency = 100  --crow, bluejay, cardinal
local day_volume = 0.9 
local day_frequent_frequency = 1000  --crow, bluejay, cardinal
local day_frequent_volume = 0.18
local cave_frequency = 10  --bats
local cave_volume = 1.0  
local cave_frequent_frequency = 70  --drops of water dripping
local cave_frequent_volume = 1.0 
local beach_frequency = 20  --seagulls
local beach_volume = 1.0  
local beach_frequent_frequency = 1000  --waves
local beach_frequent_volume = 1.0 
local water_frequent_frequency = 1000  --water sounds
local water_frequent_volume = 1.0 
local music_frequency = 7  --music (suggestion: keep this one low like around 6)
local music_volume = 0.3 
--End of Config
----------------------------------------------------------------------------------------------------
local played_on_start = false
local night = {
	handler = {},
	frequency = night_frequency,
	{name="horned_owl", length=3, gain=night_volume},
	{name="Wolves_Howling", length=11,  gain=night_volume},
	{name="ComboWind", length=17,  gain=night_volume}
}

local night_frequent = {
	handler = {},
	frequency = night_frequent_frequency,
	{name="Crickets_At_NightCombo", length=69, gain=night_frequent_volume}
}

local day = {
	handler = {},
	frequency = day_frequency,
	{name="Best Cardinal Bird", length=4, gain=day_volume},
	{name="craw", length=3, gain=day_volume},
	{name="bluejay", length=18, gain=day_volume},
	{name="ComboWind", length=17,  gain=day_volume}
}

local day_frequent = {
	handler = {},
	frequency = day_frequent_frequency,
	{name="robin2", length=16, gain=day_frequent_volume},
	{name="birdsongnl", length=13, gain=day_frequent_volume},
	{name="bird", length=30, gain=day_frequent_volume},
	{name="Best Cardinal Bird", length=4, gain=day_frequent_volume},
	{name="craw", length=3, gain=day_frequent_volume},
	{name="bluejay", length=18, gain=day_frequent_volume},
	{name="ComboWind", length=17,  gain=day_frequent_volume*3}
}


local cave = {
	handler = {},
	frequency = cave_frequency,
	{name="Bats_in_Cave", length=5, gain=cave_volume}
}

local cave_frequent = {
	handler = {},
	frequency = cave_frequent_frequency,
	{name="drippingwater_drip_a", length=2, gain=cave_frequent_volume},
	{name="drippingwater_drip_b", length=2, gain=cave_frequent_volume},
	{name="drippingwater_drip_c", length=2, gain=cave_frequent_volume},
	{name="Single_Water_Droplet", length=3, gain=cave_frequent_volume},
	{name="Spooky_Water_Drops", length=7, gain=cave_frequent_volume}
}

local beach = {
	handler = {},
	frequency = beach_frequency,
	{name="seagull", length=4.5, gain=beach_volume}
}

local beach_frequent = {
	handler = {},
	frequency = beach_frequent_frequency,
	{name="fiji_beach", length=43.5, gain=beach_frequent_volume}
}


local water = {
	handler = {},
	frequency = 0,--dolphins dont fit into small lakes
	{name="dolphins", length=6},
	{name="dolphins_screaming", length=16.5}
}

local water_frequent = {
	handler = {},
	frequency = water_frequent_frequency,
	on_stop = "drowning_gasp",
	on_start = "Splash",
	{name="scuba1bubbles", length=11, gain=water_frequent_volume},
	{name="scuba1calm", length=10},  --not sure why but sometimes I get errors when setting gain=water_frequent_volume here.
	{name="scuba1calm2", length=8.5, gain=water_frequent_volume},
	{name="scuba1interestingbubbles", length=11, gain=water_frequent_volume},
	{name="scuba1tubulentbubbles", length=10.5, gain=water_frequent_volume}
}

local flowing_water = {
	handler = {},
	frequency = 1000,
	{name="small_waterfall", length=14, gain=.4}
}
local flowing_water2 = {
	handler = {},
	frequency = 1000,
	{name="small_waterfall", length=11, gain=.3}
}

local lava = {
	handler = {},
	frequency = 1000,
	{name="earth01a", length=20}
}
local lava2 = {
	handler = {},
	frequency = 1000,
	{name="earth01a", length=15}
}


local play_music = minetest.setting_getbool("music") or false
local music = {
	handler = {},
	frequency = music_frequency,
	{name="mtest", length=4*60+33, gain=music_volume},
	{name="echos", length=2*60+26, gain=music_volume},
	{name="FoamOfTheSea", length=1*60+50, gain=music_volume},
	{name="eastern_feeling", length=3*60+51, gain=music_volume},
	{name="Mass_Effect_Uncharted_Worlds", length=2*60+29, gain=music_volume},
	{name="dark_ambiance", length=44, gain=music_volume}
}

local is_daytime = function()
	return (minetest.get_timeofday() > 0.2 and  minetest.get_timeofday() < 0.8)
end

--[[old
local nodes_in_range = function(pos, search_distance, node_name)
	local search_p = {x=0, y=0, z=0}
	local nodes_found = 0
	for p_x=(pos.x-search_distance), (pos.x+search_distance) do
		for p_y=(pos.y-search_distance), (pos.y+search_distance) do
			for p_z=(pos.z-search_distance), (pos.z+search_distance) do
				local search_n = minetest.get_node({x=p_x, y=p_y, z=p_z})
				if search_n.name == node_name then
					nodes_found = nodes_found + 1
				end
			end
		end
	end
	return nodes_found
	--minetest.chat_send_all("Range: " .. tostring(search_distance) .. " | Found (" .. node_name .. ": " .. nodes_found .. ")")
end --]]

local nodes_in_range = function(pos, search_distance, node_name)
	minp = {x=pos.x-search_distance,y=pos.y-search_distance, z=pos.z-search_distance}
	maxp = {x=pos.x+search_distance,y=pos.y+search_distance, z=pos.z+search_distance}
	nodes = minetest.find_nodes_in_area(minp, maxp, node_name)
--	minetest.chat_send_all("Found (" .. node_name .. ": " .. #nodes .. ")")
	return #nodes
end


local get_ambience = function(player)
	local pos = player:getpos()
	pos.y = pos.y+1.0
	local nodename = minetest.get_node(pos).name
	if string.find(nodename, "default:water") then
		if music then
			return {water=water, water_frequent=water_frequent, music=music}
		else
			return {water=water, water_frequent=water_frequent}
		end
	end
	if nodes_in_range(pos, 7, "default:lava_flowing")>5 or nodes_in_range(pos, 7, "default:lava_source")>5 then
		if music then
			return {lava=lava, lava2=lava2, music=music}		
		else
			return {lava=lava}
		end
	end
	if nodes_in_range(pos, 7, "default:water_flowing")>5 then
		if music then
			return {flowing_water=flowing_water, flowing_water2=flowing_water2, music=music}
		else
			return {flowing_water=flowing_water, flowing_water2=flowing_water2}
		end
	end
	pos.y = pos.y-2 
	nodename = minetest.get_node(pos).name
	--minetest.chat_send_all("Found " .. nodename .. pos.y )
	if string.find(nodename, "default:sand") and pos.y < 5 then
		if music then
			return {beach=beach, beach_frequent=beach_frequent, music=music}
		else
			return {beach=beach, beach_frequent=beach_frequent}
		end
	end
	if player:getpos().y < 0 then
		if music then
			return {cave=cave, cave_frequent=cave_frequent, music=music}
		else
			return {cave=cave, cave_frequent=cave_frequent}
		end
	end
	if is_daytime() then
		if music then
			return {day=day, day_frequent=day_frequent, music=music}
		else
			return {day=day, day_frequent=day_frequent}
		end
	else
		if music then
			return {night=night, night_frequent=night_frequent, music=music}
		else
			return {night=night, night_frequent=night_frequent}
		end
	end
end

-- start playing the sound, set the handler and delete the handler after sound is played
local play_sound = function(player, list, number)
	local player_name = player:get_player_name()
	if list.handler[player_name] == nil then
		local gain = 1.0
		if list[number].gain ~= nil then
			gain = list[number].gain
		end
		local handler = minetest.sound_play(list[number].name, {to_player=player_name, gain=gain})
		if handler ~= nil then
			list.handler[player_name] = handler
			minetest.after(list[number].length, function(args)
				local list = args[1]
				local player_name = args[2]
				if list.handler[player_name] ~= nil then
					minetest.sound_stop(list.handler[player_name])
					list.handler[player_name] = nil
				end
			end, {list, player_name})
		end
	end
end

-- stops all sounds that are not in still_playing
local stop_sound = function(still_playing, player)
	local player_name = player:get_player_name()
	if still_playing.cave == nil then
		local list = cave
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.cave_frequent == nil then
		local list = cave_frequent
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.beach == nil then
		local list = beach
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.beach_frequent == nil then
		local list = beach_frequent
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end

	if still_playing.night == nil then
		local list = night
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.night_frequent == nil then
		local list = night_frequent
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.day == nil then
		local list = day
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.day_frequent == nil then
		local list = day_frequent
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.music == nil then
		local list = music
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.flowing_water == nil then
		local list = flowing_water
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.flowing_water2 == nil then
		local list = flowing_water2
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.lava == nil then
		local list = lava
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end	
	if still_playing.lava2 == nil then
		local list = lava2
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end		
	if still_playing.water == nil then
		local list = water
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.water_frequent == nil then
		local list = water_frequent
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then				
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
				played_on_start = false
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
end

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer+dtime
	if timer < 1 then
		return
	end
	timer = 0

	for _,player in ipairs(minetest.get_connected_players()) do
		local ambiences = get_ambience(player)
		stop_sound(ambiences, player)
		for _,ambience in pairs(ambiences) do
			if math.random(1, 1000) <= ambience.frequency then
				if ambience.on_start ~= nil and played_on_start == false then
					played_on_start = true
					minetest.sound_play(ambience.on_start, {to_player=player:get_player_name()})					
				end
				play_sound(player, ambience, math.random(1, #ambience))
			end
		end
	end
end)