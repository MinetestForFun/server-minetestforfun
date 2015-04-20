minetest.register_tool("eventobjects:spleef_shovel", {
	description = "Golden Spleef Shovel",
	inventory_image = "eventobjects_spleef_shovel.png",
	wield_image = "eventobjects_spleef_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			unbreakable={times={[1]=0, [2]=0, [3]=0}, uses=0, maxlevel=3},
			crumbly = {times={[1]=1.20, [2]=0.60, [3]=0.40}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
})