-- Based on compass mod by Echo

local function tick()
	minetest.after(1, tick)
	local players  = minetest.get_connected_players()
	for i,player in ipairs(players) do
		local target = lavatemple.mapgen_data.pos;
		if not target then return end
		local pos = player:getpos()
		local dir = player:get_look_yaw()
		local angle_north = math.deg(math.atan2(target.x - pos.x, target.z - pos.z))
		if angle_north < 0 then angle_north = angle_north + 360 end
		local angle_dir = 90 - math.deg(dir)
		local angle_relative = (angle_north - angle_dir) % 360
		local compass_image = math.floor((angle_relative/30) + 0.5)%12

		local wielded_item = player:get_wielded_item():get_name()
		if string.sub(wielded_item, 0, 18) == "lavatemple:dagger_" then
			player:set_wielded_item("lavatemple:dagger_"..compass_image)
		else
			if player:get_inventory() then
				for i,stack in ipairs(player:get_inventory():get_list("main")) do
					if string.sub(stack:get_name(), 0, 18) == "lavatemple:dagger_" and
					   stack:get_name() ~= "lavatemple:dagger_"..compass_image then
						player:get_inventory():set_stack("main", i, ItemStack("lavatemple:dagger_"..compass_image))
					end
				end
			end
		end
	end
end

tick()

local images = {
	"lavatemple_dagger_0.png",
	"lavatemple_dagger_1.png",
	"lavatemple_dagger_2.png",
	"lavatemple_dagger_3.png",
	"lavatemple_dagger_4.png",
	"lavatemple_dagger_5.png",
	"lavatemple_dagger_6.png",
	"lavatemple_dagger_5.png",
	"lavatemple_dagger_4.png",
	"lavatemple_dagger_3.png",
	"lavatemple_dagger_2.png",
	"lavatemple_dagger_1.png",
}

local i
for i,img in ipairs(images) do
	local inv = 1
	if i == 1 then
		inv = 0
	end
	minetest.register_tool("lavatemple:dagger_"..(i-1), {
		description = "Lava dagger",
		inventory_image = img,
		wield_image = img,
		groups = {not_in_creative_inventory=inv},
	})
end

minetest.register_craft({
	output = 'lavatemple:dagger_1',
	recipe = {
		{'zmobs:lava_orb', 'default:steel_ingot', 'zmobs:lava_orb'},
		{'zmobs:lava_orb', 'default:steel_ingot', 'zmobs:lava_orb'},
		{'zmobs:lava_orb', 'default:stick', 'zmobs:lava_orb'}
	}
})

