--[[

Unified Dyes

This mod provides an extension to the Minetest 0.4.x dye system

==============================================================================

Copyright (C) 2012-2013, Vanessa Ezekowitz
Email: vanessaezekowitz@gmail.com

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

==============================================================================

--]]

--=====================================================================

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end

-- Items/recipes needed to generate the few base colors that are not
-- provided by the standard dyes mod.

-- Lime

minetest.register_craftitem(":dye:lime", {
        description = S("Lime Dye"),
        inventory_image = "unifieddyes_lime.png",
	groups = { dye=1, excolor_lime=1, unicolor_lime=1 }
})

minetest.register_craft( {
       output = "dye:lime 2",
       recipe = {{"dye:yellow", "dye:green"}}
})

-- Aqua

minetest.register_craftitem(":dye:aqua", {
        description = S("Aqua Dye"),
        inventory_image = "unifieddyes_aqua.png",
	groups = { dye=1, excolor_aqua=1, unicolor_aqua=1 }
})

minetest.register_craft( {
       output = "dye:aqua 2",
       recipe = {{"dye:green", "dye:cyan"}},
})

-- Sky blue

minetest.register_craftitem(":dye:skyblue", {
        description = S("Sky-blue Dye"),
        inventory_image = "unifieddyes_skyblue.png",
	groups = { dye=1, excolor_sky_blue=1, unicolor_sky_blue=1 }
})

minetest.register_craft( {
       output = "dye:skyblue 2",
       recipe = {{"dye:cyan", "dye:blue"}},
})

-- Red-violet

minetest.register_craftitem(":dye:redviolet", {
        description = S("Red-violet Dye"),
        inventory_image = "unifieddyes_redviolet.png",
	groups = { dye=1, excolor_red_violet=1, unicolor_red_violet=1 }
})

minetest.register_craft( {
       output = "dye:redviolet 2",
       recipe = {{"dye:magenta", "dye:red"}},
})


-- Light grey

minetest.register_craftitem(":dye:light_grey", {
        description = S("Light Grey Dye"),
        inventory_image = "unifieddyes_lightgrey.png",
	groups = { dye=1, excolor_lightgrey=1, unicolor_light_grey=1 }
})

minetest.register_craft( {
       output = "dye:light_grey 2",
       recipe = {{"dye:grey", "dye:white"}},
})

--[[ Extra craft for black dye

minetest.register_craft( {
       type = "shapeless",
       output = "dye:black 4",
       recipe = {
               "default:coal_lump",
		},
})]]

-- Extra craft for dark grey dye

minetest.register_craft( {
       type = "shapeless",
       output = "dye:dark_grey 3",
       recipe = {
               "dye:black",
               "dye:black",
               "dye:white",
		},
})

-- Extra craft for light grey dye

minetest.register_craft( {
       type = "shapeless",
       output = "dye:light_grey 3",
       recipe = {
               "dye:black",
               "dye:white",
               "dye:white",
		},
})

-- Extra craft for green dye

minetest.register_craft( {
       type = "shapeless",
       output = "dye:green 4",
       recipe = {
               "default:cactus",
		},
})

-- =================================================================

-- Generate all of additional variants of hue, saturation, and
-- brightness.

-- "s50" in a file/item name means "saturation: 50%".
-- Brightness levels in the textures are 33% ("dark"), 66% ("medium"),
-- 100% ("full", but not so-named), and 150% ("light").

local HUES = {
	"red",
	"orange",
	"yellow",
	"lime",
	"green",
	"aqua",
	"cyan",
	"skyblue",
	"blue",
	"violet",
	"magenta",
	"redviolet"
}

local HUES2 = {
	"Red",
	"Orange",
	"Yellow",
	"Lime",
	"Green",
	"Aqua",
	"Cyan",
	"Sky-blue",
	"Blue",
	"Violet",
	"Magenta",
	"Red-violet"
}


for i = 1, 12 do

	local hue = HUES[i]
	local hue2 = HUES2[i]

	minetest.register_craft( {
        output = "unifieddyes:dark_" .. hue .. "_s50 2",
        recipe = {{"dye:" .. hue, "dye:dark_grey"}},
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:dark_" .. hue .. "_s50 4",
        recipe = {
                "dye:" .. hue,
                "dye:black",
                "dye:black",
		"dye:white"
	        },
	})

	if hue == "green" then

		minetest.register_craft( {
		type = "shapeless",
		output = "dye:dark_green 3",
		recipe = {
		        "dye:" .. hue,
		        "dye:black",
		        "dye:black",
			},
		})
	else
		minetest.register_craft( {
		type = "shapeless",
		output = "unifieddyes:dark_" .. hue .. " 3",
		recipe = {
		        "dye:" .. hue,
		        "dye:black",
		        "dye:black",
			},
		})
	end

	minetest.register_craft( {
        output = "unifieddyes:medium_" .. hue .. "_s50 2",
        recipe = {{"dye:" .. hue, "dye:grey"}},
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:medium_" .. hue .. "_s50 3",
        recipe = {
                "dye:" .. hue,
		"dye:black",
                "dye:white",
	        },
	})

	minetest.register_craft( {
        	output = "unifieddyes:medium_" .. hue .. " 2",
        	recipe = {
        	        {"dye:" .. hue, "dye:black"},
		}
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:" .. hue .. "_s50 2",
        recipe = {
                "dye:" .. hue,
                "dye:grey",
                "dye:white",
	        },
	})

	minetest.register_craft( {
        type = "shapeless",
        output = "unifieddyes:" .. hue .. "_s50 4",
        recipe = {
                "dye:" .. hue,
                "dye:white",
                "dye:white",
                "dye:black",
	        },
	})

	if hue ~= "red" then
		minetest.register_craft( {
		output = "unifieddyes:light_" .. hue .. " 2",
		recipe = {{"dye:" .. hue, "dye:white"}},
		})
	end

	minetest.register_craftitem("unifieddyes:dark_" .. hue .. "_s50", {
		description = S("Dark " .. hue2 .. " Dye (low saturation)"),
		inventory_image = "unifieddyes_dark_" .. hue .. "_s50.png",
		groups = { dye=1, ["unicolor_dark_"..hue.."_s50"]=1 }
	})

	if hue ~= "green" then
		minetest.register_craftitem("unifieddyes:dark_" .. hue, {
			description = S("Dark " .. hue2 .. " Dye"),
			inventory_image = "unifieddyes_dark_" .. hue .. ".png",
			groups = { dye=1, ["unicolor_dark_"..hue]=1 }
		})
	end

	minetest.register_craftitem("unifieddyes:medium_" .. hue .. "_s50", {
		description = S("Medium " .. hue2 .. " Dye (low saturation)"),
		inventory_image = "unifieddyes_medium_" .. hue .. "_s50.png",
		groups = { dye=1, ["unicolor_medium_"..hue.."_s50"]=1 }
	})

	minetest.register_craftitem("unifieddyes:medium_" .. hue, {
		description = S("Medium " .. hue2 .. " Dye"),
		inventory_image = "unifieddyes_medium_" .. hue .. ".png",
		groups = { dye=1, ["unicolor_medium_"..hue]=1 }
	})

	minetest.register_craftitem("unifieddyes:" .. hue .. "_s50", {
		description = S(hue2 .. " Dye (low saturation)"),
		inventory_image = "unifieddyes_" .. hue .. "_s50.png",
		groups = { dye=1, ["unicolor_"..hue.."_s50"]=1 }
	})

	if hue ~= "red" then
		minetest.register_craftitem("unifieddyes:light_" .. hue, {
			description = S("Light " .. hue2 .. " Dye"),
			inventory_image = "unifieddyes_light_" .. hue .. ".png",
			groups = { dye=1, ["unicolor_light_"..hue]=1 }
		})
	end
	minetest.register_alias("unifieddyes:"..hue, "dye:"..hue)
	minetest.register_alias("unifieddyes:pigment_"..hue, "dye:"..hue)
end

minetest.register_alias("unifieddyes:light_red", "dye:pink")
minetest.register_alias("unifieddyes:dark_green", "dye:dark_green")

minetest.register_alias("unifieddyes:white_paint", "dye:white")
minetest.register_alias("unifieddyes:titanium_dioxide", "dye:white")
minetest.register_alias("unifieddyes:lightgrey_paint", "dye:light_grey")
minetest.register_alias("unifieddyes:grey_paint", "dye:grey")
minetest.register_alias("unifieddyes:darkgrey_paint", "dye:dark_grey")
minetest.register_alias("unifieddyes:carbon_black", "dye:black")

minetest.log("action", S("[UnifiedDyes] Loaded!"))

