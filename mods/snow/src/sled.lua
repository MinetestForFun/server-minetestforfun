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

* find out why the sled disappears after rightclicking it ~ HybridDog

--]]



--=============================================================
-- CODE STUFF
--=============================================================

--
-- Helper functions
--

vector.zero = vector.zero or {x=0, y=0, z=0}

local function table_find(t, v)
	for i = 1,#t do
		if t[i] == v then
			return true
		end
	end
	return false
end

local function is_water(pos)
	return minetest.get_item_group(minetest.get_node(pos).name, "water") ~= 0
end


--
-- Sled entity
--

local sled = {
	physical = true,
	collisionbox = {-0.6,-0.25,-0.6, 0.6,0.3,0.6},
	visual = "mesh",
	mesh = "sled.x",
	textures = {"sled.png"},
}

local players_sled = {}
local function join_sled(self, player)
	local pos = self.object:getpos()
	player:setpos(pos)
	local name = player:get_player_name()
	players_sled[name] = true
	default.player_attached[name] = true
	default.player_set_animation(player, "sit" , 30)
	self.driver = name
	self.object:set_attach(player, "", {x=0,y=-9,z=0}, {x=0,y=90,z=0})
	self.object:setyaw(player:get_look_yaw())-- - math.pi/2)
end

local function leave_sled(self, player)
	local name = player:get_player_name()
	players_sled[name] = false
	self.driver = nil
	player:set_detach()
	default.player_attached[name] = false
	default.player_set_animation(player, "stand" , 30)
	
	player:set_physics_override({
		speed = 1,
		jump = 1,
	})
	player:hud_remove(self.HUD) -- And here is part 2. ~ LazyJ
	self.object:remove()
	
	--Give the sled back again
	player:get_inventory():add_item("main", "snow:sled")
end

function sled:on_rightclick(player)
	if self.driver
	or not snow.sleds then
		return
	end
	join_sled(self, player)
	player:set_physics_override({
		speed = 2, -- multiplier to default value
		jump = 0, -- multiplier to default value
	})

-- Here is part 1 of the fix. ~ LazyJ
	self.HUD = player:hud_add({
		hud_elem_type = "text",
		position = {x=0.5, y=0.89},
		name = "sled",
		scale = {x=2, y=2},
		text = "You are on the sled! Press the sneak key to get off the sled.", -- LazyJ
		direction = 0,
	})
-- End part 1
end

function sled:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	self.object:setacceleration({x=0, y=-10, z=0})
	if staticdata then
		self.v = tonumber(staticdata)
	end
end

function sled:get_staticdata()
	return tostring(self.v)
end

function sled:on_punch(puncher)
	self.object:remove()
	if puncher
	and puncher:is_player() then
		puncher:get_inventory():add_item("main", "snow:sled")
	end
end

local driveable_nodes = {"default:snow","default:snowblock","default:ice","default:dirt_with_snow", "group:icemaker"}
local function accelerating_possible(pos)
	if is_water(pos) then
		return false
	end
	if table_find(driveable_nodes, minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name) then
		return true
	end
	return false
end

local timer = 0
function sled:on_step(dtime)
	if not self.driver then
		return
	end
	timer = timer+dtime
	if timer < 1 then
		return
	end
	timer = 0
	local player = minetest.get_player_by_name(self.driver)
	if not player then
		return
	end
	if player:get_player_control().sneak
	or not accelerating_possible(vector.round(self.object:getpos())) then
		leave_sled(self, player)
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
		if players_sled[placer:get_player_name()] then
			return
		end
		local pos = placer:getpos()
		if accelerating_possible(vector.round(pos)) then
			pos.y = pos.y+0.5
			
			--Get on the sled and remove it from inventory.
			minetest.add_entity(pos, "snow:sled"):right_click(placer)
			itemstack:take_item(); return itemstack
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
