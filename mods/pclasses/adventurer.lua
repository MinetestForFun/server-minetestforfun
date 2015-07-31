-----------------------------
-- Boilerplate class
--

pclasses.api.register_class("adventurer", {
	orb_color = { r = 255, g = 200, b = 200 },
	on_assigned = function(pname)
		minetest.chat_send_player(pname, "You are now an adventurer")
	end
})

