-----------------
-- Admin class --
-----------------

--
-- https://github.com/MinetestForFun/minetest-minetestforfun-server/issues/139
--

pclasses.api.register_class("admin", {
	determination = function(player)
		return minetest.get_player_privs(player:get_player_name()).server
	end,
	on_assigned = function(pname)
		minetest.chat_send_player(pname, "Hello admin.")
	end
})

pclasses.api.reserve_item("admin", "3d_armor:helmet_admin")
pclasses.api.reserve_item("admin", "3d_armor:chestplate_admin")
pclasses.api.reserve_item("admin", "3d_armor:leggings_admin")
pclasses.api.reserve_item("admin", "3d_armor:boots_admin")
pclasses.api.reserve_item("admin", "shields:shields_admin")
pclasses.api.reserve_item("admin", "maptools:pick_admin")
pclasses.api.reserve_item("admin", "maptools:pick_admin_with_drops")
