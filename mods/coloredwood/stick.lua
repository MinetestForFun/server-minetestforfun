-- Sticks portion of Colored Wood mod by Vanessa Ezekowitz  ~~  2012-07-17
-- based on my unified dyes modding template.
--
-- License: WTFPL

local colored_block_modname = "coloredwood"
local colored_block_description = "Stick"

for shade = 1, 3 do

	local shadename = coloredwood.shades[shade]
	local shadename2 = coloredwood.shades2[shade]

	for hue = 1, 12 do

		local huename = coloredwood.hues[hue]
		local huename2 = coloredwood.hues2[hue]

		local colorname    = colored_block_modname..":stick_"..shadename..huename
		local pngname      = colored_block_modname.."_stick_"..shadename..huename..".png"
		local itemdesc     = shadename2..huename2..colored_block_description
		local woodname     = colored_block_modname..":wood_"..shadename..huename
		local s50colorname = colored_block_modname..":stick_"..shadename..huename.."_s50"
		local s50pngname   = colored_block_modname.."_stick_"..shadename..huename.."_s50.png"
		local s50itemdesc  = shadename2..huename2..colored_block_description.." (50% Saturation)"
		local s50woodname = colored_block_modname..":wood_"..shadename..huename.."_s50"

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

		minetest.register_craftitem(colorname, {
		        description = itemdesc,
		        inventory_image = pngname,
			groups = { coloredsticks=1, stick=1 }
		})

		minetest.register_craftitem(s50colorname, {
		        description = s50itemdesc,
		        inventory_image = s50pngname,
			groups = { coloredsticks=1, stick=1 }
		})

		minetest.register_craft( {
			type = "shapeless",
			output = colorname.." 4",
			recipe = {
				woodname
			}
		})

		minetest.register_craft( {
			type = "shapeless",
			output = s50colorname.." 4",
			recipe = {
				s50woodname
			}
		})

	end
end

-- Generate the "light" shades separately, since they don"t have a low-sat version.

for hue = 1, 12 do
	local huename = coloredwood.hues[hue]
	local huename2 = coloredwood.hues2[hue]
	local colorname    = colored_block_modname..":stick_light_"..huename
	local pngname      = colored_block_modname.."_stick_light_"..huename..".png"
	local itemdesc     = "Light "..huename2..colored_block_description
	local woodname     = colored_block_modname..":wood_light_"..huename

	minetest.register_craftitem(colorname, {
	        description = itemdesc,
	        inventory_image = pngname,
		groups = { coloredsticks=1, stick=1 }
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = colorname,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = colorname.." 4",
		recipe = {
			woodname
		}
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

	local greyshadename = colored_block_modname..":stick_"..greyname
	local pngname       = colored_block_modname.."_stick_"..greyname..".png"
	local itemdesc      = greyname2..colored_block_description
	local greywoodname  = colored_block_modname..":wood_"..greyname

	minetest.register_craftitem(greyshadename, {
	        description = itemdesc,
	        inventory_image = pngname,
		groups = { coloredsticks=1, stick=1 }
	})

	minetest.register_craft({
	        type = "fuel",
	        recipe = greyshadename,
	        burntime = 7,
	})

	minetest.register_craft( {
		type = "shapeless",
		output = greyshadename.." 4",
		recipe = {
			greywoodname
		}
	})

end

-- ====================================================================
-- This recipe causes all colored sticks to be usable to craft ladders.

minetest.register_craft({
        output = "default:ladder 2" ,
        recipe = {
                {"group:coloredsticks", ""                   , "group:coloredsticks" },
                {"group:coloredsticks", "group:coloredsticks", "group:coloredsticks" },
                {"group:coloredsticks", ""                   , "group:coloredsticks" }
        }
})
