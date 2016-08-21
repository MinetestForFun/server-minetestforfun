local modname = minetest.get_current_modname()
local thismod = _G[modname]

minetest.register_abm({
  nodenames = {modname .. ':cherry_sapling', modname .. 'mg_cherry_sapling'},
  interval = 80,
  chance = 3,
  action = function(pos, node)

    local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
    local is_soil = minetest.get_item_group(nu, 'soil')

    if is_soil == 0 then
      return
    end

    minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
    thismod.grow_cherry_tree(pos, false, modname .. ':cherry_tree', modname .. ':cherry_blossom_leaves')
  end,
})
