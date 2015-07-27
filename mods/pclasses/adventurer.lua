-----------------------------
-- Default class assignment
--

pclasses.api.register_class("adventurer", {
	determination = function() return true end,
	on_assigned = function(pname)
			minetest.chat_send_player(pname, "You are now an adventurer")
	end
})

