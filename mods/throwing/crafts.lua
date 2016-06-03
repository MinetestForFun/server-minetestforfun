-- Craft recipe of the "Mithril String"
minetest.register_craft({
  output = "throwing:string_mithril",
  description = "Mithril String",
  inventory_image = "string_mithril.png",
  type = "shapeless",
  recipe = {"default:mithril_ingot", "farming:string"},
})

minetest.register_craftitem("throwing:string_mithril", {
	inventory_image = "throwing_string_mithril.png",
	description = "Mithril String",
})
