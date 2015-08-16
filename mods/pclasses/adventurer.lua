-----------------------------
-- Boilerplate class
--

pclasses.api.register_class("adventurer", {
	switch_color = { r = 142, g = 00, b = 00},
	on_assigned = function(pname)
		minetest.chat_send_player(pname, "You are now an adventurer")
	end
})

