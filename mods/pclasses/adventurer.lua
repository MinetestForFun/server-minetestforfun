-----------------------------
-- Boilerplate class
--

pclasses.api.register_class("adventurer", {
	switch_params = {
		color = { r = 142, g = 64, b = 00},
		tile = "wool_white.png",
	},
	on_assigned = function(pname)
		minetest.chat_send_player(pname, "You are now an adventurer")
	end
})

