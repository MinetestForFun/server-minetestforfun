local broomstick_time = 120 -- Seconds (for default 2 minutes)
local broomstick_mana = 210
local broomstick_actual_users = {}
local had_fly_privilege = {}
local privs = {}

-- Register broomstick
minetest.register_craftitem("broomstick:broomstick", {
	description = "Broomstick",
	inventory_image = "broomstick.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local playername = user:get_player_name()
		if mana.get(playername) >= broomstick_mana then
			local has_already_a_broomstick = false
			for _, i in ipairs(broomstick_actual_users) do
				if i.name == playername then
					has_already_a_broomstick = true
				end
			end
			if not has_already_a_broomstick then
				privs = minetest.get_player_privs(playername)
				-- Set player privs...
				if not privs.fly == true then
					privs.fly = true
					minetest.set_player_privs(playername, privs)
				else
					minetest.chat_send_player(playername, "You known you " ..
						"can fly by yourself, don't you?")
					return
				end
				-- Send a message...
				minetest.chat_send_player(playername, "You can now fly during "
					.. tostring(broomstick_time) .. " seconds.")
				minetest.log("action", "Player " .. playername
					.." has use a broomstick.")
				-- Subtract mana...
				mana.subtract(playername, broomstick_mana)
				-- And insert player in the list.
				table.insert(broomstick_actual_users, {
					name = playername,
					time = 0,
					is_warning_said = false
				})
				-- Remove broomstick...
				local item_count = user:get_wielded_item():get_count()
				return ItemStack("broomstick:broomstick ".. tostring(item_count-1))
			else
				minetest.chat_send_player(playername, "You already have a " ..
					"broomstick ! Please wait until the end of your actual " ..
					"broomstick.")
			end
		else
			minetest.chat_send_player(playername, "You must have " ..
				tostring(broomstick_mana) .. " of mana to use a broomstick !")
		end
	end,
})

-- Broomstick timer
minetest.register_globalstep(function(dtime)
	for index, i in ipairs(broomstick_actual_users) do
		i.time = i.time + dtime
		-- Just a little warning message
		if i.time >= broomstick_time - 10 and not i.is_warning_said then
			minetest.chat_send_player(i.name,
				"WARNING ! You'll fall in 10 seconds !")
			i.is_warning_said = true
		elseif i.time >= broomstick_time then
			-- Send a message...
			minetest.chat_send_player(i.name, "End of broomstick. " ..
				"I hope you're not falling down...")
			-- Set player privs...
			privs = minetest.get_player_privs(i.name)
			privs["fly"] = nil
			minetest.set_player_privs(i.name, privs)
			-- And remove the player in the list.
			table.remove(broomstick_actual_users, index)
		end
	end
end)

-- Craft
minetest.register_craft({
	output = "broomstick:broomstick",
	recipe = {{"default:stick","default:stick","farming:wheat",}},
})

minetest.log("action", "[OK] broomstick")
