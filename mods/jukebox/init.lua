jukebox = {}
jukebox.tracks = {}

minetest.register_node("jukebox:box", {
	description = "Jukebox",
	drawtype = "nodebox",
	tiles = {"jukebox_top.png", "default_wood.png", "jukebox_side.png",
		"jukebox_side.png", "jukebox_front.png", "jukebox_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	stack_max = 1,
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				
	},
	on_rightclick = function(pos, node, clicker, itemstack)
		local meta = minetest.get_meta(pos)
		local inv  = meta:get_inventory()
		if not clicker then return end
		if minetest.get_item_group(
			clicker:get_wielded_item():get_name(), "disc") == 1
		and inv:is_empty("main") then
			local discname = clicker:get_wielded_item():get_name()
			local tracknum = tonumber(discname:split("_")[2])
			local track = jukebox.tracks[tracknum]

			if not track then
				minetest.chat_send_player(clicker:get_player_name(), "ERROR: Cannot find track number " .. (tracknum or "<nil>") .. "...")
				return
			end

			inv:add_item("main", itemstack:take_item())
			meta:set_string("now_playing", minetest.sound_play(track, {
				gain = soundset.get_gain(clicker:get_player_name(),
					"music"),
				max_hear_distance = 25,
			}))
		else
			if not inv:is_empty("main") then
				local drop_pos = minetest.find_node_near(pos, 1, "air")
				if drop_pos == nil then drop_pos = {x=pos.x, y=pos.y+1,z=pos.z} end
				minetest.add_item(drop_pos, inv:get_stack("main",1))
				inv:remove_item("main",  inv:get_stack("main",1))
				if meta:get_string("now_playing") then minetest.sound_stop(meta:get_string("now_playing")) end
			end
		end
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
	end,	
	on_destruct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		if not inv:is_empty("main") then
			local drop_pos = minetest.find_node_near(pos, 1, "air")
			if drop_pos == nil then drop_pos = {x=pos.x, y=pos.y+1,z=pos.z} end
			minetest.add_item(drop_pos, inv:get_stack("main",1))
			if meta:get_string("now_playing") then minetest.sound_stop(meta:get_string("now_playing")) end
		end
	end,
})

minetest.register_craft({
	output = "jukebox:box",
	recipe = {
		{"group:wood", "group:wood", "group:wood", },
		{"group:wood", "default:diamond", "group:wood", },
		{"group:wood", "group:wood", "group:wood", }
	}
})


local function register_disc(trackname, trackdesc, craftitem)
	-- Vital information
	if not trackname then
		minetest.log("error", "[jukebox] Failed registering disc")
	end
	-- Default values for the other ones
	trackdesc = trackdesc or "???"
	craftitem = craftitem or "group:wood"

	local id = #jukebox.tracks

	minetest.register_craftitem("jukebox:disc_" .. id, {
		description = "Music Disc : " .. trackdesc,
		inventory_image = "jukebox_disc_" .. id .. ".png",
		liquids_pointable = false,
		stack_max = 1,
		groups = {disc = 1},
	})

	jukebox.tracks[id] = trackname

	minetest.register_craft({
		output = "jukebox:disc_" .. id,
		recipe = {
			{"", "default:coal_lump", ""},
			{"default:coal_lump", craftitem,"default:coal_lump"},
			{"","default:coal_lump",""}
		}
	})

	minetest.log("action", "[jukebox] Registrered disc " .. trackdesc ..
		", id = " .. id .. " for file " .. trackname)
end

register_disc("jukebox_event.ogg", "Event song", "default:stone")
