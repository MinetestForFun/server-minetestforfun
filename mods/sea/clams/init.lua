-- NODES

minetest.register_node("clams:sandalgae", {
	description = "Sandalgae",
	tiles = {"default_sand.png^clams_algae.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1},
	drop = {
		items = {
			{
				items = {'"clams:collectedalgae" 4'},
			},
			{
				items = {'clams:sandalgaeused'},
			}
		}
	},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("clams:dirtalgae", {
	description = "Dirtalgae",
	tiles = {"default_dirt.png^clams_algae.png"},
	paramtype = "light",
	is_ground_content = true,
	groups = {crumbly=3},
	drop = {
		items = {
			{
				items = {'"clams:collectedalgae" 4'},
			},
			{
				items = {'clams:dirtalgaeused'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults,	
})

minetest.register_node("clams:sandalgaeused", {
	description = "Used sandalgae",
	tiles = {"default_sand.png^clams_algaeused.png"},
	inventory_image = {"default_sand.png^clams_algaeused.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("clams:dirtalgaeused", {
	description = "Used dirtalgae",
	tiles = {"default_dirt.png^clams_algaeused.png"},
	inventory_image = {"default_dirt.png^clams_algaeused.png"},
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults(),
})


-- ENTITIES


-- The registration of the entities' code is copied from celeron55's mob (the DM's fireball)


minetest.register_entity("clams:whiteshell", {
	description="White shell",
	hp_max = 15,
	physical = true,
	collisionbox = {-0.2,-0.2,-0.2, 0.2,0.2,0.2},
	visual = "sprite",
	visual_size = {x=0.5, y=0.5},
	textures = {"clams_whiteshell.png^[makealpha:128,128,0"},
	spritediv = {x=1, y=3},
	initial_sprite_basepos = {x=0, y=0},
	drops = {
		{name = "clams:crushedwhite", chance = 1, min = 1, max = 4},
	},

	phase = 0,
	phasetimer = 0,

	on_activate = function(self, staticdata)
		minetest.log("whiteshell activated!")
	end,

	on_step = function(self, dtime)
		self.phasetimer = self.phasetimer + dtime
		if self.phasetimer > 2.0 then
			self.phasetimer = self.phasetimer - 2.0
			self.phase = self.phase + 1
			if self.phase >= 3 then
				self.phase = 0
			end
			self.object:setsprite({x=0, y=self.phase})
			phasearmor = {
				[0]={fleshy=0},
				[1]={fleshy=30},
				[2]={fleshy=70}
			}
			self.object:set_armor_groups(phasearmor[self.phase])
		end
	end,

	on_punch = function(self, hitter)
			if self.object:get_hp() <= 0 then
				if hitter and hitter:is_player() and hitter:get_inventory() then
					for _,drop in ipairs(self.drops) do
						if math.random(1, drop.chance) == 1 then
							hitter:get_inventory():add_item("main", ItemStack(drop.name.." "..math.random(drop.min, drop.max)))
						end
					end
				else
					for _,drop in ipairs(self.drops) do
						if math.random(1, drop.chance) == 1 then
							for i=1,math.random(drop.min, drop.max) do
								local obj = minetest.add_item(self.object:getpos(), drop.name)
								if obj then
									obj:get_luaentity().collect = true
									local x = math.random(1, 5)
									if math.random(1,2) == 1 then
										x = -x
									end
									local z = math.random(1, 5)
									if math.random(1,2) == 1 then
										z = -z
									end
									obj:setvelocity({x=1/x, y=obj:getvelocity().y, z=1/z})
								end
							end
						end
					end
				end
			end
		end,
})


-- CRAFT ITEMS


minetest.register_craftitem("clams:collectedalgae", {
	description = "Collected algae",
	inventory_image = "clams_collectedalgae.png",
})

minetest.register_craftitem("clams:crushedwhite", {
	description = "Crushed white shell",
	inventory_image = "clams_crushedwhite.png",
})


-- ALGAE GENERATION


minetest.register_ore({
	ore_type       = "scatter",
	ore            = "clams:sandalgae",
	wherein        = "default:sand",
	clust_scarcity = 9*9*9,
	clust_num_ores = 16,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -60,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "clams:dirtalgae",
	wherein        = "default:dirt",
	clust_scarcity = 9*9*9,
	clust_num_ores = 16,
	clust_size     = 4,
	height_max     = -4,
	height_min     = -60,
})


local function generate_ore(name, wherein, minp, maxp, seed, chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	if chunk_size >= y_max - y_min + 1 then
		return
	end
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.get_node(p2).name == wherein then
						minetest.set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
end


--ABM's


minetest.register_abm({
	nodenames = {"clams:sandalgaeused"},
	interval = 30,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local y = {x = pos.x, y = pos.y + 1, z = pos.z }
		local yy = {x = pos.x, y = pos.y + 2, z = pos.z }
		if minetest.get_node(y).name == "default:water_source" or
			minetest.get_node(y).name == "noairblocks:water_sourcex" then 
			if minetest.get_node(yy).name == "default:water_source" or
				minetest.get_node(yy).name == "noairblocks:water_sourcex" then
				minetest.add_node(pos, {name = "clams:sandalgae"}) else
				return
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"clams:dirtalgaeused"},
	interval = 30,
	chance = 20,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local y = {x = pos.x, y = pos.y + 1, z = pos.z }
		local yy = {x = pos.x, y = pos.y + 2, z = pos.z }
		if minetest.get_node(y).name == "default:water_source" or
			minetest.get_node(y).name == "noairblocks:water_sourcex" then 
			if minetest.get_node(yy).name == "default:water_source" or
				minetest.get_node(yy).name == "noairblocks:water_sourcex" then
				minetest.add_node(pos, {name = "clams:dirtalgae"}) else
				return
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"clams:sandalgae"},
	interval = 40,
	chance = 40,
	action = function(pos, node, active_object_count, active_object_count_wider)
	local y = {x = pos.x, y = pos.y + 1, z = pos.z }
	local yy = {x = pos.x, y = pos.y + 2, z = pos.z }
		if (active_object_count_wider + active_object_count_wider) > 40 then
		return
			elseif (minetest.get_node(y).name == "default:water_source" or
			minetest.get_node(y).name == "noairblocks:water_sourcex") then 
			if (minetest.get_node(yy).name == "default:water_source" or
				minetest.get_node(yy).name == "noairblocks:water_sourcex") then
				pos.y=pos.y + 1
				minetest.add_entity(pos, "clams:whiteshell")
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"clams:dirtalgae"},
	interval = 40,
	chance = 40,
	action = function(pos, node, active_object_count, active_object_count_wider)
	local y = {x = pos.x, y = pos.y + 1, z = pos.z }
	local yy = {x = pos.x, y = pos.y + 2, z = pos.z }
		if (active_object_count_wider + active_object_count_wider) > 40 then
		return
			elseif (minetest.get_node(y).name == "default:water_source" or
			minetest.get_node(y).name == "noairblocks:water_sourcex") then 
			if (minetest.get_node(yy).name == "default:water_source" or
				minetest.get_node(yy).name == "noairblocks:water_sourcex") then
				pos.y=pos.y + 1
				minetest.add_entity(pos, "clams:whiteshell")
			end
		end
	end,
})


-- ALIASES


minetest.register_alias("clams:yellowalgae","clams:collectedalgae")
minetest.register_alias("clams:redalgae","clams:collectedalgae")
minetest.register_alias("clams:bluealgae","clams:collectedalgae")

minetest.register_alias("clams:yellowshell","clams:whiteshell")
minetest.register_alias("clams:redshell","clams:whiteshell")
minetest.register_alias("clams:blueshell","clams:whiteshell")

minetest.register_alias("clams:yellowseedsanddirt","clams:sandalgae")
minetest.register_alias("clams:redseedsanddirt","clams:dirtalgae")
minetest.register_alias("clams:blueseedsanddirt","clams:sandalgae")

minetest.register_alias("clams:yellowseed","clams:collectedalgae")
minetest.register_alias("clams:redseed","clams:collectedalgae")
minetest.register_alias("clams:blueseed","clams:collectedalgae")

minetest.register_alias("clams:sanddirt","clams:sandalgaeused")
minetest.register_alias("clams:sanddirtalgae","clams:dirtalgae")
minetest.register_alias("clams:sanddirtused","clams:dirtalgaeused")

minetest.register_alias("clams:sandbalgae","clams:sandalgae")
minetest.register_alias("clams:dirtbalgae","clams:dirtalgae")

minetest.register_alias("clams:crushedyellow","clams:crushedwhite")
minetest.register_alias("clams:crushedred","clams:crushedwhite")
minetest.register_alias("clams:crushedblue","clams:crushedwhite")
minetest.register_alias("clams:crushedblack","clams:crushedwhite")

minetest.register_alias("clams:emptybleacher","colormachine:colormachine")
minetest.register_alias("clams:filledbleacher","colormachine:colormachine")
minetest.register_alias("clams:readybleacher","colormachine:colormachine")

if( minetest.get_modpath( "colormachine") ~= nil ) then
	minetest.register_alias("clams:emptybleacher","colormachine:colormachine")
	minetest.register_alias("clams:filledbleacher","colormachine:colormachine")
	minetest.register_alias("clams:readybleacher","colormachine:colormachine") else
		minetest.register_alias("clams:emptybleacher","default:mese")
		minetest.register_alias("clams:filledbleacher","default:mese")
		minetest.register_alias("clams:readybleacher","default:mese")
	return
end


-- ALIASES OLDEST VERSION


minetest.register_alias("algae:yellowalgae","clams:collectedalgae")
minetest.register_alias("algae:redalgae","clams:collectedalgae")
minetest.register_alias("algae:bluealgae","clams:collectedalgae")

minetest.register_alias("algae:sandalgae","clams:sandalgae")
minetest.register_alias("algae:dirtalgae","clams:dirtalgae")
minetest.register_alias("algae:sandbalgae","clams:sandalgae")
minetest.register_alias("algae:dirtbalgae","clams:dirtalgae")

minetest.register_alias("sea_cult:emptybleacher","colormachine:colormachine")
minetest.register_alias("sea_cult:filledbleacher","colormachine:colormachine")
minetest.register_alias("sea_cult:readybleacher","colormachine:colormachine")

if( minetest.get_modpath( "colormachine") ~= nil ) then
	minetest.register_alias("sea_cult:emptybleacher","colormachine:colormachine")
	minetest.register_alias("sea_cult:filledbleacher","colormachine:colormachine")
	minetest.register_alias("sea_cult:readybleacher","colormachine:colormachine") else
		minetest.register_alias("sea_cult:emptybleacher","default:mese")
		minetest.register_alias("sea_cult:filledbleacher","default:mese")
		minetest.register_alias("sea_cult:readybleacher","default:mese")
	return
end

minetest.register_alias("sea_cult:sanddirt","clams:sandalgaeused")
minetest.register_alias("sea_cult:sanddirtalgae","clams:dirtalgae")
minetest.register_alias("sea_cult:sanddirtused","clams:dirtalgaeused")

minetest.register_alias("shells:yellowshell","clams:whiteshell")
minetest.register_alias("shells:redshell","clams:whiteshell")
minetest.register_alias("shells:blueshell","clams:whiteshell")

minetest.register_alias("shells:yellowseed","clams:collectedalgae")
minetest.register_alias("shells:redseed","clams:collectedalgae")
minetest.register_alias("shells:blueseed","clams:collectedalgae")

minetest.register_alias("shells:crushedyellow","clams:crushedwhite")
minetest.register_alias("shells:crushedred","clams:crushedwhite")
minetest.register_alias("shells:crushedblue","clams:crushedwhite")
minetest.register_alias("shells:crushedblack","clams:crushedwhite")
minetest.register_alias("shells:crushedwhite","clams:crushedwhite")

minetest.register_alias("shells_dye:yellowlightglass","clams:yellowlightglass")
minetest.register_alias("shells_dye:redlightglass","clams:redlightglass")
minetest.register_alias("shells_dye:bluelightglass","clams:bluelightglass")
minetest.register_alias("shells_dye:whitelightglass","clams:whitelightglass")
minetest.register_alias("shells_dye:blacklightglass","clams:blacklightglass")