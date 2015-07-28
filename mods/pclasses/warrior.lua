-------------------
-- Warrior class --
-------------------

--
-- See https://github.com/Ombridride/minetest-minetestforfun-server/issues/113
--

pclasses.api.register_class("warrior", {
	determination = function(player)
		return pclasses.api.util.does_wear_full_armor(player:get_player_name(), "blackmithril", false)
	end,
	on_assigned = function(pname)
		minetest.sound_play("pclasses_full_warrior")
		minetest.chat_send_player(pname, "You are now a warrior")
		sprint.set_maxstamina(pname, 20)
		minetest.log("action", "[PClasses] Player " .. pname .. " become a warrior")
	end,
	on_unassigned = function(pname)
		sprint.set_default_maxstamina(pname)
	end,
})

pclasses.api.reserve_item("warrior", "moreores:sword_mithril")
pclasses.api.reserve_item("warrior", "default:dungeon_master_s_blood_sword")
