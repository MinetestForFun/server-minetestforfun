-----------------------------------------------------------------------------------------------
-- Fishing - Mossmanikin's version - Bobber 0.1.7
-- License (code & textures): 	WTFPL
-- Contains code from: 		fishing (original), mobs, throwing, volcano
-- Supports:				3d_armor, animal_clownfish, animal_fish_blue_white, animal_rat, flowers_plus, mobs, seaplants
-----------------------------------------------------------------------------------------------

local PoLeWeaR = (65535/(30-(math.random(15, 29))))
local BooTSWear = (2000*(math.random(20, 29)))
-- Here's what you can catch
local CaTCH = {
--	  MoD 						 iTeM				WeaR		 MeSSaGe ("You caught "..)	GeTBaiTBack		NRMiN  	CHaNCe (../120)
    {"fishing",  				"fish_raw",			0,			"a Fish.",					false,			1,		60},
	{"animal_clownfish",		"clownfish",		0,			"a Clownfish.",				false,			61,		10},
	{"animal_fish_blue_white",	"fish_blue_white",	0,			"a Blue white fish.",		false,			71,		10},
	{"default",					"stick",			0,			"a Twig.",					true,			81,		2},
	{"mobs",					"rat",				0,			"a Rat.",					false,			83,		1},
    {"animal_rat",				"rat",				0,			"a Rat.",					false,			84,		1},
	{"",						"rat",				0,			"a Rat.",					false,			85,		1},
	{"flowers_plus",			"seaweed",			0,			"some Seaweed.",			true,			86,		20},
	{"seaplants",				"kelpgreen",		0,			"a Green Kelp.",			true,			106,	10},
	{"farming",					"string",			0,			"a String.",				true,			116,	2},
	{"fishing",					"pole",				PoLeWeaR,	"an old Fishing Pole.",		true,			118,	2},
	{"3d_armor",				"boots_wood",		BooTSWear,	"some very old Boots.",		true,			120,	1},
	{"trunks",					"twig_1",			0,			"a Twig.",					true,			121,	2},
}
minetest.register_alias("flowers_plus:seaweed", "flowers:seaweed") -- exception

local PLaNTS = {
 --	  MoD* 			iTeM				MeSSaGe ("You caught "..)
	{"flowers",		"waterlily",		"a Waterlily." }, 
	{"flowers",		"waterlily_225",	"a Waterlily." }, 
	{"flowers",		"waterlily_45",		"a Waterlily." }, 
	{"flowers",		"waterlily_675",	"a Waterlily." }, 
	{"flowers",		"waterlily_s1",		"a Waterlily." }, 
	{"flowers",		"waterlily_s2",		"a Waterlily." }, 
	{"flowers",		"waterlily_s3",		"a Waterlily." }, 
	{"flowers",		"waterlily_s4",		"a Waterlily." },
	{"flowers",		"seaweed",			"some Seaweed."}, 
	{"flowers",		"seaweed_2",		"some Seaweed."}, 
	{"flowers",		"seaweed_3",		"some Seaweed."}, 
	{"flowers",		"seaweed_4",		"some Seaweed."},
	{"trunks",		"twig_1",			"a Twig."	   },
	{"trunks",		"twig_2",			"a Twig."	   },
	{"trunks",		"twig_3",			"a Twig."	   },
	{"trunks",		"twig_4",			"a Twig."	   },
	{"trunks",		"twig_5",			"a Twig."	   },
	{"trunks",		"twig_7",			"a Twig."	   },
	{"trunks",		"twig_8",			"a Twig."	   },
	{"trunks",		"twig_9",			"a Twig."	   },
	{"trunks",		"twig_10",			"a Twig."	   },
	{"trunks",		"twig_11",			"a Twig."	   },
	{"trunks",		"twig_12",			"a Twig."	   },
	{"trunks",		"twig_13",			"a Twig."	   },
}
-- *as used in the node name

local MoBS = { -- not in use
 --	  iTeM										 MeSSaGe ("You caught "..)
	{"animal_clownfish:clownfish",				"a Clownfish."		},
	{"animal_fish_blue_white:fish_blue_white",	"a Blue white fish."},
}

minetest.register_node("fishing:bobber_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
--			{ left, bottom, front,  right, top ,  back}
			{-8/16, -8/16,     0,  8/16,  8/16,     0}, -- feathers
			{-2/16, -8/16, -2/16,  2/16, -4/16,  2/16},	-- bobber
		}
	},
	tiles = {
		"fishing_bobber_top.png",
		"fishing_bobber_bottom.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png^[transformFX"
	}, -- 
	groups = {not_in_creative_inventory=1},
})

local FISHING_BOBBER_ENTITY={
	hp_max = 605,
	water_damage = 1,
	physical = true,
	timer = 0,
	env_damage_timer = 0,
	visual = "wielditem",
	visual_size = {x=1/3, y=1/3, z=1/3},
	textures = {"fishing:bobber_box"},
	--			   {left ,bottom, front, right,  top ,  back}
	collisionbox = {-2/16, -4/16, -2/16,  2/16, 0/16,  2/16},
	view_range = 7,
--	DESTROY BOBBER WHEN PUNCHING IT
	on_punch = function (self, puncher, time_from_last_punch, tool_capabilities, dir)
		local player = puncher:get_player_name()
		local inv = puncher:get_inventory()
		if MESSAGES == true then minetest.chat_send_player(player, "You didn't catch anything.", false) end -- fish escaped
		if not minetest.setting_getbool("creative_mode") then
			if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
				inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
				if MESSAGES == true then minetest.chat_send_player(player, "The bait is still there.", false) end -- bait still there
			end
		end
		-- make sound and remove bobber
		minetest.sound_play("fishing_bobber1", {
			pos = self.object:getpos(),
			gain = 0.5,
		})
		self.object:remove()
	end,
--	WHEN RIGHTCLICKING THE BOBBER THE FOLLOWING HAPPENS	(CLICK AT THE RIGHT TIME WHILE HOLDING A FISHING POLE)	
	on_rightclick = function (self, clicker)
		local item = clicker:get_wielded_item()
		local player = clicker:get_player_name()
		if item:get_name() == "fishing:pole" then
			local inv = clicker:get_inventory()
			local say = minetest.chat_send_player
			local pos = self.object:getpos()
			-- catch visible plant
			if minetest.get_node(pos).name ~= "air" then
				for i in ipairs(PLaNTS) do
					local PLaNT = PLaNTS[i][1]..":"..PLaNTS[i][2]
					local MeSSaGe = PLaNTS[i][3]
					local DRoP = minetest.registered_nodes[PLaNT].drop
					if minetest.get_node(pos).name == PLaNT then
						minetest.add_node({x=pos.x, y=pos.y, z=pos.z}, {name="air"})
						if inv:room_for_item("main", {name=DRoP, count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name=DRoP, count=1, wear=0, metadata=""})
							if MESSAGES == true then say(player, "You caught "..MeSSaGe, false) end -- caught Plant				
						end
						if not minetest.setting_getbool("creative_mode") then
							if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
								inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
								if MESSAGES == true then say(player, "The bait is still there.", false) end -- bait still there
							end
						end
					end
				end
			--end
			elseif minetest.get_node(pos).name == "air" then
			-- catch visible fish and invisible stuff
			if self.object:get_hp() <= 300 then
				if math.random(1, 100) < FISH_CHANCE then
					local 	chance = 		math.random(1, 122) -- ><((((º>
					for i in pairs(CaTCH) do
						local 	MoD = 			CaTCH[i][1]
						local 	iTeM = 			CaTCH[i][2]
						local 	WeaR = 			CaTCH[i][3]
						local 	MeSSaGe = 		CaTCH[i][4]
						local 	GeTBaiTBack = 	CaTCH[i][5]
						local 	NRMiN = 		CaTCH[i][6]
						local 	CHaNCe = 		CaTCH[i][7]
						local 	NRMaX = 		NRMiN + CHaNCe - 1
						if chance <= NRMaX and chance >= NRMiN then
							if minetest.get_modpath(MoD) ~= nil then
								-- remove visible fish, if there
								local find_fish = minetest.get_objects_inside_radius({x=pos.x,y=pos.y+0.5,z=pos.z}, 1)
								for k, obj in pairs(find_fish) do
									if obj:get_luaentity() ~= nil and obj:get_luaentity().name == "animal_fish_blue_white:fish_blue_white" then
										MoD = "animal_fish_blue_white"
										iTeM = "fish_blue_white"
										WeaR = 0
										MeSSaGe = "a Blue white fish."
										obj:remove()	
									end
								end
								-- add (in)visible fish to inventory
								if inv:room_for_item("main", {name=MoD..":"..iTeM, count=1, wear=WeaR, metadata=""}) then
									inv:add_item("main", {name=MoD..":"..iTeM, count=1, wear=WeaR, metadata=""})
									if MESSAGES == true then say(player, "You caught "..MeSSaGe, false) end -- caught somethin'	
								end
								if not minetest.setting_getbool("creative_mode") then
									if GeTBaiTBack == true then
										if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
											inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
											if MESSAGES == true then say(player, "The bait is still there.", false) end -- bait still there?
										end
									end
								end
							else
								if inv:room_for_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""}) then
									inv:add_item("main", {name="fishing:fish_raw", count=1, wear=0, metadata=""})
									if MESSAGES == true then say(player, "You caught a Fish.", false) end -- caught Fish
								end
							end
						end
					end
				else --if math.random(1, 100) > FISH_CHANCE then
					if MESSAGES == true then say(player, "Your fish escaped.", false) end -- fish escaped
				end
			end
			if self.object:get_hp() > 300 and minetest.get_node(pos).name == "air" then
				if MESSAGES == true then say(player, "You didn't catch anything.", false) end -- fish escaped
				if not minetest.setting_getbool("creative_mode") then
					if math.random(1, 2) == 1 then
						if inv:room_for_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""}) then
							inv:add_item("main", {name="fishing:bait_worm", count=1, wear=0, metadata=""})
							if MESSAGES == true then say(player, "The bait is still there.", false) end -- bait still there
						end	
					end
				end
			end
			end
		end 
		-- weither player has fishing pole or not
		-- make sound and remove bobber
		minetest.sound_play("fishing_bobber1", {
			pos = self.object:getpos(),
			gain = 0.5,
		})
		self.object:remove()
	end,
-- AS SOON AS THE BOBBER IS PLACED IT WILL ACT LIKE
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		if BOBBER_CHECK_RADIUS > 0 then
			local objs = minetest.get_objects_inside_radius(pos, BOBBER_CHECK_RADIUS)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name == "fishing:bobber_entity" then
						if obj:get_luaentity() ~= self then
							self.object:remove()
						end
					end
				end
			end
		end
		
		if math.random(1, 4) == 1 then
			self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/2880*math.pi))
		end
		for _,player in pairs(minetest.get_connected_players()) do
			local s = self.object:getpos()
			local p = player:getpos()
			local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
			if dist > self.view_range then
				-- make sound and remove bobber
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				self.object:remove()
			end
		end
		
		if self.object:get_hp() > 310 then
			local find_fish = minetest.get_objects_inside_radius({x=pos.x,y=pos.y+0.5,z=pos.z}, 1)
			for k, obj in pairs(find_fish) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name == "animal_fish_blue_white:fish_blue_white" then
						if math.random(1, 30) == 1 then
							self.object:set_hp(310)
						end
					end
				end
			end
		end
		
		
		local do_env_damage = function(self)
			self.object:set_hp(self.object:get_hp()-self.water_damage)
			if self.object:get_hp() == 600 then
				self.object:moveto({x=pos.x,y=pos.y-0.015625,z=pos.z})
			elseif self.object:get_hp() == 595 then
				self.object:moveto({x=pos.x,y=pos.y+0.015625,z=pos.z})
			elseif self.object:get_hp() == 590 then
				self.object:moveto({x=pos.x,y=pos.y+0.015625,z=pos.z})
			elseif self.object:get_hp() == 585 then
				self.object:moveto({x=pos.x,y=pos.y-0.015625,z=pos.z})
				self.object:set_hp(self.object:get_hp()-(math.random(1, 275)))
			elseif self.object:get_hp() == 300 then
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				minetest.add_particlespawner(30, 0.5,   -- for how long (?)             -- Particles on splash
					{x=pos.x,y=pos.y-0.0625,z=pos.z}, {x=pos.x,y=pos.y,z=pos.z}, -- position min, pos max
					{x=-2,y=-0.0625,z=-2}, {x=2,y=3,z=2}, -- velocity min, vel max
					{x=0,y=-9.8,z=0}, {x=0,y=-9.8,z=0},
					0.3, 1.2,
					0.25, 0.5,  -- min size, max size
					false, "default_snow.png")
				self.object:moveto({x=pos.x,y=pos.y-0.0625,z=pos.z})
			elseif self.object:get_hp() == 295 then
				self.object:moveto({x=pos.x,y=pos.y+0.0625,z=pos.z})
			elseif self.object:get_hp() == 290 then
				self.object:moveto({x=pos.x,y=pos.y+0.0625,z=pos.z})
			elseif self.object:get_hp() == 285 then
				self.object:moveto({x=pos.x,y=pos.y-0.1,z=pos.z})
			elseif self.object:get_hp() < 284 then	
				self.object:moveto({x=pos.x+(0.001*(math.random(-8, 8))),y=pos.y,z=pos.z+(0.001*(math.random(-8, 8)))})
				self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/1440*math.pi))
			elseif self.object:get_hp() == 0 then
				-- make sound and remove bobber
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				self.object:remove()
			end
		end
		do_env_damage(self)
	end,
}

minetest.register_entity("fishing:bobber_entity", FISHING_BOBBER_ENTITY)