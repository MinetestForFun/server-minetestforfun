minetest.register_node(":default:dirt", {
	description = "Dirt",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3, soil=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'bone:bone', 'default:dirt'},
				rarity = 50,
			},
			{
				items = {'default:dirt'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults(),
})


minetest.register_node(":default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {crumbly=3, soil=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'bone:bone', 'default:dirt'},
				rarity = 50,
			},
			{
				items = {'default:dirt'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})


minetest.register_craftitem("bone:bone", {
	description = "Bone",
	inventory_image = "bone_bone.png",
})


minetest.register_craft({
	output = 'bone:bonemeal 5',
	recipe = {{'bone:bone'}}
})

local n
local n2
local pos

function apple_leave()
	if math.random(0, 10) == 3 then
		return {name = "default:apple"}
	else
		return {name = "default:leaves"}
	end
end

function air_leave()
	if math.random(0, 50) == 3 then
		return {name = "air"}
	else
		return {name = "default:leaves"}
	end
end

function generate_tree(pos, trunk, leaves)
	pos.y = pos.y-1
	local nodename = minetest.get_node(pos).name
		
	pos.y = pos.y+1
	if not minetest.get_node_light(pos) then
		return
	end

	node = {name = ""}
	for dy=1,4 do
		pos.y = pos.y+dy
		if minetest.get_node(pos).name ~= "air" then
			return
		end
		pos.y = pos.y-dy
	end
	node = {name = "default:tree"}
	for dy=0,4 do
		pos.y = pos.y+dy
		minetest.set_node(pos, node)
		pos.y = pos.y-dy
	end

	node = {name = "default:leaves"}
	pos.y = pos.y+3
	local rarity = 0
	if math.random(0, 10) == 3 then
		rarity = 1
	end
	for dx=-2,2 do
		for dz=-2,2 do
			for dy=0,3 do
				pos.x = pos.x+dx
				pos.y = pos.y+dy
				pos.z = pos.z+dz

				if dx == 0 and dz == 0 and dy==3 then
					if minetest.get_node(pos).name == "air" and math.random(1, 5) <= 4 then
						minetest.set_node(pos, node)
						if rarity == 1 then
							minetest.set_node(pos, apple_leave())
						else
							minetest.set_node(pos, air_leave())
						end
					end
				elseif dx == 0 and dz == 0 and dy==4 then
					if minetest.get_node(pos).name == "air" and math.random(1, 5) <= 4 then
						minetest.set_node(pos, node)
						if rarity == 1 then
							minetest.set_node(pos, apple_leave())
						else
							minetest.set_node(pos, air_leave())
						end
					end
				elseif math.abs(dx) ~= 2 and math.abs(dz) ~= 2 then
					if minetest.get_node(pos).name == "air" then
						minetest.set_node(pos, node)
						if rarity == 1 then
							minetest.set_node(pos, apple_leave())
						else
							minetest.set_node(pos, air_leave())
						end
					end
				else
					if math.abs(dx) ~= 2 or math.abs(dz) ~= 2 then
						if minetest.get_node(pos).name == "air" and math.random(1, 5) <= 4 then
							minetest.set_node(pos, node)
						if rarity == 1 then
							minetest.set_node(pos, apple_leave())
						else
							minetest.set_node(pos, air_leave())
						end
						end
					end
				end
				pos.x = pos.x-dx
				pos.y = pos.y-dy
				pos.z = pos.z-dz
			end
		end
	end
end

local plant_tab = {}
local rnd_max = 5
minetest.after(0.5, function()
	plant_tab[0] = "air"
	plant_tab[1] = "default:grass_1"
	plant_tab[2] = "default:grass_2"
	plant_tab[3] = "default:grass_3"
	plant_tab[4] = "default:grass_4"
	plant_tab[5] = "default:grass_5"

if minetest.get_modpath("flowers") ~= nil then
	rnd_max = 11
	plant_tab[6] = "flowers:dandelion_white"
	plant_tab[7] = "flowers:dandelion_yellow"
	plant_tab[8] = "flowers:geranium"
	plant_tab[9] = "flowers:rose"
	plant_tab[10] = "flowers:tulip"
	plant_tab[11] = "flowers:viola"
end

end)

local function duengen(pointed_thing)
pos = pointed_thing.under
n = minetest.get_node(pos)
if n.name == "" then return end
local stage = ""
if n.name == "default:sapling" then
	minetest.set_node(pos, {name="air"})
	generate_tree(pos, "default:tree", "default:leaves")
elseif string.find(n.name, "farming:wheat_") ~= nil then
	stage = string.sub(n.name, 15)
	if stage == "3" then
		minetest.set_node(pos, {name="farming:wheat"})
	elseif math.random(1,5) < 3 then
		minetest.set_node(pos, {name="farming:wheat"})
	else
		minetest.set_node(pos, {name="farming:wheat_"..math.random(2,3)})
	end
elseif string.find(n.name, "farming:cotton_") ~= nil then
	stage = tonumber(string.sub(n.name, 16))
	if stage == 1 then
		minetest.set_node(pos, {name="farming:cotton_"..math.random(stage,2)})
	else
		minetest.set_node(pos, {name="farming:cotton"})
	end
elseif string.find(n.name, "farming:pumpkin_") ~= nil then
	stage = tonumber(string.sub(n.name, 17))
	if stage == 1 then
		minetest.set_node(pos, {name="farming:pumpkin_"..math.random(stage,2)})
	else
		minetest.set_node(pos, {name="farming:pumpkin"})
	end
	
elseif n.name == "default:dirt_with_grass" then
	for i = -2, 3, 1 do
		for j = -3, 2, 1 do
			pos = pointed_thing.above
			pos = {x=pos.x+i, y=pos.y, z=pos.z+j}
			n = minetest.get_node(pos)
			n2 = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})

			if n.name ~= ""  and n.name == "air" and n2.name == "default:dirt_with_grass" then
				if math.random(0,5) > 3 then
					minetest.set_node(pos, {name=plant_tab[math.random(0, rnd_max)]})
				else
					minetest.set_node(pos, {name=plant_tab[math.random(0, 5)]})
				end
				
				
			end
		end
	end
end
end


minetest.register_craftitem("bone:bonemeal", {
	description = "Bone Meal",
	inventory_image = "bone_bonemeal.png",
	liquids_pointable = false,
	stack_max = 99,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
			duengen(pointed_thing)
			itemstack:take_item()
			return itemstack
		end
	end,

})
