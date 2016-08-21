local modname = minetest.get_current_modname()

bucket.register_liquid(
  modname .. ':acid_source',
  modname .. ':acid_flowing',
  modname .. ':bucket_acid',
  'bucket_acid.png',
  "Acid Bucket",
  {not_in_creative_inventory = 1}
)

bucket.register_liquid(
  modname .. ':sand_source',
  modname .. ':sand_flowing',
  modname .. ':bucket_sand',
  'bucket_sand.png',
  "Sand Bucket",
  {not_in_creative_inventory = 1}
)

minetest.register_craft({
  output = modname .. ':bucket_sand',
  recipe = {
    {'group:sand'},
    {'group:sand'},
    {'bucket:bucket_water'}
  },
})
