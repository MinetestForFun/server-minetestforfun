--[[TODO
  ropebox rope break results in bottom rope dissapearing and bottom drop rope node to appear at the new bottom
  and rope does not drop anything!!!!
]]

vines = {}

local mod_name = "vines"
local average_height = 12
local spawn_interval = 90
local vines_group = {attached_node=1,vines=1,snappy=3,flammable=2,hanging_node=1,vines_cleanup=1}

vines.growth_interval = 300
vines.growth_chance = 2
vines.rot_interval = 300
vines.rot_chance = 8

local jungle_leaves_list = {
	"default:jungleleaves",
	"moretrees:jungle_leaves_red",
	"moretrees:jungle_leaves_yellow",
	"moretrees:jungle_leaves_green"
}

-- Nodes
minetest.register_node("vines:rope_block", {
  description = "Rope",
  sunlight_propagates = true,
  paramtype = "light",
  tile_images = {
    "default_wood.png^vines_rope.png",
    "default_wood.png^vines_rope.png",
    "default_wood.png",
    "default_wood.png",
    "default_wood.png^vines_rope.png",
    "default_wood.png^vines_rope.png",
  },
  drawtype = "cube",
  groups = {choppy=2,oddly_breakable_by_hand=1},
  after_place_node = function(pos)
    local p = {x=pos.x, y=pos.y-1, z=pos.z}
    local n = minetest.get_node(p)
    if n.name == "air" then
      minetest.add_node(p, {name="vines:rope_end"})
    end
  end,
  after_dig_node = function(pos, node, digger)
    local p = {x=pos.x, y=pos.y-1, z=pos.z}
    local n = minetest.get_node(p)
    while n.name == 'vines:rope' do
      minetest.remove_node(p)
      p = {x=p.x, y=p.y-1, z=p.z}
      n = minetest.get_node(p)
    end
    if n.name == 'vines:rope_end' then
      minetest.remove_node(p)
    end
  end
})

minetest.register_node("vines:rope", {
  description = "Rope",
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  paramtype = "light",
  drop = "",
  tile_images = { "vines_rope.png" },
  drawtype = "plantlike",
  groups = {flammable=2, not_in_creative_inventory=1},
  sounds =  default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
  },
  on_destruct = function()
    
  end,
})

minetest.register_node("vines:rope_end", {
  description = "Rope",
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  paramtype = "light",
  drop = "",
  tile_images = { "vines_rope_end.png" },
  drawtype = "plantlike",
  groups = {flammable=2, not_in_creative_inventory=1},
  sounds =  default.node_sound_leaves_defaults(),
  after_place_node = function(pos)
    yesh  = {x = pos.x, y= pos.y-1, z=pos.z}
    minetest.add_node(yesh, {name="vines:rope"})
  end,
  selection_box = {
	  type = "fixed",
	  fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
  },
})

minetest.register_node("vines:side", {
  description = "Vine",
  walkable = false,
  climbable = true,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "wallmounted",
  buildable_to = true,
  tile_images = { "vines_side.png" },
  drawtype = "signlike",
  inventory_image = "vines_side.png",
  groups = vines_group,
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
  after_dig_node = function(pos, oldnode, oldmetadata, user)
    local wielded if user:get_wielded_item() ~= nil then wielded = user:get_wielded_item() else return end
    if 'vines:shears' == wielded:get_name() then 
      local inv = user:get_inventory()
      if inv then
        inv:add_item("main", ItemStack(oldnode.name))
      end
    end
  end
})

minetest.register_node("vines:side_rotten", {
  description = "Vine",
  walkable = false,
  climbable = false,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "wallmounted",
  buildable_to = true,
  tile_images = { "vines_side_rotten.png" },
  drawtype = "signlike",
  inventory_image = "vines_side.png",
  groups = {snappy = 3,flammable=2, hanging_node=1,vines_cleanup=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
})

minetest.register_node("vines:willow", {
  description = "Vine",
  walkable = false,
  climbable = true,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  paramtype2 = "wallmounted",
  buildable_to = true,
  tile_images = { "vines_willow.png" },
  drawtype = "signlike",
  inventory_image = "vines_willow.png",
  groups = vines_group,
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
  after_dig_node = function(pos, oldnode, oldmetadata, user)
    local wielded if user:get_wielded_item() ~= nil then wielded = user:get_wielded_item() else return end
    if 'vines:shears' == wielded:get_name() then 
      local inv = user:get_inventory()
      if inv then
        inv:add_item("main", ItemStack(oldnode.name))
      end
    end
  end
})

minetest.register_node("vines:willow_rotten", {
  description = "Vine",
  walkable = false,
  climbable = false,
  sunlight_propagates = true,
  paramtype = "light",
  drop = "",
  paramtype2 = "wallmounted",
  buildable_to = true,
  tile_images = { "vines_willow_rotten.png" },
  drawtype = "signlike",
  inventory_image = "vines_willow.png",
  groups = {snappy = 3,flammable=2, hanging_node=1,vines_cleanup=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "wallmounted",
  },
})

minetest.register_node("vines:root", {
  description = "Vine",
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  paramtype = "light",
  buildable_to = true,
  tile_images = { "vines_root.png" },
  drawtype = "plantlike",
  inventory_image = "vines_root.png",
  groups = {vines=1,snappy = 3,flammable=2, hanging_node=1,vines_cleanup=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
  },
})

minetest.register_node("vines:vine", {
  description = "Vine",
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  drop = "",
  paramtype = "light",
  buildable_to = true,
  tile_images = { "vines_vine.png" },
  drawtype = "plantlike",
  inventory_image = "vines_vine.png",
  groups = vines_group,
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-0.3, -1/2, -0.3, 0.3, 1/2, 0.3},
  },
  after_dig_node = function(pos, oldnode, oldmetadata, user)
    local wielded if user:get_wielded_item() ~= nil then wielded = user:get_wielded_item() else return end
    if 'vines:shears' == wielded:get_name() then 
      local inv = user:get_inventory()
      if inv then
        inv:add_item("main", ItemStack(oldnode.name))
      end
    end
  end
})

minetest.register_node("vines:vine_rotten", {
  description = "Rotten vine",
  walkable = false,
  climbable = true,
  drop = "",
  sunlight_propagates = true,
  paramtype = "light",
  buildable_to = true,
  tile_images = { "vines_vine_rotten.png" },
  drawtype = "plantlike",
  inventory_image = "vines_vine_rotten.png",
  groups = {snappy = 3,flammable=2, hanging_node=1,vines_cleanup=1},
  sounds = default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-0.3, -1/2, -0.3, 0.3, 1/2, 0.3},
  },
})

-- vine rotting

minetest.register_abm({
  nodenames = {"vines:vine", "vines:side", "vines:willow"},
  interval = vines.rot_interval,
  chance = vines.rot_chance,
  action = function(pos, node, active_object_count, active_object_count_wider)
    if minetest.find_node_near(pos, 5, "group:tree") == nil then
      local walldir = node.param2
      minetest.add_node(pos, {name=node.name.."_rotten", param2 = walldir})
    end
  end
})

-- vine growth

minetest.register_abm({
  nodenames = {"vines:vine", "vines:side", "vines:willow"},
  interval = vines.growth_interval,
  chance = vines.growth_chance,
  action = function(pos, node, active_object_count, active_object_count_wider)
    local p = {x=pos.x, y=pos.y-1, z=pos.z}
    local n = minetest.get_node(p)
    if n.name == "air" then
      local walldir = node.param2
      minetest.add_node(p, {name=node.name, param2 = walldir})
    end
  end
})

-- cleanup if the initial tree is missing entirely (e.g. has been dug away)

minetest.register_abm({
	nodenames = {"group:vines_cleanup"},
	interval = 10,
	chance = 5,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if not minetest.find_node_near(pos, 1, jungle_leaves_list) then
			local p_top = {x=pos.x, y=pos.y+1, z=pos.z}
			if minetest.get_item_group(minetest.get_node(p_top).name, "vines_cleanup") == 0 then
				minetest.remove_node(pos)
			end
		end
	end
})

-- rope extension

minetest.register_abm({
  nodenames = {"vines:rope_end"},
  interval = 1,
  chance = 1,
  drop = "",
  action = function(pos, node, active_object_count, active_object_count_wider)
    local p = {x=pos.x, y=pos.y-1, z=pos.z}
    local n = minetest.get_node(p)
    --remove if top node is removed
    if  n.name == "air" then
      minetest.set_node(pos, {name="vines:rope"})
      minetest.add_node(p, {name="vines:rope_end"})
    end 
  end
})
--Craft
minetest.register_craft({
  output = 'vines:rope_block',
  recipe = {
    {'', 'default:wood', ''},
    {'', 'vines:side', ''},
    {'', 'vines:side', ''},
  }
})

minetest.register_craftitem("vines:vines", {
  description = "Vines",
  inventory_image = "vines_item.png",
})
--spawning
plantslib:spawn_on_surfaces({
  avoid_nodes = {"vines:vine"},
  avoid_radius = 5,
  spawn_delay = spawn_interval,
  spawn_plants = {"vines:vine"},
  spawn_chance = 10,
  spawn_surfaces = {"default:dirt_with_grass","default:dirt"},
  spawn_on_bottom = true,
  plantlife_limit = -0.9,
})

plantslib:spawn_on_surfaces({
  avoid_nodes = {"vines:vine", "vines:side"},
  avoid_radius = 3,
  spawn_delay = spawn_interval,
  spawn_plants = {"vines:side"},
  spawn_chance = 10,
  spawn_surfaces = jungle_leaves_list,
  spawn_on_side = true,
  near_nodes = {"default:jungletree"},
  near_nodes_size = 5,
  plantlife_limit = -0.9,
})

plantslib:spawn_on_surfaces({
  spawn_plants = {"vines:willow"},
  spawn_delay = spawn_interval,
  spawn_chance = 3,
  spawn_surfaces = {"moretrees:willow_leaves"},
  spawn_on_side = true,
  near_nodes = {"default:water_source"},
  near_nodes_size = 2,
  near_nodes_vertical = 5,
  near_nodes_count = 1,
  plantlife_limit = -0.9,
})

--Shears jojoa1997's shears
minetest.register_tool("vines:shears", {
	description = "Shears",
	inventory_image = "shears.png",
	wield_image = "shears.png",
	stack_max = 1,
	max_drop_level=3,
	tool_capabilities = {
    full_punch_interval = 1.0,
    max_drop_level=0,
    groupcaps={
      snappy={times={[3]=0.2}, maxwear=0.05, maxlevel=3},
      wool={times={[3]=0.2}, maxwear=0.05, maxlevel=3}
    }
  },
})

minetest.register_craft({
	output = 'vines:shears',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:stick', 'default:wood', 'default:steel_ingot'},
		{'', '', 'default:stick'},
	}
})

print("[Vines] Loaded!")
