returnmirror = {}
returnmirror.cost_teleport = 200
returnmirror.cost_set = 20

if tonumber(minetest.setting_get("returnmirror_cost_teleport")) ~= nil then
	returnmirror.cost_teleport = tonumber(minetest.setting_get("returnmirror_cost_teleport"))
end
if tonumber(minetest.setting_get("returnmirror_cost_set")) ~= nil then
	returnmirror.cost_set = tonumber(minetest.setting_get("returnmirror_cost_set"))
end

if minetest.get_modpath("mana") ~= nil then
	returnmirror.mana = true
else
	returnmirror.mana = false
end

returnmirror.mana_check = function(player, cost)
	local allowed
	if returnmirror.mana then
		if mana.subtract(player:get_player_name(), cost) then
			allowed = true
		else
			allowed = false
		end
	else
		allowed = true
	end
	return allowed
end

minetest.register_tool("returnmirror:mirror_inactive", {
	description = "Mirror of Returning/Portal mirror",
	inventory_image = "returnmirror_mirror_inactive.png",
	wield_image = "returnmirror_mirror_inactive.png",
	tool_capabilities = {},
	on_place = function(itemstack, placer, pointed_thing)
		if returnmirror.mana_check(placer, returnmirror.cost_set) then
			local pos = placer:getpos()
			local newitem = ItemStack("returnmirror:mirror_active")
			newitem:set_metadata(minetest.pos_to_string(pos))
			minetest.sound_play({name="returnmirror_set", gain=0.5}, {pos=pos, max_hear_distance=12})
			return newitem
		end
	end,
})

minetest.register_craftitem("returnmirror:mirror_glass", {
	description = "Mirror glass",
	inventory_image = "returnmirror_mirror_glass.png",
	wield_image = "returnmirror_mirror_glass.png",
})

minetest.register_tool("returnmirror:mirror_active", {
	description = "Mirror of Returning/Portal mirror",
	stack_max = 1,
	inventory_image = "returnmirror_mirror_active.png",
	wield_image = "returnmirror_mirror_active.png",
	tool_capabilities = {},
	on_use = function(itemstack, user, pointed_thing)
		local dest_string = itemstack:get_metadata()
		local dest = minetest.string_to_pos(dest_string)
		if dest ~= nil then
			if returnmirror.mana_check(user, returnmirror.cost_teleport) then
				local src = user:getpos()
				minetest.sound_play( {name="returnmirror_teleport", gain=1}, {pos=src, max_hear_distance=30})
				minetest.add_particlespawner({
					amount = 50,
					time = 0.1,
					minpos = {x=src.x-0.4, y=src.y+0.25, z=src.z-0.4},
					maxpos = {x=src.x+0.4, y=src.y+0.75, z=src.z+0.4},
					minvel = {x=-0.2, y=-0.2, z=-0.2},
					maxvel = {x=0.2, y=0.2, z=0.2},
					minexptime=3,
					maxexptime=4.5,
					minsize=1,
					maxsize=1.25,
					texture = "returnmirror_particle_departure.png",
				})
				user:setpos(dest)
				minetest.sound_play( {name="returnmirror_teleport", gain=1}, {pos=dest, max_hear_distance=30})
				minetest.add_particlespawner({
					amount = 100,
					time = 0.1,
					minpos = {x=dest.x-0.4, y=dest.y+0.25, z=dest.z-0.4},
					maxpos = {x=dest.x+0.4, y=dest.y+0.75, z=dest.z+0.4},
					minvel = {x=-0.4, y=-0.3, z=-0.4},
					maxvel = {x=0.4, y=0.3, z=0.4},
					minexptime=6,
					maxexptime=12,
					minsize=1,
					maxsize=1.25,
					texture = "returnmirror_particle_arrival.png",
				})
			end
		end
	end,
	on_place = function(itemstack, placer, pointed_thing)
		if returnmirror.mana_check(placer, returnmirror.cost_set) then
			local pos = placer:getpos()
			itemstack:set_metadata(minetest.pos_to_string(pos))
			minetest.sound_play( {name="returnmirror_set", gain=1}, {pos=pos, max_hear_distance=12})
			return itemstack
		end
	end,
	groups = { not_in_creative_inventory = 1 },
})

minetest.register_alias("returnmirror:mirror_inactive", "returnmirror:returnmirror")

minetest.register_craft({
	output = "returnmirror:mirror_glass",
	recipe = {
		{"default:diamondblock","default:mese","default:diamondblock"},
		{"default:mese","doors:door_obsidian_glass","default:mese"},
		{"default:diamondblock","default:mese","default:diamondblock"},
	},
})

minetest.register_craft({
	output = "returnmirror:mirror_inactive",
	recipe = {
		{"default:diamondblock", "default:nyancat", "default:diamondblock"},
		{"default:nyancat", "returnmirror:mirror_glass", "default:nyancat"},
		{"default:diamondblock", "default:nyancat", "default:diamondblock"},
	},
})

minetest.register_alias("returnmirror:portal","returnmirror:mirror_inactive")
