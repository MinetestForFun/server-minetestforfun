
-- Amiga 500 lookalike
computer.register("computer:shefriendSOO", {
	description = "SheFriendSOO";
	tiles_off = { front=true; };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0, 17, 32, 32, 12 },   -- Monitor Screen
		{  3,  3, 29, 26, 26,  3 },   -- Monitor Tube
		{  0,  0,  0, 32,  4, 17 },   -- Keyboard
	});
});

-- Some generic laptop
computer.register("computer:vanio", {
	description = "Pony Vanio";
	tiles_off = { front=true; top=true; left=true; right=true; back=true; };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0,  4, 32,  3, 24 },   -- Keyboard
		{  0,  3, 25, 32, 21,  3 },   -- Screen
	});
	node_box_off = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0,  4, 32,  3, 24 },   -- Keyboard
		{  0,  3,  4, 32,  3, 24 },   -- Screen
	});
});

-- Sony PlayStation lookalike
computer.register("computer:slaystation", {
	description = "Pony SlayStation";
	tiles_off = { top=true; };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0, 11, 32,  6, 21 },   -- Console
		{  1,  0,  1,  4,  2,  9 },   -- Controller 1 L Grip
		{ 10,  0,  1,  4,  2,  9 },   -- Controller 1 R Grip
		{  5,  0,  4,  5,  2,  5 },   -- Controller 1 Center
		{ 18,  0,  1,  4,  2,  9 },   -- Controller 2 L Grip
		{ 27,  0,  1,  4,  2,  9 },   -- Controller 2 R Grip
		{ 22,  0,  4,  5,  2,  5 },   -- Controller 2 Center
	});
});

-- Sony PlayStation 2 lookalike
computer.register("computer:slaystation2", {
	description = "Pony SlayStation 2";
	tiles_off = { front=true; };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  2,  2, 11, 28,  3, 19 },   -- Console (Upper part)
		{  2,  0, 11, 26,  2, 19 },   -- Console (Lower part)
		{  1,  0,  1,  4,  2,  9 },   -- Controller 1 L Grip
		{ 10,  0,  1,  4,  2,  9 },   -- Controller 1 R Grip
		{  5,  0,  1,  5,  2,  8 },   -- Controller 1 Center
		{ 18,  0,  1,  4,  2,  9 },   -- Controller 2 L Grip
		{ 27,  0,  1,  4,  2,  9 },   -- Controller 2 R Grip
		{ 22,  0,  1,  5,  2,  8 },   -- Controller 2 Center
	});
});

-- Sinclair ZX Spectrum lookalike
computer.register("computer:specter", {
	description = "SX Specter";
	tiles_off = { };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  3,  0,  0, 26,  4, 17 },   -- Keyboard
		{ 18,  0, 18, 12,  6, 14 },   -- Tape Player
	});
});

-- Nintendo Wii lookalike
computer.register("computer:wee", {
	description = "Nientiendo Wee";
	tiles_off = { front=true; };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{ 11,  0,  3, 10,  6, 26 },   -- Base
		{ 12,  6,  4,  8, 22, 24 },   -- Top
	});
});

-- Apple iPad lookalike
minetest.register_node("computer:piepad", {
	description = "Snapple Piepad",
	drawtype = "signlike",
	tiles = {"computer_piepad_inv.png"},
	inventory_image = "computer_piepad_inv.png",
	wield_image = "computer_piepad_inv.png",
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "wallmounted",
	light_source = 10,
	walkable = false,
	groups = { snappy=3, cracky=3, choppy=3, oddly_breakable_by_hand=3},
	selection_box = {type = "wallmounted"},
	sounds = default.node_sound_wood_defaults()
})

-- Commodore 64 lookalike
computer.register("computer:admiral64", {
	description = "Admiral64";
	tiles_off = { };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0,  0, 32,  4, 18 },   -- Keyboard
	});
});

-- Commodore 128 lookalike
computer.register("computer:admiral128", {
	description = "Admiral128";
	tiles_off = { };
	node_box = computer.pixelnodebox(32, {
		-- X   Y   Z   W   H   L
		{  0,  0,  0, 32,  4, 27 },   -- Keyboard
	});
});

---------------------------------------------------------------------------------
----------------------------added by crazyginger72-------------------------------
---------------------------------------------------------------------------------

-- Generic Flat Screen LCD (16x9) with keyboard
minetest.register_node("computer:monitor_on", {
	description = "Monitor and keyboard",
	tiles = {"computer_monitor_t.png","computer_monitor_bt.png",
		 "computer_monitor_l.png","computer_monitor_r.png",
		 "computer_monitor_b.png","computer_monitor_f_desktop.png"}, --"computer_monitor_f_on.png"}, --till i get a boot abm inplace
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, 0.1875, 0.5, 0.375, 0.223116},
			{-0.25, -0.5, 0.125, 0.25, -0.466981, 0.5},
			{-0.125, -0.5, 0.3125, 0.125, 0.0283019, 0.346698},
			{-0.375, -0.3125, 0.208965, 0.375, 0.240566, 0.3125},
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, -0.125},
			{-0.1875, -0.5, 0.25, 0.1875, -0.410377, 0.375},
			},
		},
	drop = 'computer:monitor',
	on_rightclick = function ( pos, node, clicker, itemstack)
		node.name = "computer:monitor";
		minetest.set_node(pos, node);
	end
})

minetest.register_node("computer:monitor_bios", {
	description = "Monitor and keyboard",
	tiles = {"computer_monitor_t.png","computer_monitor_bt.png","computer_monitor_l.png",
		"computer_monitor_r.png","computer_monitor_b.png","computer_monitor_f_bios.png"},
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, 0.1875, 0.5, 0.375, 0.223116},
			{-0.25, -0.5, 0.125, 0.25, -0.466981, 0.5},
			{-0.125, -0.5, 0.3125, 0.125, 0.0283019, 0.346698},
			{-0.375, -0.3125, 0.208965, 0.375, 0.240566, 0.3125},
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, -0.125},
			{-0.1875, -0.5, 0.25, 0.1875, -0.410377, 0.375},
			},
		},
	drop = 'computer:monitor',
})

minetest.register_node("computer:monitor_loading", {
	description = "Monitor and keyboard",
	tiles = {"computer_monitor_t.png","computer_monitor_bt.png","computer_monitor_l.png",
			"computer_monitor_r.png","computer_monitor_b.png","computer_monitor_f_loading.png"},
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, 0.1875, 0.5, 0.375, 0.223116},
			{-0.25, -0.5, 0.125, 0.25, -0.466981, 0.5},
			{-0.125, -0.5, 0.3125, 0.125, 0.0283019, 0.346698},
			{-0.375, -0.3125, 0.208965, 0.375, 0.240566, 0.3125},
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, -0.125},
			{-0.1875, -0.5, 0.25, 0.1875, -0.410377, 0.375},
			},
		},
	drop = 'computer:monitor',
})

minetest.register_node("computer:monitor_login", {
	description = "Monitor and keyboard",
	tiles = {"computer_monitor_t.png","computer_monitor_bt.png","computer_monitor_l.png",
			"computer_monitor_r.png","computer_monitor_b.png","computer_monitor_f_login.png"},
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, 0.1875, 0.5, 0.375, 0.223116},
			{-0.25, -0.5, 0.125, 0.25, -0.466981, 0.5},
			{-0.125, -0.5, 0.3125, 0.125, 0.0283019, 0.346698},
			{-0.375, -0.3125, 0.208965, 0.375, 0.240566, 0.3125},
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, -0.125},
			{-0.1875, -0.5, 0.25, 0.1875, -0.410377, 0.375},
			},
		},
	drop = 'computer:monitor',
})

minetest.register_node("computer:monitor_desktop", {
	description = "Monitor and keyboard",
	tiles = {"computer_monitor_t.png","computer_monitor_bt.png","computer_monitor_l.png",
			"computer_monitor_r.png","computer_monitor_b.png","computer_monitor_f_desktop.png"},
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3,not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, 0.1875, 0.5, 0.375, 0.223116},
			{-0.25, -0.5, 0.125, 0.25, -0.466981, 0.5},
			{-0.125, -0.5, 0.3125, 0.125, 0.0283019, 0.346698},
			{-0.375, -0.3125, 0.208965, 0.375, 0.240566, 0.3125},
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, -0.125},
			{-0.1875, -0.5, 0.25, 0.1875, -0.410377, 0.375},
			},
		},
	drop = 'computer:monitor',
})

minetest.register_node("computer:monitor", {
	description = "Monitor and keyboard",
	tiles = {"computer_monitor_t_off.png","computer_monitor_bt.png","computer_monitor_l.png",
		 "computer_monitor_r.png","computer_monitor_b.png","computer_monitor_f_off.png"},
	paramtype = "light",
	light_source = 4,
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.3125, 0.1875, 0.5, 0.375, 0.223116},
			{-0.25, -0.5, 0.125, 0.25, -0.466981, 0.5},
			{-0.125, -0.5, 0.3125, 0.125, 0.0283019, 0.346698},
			{-0.375, -0.3125, 0.208965, 0.375, 0.240566, 0.3125},
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, -0.125},
			{-0.1875, -0.5, 0.25, 0.1875, -0.410377, 0.375},
			},
		},
	on_rightclick = function ( pos, node, clicker, itemstack)
		node.name = "computer:monitor_on";
		minetest.set_node(pos, node);
	end
})

--WIFI Router (linksys look-a-like)
minetest.register_node("computer:router", {
	description = "WIFI Router",
	tiles = {"computer_router_t.png","computer_router_bt.png","computer_router_l.png","computer_router_r.png","computer_router_b.png",
			{name="computer_router_f_animated.png", animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.0}},}, --"computer_router_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	is_ground_content = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.0625, 0.25, -0.375, 0.3125},
			{-0.1875, -0.4375, 0.3125, -0.125, -0.1875, 0.375},
			{0.125, -0.4375, 0.3125, 0.1875, -0.1875, 0.375},
			{-0.0625, -0.4375, 0.3125, 0.0625, -0.25, 0.375},
			},
		},
})

--Modern PC Tower
minetest.register_node("computer:tower_on", {
	description = "Computer Tower",
	tiles = {"computer_tower_t.png","computer_tower_bt.png","computer_tower_l.png",
			"computer_tower_r.png","computer_tower_b.png","computer_tower_f_on.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	is_ground_content = true,
	groups = {snappy=3,not_in_creative_inventory=1},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.3125, 0.1875, 0.3125, 0.4375},
			{-0.1875, -0.5, -0.353774, 0.1875, 0, -0.0625},
			{-0.1875, 0.247641, -0.353774, 0.1875, 0.3125, 0.1875},
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.3125, 0.1875, 0.3125, 0.4375},
			},
		},
	drop = 'computer:tower',
	on_rightclick = function ( pos, node, clicker, itemstack)
		node.name = "computer:tower";
		minetest.set_node(pos, node);
	end
})

minetest.register_node("computer:tower", {
	description = "Computer Tower",
	tiles = {"computer_tower_t.png","computer_tower_bt.png","computer_tower_l.png","computer_tower_r.png",
			"computer_tower_b.png","computer_tower_f_off.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	is_ground_content = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.3125, 0.1875, 0.3125, 0.4375},
			{-0.1875, -0.5, -0.353774, 0.1875, 0, -0.0625},
			{-0.1875, 0.247641, -0.353774, 0.1875, 0.3125, 0.1875},
			},
		},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.3125, 0.1875, 0.3125, 0.4375},
			},
		},
	on_rightclick = function ( pos, node, clicker, itemstack)
		node.name = "computer:tower_on";
		minetest.set_node(pos, node);
	end
})

-- Printer/scaner combo
minetest.register_node("computer:printer", {
	description = "Printer Scaner Combo",
	tiles = {"computer_printer_t.png","computer_printer_bt.png","computer_printer_l.png",
			"computer_printer_r.png","computer_printer_b.png","computer_printer_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	is_ground_content = true,
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
			{-0.25, -0.481132, -0.3125, 0.25, -0.4375, 0},
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
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = {snappy=3},
		selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375},
		},
		node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375},
		},
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function ( pos, node, clicker, itemstack)
		node.name = "computer:server_on";
		minetest.set_node(pos, node);
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
	sunlight_propagates = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = {snappy=3,not_in_creative_inventory=1},
		selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375},
		},
		node_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.25, 0.5, 1.125, 0.4375},
		},
	sounds = default.node_sound_wood_defaults(),
	drop = 'computer:server',
	on_rightclick = function ( pos, node, clicker, itemstack)
		node.name = "computer:server";
		minetest.set_node(pos, node);
	end
})
