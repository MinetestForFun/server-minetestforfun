-----------------------------------------------------------------------------------------------
-- Fishing - crabman77's version
-- Rewrited from original Fishing - Mossmanikin's version - Trophies 0.0.2
-- License (code & textures): 	WTFPL
-- Contains code from: 		default
-- Supports:				animal_clownfish, animal_fish_blue_white
-----------------------------------------------------------------------------------------------


local trophy = {
--	  mod						 item				 name				icon
    {"fishing",  				"fish_raw",				"Fish",				"fishing_fish_raw.png"},
	{"fishing",  				"pike_raw",				"Northern Pike",	"fishing_pike_raw.png"},
	{"fishing",  				"shark_raw",			"Shark",			"fishing_shark_raw.png"},
	{"fishing",		            "clownfish_raw",		"Clownfish",		"fishing_clownfish_raw.png"},
	{"fishing",	                "bluewhite_raw",	        "Bluewhite",	        "fishing_bluewhite_raw.png"},
}

local function has_trophy_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

for i in pairs(trophy) do
	local 	mod = 			trophy[i][1]
	local 	item = 			trophy[i][2]
	local 	name = 			trophy[i][3]
	local 	icon = 			trophy[i][4]
	minetest.register_node("fishing:trophy_"..item, {
		description = fishing_setting.func.S(name.." Trophy"),
		inventory_image = "fishing_trophy_plank.png^"..icon.."^fishing_trophy_label.png",
		drawtype = "nodebox",
		tiles = {
			"fishing_trophy_plank.png", -- top
			"fishing_trophy_plank.png", -- bottom
			"fishing_trophy_plank.png", -- right
			"fishing_trophy_plank.png", -- left
			"fishing_trophy_plank.png", -- back
			"fishing_trophy_plank.png^"..icon.."^fishing_trophy_label.png", -- front
		},
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		node_box = {
			type = "fixed",
			fixed = {
			--	{ left	, bottom , front  ,  right ,  top   ,  back  }
				{ -1/2  , -1/2   ,  7/16  , 1/2    ,  1/2   ,  1/2  },
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -1/2  , -1/2   ,  7/16  , 1/2    ,  1/2   ,  1/2  },
		}
		},
		groups = {choppy=2,oddly_breakable_by_hand=3,flammable=2},
		sounds = default.node_sound_wood_defaults(),
		after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner",  placer:get_player_name() or "")
			meta:set_string("infotext",  fishing_setting.func.S("This Huge "..name.." was caught by the Famous Angler %s !"):format((placer:get_player_name() or "")))
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", name)
			meta:set_string("owner", "")
		end,
		can_dig = function(pos,player)
			local meta = minetest.get_meta(pos);
			return has_trophy_privilege(meta, player)
		end,
	})

--[[
	minetest.register_craft({
		type = "shapeless",
		output = "fishing:trophy_"..item,
		recipe = {mod..":"..item, "default:sign_wall"},
	})
--]]
end
