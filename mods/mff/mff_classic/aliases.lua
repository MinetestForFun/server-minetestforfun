local modname = minetest.get_current_modname()

local alias
if minetest.setting_get(modname .. '.output_alias_list') == 'true' then
  alias = function(from, to)
    minetest.log('action', "[" .. modname .. "] " .. from .. " -> " .. to)
    minetest.register_alias(from, to)
  end
else
  alias = minetest.register_alias
end

do -- default
  local aliases = {
    'mg_cherry_sapling', 'acid_source', 'acid_flowing', 'sand_source', 'sand_flowing',
    'clay_burned', 'cherry_tree', 'cherry_log', 'cherry_plank', 'cherry_blossom_leaves',
    'cherry_leaves_deco', 'cherry_sapling', 'desert_stone_with_coal', 'desert_stone_with_copper',
    'stone_with_tin', 'desert_stone_with_tin', 'tinblock', 'stone_with_silver',
    'desert_stone_with_silver', 'silverblock', 'meze', 'stone_with_mithril', 'mithrilblock',
    'stone_with_coin', 'ladder_obsidian', 'fence_cobble', 'fence_desert_cobble',
    'fence_steelblock', 'fence_brick', 'nyancat', 'nyancat_rainbow', 'obsidian_cooled',
    'cobble_cooled', 'scorched_stuff'
  }
  for _, node in pairs(aliases) do
    alias('default:' .. node, modname .. ':' .. node)
  end
  alias('default:meze_block', modname .. ':meze')
end

do -- moreores
  local aliases = {
    'pick_silver', 'pick_mithril', 'shovel_silver', 'shovel_mithril', 'axe_silver', 'axe_mithril',
    'sword_silver', 'sword_mithril', 'mithril_ingot', 'silver_ingot', 'tin_ingot', 'mithril_lump',
    'silver_lump', 'tin_lump'
  }
  for _, node in pairs(aliases) do
    alias('moreores:' .. node, modname .. ':' .. node)
    alias('default:' .. node, modname .. ':' .. node)
  end
  alias('mineral_silver', modname .. ':stone_with_silver')
  alias('mineral_tin', modname .. ':stone_with_tin')
  alias('mineral_mithril', modname .. ':stone_with_mithril')
  alias('mithril_block', modname .. ':mithrilblock')
  alias('silver_block', modname .. ':silverblock')
  alias('tin_block', modname .. ':tinblock')
end

alias('bucket_acid', modname .. ':bucket_acid')
alias('bucket:bucket_acid', modname .. ':bucket_acid')
alias('bucket_sand', modname .. ':bucket_sand')
alias('bucket:bucket_sand', modname .. ':bucket_sand')
