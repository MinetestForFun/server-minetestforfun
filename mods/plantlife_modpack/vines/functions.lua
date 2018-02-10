-- support for i18n
local S = plantlife_i18n.gettext

vines.register_vine = function( name, defs, biome )
  local groups = { vines=1, snappy=3, flammable=2 }

  local vine_name_end = 'vines:'..name..'_end'
  local vine_name_middle = 'vines:'..name..'_middle'

  local vine_image_end = "vines_"..name.."_end.png"
  local vine_image_middle = "vines_"..name.."_middle.png"

  local drop_node = vine_name_end

  biome.spawn_plants = { vine_name_end }

  local vine_group = 'group:'..name..'_vines'
  biome.spawn_surfaces[ #biome.spawn_surfaces + 1 ] = vine_group

  local selection_box = { type = "wallmounted", }
  local drawtype = 'signlike'
  if ( not biome.spawn_on_side ) then
    --different properties for bottom and side vines.
    selection_box = { type = "fixed", fixed = { -0.4, -1/2, -0.4, 0.4, 1/2, 0.4 }, }
    drawtype = 'plantlike'
  end

  minetest.register_node( vine_name_end, {
    description = defs.description,
    walkable = false,
    climbable = true,
    wield_image = vine_image_end,
    drop = "",
    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "wallmounted",
    buildable_to = false,
    tiles = { vine_image_end },
    drawtype = drawtype,
    inventory_image = vine_image_end,
    groups = groups,
    sounds = default.node_sound_leaves_defaults(),
    selection_box = selection_box,
    on_construct = function( pos )
      local timer = minetest.get_node_timer( pos )
      timer:start( math.random(5, 10) )
    end,
    on_timer = function( pos )
      local node = minetest.get_node( pos )
      local bottom = {x=pos.x, y=pos.y-1, z=pos.z}
      local bottom_node = minetest.get_node( bottom )
      if bottom_node.name == "air" then
        if not ( math.random( defs.average_length ) == 1 ) then
          minetest.set_node( pos, { name = vine_name_middle, param2 = node.param2 } )
          minetest.set_node( bottom, { name = node.name, param2 = node.param2 } )
          local timer = minetest.get_node_timer( bottom_node )
          timer:start( math.random(5, 10) )
        end
      end
    end,
    after_dig_node = function(pos, node, oldmetadata, user)
      vines.dig_vine( pos, drop_node, user )
    end
  })

  minetest.register_node( vine_name_middle, {
    description = S("Matured").." "..defs.description,
    walkable = false,
    climbable = true,
    drop = "",
    sunlight_propagates = true,
    paramtype = "light",
    paramtype2 = "wallmounted",
    buildable_to = false,
    tiles = { vine_image_middle },
    wield_image = vine_image_middle,
    drawtype = drawtype,
    inventory_image = vine_image_middle,
    groups = groups,
    sounds = default.node_sound_leaves_defaults(),
    selection_box = selection_box,
    on_destruct = function( pos )
      local bottom = {x=pos.x, y=pos.y-1, z=pos.z}
      local bottom_node = minetest.get_node( bottom )
      if minetest.get_item_group( bottom_node.name, "vines") > 0 then
        minetest.after( 0, minetest.remove_node, bottom )
      end
    end,
    after_dig_node = function( pos, node, oldmetadata, user )
      vines.dig_vine( pos, drop_node, user )
    end
  })

  biome_lib:spawn_on_surfaces( biome )

  local override_nodes = function( nodes, def )
  local function override( index, registered )
      local node = nodes[ index ]
      if index > #nodes then return registered end
      if minetest.registered_nodes[node] then
        minetest.override_item( node, def )
        registered[#registered+1] = node
      end
      override( index+1, registered )
    end
    override( 1, {} )
  end

  override_nodes( biome.spawn_surfaces,{
    on_destruct = function( pos )
      local pos_min = { x = pos.x -1, y = pos.y - 1, z = pos.z - 1 }
      local pos_max = { x = pos.x +1, y = pos.y + 1, z = pos.z + 1 }
      local positions = minetest.find_nodes_in_area( pos_min, pos_max, "group:vines" )
      for index, position in pairs(positions) do
        minetest.remove_node( position )
      end
    end
  })

end

vines.dig_vine = function( pos, node_name, user )
  --only dig give the vine if shears are used
  if not user then return false end
  local wielded = user:get_wielded_item()
  if 'vines:shears' == wielded:get_name() then
    local inv = user:get_inventory()
    if inv then
      inv:add_item("main", ItemStack( node_name ))
    end
  end
end
