function spears_register_spear(kind, desc, eq, toughness, material)

	minetest.register_tool("spears:spear_" .. kind, {
		description = desc .. " spear",
		inventory_image = "spears_spear_" .. kind .. ".png",
		wield_scale= {x=2,y=1,z=1},
		on_drop = function(itemstack, user, pointed_thing)
			spears_shot(itemstack, user)
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
		tool_capabilities = {
			full_punch_interval = 1.5,
			max_drop_level=1,
			groupcaps={
				cracky = {times={[3]=2}, uses=toughness, maxlevel=1},
			},
			damage_groups = {fleshy=eq},
		}
	})


	local SPEAR_ENTITY=spears_set_entity(kind, eq, toughness)

	minetest.register_entity("spears:spear_" .. kind .. "_entity", SPEAR_ENTITY)

	minetest.register_craft({
		output = 'spears:spear_' .. kind,
		recipe = {
			{'group:wood', 'group:wood', material},
		}
	})

	minetest.register_craft({
		output = 'spears:spear_' .. kind,
		recipe = {
			{material, 'group:wood', 'group:wood'},
		}
	})
end

if not DISABLE_STONE_SPEAR then
	spears_register_spear('stone', 'Stone (Hunter)', 3, 25, 'group:stone') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_STEEL_SPEAR then
	spears_register_spear('steel', 'Steel (Hunter)', 4, 30, 'default:steel_ingot') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_DIAMOND_SPEAR then
	spears_register_spear('diamond', 'Diamond (Hunter)', 7, 50, 'default:diamond') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_OBSIDIAN_SPEAR then
	spears_register_spear('obsidian', 'Obsidian (Hunter)', 5, 40, 'default:obsidian') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_MITHRIL_SPEAR then
	spears_register_spear('mithril', 'Mithril (Hunter)', 8, 200, 'default:mithril_ingot') --MFF crabman(28/09/2015) damage and wear
end

