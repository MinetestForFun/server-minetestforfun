-- support for i18n
local S = plantlife_i18n.gettext

minetest.register_tool("vines:shears", {
  description = S("Shears"),
  inventory_image = "vines_shears.png",
  wield_image = "vines_shears.png",
  stack_max = 1,
  max_drop_level=3,
  tool_capabilities = {
    full_punch_interval = 1.0,
    max_drop_level=0,
    groupcaps={
      snappy={times={[3]=0.2}, uses=60, maxlevel=3},
      wool={times={[3]=0.2}, uses=60, maxlevel=3}
    }
  },
})
