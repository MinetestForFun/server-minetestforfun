local modname = minetest.get_current_modname()
local thismod = _G[modname]

-- Beware of Meze

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':meze',
  wherein        = 'default:stone',
  clust_scarcity = 40 * 40 * 40,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = 0,
  y_max          = 64,
  flags          = 'absheight',
})

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':meze',
  wherein        = 'default:desert_stone',
  clust_scarcity = 40 * 40 * 40,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = 0,
  y_max          = 64,
  flags          = 'absheight',
})


-- Tin

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':stone_with_tin',
  wherein	       = 'default:stone',
  clust_scarcity = 7 * 7 * 7,
  clust_num_ores = 3,
  clust_size     = 7,
  y_min	       = -31000,
  y_max          = 12,
})

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':desert_stone_with_tin',
  wherein	       = 'default:desert_stone',
  clust_scarcity = 7 * 7 * 7,
  clust_num_ores = 3,
  clust_size     = 7,
  y_min	       = -31000,
  y_max          = 12,
})

-- Silver

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':stone_with_silver',
  wherein	       = 'default:stone',
  clust_scarcity = 11 * 11 * 11,
  clust_num_ores = 4,
  clust_size     = 11,
  y_min	       = -31000,
  y_max          = -12,
})

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':desert_stone_with_silver',
  wherein	       = 'default:desert_stone',
  clust_scarcity = 11 * 11 * 11,
  clust_num_ores = 4,
  clust_size     = 11,
  y_min	       = -31000,
  y_max          = -12,
})

-- Mithril

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':stone_with_mithril',
  wherein	       = 'default:stone',
  clust_scarcity = 11 * 11 * 11,
  clust_num_ores = 1,
  clust_size     = 11,
  y_min	       = -31000,
  y_max          = -1024,
})

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':stone_with_mithril',
  wherein	       = 'default:stone',
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 2,
  clust_size     = 3,
  y_min	       = -31000,
  y_max          = -2048,
})

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':stone_with_mithril',
  wherein	       = 'default:stone',
  clust_scarcity = 22 * 22 * 22,
  clust_num_ores = 5,
  clust_size     = 5,
  y_min	       = -31000,
  y_max          = -4096,
})

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':stone_with_mithril',
  wherein	       = 'default:stone',
  clust_scarcity = 28 * 28 * 28,
  clust_num_ores = 20,
  clust_size     = 7,
  y_min	       = -31000,
  y_max          = -12288,
})

-- Gold Coins

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = modname .. ':stone_with_coin',
  wherein        = 'default:stone',
  clust_scarcity = 26 * 26 * 26,
  clust_num_ores = 1,
  clust_size     = 1,
  y_min          = -30000,
  y_max          = 0,
  flags          = 'absheight',
})

-- Cherry tree

minetest.register_decoration({
  deco_type = 'simple',
  place_on = 'default:dirt_with_grass"',
  sidelen = 16,
  noise_params = {
    offset = 0,
    scale = 0.005,
    spread = {x=100, y=100, z=100},
    seed = 278,
    octaves = 2,
    persist = 0.7
  },
  decoration = modname .. ':mg_cherry_sapling',
  height = 1,
})

-- More ores, MORE ORES!!!

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = 'default:stone_with_coal',
  wherein        = 'default:stone',
  clust_scarcity = 32 * 32 * 32,
  clust_num_ores = 40,
  clust_size     = 4,
  y_max          = 64,
  y_min          = -30000,
})

minetest.register_ore({
  ore_type       = 'scatter',
  ore            = 'default:stone_with_iron',
  wherein        = 'default:stone',
  clust_scarcity = 12 * 12 * 12,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -15,
  y_max          = 2,
})

--
-- Generate nyan cats
--

-- All mapgens except singlenode

function thismod.make_nyancat(pos, facedir, length)
  local tailvec = {x = 0, y = 0, z = 0}
  if facedir == 0 then
    tailvec.z = 1
  elseif facedir == 1 then
    tailvec.x = 1
  elseif facedir == 2 then
    tailvec.z = -1
  elseif facedir == 3 then
    tailvec.x = -1
  else
    facedir = 0
    tailvec.z = 1
  end
  local p = {x = pos.x, y = pos.y, z = pos.z}
  minetest.set_node(p, {name = modname .. ':nyancat', param2 = facedir})
  for i = 1, length do
    p.x = p.x + tailvec.x
    p.z = p.z + tailvec.z
    minetest.set_node(p, {name = modname .. ':nyancat_rainbow', param2 = facedir})
  end
end

function thismod.generate_nyancats(minp, maxp, seed)
  local height_min = -19600
  local height_max = 30000
  if maxp.y < height_min or minp.y > height_max then
    return
  end
  local y_min = math.max(minp.y, height_min)
  local y_max = math.min(maxp.y, height_max)
  local volume = (maxp.x - minp.x + 1) * (y_max - y_min + 1) * (maxp.z - minp.z + 1)
  local pr = PseudoRandom(seed + 9324342)
  local max_num_nyancats = math.floor(volume / (16 * 16 * 16))
  for i = 1, max_num_nyancats do
    if pr:next(0, 1000) == 0 then
      local x0 = pr:next(minp.x, maxp.x)
      local y0 = pr:next(minp.y, maxp.y)
      local z0 = pr:next(minp.z, maxp.z)
      local p0 = {x = x0, y = y0, z = z0}
      thismod.make_nyancat(p0, pr:next(0, 3), pr:next(10, 15))
    end
  end
end

if minetest.setting_get(modname .. '.disable_nyancat_mapgen') ~= 'true' then
  minetest.register_on_generated(thismod.generate_nyancats)
end
