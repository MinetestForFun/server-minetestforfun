-----------------------------------------------------------------------------------------------
-- Fishing - Mossmanikin's version - Fishes 0.0.4
-- License (code & textures): 	WTFPL
-----------------------------------------------------------------------------------------------

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

-----------------------------------------------------------------------------------------------
-- Fish
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:fish_raw", {
	description = S("Fish"),
    groups = {},
    inventory_image = "fishing_fish.png",
	 on_use = minetest.item_eat(2),
})
	-----------------------------------------------------
	-- Roasted Fish
	-----------------------------------------------------
	minetest.register_craftitem("fishing:fish", {
		description = S("Roasted Fish"),
		groups = {},
		inventory_image = "fishing_fish_cooked.png",
		on_use = minetest.item_eat(4),
	})
	-----------------------------------------------------
	-- Sushi
	-----------------------------------------------------
	minetest.register_craftitem("fishing:sushi", {
		description = S("Sushi (Hoso Maki)"),
		groups = {},
		inventory_image = "fishing_sushi.png",
		on_use = minetest.item_eat(6),
	})

-----------------------------------------------------------------------------------------------
-- Whatthef... it's a freakin' Shark!
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:shark", {
	description = S("Shark"),
    groups = {},
    inventory_image = "fishing_shark.png",
	 on_use = minetest.item_eat(2),
})
	-----------------------------------------------------
	-- Roasted Shark
	-----------------------------------------------------
	minetest.register_craftitem("fishing:shark_cooked", {
		description = S("Roasted Shark"),
		groups = {},
		inventory_image = "fishing_shark_cooked.png",
		on_use = minetest.item_eat(6),
	})

-----------------------------------------------------------------------------------------------
-- Pike
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("fishing:pike", {
	description = S("Northern Pike"),
    groups = {},
    inventory_image = "fishing_pike.png",
	 on_use = minetest.item_eat(2),
})
	-----------------------------------------------------
	-- Roasted Pike
	-----------------------------------------------------
	minetest.register_craftitem("fishing:pike_cooked", {
		description = S("Roasted Northern Pike"),
		groups = {},
		inventory_image = "fishing_pike_cooked.png",
		on_use = minetest.item_eat(6),
	})
