-- support for i18n
local S = plantlife_i18n.gettext

minetest.register_craft({
  output = 'vines:rope_block',
  recipe = vines.recipes['rope_block']
})

minetest.register_craft({
  output = 'vines:shears',
  recipe = vines.recipes['shears']
})

minetest.register_craftitem("vines:vines", {
  description = S("Vines"),
  inventory_image = "vines_item.png",
})
