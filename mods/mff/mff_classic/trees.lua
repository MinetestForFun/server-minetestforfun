local modname = minetest.get_current_modname()
local thismod = _G[modname]

-- From BFD:

minetest.register_node(modname .. ':mg_cherry_sapling', {
  description = "Impossible to get node.",
  drawtype = 'airlike',
  paramtype = 'light',
  tiles = {'xfences_space.png'},
  groups = {not_in_creative_inventory=1},
})

local c_mg_cherry_sapling = minetest.get_content_id(modname .. ':mg_cherry_sapling')

minetest.register_on_generated(function(minp, maxp, seed)
  local timer = os.clock()
  local vm, emin, emax = minetest.get_mapgen_object('voxelmanip')
  local data = vm:get_data()
  local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
  local trees_grown = 0
  for z=minp.z, maxp.z, 1 do
    for y=minp.y, maxp.y, 1 do
      for x=minp.x, maxp.x, 1 do
        local p_pos = area:index(x,y,z)
        local content_id = data[p_pos]
        if content_id == c_mg_cherry_sapling then
          minetest.after(1, thismod.grow_cherry_tree,
            {x=x, y=y, z=z},
            false,
            modname .. ':cherry_tree',
            modname .. ':cherry_blossom_leaves')
          trees_grown = trees_grown + 1
        else
          -- nope
        end
      end
    end
  end
  local geninfo = string.format(" trees grown after: %.2fs", os.clock() - timer)
  minetest.log('action', trees_grown..geninfo)
end)

function thismod.grow_cherry_tree(pos, is_apple_tree, trunk_node, leaves_node)
  --[[
    NOTE: Tree-placing code is currently duplicated in the engine
    and in games that have saplings; both are deprecated but not
    replaced yet
  --]]

  local x, y, z = pos.x, pos.y, pos.z
  local height = random(4, 5)
  local c_tree = minetest.get_content_id(trunk_node)
  local c_leaves = minetest.get_content_id(leaves_node)

  local vm = minetest.get_voxel_manip()
  local minp, maxp = vm:read_from_map(
    {x = pos.x - 2, y = pos.y, z = pos.z - 2},
    {x = pos.x + 2, y = pos.y + height + 1, z = pos.z + 2}
  )
  local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
  local data = vm:get_data()

  default.add_trunk_and_leaves(data, a, pos, c_tree, c_leaves, height, 2, 8, is_apple_tree)

  vm:set_data(data)
  vm:write_to_map()
  vm:update_map()
end
