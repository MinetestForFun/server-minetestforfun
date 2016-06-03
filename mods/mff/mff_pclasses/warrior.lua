-------------------
-- Warrior class --
-------------------

--
-- See https://github.com/Ombridride/minetest-minetestforfun-server/issues/113
--

pclasses.api.register_class("warrior", {
	on_assigned = function(pname, inform)
		if inform then
			minetest.sound_play("pclasses_full_warrior", {to_player=pname, gain=1})
			minetest.chat_send_player(pname, "You are now a warrior")
		end
		sprint.set_maxstamina(pname, 20)
		minetest.log("action", "[PClasses] Player " .. pname .. " becomes a warrior")
	end,
	on_unassigned = function(pname)
		sprint.set_default_maxstamina(pname)
	end,
	switch_params = {
		color = {r = 06, g = 06, b = 30},
		tile = "default_steel_block.png",
		holo_item = "default:dungeon_master_s_blood_sword"
	}
})

pclasses.api.reserve_item("warrior", "default:sword_mithril")
pclasses.api.reserve_item("warrior", "default:dungeon_master_s_blood_sword")

for _, i in pairs({"helmet", "chestplate", "boots", "leggings"}) do
	pclasses.api.reserve_item("warrior", "3d_armor:" .. i .. "_blackmithril")
	pclasses.api.reserve_item("warrior", "3d_armor:" .. i .. "_mithril")
end

pclasses.api.reserve_item("warrior", "shields:shield_mithril")
pclasses.api.reserve_item("warrior", "shields:shield_blackmithril")
