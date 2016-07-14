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
	end,
	on_unassigned = function(pname)
	end,
	informations = "Adventurer, the casual players, or hardcore players. Whatever end of the spectrum " ..
	   "you're in, adventurer will bring you what you want : no advantages, no help. Maybe you don't want " ..
	"that if you just began playing. If that's the case.. just pick another tab and read what's in it. " ..
	   "You'll still be able to come back to this boilerplate class whenever you want to (minus actual " ..
	"cooldown regulation of.. an hour between two changes) if you like being hurt, or hardcore gaming, " ..
	   "which, from afar, look alike.... The pedestal has a backpack over it, because, yay adventures!"
})

