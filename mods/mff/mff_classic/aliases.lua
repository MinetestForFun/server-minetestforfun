local modname = minetest.get_current_modname()

do -- default
  local aliases = {
    'mg_cherry_sapling', 'acid_source', 'acid_flowing', 'sand_source', 'sand_flowing',
    'clay_burned', 'cherry_tree', 'cherry_log', 'cherry_plank', 'cherry_blossom_leaves',
    'cherry_leaves_deco', 'cherry_sapling', 'desert_stone_with_coal', 'desert_stone_with_copper',
    'stone_with_tin', 'desert_stone_with_tin', 'tinblock', 'stone_with_silver',
    'desert_stone_with_silver', 'silverblock', 'meze', 'stone_with_mithril', 'mithrilblock',
    'stone_with_coin', 'ladder_obsidian', 'fence_cobble', 'fence_desert_cobble',
    'fence_steelblock', 'fence_brick', 'nyancat', 'nyancat_rainbow', 'obsidian_cooled',
    'cobble_cooled'
  }
  for node in pairs(aliases) do
    minetest.register_alias('default:' .. node, modname .. ':' .. node)
  end
  minetest.register_alias('default:meze_block', modname .. ':meze')
end

do -- moreores
  local aliases = {
    'pick_silver', 'pick_mithril', 'shovel_silver', 'shovel_mithril', 'axe_silver', 'axe_mithril',
    'sword_silver', 'sword_mithril', 'mithril_ingot', 'silver_ingot', 'tin_ingot', 'mithril_lump',
    'silver_lump', 'tin_lump'
  }
  for node in pairs(aliases) do
    minetest.register_alias('moreores:' .. node, modname .. ':' .. node)
  end
  minetest.register_alias('mineral_silver', modname .. ':stone_with_silver')
  minetest.register_alias('mineral_tin', modname .. ':stone_with_tin')
  minetest.register_alias('mineral_mithril', modname .. ':stone_with_mithril')
  minetest.register_alias('mithril_block', modname .. ':mithrilblock')
  minetest.register_alias('silver_block', modname .. ':silverblock')
  minetest.register_alias('tin_block', modname .. ':tinblock')
end
