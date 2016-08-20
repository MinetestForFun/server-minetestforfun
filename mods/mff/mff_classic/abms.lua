local modname = minetest.get_current_modname()

minetest.register_abm({
  nodenames = {'default:cherry_sapling', modname .. 'mg_cherry_sapling'},
  interval = 80,
  chance = 3,
  action = function(pos, node)

    local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
    local is_soil = minetest.get_item_group(nu, 'soil')

    if is_soil == 0 then
      return
    end

    minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
    default.grow_cherry_tree(pos, false, 'default:cherry_tree', 'default:cherry_blossom_leaves')
  end,
})
