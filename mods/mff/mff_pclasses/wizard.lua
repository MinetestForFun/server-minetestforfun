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
		mana.setmax(pname, mana.getmax(pname)+100)
		minetest.log("action", "[PClasses] Player " .. pname .. " becomes a wizard")
	end,
	on_unassigned = function(pname)
		mana.setmax(pname, mana.getmax(pname)-100)
	end,
	switch_params = {
		color = {r = 230, g = 230, b = 0},
		holo_item = "default:book"
	},
	informations = pclasses.api.textify("'Wizards' is a class of players aimed at enhancing magic abilities. Basically, you\n" ..
		"become a wizard. Or a witch. Whichever one you prefer. You can then use magic, which\n" ..
		"is nice. But since this magic was implemented by the people coding for this server\n" ..
		"(well, one of them, mostly), you should expect a few things to not.. work.. If you have\n" ..
		"comments, complaints and threats, contact us, well, me.. Being a wizard means you will\n" ..
		"need energy, or 'mana', to cast spells, or rather, to use our ugly wands. This energy is\n" ..
		"recharged by.. waiting. You use it every time you cast a spell or engrave a rune with a\n" ..
		"wand, to charge it, and not have you throw zillions of spell in a minute. Once your\n" ..
		"your mana charger has dropped down to 0, or too low for that cool shape shift spell\n" ..
		"(not implemented (yet?)), just wait a bit and it will come back on its own. At least it\n" ..
		"should. The maximum mana capacity is significantly higher in Wizards (and Witches) than\n" ..
		"in any other class. Since this class is still a work in progress, the following things are\n" ..
		"not implemented yet. Note : poking at the developers could help us bring you the\n" ..
		"content, it's motivating! Wizards can wear silk robes (not there yet) to add in maximum\n" ..
		"mana levels and mana regeneration if worn entirely. It is interesting to note that those\n" ..
		"robes do not make you hungry faster, contrary to most armors. Finally, the pedestal to\n" ..
		"use in order to become a member of this class has a book floating over it, to symbolize\n" ..
		"wisdom.")
})

-- Reserved items here 
pclasses.api.reserve_item("wizard", "runes:info_wand")
pclasses.api.reserve_item("wizard", "runes:recharge_wand")
pclasses.api.reserve_item("wizard", "runes:stylus")

for scroll, _ in pairs(runes.scrolls) do
   pclasses.api.reserve_item("wizard", "runes:scroll_" .. scroll)
end
