-----------------------------
-- Boilerplate class
--

pclasses.api.register_class("adventurer", {
	switch_params = {
		color = { r = 142, g = 64, b = 00},
		tile = "wool_white.png",
		holo_item = "unified_inventory:bag_large"
	},
	on_assigned = function(pname, inform)
		if inform then
			minetest.chat_send_player(pname, "You are now an adventurer")
		end
		pclasses.api.util.on_update(pname)
	end,
	on_unassigned = function(pname)
	end,
	on_update = function(pname)
		local staminavalue = 10
		local manavalue = 100
		sprint.set_maxstamina(pname, staminavalue)
		mana.setmax(pname, manavalue)
	end,
	informations = pclasses.api.textify("Adventurer, the casual players, or hardcore players. Whatever end of the spectrum\n" ..
		"you're in, adventurer will bring you what you want : no advantages, no help. Maybe you\n" ..
		"don't want that if you just began playing. If that's the case.. just pick another tab and\n" ..
		"read what's in it. You'll still be able to come back to this boilerplate class whenever you\n" ..
		"want to (minus actual cooldown regulation of.. an hour between two changes) if you like\n" ..
		"being hurt, or hardcore gaming, which, from afar, look alike.... The pedestal has a backpack\n" ..
		"over it, because, yay adventures!") .. "image[2.4,5.6;6,4;pclasses_showcase_adventurer.png]"
})

