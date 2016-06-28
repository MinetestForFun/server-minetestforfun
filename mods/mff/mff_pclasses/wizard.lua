------------------
-- Wizard class --
------------------

--
-- No Issue Yet
--

pclasses.api.register_class("wizard", {
	on_assigned = function(pname, inform)
		if inform then
	--		minetest.sound_play("pclasses_full_wizard", {to_player=pname, gain=1})
			minetest.chat_send_player(pname, "You are now a wizard.")
		end
		-- Add specs here
		minetest.log("action", "[PClasses] Player " .. pname .. " becomes a wizard")
	end,
	on_unassigned = function(pname)
	end,
	switch_params = {
		color = {r = 230, g = 230, b = 0},
		holo_item = "default:book"
	}
})

-- Reserved items here 
pclasses.api.reserve_item("wizard", "runes:info_wand")
pclasses.api.reserve_item("wizard", "runes:recharge_wand")
pclasses.api.reserve_item("wizard", "runes:stylus")

for scroll, _ in pairs(runes.scrolls) do
   pclasses.api.reserve_item("wizard", "runes:scroll_" .. scroll)
end
