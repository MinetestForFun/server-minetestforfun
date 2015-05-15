-- Amiga 500 lookalike
computer.register("computer:shefriendSOO", {
	description = "SheFriendSOO",
	tiles_off = { front=true },
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0, 17, 32, 32, 12 },   -- Monitor Screen
		{  3,  3, 29, 26, 26,  3 },   -- Monitor Tube
		{  0,  0,  0, 32,  4, 17 }   -- Keyboard
	})
})

-- Some generic laptop
minetest.register_node("computer:vanio", {
	drawtype = "mesh",
	mesh = "computer_laptop.obj",
	description = "Pony Vanio",
	inventory_image = "computer_laptop_inv.png",
	tiles = {"computer_laptop.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 4,
	groups = {snappy=3},
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.5, -0.35, 0.35, 0.05, 0.35},
	},
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computer:vanio_off"
		minetest.set_node(pos, node)
	end
})

minetest.register_node("computer:vanio_off", {
	drawtype = "mesh",
	mesh = "computer_laptop_closed.obj",
	tiles = {"computer_laptop.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3, not_in_creative_inventory=1},
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.5, -0.35, 0.35, -0.4, 0.25},
	},
	drop = "computer:vanio",
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computer:vanio"
		minetest.set_node(pos, node)
	end
})

-- Sony PlayStation lookalike
computer.register("computer:slaystation", {
	description = "Pony SlayStation",
	inventory_image = "computer_ps1_inv.png",
	tiles_off = { top=true },
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0, 11, 32,  6, 21 },   -- Console
		{  1,  0,  1,  4,  2,  9 },   -- Controller 1 L Grip
		{ 10,  0,  1,  4,  2,  9 },   -- Controller 1 R Grip
		{  5,  0,  4,  5,  2,  5 },   -- Controller 1 Center
		{ 18,  0,  1,  4,  2,  9 },   -- Controller 2 L Grip
		{ 27,  0,  1,  4,  2,  9 },   -- Controller 2 R Grip
		{ 22,  0,  4,  5,  2,  5 }   -- Controller 2 Center
	})
})

-- Sony PlayStation 2 lookalike
computer.register("computer:slaystation2", {
	description = "Pony SlayStation 2",
	inventory_image = "computer_ps2_inv.png",
	tiles_off = { front=true },
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  2,  2, 11, 28,  3, 19 },   -- Console (Upper part)
		{  2,  0, 11, 26,  2, 19 },   -- Console (Lower part)
		{  1,  0,  1,  4,  2,  9 },   -- Controller 1 L Grip
		{ 10,  0,  1,  4,  2,  9 },   -- Controller 1 R Grip
		{  5,  0,  1,  5,  2,  8 },   -- Controller 1 Center
		{ 18,  0,  1,  4,  2,  9 },   -- Controller 2 L Grip
		{ 27,  0,  1,  4,  2,  9 },   -- Controller 2 R Grip
		{ 22,  0,  1,  5,  2,  8 }   -- Controller 2 Center
	})
})

-- Sinclair ZX Spectrum lookalike
computer.register("computer:specter", {
	description = "SX Specter",
	inventory_image = "computer_specter_inv.png",
	tiles_off = { },
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  3,  0,  0, 26,  4, 17 },   -- Keyboard
		{ 18,  0, 18, 12,  6, 14 }   -- Tape Player
	})
})

-- Nintendo Wii lookalike
computer.register("computer:wee", {
	description = "Nientiendo Wee",
	inventory_image = "computer_wii_inv.png",
	tiles_off = { front=true },
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{ 11,  0,  3, 10,  6, 26 },   -- Base
		{ 12,  6,  4,  8, 22, 24 }   -- Top
	})
})

-- Apple iPad lookalike
minetest.register_node("computer:piepad", {
	description = "Snapple Piepad",
	drawtype = "signlike",
	tiles = {"computer_piepad_inv.png"},
	inventory_image = "computer_piepad_inv.png",
	wield_image = "computer_piepad_inv.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 8,
	walkable = false,
	groups = {oddly_breakable_by_hand=2},
	selection_box = {type = "wallmounted"},
	sounds = default.node_sound_wood_defaults()
})

-- Commodore 64 lookalike
computer.register("computer:admiral64", {
	description = "Admiral64",
	inventory_image = "computer_ad64_inv.png",
	tiles_off = { },
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0,  0, 32,  4, 18 }   -- Keyboard
	})
})

-- Commodore 128 lookalike
computer.register("computer:admiral128", {
	description = "Admiral128",
	inventory_image = "computer_ad128_inv.png",
	tiles_off = { },
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0,  0, 32,  4, 27 }   -- Keyboard
	})
})

-- Generic Flat Screen LCD (16x9) with keyboard
local mo_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.43, 0.5, 0.2, 0.25 }
}

minetest.register_node("computer:monitor", {
	description = "Monitor and keyboard",
	inventory_image = "computer_monitor_inv.png",
	drawtype = "mesh",
	mesh = "computer_monitor.obj",
	tiles = {"computer_black.png", "monitor_plastic.png", "computer_black.png", "monitor_plastic.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	groups = {snappy=3},
	selection_box = mo_sbox,
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computer:monitor_on"
		minetest.set_node(pos, node)
	end
})

minetest.register_node("computer:monitor_on", {
	description = "Monitor and keyboard",
	drawtype = "mesh",
	mesh = "computer_monitor.obj",
	tiles = {"monitor_display.png^[transformFX", "monitor_plastic.png", "computer_black.png", "monitor_plastic.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 9,
	walkable = false,
	groups = {snappy=3, not_in_creative_inventory=1},
	selection_box = mo_sbox,
	drop = "computer:monitor",
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computer:monitor"
		minetest.set_node(pos, node)
	end
})

minetest.register_alias("computer:monitor_bios", "computer:monitor")
minetest.register_alias("computer:monitor_loading", "computer:monitor")
minetest.register_alias("computer:monitor_login", "computer:monitor")
minetest.register_alias("computer:monitor_desktop", "computer:monitor")

--WIFI Router (linksys look-a-like)
minetest.register_node("computer:router", {
	description = "WIFI Router",
	inventory_image = "computer_router_inv.png",
	tiles = {"computer_router_t.png","computer_router_bt.png","computer_router_l.png","computer_router_r.png","computer_router_b.png",
			{name="computer_router_f_animated.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.0}},}, --"computer_router_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.0625, 0.25, -0.375, 0.3125},
			{-0.1875, -0.4375, 0.3125, -0.125, -0.1875, 0.375},
			{0.125, -0.4375, 0.3125, 0.1875, -0.1875, 0.375},
			{-0.0625, -0.4375, 0.3125, 0.0625, -0.25, 0.375}
		}
	}
})

local pct_cbox = {
	type = "fixed",
	fixed = { -0.1875, -0.5, -0.36, 0.1875, 0.34, 0.46 }
}

--Modern PC Tower
minetest.register_node("computer:tower", {
	description = "Computer Tower",
	inventory_image = "computer_tower_inv.png",
	drawtype = "mesh",
	mesh = "computer_tower.obj",
	tiles = {"computer_tower.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	selection_box = pct_cbox,
	collision_box = pct_cbox
})

minetest.register_alias("computer:tower_on", "computer:tower")

-- Printer/scaner combo
minetest.register_node("computer:printer", {
	description = "Printer Scaner Combo",
	inventory_image = "computer_printer_inv.png",
	tiles = {"computer_printer_t.png","computer_printer_bt.png","computer_printer_l.png",
			"computer_printer_r.png","computer_printer_b.png","computer_printer_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.3125, -0.125, 0.4375, -0.0625, 0.375},
			{-0.4375, -0.5, -0.125, 0.4375, -0.4375, 0.375},
			{-0.4375, -0.5, -0.125, -0.25, -0.0625, 0.375},
			{0.25, -0.5, -0.125, 0.4375, -0.0625, 0.375},
			{-0.4375, -0.5, -0.0625, 0.4375, -0.0625, 0.375},
			{-0.375, -0.4375, 0.25, 0.375, -0.0625, 0.4375},
			{-0.25, -0.25, 0.4375, 0.25, 0.0625, 0.5},
			{-0.25, -0.481132, -0.3125, 0.25, -0.4375, 0}
		},
	},
})

--Rack Server
minetest.register_node("computer:server", {
	drawtype = "nodebox",
	description = "Rack Server",
	tiles = {
		'computer_server_t.png',
		'computer_server_bt.png',
		'computer_server_l.png',
		'computer_server_r.png',
		'computer_server_bt.png',
		'computer_server_f_off.png'
	},
	inventory_image = "computer_server_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375}
	},
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375}
	},
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computer:server_on"
		minetest.set_node(pos, node)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name ~= "air" then
			minetest.chat_send_player( placer:get_player_name(), "Not enough vertical space to place a server!" )
			return
		end
		return minetest.item_place(itemstack, placer, pointed_thing)
	end
})

minetest.register_node("computer:server_on", {
	drawtype = "nodebox",
	description = "Rack Server",
	tiles = {
		'computer_server_t.png',
		'computer_server_bt.png',
		'computer_server_r.png',
		'computer_server_l.png',
		'computer_server_bt.png',
		'computer_server_f_on.png',
	},
	inventory_image = "computer_server_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3,not_in_creative_inventory=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375}
	},
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375}
	},
	sounds = default.node_sound_wood_defaults(),
	drop = 'computer:server',
	on_rightclick = function(pos, node, clicker, itemstack)
		node.name = "computer:server"
		minetest.set_node(pos, node)
	end
})
