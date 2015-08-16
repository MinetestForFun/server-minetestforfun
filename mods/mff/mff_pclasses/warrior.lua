-------------------
-- Warrior class --
-------------------

--
-- See https://github.com/Ombridride/minetest-minetestforfun-server/issues/113
--

pclasses.api.register_class("warrior", {
	on_assigned = function(pname)
		minetest.sound_play("pclasses_full_warrior")
		minetest.chat_send_player(pname, "You are now a warrior")
		sprint.set_maxstamina(pname, 20)
		minetest.log("action", "[PClasses] Player " .. pname .. " become a warrior")
	end,
	on_unassigned = function(pname)
		sprint.set_default_maxstamina(pname)
	end,
	switch_color = {r = 00, g = 00, b = 114}
})

pclasses.api.reserve_item("warrior", "moreores:sword_mithril")
pclasses.api.reserve_item("warrior", "default:dungeon_master_s_blood_sword")
