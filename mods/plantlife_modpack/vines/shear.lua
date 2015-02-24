minetest.register_tool("vines:shears", {
  description = "Shears",
  inventory_image = "vines_shears.png",
  wield_image = "shears.png",
  stack_max = 1,
  max_drop_level=3,
  tool_capabilities = {
    full_punch_interval = 1.0,
    max_drop_level=0,
    groupcaps={
      snappy={times={[3]=0.2}, maxwear=0.05, maxlevel=3},
      wool={times={[3]=0.2}, maxwear=0.05, maxlevel=3}
    }
  },
})
