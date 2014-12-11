--------------------------------------------------------------------------------------------------------
--Ambiance Configuration for version .29   
--working on Flying
--PROB:  wind stops short even though it says we are still flying and don't hear the start sound.
--really BIG prob, it ruins water meaning you hear beach while treading water.  (find out if still hear it in .28) because
--it is fairly rare in .29
--need a separate onstart variable for flying


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
local desert_frequency = 20  --coyote
local desert_volume = 1.0  
local desert_frequent_frequency = 700  --desertwind
local desert_frequent_volume = 1.0 
local swimming_frequent_frequency = 1000  --swimming splashes
local swimming_frequent_volume = 1.0 
local music_frequency = 0  --music (suggestion: keep this one low like around 6)
local music_volume = 0.3 
--End of Config
----------------------------------------------------------------------------------------------------
local counter=0--*****************
local last_x_pos = 0
local last_y_pos = 0
local last_z_pos = 0
local node_under_feet
local node_at_upper_body
local node_at_lower_body
local node_3_under_feet

local played_on_start = false
local played_on_start_flying = false

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
local swimming_frequent = {
	handler = {},
	frequency = day_frequent_frequency,
	{name="water_swimming_splashing_breath", length=11.5, gain=swimming_frequent_volume},
	{name="water_swimming_splashing", length=9, gain=swimming_frequent_volume}
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

local desert = {
	handler = {},
	frequency = desert_frequency,
	{name="coyote2", length=2.5, gain=desert_volume},
	{name="RattleSnake", length=8, gain=desert_volume}
}

local desert_frequent = {
	handler = {},
	frequency = desert_frequent_frequency,
	{name="DesertMonolithMed", length=34.5, gain=desert_frequent_volume}
}

local flying = {
	handler = {},
	frequency = 1000,
	on_start = "crystal_airlines",
	on_stop = "nothing_yet",
	{name="ComboWind", length=17,  gain=1}
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
	--on_start = "Splash",
	{name="scuba1bubbles", length=11, gain=water_frequent_volume},
	{name="scuba1calm", length=10},  --not sure why but sometimes I get errors when setting gain=water_frequent_volume here.
	{name="scuba1calm2", length=8.5, gain=water_frequent_volume},
	{name="scuba1interestingbubbles", length=11, gain=water_frequent_volume},
	{name="scuba1tubulentbubbles", length=10.5, gain=water_frequent_volume}
}

local water_surface = {
	handler = {},
	frequency = 1000,
	on_stop = "Splash",
	on_start = "Splash",
	{name="lake_waves_2_calm", length=9.5},
	{name="lake_waves_2_variety", length=13.1}
}
local splashing_water = {
	handler = {},
	frequency = 1000,
	{name="Splash", length=1.22, gain=1}
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

local nodes_in_range = function(pos, search_distance, node_name)
	minp = {x=pos.x-search_distance,y=pos.y-search_distance, z=pos.z-search_distance}
	maxp = {x=pos.x+search_distance,y=pos.y+search_distance, z=pos.z+search_distance}
	nodes = minetest.find_nodes_in_area(minp, maxp, node_name)
	--minetest.chat_send_all("Found (" .. node_name .. ": " .. #nodes .. ")")
	return #nodes
end

local nodes_in_coords = function(minp, maxp, node_name)
	nodes = minetest.find_nodes_in_area(minp, maxp, node_name)
	--minetest.chat_send_all("Found (" .. node_name .. ": " .. #nodes .. ")")
	return #nodes
end

local atleast_nodes_in_grid = function(pos, search_distance, height, node_name, threshold)
--	counter = counter +1
--	minetest.chat_send_all("counter: (" .. counter .. ")")
	minp = {x=pos.x-search_distance,y=height, z=pos.z+20}
	maxp = {x=pos.x+search_distance,y=height, z=pos.z+20}
	nodes = minetest.find_nodes_in_area(minp, maxp, node_name)
--	minetest.chat_send_all("z+Found (" .. node_name .. ": " .. #nodes .. ")")
	if #nodes >= threshold then
		return true
	end
	totalnodes = #nodes
	minp = {x=pos.x-search_distance,y=height, z=pos.z-20}
	maxp = {x=pos.x+search_distance,y=height, z=pos.z-20}
	nodes = minetest.find_nodes_in_area(minp, maxp, node_name)
--	minetest.chat_send_all("z-Found (" .. node_name .. ": " .. #nodes .. ")")
	if #nodes >= threshold then
		return true
	end
	totalnodes = totalnodes + #nodes
	maxp = {x=pos.x+20,y=height, z=pos.z+search_distance}
	minp = {x=pos.x+20,y=height, z=pos.z-search_distance}
	nodes = minetest.find_nodes_in_area(minp, maxp, node_name)	
--	minetest.chat_send_all("x+Found (" .. node_name .. ": " .. #nodes .. ")")
	if #nodes >= threshold then
		return true
	end
	totalnodes = totalnodes + #nodes
	maxp = {x=pos.x-20,y=height, z=pos.z+search_distance}
	minp = {x=pos.x-20,y=height, z=pos.z-search_distance}
	nodes = minetest.find_nodes_in_area(minp, maxp, node_name)	
--	minetest.chat_send_all("x+Found (" .. node_name .. ": " .. #nodes .. ")")	
	if #nodes >= threshold then
		return true
	end
	totalnodes = totalnodes + #nodes
--	minetest.chat_send_all("Found total(" .. totalnodes .. ")")
	if totalnodes >= threshold*2 then
		return true
	end	
	return false
end

local get_immediate_nodes = function(pos)
	pos.y = pos.y-1
	node_under_feet = minetest.get_node(pos).name
	pos.y = pos.y-3
	node_3_under_feet = minetest.get_node(pos).name
	pos.y = pos.y+3
	pos.y = pos.y+2.2
	node_at_upper_body = minetest.get_node(pos).name
	pos.y = pos.y-1.19   
	node_at_lower_body = minetest.get_node(pos).name
	pos.y = pos.y+0.99   --1.6
	--minetest.chat_send_all("node_under_feet(" .. nodename .. ")")
end 


local get_ambience = function(player)
	local player_is_climbing = false
	local player_is_descending = false
	local player_is_moving_horiz = false
	local standing_in_water = false
	local pos = player:getpos()
	get_immediate_nodes(pos)

	if last_x_pos ~=pos.x or last_z_pos ~=pos.z then 
		player_is_moving_horiz = true 
	end
	if pos.y > last_y_pos+.5   then 
		player_is_climbing = true 
	end
	if pos.y < last_y_pos-.5  then 
		player_is_descending = true 
	end
	
	last_x_pos =pos.x
	last_z_pos =pos.z	
	last_y_pos =pos.y
	
	if string.find(node_at_upper_body, "default:water") then
		if music then
			return {water=water, water_frequent=water_frequent, music=music}
		else
			return {water=water, water_frequent=water_frequent}
		end
	elseif node_at_upper_body == "air" then
		if string.find(node_at_lower_body, "default:water") then
		    --minetest.chat_send_all("bottom counted as water")
			--we found air at upperbody, and water at lower body.  Now there are 4 possibilities:
			--Key: under feet, moving or not
			--swimming 			w, m swimming
			--walking in water  nw, m splashing
			--treading water    w, nm  sloshing
			--standing in water nw, nm	beach trumps, then sloshing					
			if player_is_moving_horiz then
				if string.find(node_under_feet, "default:water") then
					if music then
						return {swimming_frequent=swimming_frequent, music=music}
					else
						return {swimming_frequent}
					end	
				else --didn't find water under feet: walking in water			
					if music then
						return {splashing_water=splashing_water, music=music}
					else
						return {splashing_water}
					end	
				end
			else--player is not moving
				if string.find(node_under_feet, "default:water") then
					if music then
						return {water_surface=water_surface, music=music}
					else
						return {water_surface}
					end	
				else --didn't find water under feet				
					standing_in_water = true
				end			
		    end
		end	
	end
	if player_is_moving_horiz then
		minetest.chat_send_all("playermoving")
	end
	if player_is_climbing then
			minetest.chat_send_all("player Climbing")
	end
	minetest.chat_send_all("nub:" ..node_at_upper_body)
	minetest.chat_send_all("nlb:" ..node_at_lower_body)
	minetest.chat_send_all("nuf:" ..node_under_feet)
	minetest.chat_send_all("n3uf:" ..node_3_under_feet)
	
	local air_or_ignore = {air=true,ignore=true}
	--minetest.chat_send_all(air_or_ignore[node_under_feet])
	if (player_is_moving_horiz or player_is_climbing) and air_or_ignore[node_at_upper_body] and air_or_ignore[node_at_lower_body]
	 and air_or_ignore[node_under_feet] and air_or_ignore[node_3_under_feet] and not player_is_descending then 
	minetest.chat_send_all("flying!!!!")	
		if music then
			return {flying=flying, music=music}
		else
			return {flying}
		end	
	end
	minetest.chat_send_all("not flying!!!!")	

	if nodes_in_range(pos, 7, "default:lava_flowing")>5 or nodes_in_range(pos, 7, "default:lava_source")>5 then
		if music then
			return {lava=lava, lava2=lava2, music=music}		
		else
			return {lava=lava}
		end
	end
	if nodes_in_range(pos, 6, "default:water_flowing")>45 then
		if music then
			return {flowing_water=flowing_water, flowing_water2=flowing_water2, music=music}
		else
			return {flowing_water=flowing_water, flowing_water2=flowing_water2}
		end
	end	


--if we are near sea level and there is lots of water around the area
	if pos.y < 7 and pos.y >0 and atleast_nodes_in_grid(pos, 60, 1, "default:water_source", 51 ) then
		if music then
			return {beach=beach, beach_frequent=beach_frequent, music=music}
		else
			return {beach=beach, beach_frequent=beach_frequent}
		end		
	end
	if standing_in_water then
		if music then
			return {water_surface=water_surface, music=music}
		else
			return {water_surface}
		end	
	end
	
	
	desert_in_range = (nodes_in_range(pos, 6, "default:desert_sand")+nodes_in_range(pos, 6, "default:desert_stone"))
	--minetest.chat_send_all("desertcount: " .. desert_in_range .. ",".. pos.y )
	if  desert_in_range >250 then
		if music then
			return {desert=desert, desert_frequent=desert_frequent, music=music}
		else
			return {desert=desert, desert_frequent=desert_frequent}
		end
	end	

	pos.y = pos.y-2 
	nodename = minetest.get_node(pos).name
--	minetest.chat_send_all("Found " .. nodename .. pos.y )
	

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
	if still_playing.swimming_frequent == nil then
		local list = swimming_frequent
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
	if still_playing.desert == nil then
		local list = desert
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.desert_frequent == nil then
		local list = desert_frequent
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
	if still_playing.water_surface == nil then
		local list = water_surface
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then				
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
				played_on_start = false
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
		--		minetest.chat_send_all("list.on_stop " .. list.on_stop  )				
				played_on_start = false
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end
	if still_playing.flying == nil then
		--minetest.chat_send_all("begin stop flying "   )
		local list = flying
		if list.handler[player_name] ~= nil then
		--	minetest.chat_send_all("handler flying "   )
			if list.on_stop ~= nil then
			--	minetest.chat_send_all("onstop flying"   )
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
				played_on_start = false
			end
			minetest.sound_stop(list.handler[player_name])
			list.handler[player_name] = nil
		end
	end	
	if still_playing.splashing_water == nil then
		local list = splashing_water
		if list.handler[player_name] ~= nil then
			if list.on_stop ~= nil then
				minetest.sound_play(list.on_stop, {to_player=player:get_player_name()})
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
				if(played_on_start) then
				--	minetest.chat_send_all("playedOnStart "  )
				else
				--	minetest.chat_send_all("FALSEplayedOnStart "  )
				end
				if ambience.on_start ~= nil and played_on_start == false then
					played_on_start = true
					minetest.sound_play(ambience.on_start, {to_player=player:get_player_name()})					
				end
				minetest.chat_send_all("ambience: " ..ambience )
			--	if ambience.on_start ~= nil and played_on_start_flying == false then
			--		played_on_start_flying = true
			--		minetest.sound_play(ambience.on_start, {to_player=player:get_player_name()})					
			--	end
				play_sound(player, ambience, math.random(1, #ambience))
			end
		end
	end
end)