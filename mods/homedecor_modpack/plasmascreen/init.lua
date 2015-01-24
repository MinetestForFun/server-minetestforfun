--Mod adding a plasma screen television by qwrwed


minetest.register_node("plasmascreen:stand", {
	description = "Plasma Screen TV Stand",
	tiles = {"plasmascreen_back.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{0.5000,-0.5000,0.0625,-0.5000,-0.4375,-0.5000}, --NodeBox 1
			{-0.1875,-0.5000,-0.3750,0.1875,0.1250,-0.1250}, --NodeBox 2
			{-0.5000,-0.2500,-0.5000,0.5000,0.5000,-0.3750}, --NodeBox 3
			{-0.3750,-0.1875,-0.3750,0.3750,0.3125,-0.2500}, --NodeBox 4
		}
	},
		selection_box = {
				type = "fixed",
				fixed = {
							{-0.5000, -0.5000, -0.5000, 0.5000, 0.5000, 0.0000},
						}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},
})

minetest.register_node("plasmascreen:screen1", {
	description = "Plasma Screen 1",
	tiles = {
		"plasmascreen_back.png",
		"plasmascreen_screen.png",
		"plasmascreen_screen.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		{ name="plasmascreen_screen1.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=44
			}
		}

	},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
        light_source = 10,
	drawtype = "nodebox",
	node_box = {
				type = "fixed",
				fixed = {
							{-0.5000, -0.5000, 0.4375, 0.5000, 0.5000, 0.5000},
							{-0.5000, 0.5000, 0.3750, 0.5000, 0.3125, 0.4375},
							{-0.5000, -0.5000, 0.5000, -0.3125, 0.5000, 0.3750},
						}
	},
		selection_box = {
				type = "fixed",
				fixed = {-0.2500, -0.2500, 0.4500, 0.2500, 0.2500, 0.4500}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
})
minetest.register_node("plasmascreen:screen2", {
	description = "Plasma Screen 2",
	tiles = {
		"plasmascreen_back.png",
		"plasmascreen_screen.png",
		"plasmascreen_screen.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		{ name="plasmascreen_screen2.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=44
			}
		}

	},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
        light_source = 10,
	drawtype = "nodebox",
	node_box = {
				type = "fixed",
				fixed = {
							{-0.5000, -0.5000, 0.4375, 0.5000, 0.5000, 0.5000},
							{-0.5000, 0.5000, 0.3750, 0.5000, 0.3125, 0.4375},
						}
	},
		selection_box = {
				type = "fixed",
				fixed = {-0.2500, -0.2500, 0.4500, 0.2500, 0.2500, 0.4500}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
})
minetest.register_node("plasmascreen:screen3", {
	description = "Plasma Screen 3",
	tiles = {
		"plasmascreen_back.png",
		"plasmascreen_screen.png",
		"plasmascreen_screen.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		{ name="plasmascreen_screen3.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=44
			}
		}

	},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
        light_source = 10,
	drawtype = "nodebox",
	node_box = {
				type = "fixed",
				fixed = {
							{-0.5000, -0.5000, 0.4375, 0.5000, 0.5000, 0.5000},
							{-0.5000, 0.5000, 0.3750, 0.5000, 0.3125, 0.4375},
							{0.3125, -0.5000, 0.5000, 0.5000, 0.5000, 0.3750},
						}
	},
		selection_box = {
				type = "fixed",
				fixed = {-0.2500, -0.2500, 0.4500, 0.2500, 0.2500, 0.4500}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
})
minetest.register_node("plasmascreen:screen4", {
	description = "Plasma Screen 4",
	tiles = {
		"plasmascreen_back.png",
		"plasmascreen_screen.png",
		"plasmascreen_screen.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		{ name="plasmascreen_screen4.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=44
			}
		}

	},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
        light_source = 10,
	drawtype = "nodebox",
	node_box = {
				type = "fixed",
				fixed = {
							{-0.5000, -0.3125, 0.4375, 0.5000, 0.5000, 0.5000},
							{-0.5000, -0.3125, 0.3750, 0.5000, -0.1250, 0.4375},
							{-0.5000, -0.3125, 0.5000, -0.3125, 0.5000, 0.3750},
						}
	},
		selection_box = {
				type = "fixed",
				fixed = {-0.2500, -0.2500, 0.4500, 0.2500, 0.2500, 0.4500}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
})

minetest.register_node("plasmascreen:screen5", {
	description = "Plasma TV",
	tiles = {
		"plasmascreen_back.png",
		"plasmascreen_screen.png",
		"plasmascreen_screen.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		{ name="plasmascreen_screen5.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=44
			}
		}

	},
	inventory_image = "plasmascreen_tv_inv.png",
	wield_image = "plasmascreen_tv_inv.png",
	paramtype = "light",
	paramtype2 = "facedir",
        light_source = 10,
	drawtype = "nodebox",
	node_box = {
				type = "fixed",
				fixed = {
							{-0.5000, -0.3125, 0.4375, 0.5000, 0.5000, 0.5000},
							{-0.5000, -0.3125, 0.3750, 0.5000, -0.1250, 0.4375},
						}
	},
		selection_box = {
				type = "fixed",
				fixed = {-1.5050, -0.3125, 0.3700, 1.5050, 1.5050, 0.5050}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2},

after_place_node = function(pos,placer,itemstack)
	local param2 = minetest.get_node(pos).param2
	local p = {x=pos.x, y=pos.y, z=pos.z}
		if param2 == 0 then
			pos.x = pos.x-1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.x = pos.x+2
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.x = pos.x-1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.x = pos.x-1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
		elseif param2 == 1 then
			pos.z = pos.z+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
        minetest.set_node(pos,{name="plasmascreen:screen4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.z = pos.z-2
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.z = pos.z+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.z = pos.z+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
		elseif param2 == 2 then
			pos.x = pos.x+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
        minetest.set_node(pos,{name="plasmascreen:screen4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.x = pos.x-2
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.x = pos.x+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.x = pos.x+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
		elseif param2 == 3 then
			pos.z = pos.z-1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
        minetest.set_node(pos,{name="plasmascreen:screen4", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.z = pos.z+2
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen6", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.y = pos.y+1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen3", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.z = pos.z-1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen2", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
			pos.z = pos.z-1
		if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to  then
		minetest.set_node(pos,{name="plasmascreen:screen1", param2=minetest.dir_to_facedir(placer:get_look_dir())})
		else
			minetest.remove_node(p)
			return true
		end
		end
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if oldnode.param2 == 0 then
			pos.x = pos.x-1
		minetest.remove_node(pos)
			pos.x = pos.x+2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.x = pos.x-1
		minetest.remove_node(pos)
			pos.x = pos.x-1
		minetest.remove_node(pos)
		elseif oldnode.param2 == 1 then
			pos.z = pos.z+1
        minetest.remove_node(pos)
			pos.z = pos.z-2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.z = pos.z+1
		minetest.remove_node(pos)
			pos.z = pos.z+1
		minetest.remove_node(pos)
		elseif oldnode.param2 == 2 then
			pos.x = pos.x+1
        minetest.remove_node(pos)
			pos.x = pos.x-2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.x = pos.x+1
		minetest.remove_node(pos)
			pos.x = pos.x+1
		minetest.remove_node(pos)
		elseif oldnode.param2 == 3 then
			pos.z = pos.z-1
        minetest.remove_node(pos)
			pos.z = pos.z+2
		minetest.remove_node(pos)
			pos.y = pos.y+1
		minetest.remove_node(pos)
			pos.z = pos.z-1
		minetest.remove_node(pos)
			pos.z = pos.z-1
		minetest.remove_node(pos)
		end
	end
})

minetest.register_node("plasmascreen:screen6", {
	description = "Plasma Screen 6",
	tiles = {
		"plasmascreen_back.png",
		"plasmascreen_screen.png",
		"plasmascreen_screen.png",
		"plasmascreen_back.png",
		"plasmascreen_back.png",
		{ name="plasmascreen_screen6.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=44
			}
		}

	},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
        light_source = 10,
	drawtype = "nodebox",
	node_box = {
				type = "fixed",
				fixed = {
							{-0.5000, -0.3125, 0.4375, 0.5000, 0.5000, 0.5000},
							{-0.5000, -0.3125, 0.3750, 0.5000, -0.1250, 0.4375},
							{0.3125, -0.3125, 0.5000, 0.5000, 0.5000, 0.3750},
						}
	},
		selection_box = {
				type = "fixed",
				fixed = {-0.2500, -0.2500, 0.4500, 0.2500, 0.2500, 0.4500}
	},
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,not_in_creative_inventory=1},
})

minetest.register_craft({
	output = "plasmascreen:screen5",
	recipe = {
		{'default:glass', 'default:coal_lump', 'default:glass'},
		{'default:steel_ingot', 'default:copper_ingot', 'default:steel_ingot'},
		{'default:glass', 'default:glass', 'default:glass'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "plasmascreen:screen5",
	recipe = {'homedecor:television', 'homedecor:television'},
})

minetest.register_craft({
	output = "plasmascreen:stand",
	recipe = {
		{'', '', ''},
		{'', 'default:steel_ingot', ''},
		{'group:stick', 'default:coal_lump', 'group:stick'},
	}
})
