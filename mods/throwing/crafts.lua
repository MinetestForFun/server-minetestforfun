-- Craft recipe of the "Mithril String"
minetest.register_craft({
  output = "throwing:string_mithril",
  description = "Mithril String",
  inventory_image = "string_mithril.png",
  type = "shapeless",
  recipe = {"moreores:mithril_ingot", "farming:string"},
})
