--[[
--=================
--======================================
LazyJ's Fork of Splizard's "Snow" Mod
by LazyJ
version: Umpteen and 7/5ths something or another.
2014_04_12
--======================================
--=================


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
THE LIST OF CHANGES I'VE MADE
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



* The HUD message that displayed when a player sat on the sled would not go away after the player 
got off the sled. I spent hours on trial-and-error while reading the lua_api.txt and scrounging 
the Internet for a needle-in-the-haystack solution as to why the hud_remove wasn't working. 
Turns out Splizard's code was mostly correct, just not assembled in the right order.

The key to the solution was found in the code of leetelate's scuba mod:
http://forum.minetest.net/viewtopic.php?id=7175

* Changed the wording of the HUD message for clarity.


~~~~~~
TODO
~~~~~~

* Figure out why the player avatars remain in a seated position, even after getting off the sled, 
if they flew while on the sled. 'default.player_set_animation', where is a better explanation 
for this and what are it's available options?

* Go through, clean-up my notes and get them better sorted. Some are in the code, some are 
scattered in my note-taking program. This "Oh, I'll just make a little tweak here and a 
little tweak there" project has evolved into something much bigger and more complex 
than I originally planned. :p  ~ LazyJ


--]]



--=============================================================
-- CODE STUFF
--=============================================================

--
-- Helper functions
--

local function is_water(pos)
	local nn = minetest.env:get_node(pos).name
	return minetest.get_item_group(nn, "water") ~= 0
end


--
-- Sled entity
--

local sled = {
	physical = false,
	collisionbox = {-0.6,-0.25,-0.6, 0.6,0.3,0.6},
	visual = "mesh",
	mesh = "sled.x",
	textures = {"sled.png"},
	HUD,
	
	driver = nil,
	sliding = false,
}

local players_sled = {}

function sled:on_rightclick(clicker)
	if (not self.driver) and snow.sleds then
		players_sled[clicker:get_player_name()] = true
		self.driver = clicker
		self.object:set_attach(clicker, "", {x=0,y=-9,z=0}, {x=0,y=90,z=0})
		clicker:set_physics_override({
			speed = 2, -- multiplier to default value
			jump = 0, -- multiplier to default value
			gravity = 1
		  })
--[[
		local HUD = 
			{
				hud_elem_type = "text", -- see HUD element types
				position = {x=0.5, y=0.89},
				name = "sled",
				scale = {x=2, y=2},
				text = "You are sledding, hold sneak to stop.",
				direction = 0,
			}
			
		clicker:hud_add(HUD)
--]]

-- Here is part 1 of the fix. ~ LazyJ
		self.HUD = clicker:hud_add({
				hud_elem_type = "text",
				position = {x=0.5, y=0.89},
				name = "sled",
				scale = {x=2, y=2},
				text = "You are on the sled! Press the sneak key to get off the sled.", -- LazyJ
				direction = 0,
			})
-- End part 1	
 	end
end

function sled:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function sled:get_staticdata()
	return tostring(v)
end

function sled:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	self.object:remove()
	if puncher and puncher:is_player() then
		puncher:get_inventory():add_item("main", "snow:sled")
	end
end


minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		if players_sled[player:get_player_name()] then
			default.player_set_animation(player, "sit", 0)
		end
	end
end)

function sled:on_step(dtime)
	if self.driver then
		local p = self.object:getpos()
		p.y = p.y+0.4
		local s = self.object:getpos()
		s.y = s.y -0.5
		local keys = self.driver:get_player_control()
		if keys["sneak"] or is_water(p) or (not minetest.find_node_near(s, 1, {"default:snow","default:snowblock","default:ice","default:dirt_with_snow", "group:icemaker"})) then  -- LazyJ
			self.driver:set_physics_override({
				speed = 1, -- multiplier to default value
				jump = 1, -- multiplier to default value
				gravity = 1
		  	})

			players_sled[self.driver:get_player_name()] = false
			self.object:set_detach()
			--self.driver:hud_remove("sled")
			self.driver:hud_remove(self.HUD) -- And here is part 2. ~ LazyJ
			self.driver = nil
			self.object:remove()

		end
	end
end

minetest.register_entity("snow:sled", sled)


minetest.register_craftitem("snow:sled", {
	description = "Sled",
	inventory_image = "snow_sled.png",
	wield_image = "snow_sled.png",
	wield_scale = {x=2, y=2, z=1},
	liquids_pointable = true,
	stack_max = 1,
	
 	on_use = function(itemstack, placer)
 		local pos = {x=0,y=-1000, z=0}
 		local name = placer:get_player_name()
 		local player_pos = placer:getpos()
 		if not players_sled[name] then
 			if minetest.get_node({x=player_pos.x,y=player_pos.y, z=player_pos.z}).name == "default:snow" then
				local sled = minetest.env:add_entity(pos, "snow:sled")
				sled:get_luaentity():on_rightclick(placer)
			end
		end
	end,
})

minetest.register_craft({
	output = "snow:sled",
	recipe = {
		{"", "", ""},
		{"group:stick", "", ""},
		{"group:wood", "group:wood", "group:wood"},
	},
})
minetest.register_craft({
	output = "snow:sled",
	recipe = {
		{"", "", ""},
		{"", "", "group:stick"},
		{"group:wood", "group:wood", "group:wood"},
	},
})
