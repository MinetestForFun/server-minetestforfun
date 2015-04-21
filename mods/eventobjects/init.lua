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

minetest.register_node("eventobjects:surprise_node", {
	description = "'?' block",
	tiles = {"eventobjects_surprise_node.png"},
	inventory_image = "eventobjects_surprise_node.png",
	wield_image = "eventobjects_surprise_node.png",
})

minetest.after(1,function()
	minetest.override_item("eventobjects:surprise_node", {
		on_punch = function(pos, node, puncher, pointed_things)
			-- Spawn betweek 5 and 20 random nodes
			for cnt = 1,math.random(5,20) do
				local item = ""
				local random_num = math.random(1,#minetest.registered_items)+math.random(-cnt,cnt)
				if random_num <= 0 then random_num = 1 end
				local random_count = 1
				for key, value in pairs(minetest.registered_items) do
					if random_count == random_num then
						item = key
						break
					end
					random_count = random_count + 1
				end
				print(table.getn(minetest.registered_items))
				local s_count = math.random(1,minetest.registered_items[item].max_count or 99)
				local obj = minetest.spawn_item({x=pos.x, y = pos.y + 1,z=pos.z},{name = item, count = s_count})
				if not obj then return end
				obj:setvelocity({x = 0, y = math.random(2,9), z = 0})
			end
			minetest.remove_node(pos)
		end,
	})
end)
