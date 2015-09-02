if hungry_games.dig_mode == "none" then
	--Redefine hand.
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x=1,y=1,z=2.5},
		tool_capabilities = {
			full_punch_interval = 0.9,
			max_drop_level = 0,
			damage_groups = {fleshy=1},
			groupcaps = { ladder_diggable = {times = {[1]=2.5}, uses = 0} },
		}
	})

	--Protect everything to ensure that no node is ever dug or placed by players who do not have hg_maker
	minetest.is_protected = function(pos, name)
		if minetest.check_player_privs(name, {hg_maker=true}) then
			return false
		else
			return true
		end
	end
end
-- Swords
minetest.register_tool(":default:sword_wood", {
	description = "Wooden Sword",
	inventory_image = "default_tool_woodsword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=0,
		damage_groups = {fleshy=3},
	}
})
minetest.register_tool(":default:sword_stone", {
	description = "Stone Sword",
	inventory_image = "default_tool_stonesword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=0,
		damage_groups = {fleshy=4},
	}
})
minetest.register_tool(":default:sword_steel", {
	description = "Steel Sword",
	inventory_image = "default_tool_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		damage_groups = {fleshy=5},
	}
})
minetest.register_tool(":default:sword_bronze", {
	description = "Bronze Sword",
	inventory_image = "default_tool_bronzesword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		damage_groups = {fleshy=6},
	}
})
minetest.register_tool(":default:sword_mese", {
	description = "Mese Sword",
	inventory_image = "default_tool_mesesword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		damage_groups = {fleshy=7},
	}
})
minetest.register_tool(":default:sword_diamond", {
	description = "Diamond Sword",
	inventory_image = "default_tool_diamondsword.png",
	tool_capabilities = {
		full_punch_interval = 0.7,
		max_drop_level=1,
		damage_groups = {fleshy=8},
	}
})

