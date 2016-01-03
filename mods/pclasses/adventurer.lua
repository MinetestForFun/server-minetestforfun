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
	end
})

