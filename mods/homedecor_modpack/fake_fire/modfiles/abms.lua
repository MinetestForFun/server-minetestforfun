minetest.register_abm({
	nodenames = {
				"fake_fire:fake_fire",
				"fake_fire:ice_fire",
				"fake_fire:chimney_top_stone",
				"fake_fire:chimney_top_sandstone"
				},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == "air"
			and minetest.get_node({x=pos.x, y=pos.y+2.0, z=pos.z}).name == "air" then
		local image_number = math.random(4)
		minetest.add_particlespawner({
			amount = 6,
			time = 1,
			minpos = {x=pos.x-0.25, y=pos.y+0.4, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+8, z=pos.z+0.25},
			minvel = {x=-0.2, y=0.3, z=-0.2},
			maxvel = {x=0.2, y=1, z=0.2},
			minacc = {x=0,y=0,z=0},
			maxacc = {x=0,y=0,z=0},
			minexptime = 0.5,
			maxexptime = 3,
			minsize = 2,
			maxsize = 10,
			collisiondetection = false,
			texture = "smoke_particle_"..image_number..".png",
		})
		end
	end
})
