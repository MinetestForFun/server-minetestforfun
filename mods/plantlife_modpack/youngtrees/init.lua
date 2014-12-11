abstract_youngtrees = {} 

minetest.register_node("youngtrees:bamboo", {
	description = "Young Bamboo Tree", 
	drawtype="nodebox",
	tiles = {"bamboo.png"},
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	node_box = {
	type = "fixed",
	fixed = {
		{-0.058251,-0.500000,-0.413681,0.066749,0.500000,-0.282500}, --NodeBox 1
		{-0.058251,-0.500000,-0.103123,0.066749,0.500000,0.038672}, --NodeBox 2
		{-0.058251,-0.500000,0.181227,0.066749,0.500000,0.342500}, --NodeBox 3
		}
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

minetest.register_node("youngtrees:youngtree2_middle",{
	description = "Young Tree 2 (middle)", 
	drawtype="nodebox",
	tiles = {"youngtree2branch.png"},
	inventory_image = "youngtree2branch.png",
	wield_image = "youngtree2branch.png", 
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.125000,-0.500000,-0.500000,0.500000,-0.187500,-0.125000}, --NodeBox 1
			{-0.187500,-0.187500,-0.500000,0.500000,0.125000,0.250000}, --NodeBox 2
			{-0.500000,0.125000,-0.500000,0.500000,0.500000,0.500000}, --NodeBox 3
		}
	},
		groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

minetest.register_node("youngtrees:youngtree_top", {
	description = "Young Tree (top)",
	drawtype = "plantlike",
	tiles = {"youngtree16xa.png"},
	inventory_image = "youngtree16xa.png",
	wield_image = "youngtree16xa.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})

 
minetest.register_node("youngtrees:youngtree_middle", {
	description = "Young Tree (middle)",
	drawtype = "plantlike",
	tiles = {"youngtree16xb.png"},
	inventory_image = "youngtree16xb.png",
	wield_image = "youngtree16xb.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})


 
minetest.register_node("youngtrees:youngtree_bottom", {
	description = "Young Tree (bottom)",
	drawtype = "plantlike",
	tiles = {"youngtree16xc.png"},
	inventory_image = "youngtree16xc.png",
	wield_image = "youngtree16xc.png",
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	drop = 'trunks:twig_1'
})
 
 
 abstract_youngtrees.grow_youngtree = function(pos)
	local height = math.random(1,3)	
	abstract_youngtrees.grow_youngtree_node(pos,height)
end

abstract_youngtrees.grow_youngtree_node = function(pos, height)
	
	
	local right_here = {x=pos.x, y=pos.y+1, z=pos.z}
	local above_right_here = {x=pos.x, y=pos.y+2, z=pos.z}
	
	if minetest.get_node(right_here).name == "air"  -- instead of check_air = true,
	or minetest.get_node(right_here).name == "default:junglegrass" then
		if height == 1 then
				minetest.set_node(right_here, {name="youngtrees:youngtree_top"})
		end
		if height == 2 then
				minetest.set_node(right_here, {name="youngtrees:youngtree_bottom"})
				minetest.set_node(above_right_here, {name="youngtrees:youngtree_top"})
		end	
		if height == 3 then
				local two_above_right_here = {x=pos.x, y=pos.y+3, z=pos.z}
				minetest.set_node(right_here, {name="youngtrees:youngtree_bottom"})
				minetest.set_node(above_right_here, {name="youngtrees:youngtree_middle"})
				minetest.set_node(two_above_right_here, {name="youngtrees:youngtree_top"})
		end		
	end
end


plantslib:register_generate_plant({
    surface = {
		"default:dirt_with_grass", 
		"stoneage:grass_with_silex",
		"sumpf:peat",
		"sumpf:sumpf"
	},
    max_count = 55,  --10,15
    rarity = 101 - 4,  --3,4
    min_elevation = 1, -- above sea level
	plantlife_limit = -0.9,
  },
  abstract_youngtrees.grow_youngtree
)		
