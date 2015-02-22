--[[

Stained Glass 1.2

This mod provides luminescent stained glass blocks for Minetest 0.4.x.

Depends:
[moreblocks] by Calinou
[unifieddyes] by VanessaE

==============================================================================
Sat 04 May 2013 01:52:35 PM EDT

Copyright (C) 2013, Eli Innis
Email: doyousketch2 @ yahoo.com

Unified Dyes was released under GNU-GPL 2.0, see LICENSE for info.
More Blocks was released under zlib/libpng for code and CC BY-SA 3.0 Unported for textures, see LICENSE.txt for info.

==============================================================================


Recipe for standard colors:

dye
super glow glass
super glow glass
super glow glass


Recipe for pastel colors:

light dye
white paint
super glow glass
super glow glass
super glow glass


Recipe for faint colors:

light dye
white paint
white paint
super glow glass
super glow glass
super glow glass


All recipes produce three glowing stained glass blocks.
Pastel blocks give back an empty bucket.
Faint blocks give back two empty buckets.

==============================================================================
]]--


-- HUES includes all colors for the various shades
--  I'm trying to get it to sort by color in the game, tho it sorts alpha-numerically...
--   so with 12 colors, it's sorting 10, 11, 12, 1, 2, 3, 4...

HUES = {
	"yellow",
	"lime",
	"green",
	"aqua",
	"cyan",
	"skyblue",
	"blue",
	"violet",
	"magenta",
	"redviolet",
	"red",
	"orange"
}


-- Brightness levels in the textures are 33% ("dark"), 66% ("medium"),
-- 100% ("full"), 150% ("light"), 200% ("pastel").
-- 1x and 2x are simply placeholders to fill in so numbers start at 3.

BRIGHT = {
	"1x",
	"2x",
	"dark_",
	"medium_",
	"",		--(full)
}


-- Saturation - "s50" in a file/item name means "saturation: 50%".
-- 1x - 5x are simply placeholders so numbers start at 6.


SAT = {
	"1x",
	"2x",
	"3x",
	"4x",
	"5x",
	"_s50",
	""	--(full)
}


--main loop for all 12 hues

for h = 1, 12 do

	hues = HUES[h]


	--nested loop for brightness
	--starts at 3 to hopefully keep colors in order

	for b = 3, 5 do

	bright = BRIGHT[b]


		--sub loop for saturation
		--starts at 6 to keep colors in order
		for s = 6, 7 do

			sat = SAT[s]


				--register recipes

				minetest.register_craft({
				type = "shapeless",
				output = "stained_glass:" .. (h) .. "_" .. (b) .. "_" .. (s) .." 3",
				recipe = {
					"unifieddyes:" .. bright .. hues .. sat,
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					},
				})

				--register item attributes

				minetest.register_node("stained_glass:" .. (h) .. "_" .. (b) .. "_" .. (s), {
				description = "Stained Glass - " .. bright .. hues .. sat,
				drawtype = "glasslike_framed_optional",
				tiles = {"stained_glass_" .. bright .. hues .. sat .. ".png", "stained_glass_" .. bright .. hues .. sat .. "_detail.png"},
				paramtype = "light",
				sunlight_propagates = true,
				use_texture_alpha = true,
				light_source = 14,
				is_ground_content = true,
				groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
				sounds = default.node_sound_glass_defaults()
				})
		end  --sat

	end  --bright

end  --hues


--secondary loop for light blocks 
--(as they don't have 50% saturation blocks to go along with 'em)


for h = 1, 12 do


	hues = HUES[h]

				--register recipes (set at 8 to keep colors in order)

				minetest.register_craft({
				type = "shapeless",
				output = "stained_glass:" .. (h) .. "_8 3",
				recipe = {
					"unifieddyes:light_" .. hues,
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					},
				})

				--register item attributes

				minetest.register_node("stained_glass:" .. (h) .. "_8_", {
				description = "Stained Glass - light_" .. hues,
				drawtype = "glasslike_framed_optional",
				tiles = {"stained_glass_light_" .. hues .. ".png", "stained_glass_light_" .. hues .. "_detail.png"},
				paramtype = "light",
				sunlight_propagates = true,
				use_texture_alpha = true,
				light_source = 14,
				is_ground_content = true,
				groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
				sounds = default.node_sound_glass_defaults()
				})


end  --hues


--third loop for pastel blocks 
--(as they don't have 50% saturation blocks to go along with 'em)
--(plus they have a diff recipe to create.)


for h = 1, 12 do


	hues = HUES[h]

				--register recipes (set at 9 to keep colors in order)

				minetest.register_craft({
				type = "shapeless",
				output = "stained_glass:" .. (h) .. "_9 3",
				recipe = {
					"unifieddyes:white_paint",
					"unifieddyes:light_" .. hues,
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					},
					replacements = { {'unifieddyes:white_paint', 'bucket:bucket_empty'}, },
				})

				--register item attributes

				minetest.register_node("stained_glass:" .. (h) .. "_9", {
				description = "Stained Glass - pastel_" .. hues,
				drawtype = "glasslike_framed_optional",
				tiles = {"stained_glass_pastel_" .. hues .. ".png", "stained_glass_pastel_" .. hues .. "_detail.png"},
				paramtype = "light",
				sunlight_propagates = true,
				use_texture_alpha = true,
				light_source = 14,
				is_ground_content = true,
				groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
				sounds = default.node_sound_glass_defaults()
				})


end  --hues


--last loop for faint blocks 
--(as they don't have 50% saturation blocks to go along with 'em)
--(plus they have a diff recipe to create.)


for h = 1, 12 do


	hues = HUES[h]

				--register recipes (set at 91 to keep colors in order)

				minetest.register_craft({
				type = "shapeless",
				output = "stained_glass:" .. (h) .. "_91 3",
				recipe = {
					"unifieddyes:white_paint",
					"unifieddyes:white_paint",
					"unifieddyes:light_" .. hues,
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					"moreblocks:superglowglass",
					},
					replacements = { {'unifieddyes:white_paint', 'bucket:bucket_empty 2'}, },
				})

				--register item attributes

				minetest.register_node("stained_glass:" .. (h) .. "_91", {
				description = "Stained Glass - faint_" .. hues,
				drawtype = "glasslike_framed_optional",
				tiles = {"stained_glass_faint_" .. hues .. ".png", "stained_glass_faint_" .. hues .. "_detail.png"},
				paramtype = "light",
				sunlight_propagates = true,
				use_texture_alpha = true,
				light_source = 14,
				is_ground_content = true,
				groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3},
				sounds = default.node_sound_glass_defaults()
				})


end  --hues


print("[stained_glass] Loaded!")



