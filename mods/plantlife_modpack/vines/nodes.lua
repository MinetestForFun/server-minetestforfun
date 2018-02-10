-- support for i18n
local S = plantlife_i18n.gettext

minetest.register_node("vines:rope_block", {
  description = S("Rope"),
  sunlight_propagates = true,
  paramtype = "light",
  tiles = {
    "default_wood.png^vines_rope.png",
    "default_wood.png^vines_rope.png",
    "default_wood.png",
    "default_wood.png",
    "default_wood.png^vines_rope.png",
    "default_wood.png^vines_rope.png",
  },
  groups = { flammable=2, choppy=2, oddly_breakable_by_hand=1 },
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
    while ( n.name == 'vines:rope' or n.name == 'vines:rope_end' ) do
      minetest.remove_node(p)
      p = {x=p.x, y=p.y-1, z=p.z}
      n = minetest.get_node(p)
    end
  end
})

minetest.register_node("vines:rope", {
  description = S("Rope"),
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  paramtype = "light",
  drop = "",
  tiles = { "vines_rope.png" },
  drawtype = "plantlike",
  groups = {flammable=2, not_in_creative_inventory=1},
  sounds =  default.node_sound_leaves_defaults(),
  selection_box = {
    type = "fixed",
    fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
  },
})

minetest.register_node("vines:rope_end", {
  description = S("Rope"),
  walkable = false,
  climbable = true,
  sunlight_propagates = true,
  paramtype = "light",
  drop = "",
  tiles = { "vines_rope_end.png" },
  drawtype = "plantlike",
  groups = {flammable=2, not_in_creative_inventory=1},
  sounds =  default.node_sound_leaves_defaults(),
  after_place_node = function(pos)
    local yesh  = {x = pos.x, y= pos.y-1, z=pos.z}
    minetest.add_node(yesh, {name="vines:rope"})
  end,
  selection_box = {
	  type = "fixed",
	  fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
  },
  on_construct = function( pos )
    local timer = minetest.get_node_timer( pos )
    timer:start( 1 )
  end,
  on_timer = function( pos, elapsed )
    local p = {x=pos.x, y=pos.y-1, z=pos.z}
    local n = minetest.get_node(p)
    if  n.name == "air" then
      minetest.set_node(pos, {name="vines:rope"})
      minetest.add_node(p, {name="vines:rope_end"})
    else
      local timer = minetest.get_node_timer( pos )
      timer:start( 1 )
    end
  end
})
