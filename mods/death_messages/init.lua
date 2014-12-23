-----------------------------------------------------------------------------------------------
local title	= "Death Messages"
local version = "0.1.2"
local mname	= "death_messages"
-----------------------------------------------------------------------------------------------
dofile(minetest.get_modpath("death_messages").."/settings.txt")
-----------------------------------------------------------------------------------------------

-- A table of quips for death messages

local messages = {}

-- Lava death messages
messages.lava = {
	" pensait que la lave etait cool.",
	" s'est sentit oblige de toucher la lave.",
	" est tombe dans la lave.",
	" est mort dans de la lave.",
	" ne savait pas que la lave etait vraiment chaude."
}

-- Drowning death messages
messages.water = {
	" a manque d'air.",
	" a essaye d'usurper l'identite d'une ancre.",
	" a oublie qu'il n'etait pas un poisson.",
	" a oublier qu'il lui fallait respirer sous l'eau.",
	" n'est pas bon en natation."
}

-- Burning death messages
messages.fire = {
	" a eut un peu trop chaud.",
	" a ete trop pres du feu.",
	" vient de se faire rotir.",
	" a ete carbonise.",
	" s'est prit pour torch man. (des quatres fantastiques)"
}

-- Burning death messages
messages.acid = {
	" a desormais des parties en moins.",
	" a decouvert que l'acide c'est fun.",
	" a mis sa tete la ou elle a fondu.",
	" a decouvert que son corps dans l'acide, c'est comme du sucre dans de l'eau.",
	" a cru qu'il se baignait dans du jus de pomme."
}

-- Other death messages
messages.other = {
	" a fait quelque chose qui lui a ete fatale.",
	" est mort.",
	" n'est plus de ce monde.",
	" a rejoint le paradis des mineurs.",
	" a perdu la vie."
}

if RANDOM_MESSAGES == true then
	minetest.register_on_dieplayer(function(player)
		local player_name = player:get_player_name()
		local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
		if minetest.is_singleplayer() then
			player_name = "You"
		end
		-- Death by lava
		if node.groups.lava ~= nil then
			minetest.chat_send_all(player_name ..  messages.lava[math.random(1,#messages.lava)] )
		-- Death by acid
		elseif node.groups.acid ~= nil then
			minetest.chat_send_all(player_name ..  messages.acid[math.random(1,#messages.acid)] )
		-- Death by drowning
		elseif player:get_breath() == 0 then
			minetest.chat_send_all(player_name ..  messages.water[math.random(1,#messages.water)] )
		-- Death by fire
		elseif node.name == "fire:basic_flame" then
			minetest.chat_send_all(player_name ..  messages.fire[math.random(1,#messages.fire)] )
		-- Death by something else
		else
			minetest.chat_send_all(player_name ..  messages.other[math.random(1,#messages.other)] )
		end

	end)
	
else
	minetest.register_on_dieplayer(function(player)
		local player_name = player:get_player_name()
		local node = minetest.registered_nodes[minetest.get_node(player:getpos()).name]
		if minetest.is_singleplayer() then
			player_name = "You"
		end
		-- Death by lava
		if node.groups.lava ~= nil then
			minetest.chat_send_all(player_name .. " melted into a ball of fire")
		-- Death by drowning
		elseif player:get_breath() == 0 then
			minetest.chat_send_all(player_name .. " ran out of air.")
		-- Death by fire
		elseif node.name == "fire:basic_flame" then
			minetest.chat_send_all(player_name .. " burned to a crisp.")
		-- Death by something else
		else
			minetest.chat_send_all(player_name .. " died.")
		end

	end)
end

-----------------------------------------------------------------------------------------------
print("[Mod] "..title.." ["..version.."] ["..mname.."] Loaded...")
-----------------------------------------------------------------------------------------------
