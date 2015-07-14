local broomstick_time = 120 -- Seconds
local broomstick_mana = 190
local broomstick_actual_users = {}
local had_fly_privilege = {}
local privs = {}

-- broomstick file
users_file = minetest.get_worldpath() .. "/broomstick_users.txt"
--load broomstick  file
local file = io.open(users_file, "r")
if file then
	had_fly_privilege = minetest.deserialize(file:read("*all"))
	file:close()
	file = nil
	if not had_fly_privilege or type(had_fly_privilege) ~= "table" then
		had_fly_privilege = {}
	end
else
	minetest.log("error", "[broomstick] Can not open broomstick_users.txt file !")
end


-- funtion save broomstick  file
local function save()
	local input = io.open(users_file, "w")
	if input then
		input:write(minetest.serialize(had_fly_privilege))
		input:close()
	else
		minetest.log("error","[broomstick] Open failed (mode:w) of " .. users_file)
	end
end

-- on join_player remove priv fly
minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()
	if had_fly_privilege[playername] ~= nil then
		privs = minetest.get_player_privs(playername)
		privs.fly = nil
		minetest.set_player_privs(playername, privs)
		had_fly_privilege[playername] = nil
		save()
	end
end)

-- Broomstick timer
local function broomstick_end(playername)
	minetest.chat_send_player(playername, "WARNING ! You'll fall in 10 seconds !")
	minetest.after(10, function(playername)
		-- Send a message...
		minetest.chat_send_player(playername, "End of broomstick. I hope you're not falling down...")
		-- Set player privs...
		privs = minetest.get_player_privs(playername)
		privs["fly"] = nil
		minetest.set_player_privs(playername, privs)
		-- Remove the player in the list.
		for i = 1, #broomstick_actual_users do
			if broomstick_actual_users[i] == playername then
				table.remove(broomstick_actual_users, i)
			end
		end
		-- Rewrite the broomstick_users.txt file.
		had_fly_privilege[playername] = nil
		save()
	end, playername)
end

-- Register broomstick
minetest.register_craftitem("broomstick:broomstick", {
	description = "Broomstick",
	inventory_image = "broomstick.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local playername = user:get_player_name()
		if mana.get(playername) >= broomstick_mana then
			local has_already_a_broomstick = false
			for i = 1, #broomstick_actual_users do
				if broomstick_actual_users[i] == playername then
					has_already_a_broomstick = true
				end
			end
			if not has_already_a_broomstick then
				privs = minetest.get_player_privs(playername)
				-- Set player privs...
				if not privs.fly == true then
					-- Rewrite the broomstick_users.txt file.
					had_fly_privilege[playername] = true
					save()
					privs.fly = true
					minetest.set_player_privs(playername, privs)
				else
					minetest.chat_send_player(playername, "You known you can fly by yourself, don't you?")
					return
				end
				-- Send a message...
				minetest.chat_send_player(playername, "You can now fly during " .. tostring(broomstick_time) .. " seconds.")
				minetest.log("action", "Player " .. playername .. " has use a broomstick.")
				-- Subtract mana...
				mana.subtract(playername, broomstick_mana)
				-- Insert player in the list.
				table.insert(broomstick_actual_users, playername)
				-- And add the function in queue
				minetest.after(broomstick_time-10, broomstick_end, playername)
				-- Remove broomstick.
				return ItemStack("")
			else
				minetest.chat_send_player(playername, "You already have a broomstick ! Please wait until the end of your actual broomstick.")
			end
		else
			minetest.chat_send_player(playername, "You must have " .. tostring(broomstick_mana) .. " of mana to use a broomstick !")
		end
	end,
})

-- Craft
minetest.register_craft({
	output = "broomstick:broomstick",
	recipe = {{"","","farming:string",},
		{"default:stick","default:stick","mobs:minotaur_lots_of_fur",},
		{"","","farming:string",},},
})


minetest.log("info", "[OK] broomstick")
