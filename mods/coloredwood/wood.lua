-- Woods portion of Colored Wood mod by Vanessa Ezekowitz  ~~  2012-07-17
-- based on my unified dyes modding template.
--
-- License: WTFPL

coloredwood.enable_stairsplus = true

if minetest.setting_getbool("coloredwood_enable_stairsplus") == false or not minetest.get_modpath("moreblocks") then
	coloredwood.enable_stairsplus = false
end

local colored_block_modname = "coloredwood"
local colored_block_description = "Wood Planks"
local neutral_block = "default:wood"
local colored_block_sunlight = "false"
local colored_block_walkable = "true"
local colored_block_groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2, not_in_creative_inventory=1}
local colored_block_sound = "default.node_sound_wood_defaults()"

for shade = 1, 3 do

	local shadename = coloredwood.shades[shade]
	local shadename2 = coloredwood.shades2[shade]

	for hue = 1, 12 do

		local huename = coloredwood.hues[hue]
		local huename2 = coloredwood.hues2[hue]

		local colorname    = colored_block_modname..":wood_"..shadename..huename
		local pngname      = colored_block_modname.."_wood_"..shadename..huename..".png"
		local nodedesc     = shadename2..huename2..colored_block_description
		local s50colorname = colored_block_modname..":wood_"..shadename..huename.."_s50"
		local s50pngname   = colored_block_modname.."_wood_"..shadename..huename.."_s50.png"
		local s50nodedesc  = shadename2..huename2..colored_block_description.." (50% Saturation)"

		minetest.register_node(colorname, {
			description = nodedesc,
			tiles = { pngname },
			sunlight_propagates = colored_block_sunlight,
			paramtype = "light",
			walkable = colored_block_walkable,
			groups = colored_block_groups,
			sounds = colored_block_sound
		})

		minetest.register_node(s50colorname, {
			description = s50nodedesc,
			tiles = { s50pngname },
			sunlight_propagates = colored_block_sunlight,
			paramtype = "light",
			walkable = colored_block_walkable,
			groups = colored_block_groups,
			sounds = colored_block_sound
		})

		if coloredwood.enable_stairsplus then

--			stairsplus:register_all(modname, subname, recipeitem, {fields})

			stairsplus:register_all(
				"coloredwood",
				"wood_"..shadename..huename,
				colorname,
				{
					groups = colored_block_groups,
					tiles =	{ pngname },
					description = nodedesc,
					drop = "wood_"..shadename..huename,
				}
			)

			stairsplus:register_all(
				"coloredwood",
				"wood_"..shadename..huename.."_s50",
				s50colorname,
				{
					groups = colored_block_groups,
					tiles =	{ s50pngname },
					description = s50nodedesc,
					drop = "wood_"..shadename..huename.."_s50",
				}
			)
		end

		minetest.register_craft({
		        type = "fuel",
		        recipe = colorname,
		        burntime = 7,
		})

		minetest.register_craft({
		        type = "fuel",
		        recipe = s50colorname,
		        burntime = 7,
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." 2",
			recipe = {
				neutral_block,
				neutral_block,
				"unifieddyes:"..shadename..huename
			},
		})

		minetest.register_craft( {
			type = "shapeless",
			output = s50colorname.." 2",
			recipe = {
				neutral_block,
				neutral_block,
				"unifieddyes:"..shadename..huename.."_s50"
			},
		})

	end
end

-- Generate the "light" shades separately, since they don"t have a low-sat version.

for hue = 1, 12 do

	local huename = coloredwood.hues[hue]
	local huename2 = coloredwood.hues2[hue]
	local colorname    = colored_block_modname..":wood_light_"..huename
	local pngname      = colored_block_modname.."_wood_light_"..huename..".png"
	local nodedesc     = "Light "..huename2..colored_block_description

	minetest.register_node(colorname, {
		description = nodedesc,
		tiles = { pngname },
		sunlight_propagates = colored_block_sunlight,
		paramtype = "light",
		walkable = colored_block_walkable,
		groups = colored_block_groups,
		sounds = colored_block_sound
	})

	if coloredwood.enable_stairsplus then
		stairsplus:register_all(
			"coloredwood",
			"wood_light_"..huename,
			colorname,
			{
				groups = colored_block_groups,
				tiles =	{ pngname },
				description = nodedesc,
				drop = "wood_light_"..huename,
			}
		)
	end

	minetest.register_craft({
	        type = "fuel",
	        recipe = colorname,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = colorname.." 2",
		recipe = {
			neutral_block,
			neutral_block,
			"unifieddyes:light_"..huename
		},
	})
end
	

-- ============================================================
-- The 5 levels of greyscale.
--
-- Oficially these are 0, 25, 50, 75, and 100% relative to white,
-- but in practice, they"re actually 7.5%, 25%, 50%, 75%, and 95%.
-- (otherwise black and white would wash out).

for grey = 1,5 do

	local greyname = coloredwood.greys[grey]
	local greyname2 = coloredwood.greys2[grey]
	local greyname3 = coloredwood.greys3[grey]

	local greyshadename = colored_block_modname..":wood_"..greyname
	local pngname = colored_block_modname.."_wood_"..greyname..".png"
	local nodedesc = greyname2..colored_block_description

	minetest.register_node(greyshadename, {
		description = nodedesc,
		tiles = { pngname },
		sunlight_propagates = colored_block_sunlight,
		paramtype = "light",
		walkable = colored_block_walkable,
		groups = colored_block_groups,
		sounds = colored_block_sound
	})

	if coloredwood.enable_stairsplus then
		stairsplus:register_all(
			"coloredwood",
			"wood_"..greyname,
			greyshadename,
			{
				groups = colored_block_groups,
				tiles =	{ pngname },
				description = nodedesc,
				drop = "wood_"..greyname,
			}
		)
	end

	minetest.register_craft({
	        type = "fuel",
	        recipe = greyshadename,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = greyshadename.." 2",
		recipe = {
			neutral_block,
			neutral_block,
			greyname3
		},
	})

end
