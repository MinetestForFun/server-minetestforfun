local modname = minetest.get_current_modname()

minetest.register_craft({
  type = 'cooking',
  output = modname .. ':mithril_ingot',
  recipe = modname .. ':mithril_lump',
})

minetest.register_craft({
  type = 'cooking',
  output = modname .. ':clay_burned',
  recipe = 'default:clay',
})

minetest.register_craft({
  type = 'fuel',
  recipe = 'group:stick',
  burntime = 1,
})

minetest.register_craft({
  type = 'cooking',
  output = modname .. ':tin_ingot',
  recipe = modname .. ':tin_lump',
})

minetest.register_craft({
  type = 'cooking',
  output = modname .. ':silver_ingot',
  recipe = modname .. ':silver_lump',
})

minetest.register_craft({
  output = modname .. ':pick_silver',
  recipe = {
    {modname .. ':silver_ingot', modname .. ':silver_ingot', modname .. ':silver_ingot'},
    {'', 'group:stick', ''},
    {'', 'group:stick', ''},
  }
})

minetest.register_craft({
  output = modname .. ':pick_gold',
  recipe = {
    {modname .. ':gold_ingot', modname .. ':gold_ingot', modname .. ':gold_ingot'},
    {'', 'group:stick', ''},
    {'', 'group:stick', ''},
  }
})

minetest.register_craft({
  output = 'maptools:superapple',
  type = 'shapeless',
  recipe = {'default:apple', 'default:mese', 'default:mese'},
})

minetest.register_craft({
  output = modname .. ':cherry_plank 6',
  recipe = {
    {modname .. ':cherry_log'},
  }
})

minetest.register_craft({
  output = modname .. ':pick_mithril',
  recipe = {
    {modname .. ':mithril_ingot', modname .. ':mithril_ingot', modname .. ':mithril_ingot'},
    {'', 'group:stick', ''},
    {'', 'group:stick', ''},
  }
})

minetest.register_craft({
  output = modname .. ':pick_nyan',
  recipe = {
    {modname .. ':nyancat', modname .. ':nyancat', modname .. ':nyancat'},
    {'', 'group:stick', ''},
    {'', 'group:stick', ''},
  }
})

minetest.register_craft({
  output = modname .. ':shovel_silver',
  recipe = {
    {modname .. ':silver_ingot'},
    {'group:stick'},
    {'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':shovel_gold',
  recipe = {
    {'default:gold_ingot'},
    {'group:stick'},
    {'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':shovel_mithril',
  recipe = {
    {modname .. ':mithril_ingot'},
    {'group:stick'},
    {'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':shovel_nyan',
  recipe = {
    {modname .. ':nyancat'},
    {'group:stick'},
    {'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':axe_silver',
  recipe = {
    {modname .. ':silver_ingot', modname .. ':silver_ingot'},
    {modname .. ':silver_ingot', 'group:stick'},
    {'', 'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':axe_gold',
  recipe = {
    {modname .. ':gold_ingot', modname .. ':gold_ingot'},
    {modname .. ':gold_ingot', 'group:stick'},
    {'', 'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':axe_mithril',
  recipe = {
    {modname .. ':mithril_ingot', modname .. ':mithril_ingot'},
    {modname .. ':mithril_ingot', 'group:stick'},
    {'', 'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':axe_nyan',
  recipe = {
    {modname .. ':nyancat', modname .. ':nyancat'},
    {modname .. ':nyancat', 'group:stick'},
    {'', 'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':axe_silver',
  recipe = {
    {modname .. ':silver_ingot', modname .. ':silver_ingot'},
    {'group:stick', modname .. ':silver_ingot'},
    {'group:stick', ''},
  }
})

minetest.register_craft({
  output = modname .. ':axe_gold',
  recipe = {
    {'default:gold_ingot', 'default:gold_ingot'},
    {'group:stick', 'default:gold_ingot'},
    {'group:stick', ''},
  }
})

minetest.register_craft({
  output = modname .. ':axe_mithril',
  recipe = {
    {modname .. ':mithril_ingot', modname .. ':mithril_ingot'},
    {'group:stick', modname .. ':mithril_ingot'},
    {'group:stick', ''},
  }
})

minetest.register_craft({
  output = modname .. ':axe_nyan',
  recipe = {
    {modname .. ':nyancat', modname .. ':nyancat'},
    {'group:stick', modname .. ':nyancat'},
    {'group:stick', ''},
  }
})

minetest.register_craft({
  output = modname .. ':sword_silver',
  recipe = {
    {modname .. ':silver_ingot'},
    {modname .. ':silver_ingot'},
    {'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':sword_gold',
  recipe = {
    {'default:gold_ingot'},
    {'default:gold_ingot'},
    {'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':sword_mithril',
  recipe = {
    {modname .. ':mithril_ingot'},
    {modname .. ':mithril_ingot'},
    {'group:stick'},
  }
})

minetest.register_craft({
  output = modname .. ':sword_nyan',
  recipe = {
    {modname .. ':nyancat'},
    {modname .. ':nyancat'},
    {'group:stick'},
  }
})


minetest.register_craft({ 			-- Ultimate Warrior weapon
  output = modname .. ':dungeon_master_s_blood_sword',
  recipe = {
    {'mobs:dungeon_master_blood', 'nether:white', 'mobs:dungeon_master_blood'},
    {'mobs:dungeon_master_blood', 'mobs:dungeon_master_diamond', 'mobs:dungeon_master_blood'},
    {modname .. ':mithrilblock', 'mobs:zombie_tibia', modname .. ':mithril_block'},
  }
})

minetest.register_craft({
  type = 'shapeless',
  output = 'default:bronze_ingot 3',
  recipe = {
    modname .. ':tin_ingot',
    'default:copper_ingot',
    'default:copper_ingot',
  }
})

minetest.register_craft({
  output = modname .. ':tinblock',
  recipe = {
    {modname .. ':tin_ingot', modname .. ':tin_ingot', modname .. ':tin_ingot'},
    {modname .. ':tin_ingot', modname .. ':tin_ingot', modname .. ':tin_ingot'},
    {modname .. ':tin_ingot', modname .. ':tin_ingot', modname .. ':tin_ingot'},
  }
})

minetest.register_craft({
  output = modname .. ':tin_ingot 9',
  recipe = {
    {modname .. ':tinblock'},
  }
})

minetest.register_craft({
  output = modname .. ':silverblock',
  recipe = {
    {modname .. ':silver_ingot', modname .. ':silver_ingot', modname .. ':silver_ingot'},
    {modname .. ':silver_ingot', modname .. ':silver_ingot', modname .. ':silver_ingot'},
    {modname .. ':silver_ingot', modname .. ':silver_ingot', modname .. ':silver_ingot'},
  }
})

minetest.register_craft({
  output = modname .. ':silver_ingot 9',
  recipe = {
    {modname .. ':silverblock'},
  }
})

minetest.register_craft({
  output = modname .. ':mithrilblock',
  recipe = {
    {modname .. ':mithril_ingot', modname .. ':mithril_ingot', modname .. ':mithril_ingot'},
    {modname .. ':mithril_ingot', modname .. ':mithril_ingot', modname .. ':mithril_ingot'},
    {modname .. ':mithril_ingot', modname .. ':mithril_ingot', modname .. ':mithril_ingot'},
  }
})

minetest.register_craft({
  output = modname .. ':mithril_ingot 9',
  recipe = {
    {modname .. ':mithrilblock'},
  }
})

-- Utility crafts

minetest.register_craft({
  output = 'default:dirt 4',
  type = 'shapeless',
  recipe = {'default:gravel', 'default:gravel', 'default:gravel', 'default:gravel'}
})

minetest.register_craft({
  output = 'default:gravel',
  recipe = {
    {'default:cobble'},
  }
})

minetest.register_craft({
  output = 'default:desert_stone 2',
  recipe = {
    {'default:desert_sand', 'default:desert_sand'},
    {'default:desert_sand', 'default:desert_sand'},
  }
})

