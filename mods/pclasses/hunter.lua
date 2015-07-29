------------------
-- Hunter class --
------------------

--
-- See https://github.com/Ombridride/minetest-minetestforfun-server/issues/114
--

pclasses.api.register_class("hunter", {
	determination = function(player)
		return pclasses.api.util.does_wear_full_armor(player:get_player_name(), "reinforcedleather", true)
			or pclasses.api.util.does_wear_full_armor(player:get_player_name(), "hardenedleather", true)
	end,
	on_assigned = function(pname)
		minetest.chat_send_player(pname, "You are now a hunter")
		minetest.sound_play("pclasses_full_hunter")
		local reinforced = pclasses.api.util.does_wear_full_armor(pname, "reinforcedleather", true)
		if reinforced then
			sprint.increase_maxstamina(pname, 20)
		else
			sprint.increase_maxstamina(pname, 10)
		end
		minetest.log("action", "[PClasses] Player " .. pname .. " become a hunter")
	end,
	on_unassigned = function(pname)
		sprint.set_default_maxstamina(pname)
	end,
})


pclasses.api.reserve_item("hunter", "throwing:bow_minotaur_horn")
pclasses.api.reserve_item("hunter", "throwing:bow_minotaur_horn_improved")
pclasses.api.reserve_item("hunter", "throwing:arrow_mithril")
