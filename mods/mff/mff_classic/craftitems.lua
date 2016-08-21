local modname = minetest.get_current_modname()

minetest.register_craftitem(modname .. ':tin_lump', {
  description = "Tin Lump",
  inventory_image = 'default_tin_lump.png',
})

minetest.register_craftitem(modname .. ':silver_lump', {
  description = "Silver Lump",
  inventory_image = 'default_silver_lump.png',
})

minetest.register_craftitem(modname .. ':mithril_lump', {
  description = "Mithril Lump",
  inventory_image = 'default_mithril_lump.png',
})

minetest.register_craftitem(modname .. ':tin_ingot', {
  description = "Tin Ingot",
  inventory_image = 'default_tin_ingot.png',
  groups = {ingot = 1},
})

minetest.register_craftitem(modname .. ':silver_ingot', {
  description = "Silver Ingot",
  inventory_image = 'default_silver_ingot.png',
  groups = {ingot = 1},
})

minetest.register_craftitem(modname .. ':mithril_ingot', {
  description = "Mithril Ingot",
  groups = {ingot = 1},
  inventory_image = 'default_mithril_ingot.png',
})

minetest.register_craftitem(modname .. ':scorched_stuff', {
  description = "Scorched Stuff",
  inventory_image = 'default_scorched_stuff.png',
})
