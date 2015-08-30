--============
--Snowballs
--============

-- Snowballs were destroying nodes if the snowballs landed just right.
-- Quite a bit of trial-and-error learning here and it boiled down to a
-- small handful of code lines making the difference. ~ LazyJ

local creative_mode = minetest.setting_getbool("creative_mode")

local function get_gravity()
	local grav = tonumber(minetest.setting_get("movement_gravity")) or 9.81
	return grav*snow.snowball_gravity
end

local someone_throwing
local timer = 0

--Shoot snowball
local function snow_shoot_snowball(item, player)
	local addp = {y = 1.625} -- + (math.random()-0.5)/5}
	local dir = player:get_look_dir()
	local dif = 2*math.sqrt(dir.z*dir.z+dir.x*dir.x)
	addp.x = dir.z/dif -- + (math.random()-0.5)/5
	addp.z = -dir.x/dif -- + (math.random()-0.5)/5
	local pos = vector.add(player:getpos(), addp)
	local obj = minetest.add_entity(pos, "snow:snowball_entity")
	obj:setvelocity(vector.multiply(dir, snow.snowball_velocity))
	obj:setacceleration({x=dir.x*-3, y=-get_gravity(), z=dir.z*-3})
	if creative_mode then
		if not someone_throwing then
			someone_throwing = true
			timer = -0.5
		end
		return
	end
	item:take_item()
	return item
end

if creative_mode then
	local function update_step(dtime)
		timer = timer+dtime
		if timer < 0.006 then
			return
		end
		timer = 0

		local active
		for _,player in pairs(minetest.get_connected_players()) do
			if player:get_player_control().LMB then
				local item = player:get_wielded_item()
				local itemname = item:get_name()
				if itemname == "default:snow" then
					snow_shoot_snowball(nil, player)
					active = true
					break
				end
			end
		end

		-- disable the function if noone currently throws them
		if not active then
			someone_throwing = false
		end
	end

	-- do automatic throwing using a globalstep
	minetest.register_globalstep(function(dtime)
		-- only if one holds left click
		if someone_throwing then
			update_step(dtime)
		end
	end)
end

--The snowball Entity
local snow_snowball_ENTITY = {
	physical = false,
	timer = 0,
	collisionbox = {-5/16,-5/16,-5/16, 5/16,5/16,5/16},
}

function snow_snowball_ENTITY.on_activate(self)
	self.object:set_properties({textures = {"default_snowball.png^[transform"..math.random(0,7)}})
	self.object:setacceleration({x=0, y=-get_gravity(), z=0})
	self.lastpos = self.object:getpos()
	minetest.after(0.1, function(obj)
		if not obj then
			return
		end
		local vel = obj:getvelocity()
		if vel
		and vel.y ~= 0 then
			return
		end
		minetest.after(0, function(obj)
			if not obj then
				return
			end
			local vel = obj:getvelocity()
			if not vel
			or vel.y == 0 then
				obj:remove()
			end
		end, obj)
	end, self.object)
end

--Snowball_entity.on_step()--> called when snowball is moving.
function snow_snowball_ENTITY.on_step(self, dtime)
	self.timer = self.timer+dtime
	if self.timer > 600 then
		-- 10 minutes are too long for a snowball to fly somewhere
		self.object:remove()
	end

	if self.physical then
		local fell = self.object:getvelocity().y == 0
		if not fell then
			return
		end
		local pos = vector.round(self.object:getpos())
		if minetest.get_node(pos).name == "air" then
			pos.y = pos.y-1
			if minetest.get_node(pos).name == "air" then
				return
			end
		end
		snow.place(pos)
		self.object:remove()
		return
	end

	local pos = vector.round(self.object:getpos())
	if vector.equals(pos, self.lastpos) then
		return
	end
	if minetest.get_node(pos).name ~= "air" then
		self.object:setacceleration({x=0, y=-get_gravity(), z=0})
		--self.object:setvelocity({x=0, y=0, z=0})
		pos = self.lastpos
		self.object:setpos(pos)
		local gain = vector.length(self.object:getvelocity())/30
		minetest.sound_play("default_snow_footstep", {pos=pos, gain=gain})
		self.object:set_properties({physical = true})
		self.physical = true
		return
	end
	self.lastpos = vector.new(pos)
end



minetest.register_entity("snow:snowball_entity", snow_snowball_ENTITY)



-- Snowball and Default Snowball Merged

-- They both look the same, they do basically the same thing (except one is a leftclick throw
-- and the other is a rightclick drop),... Why not combine snow:snowball with default:snow and
-- benefit from both? ~ LazyJ, 2014_04_08

--[[ Save this for reference and occasionally compare to the default code for any updates.

minetest.register_node(":default:snow", {
	description = "Snow",
	tiles = {"default_snow.png"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	is_ground_content = true,
	paramtype = "light",
	buildable_to = true,
	leveled = 7,
	drawtype = "nodebox",
	freezemelt = "default:water_flowing",
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
		},
	},
	groups = {crumbly=3,falling_node=1, melts=1, float=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),
	on_construct = function(pos)
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:dirt_with_grass" or minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:dirt" then
			minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z}, {name="default:dirt_with_snow"})
		end
		-- Now, let's turn the snow pile into a snowblock. ~ LazyJ
		if minetest.get_node({x=pos.x, y=pos.y-2, z=pos.z}).name == "default:snow" and -- Minus 2 because at the end of this, the layer that triggers the change to a snowblock is the second layer more than a full block, starting into a second block (-2) ~ LazyJ, 2014_04_11
			minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:snow" then
			minetest.set_node({x=pos.x, y=pos.y-2, z=pos.z}, {name="default:snowblock"})
		end
	end,
	on_use = snow_shoot_snowball  -- This line is from the 'Snow' mod, the reset is default Minetest.
})
--]]



minetest.override_item("default:snow", {
	drop = {
		max_items = 2,
		items = {
			{items = {'snow:moss'}, rarity = 20,},
			{items = {'default:snow'},}
		}
	},
	leveled = 7,
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
		},
	},
	groups = {cracky=3, crumbly=3, choppy=3, oddly_breakable_by_hand=3, falling_node=1, melts=2, float=1},
	sunlight_propagates = true,
	--Disable placement prediction for snow.
 	node_placement_prediction = "",
	on_construct = function(pos)
		pos.y = pos.y-1
		local node = minetest.get_node(pos)
		if node.name == "default:dirt_with_grass"
		or node.name == "default:dirt" then
			node.name = "default:dirt_with_snow"
			minetest.set_node(pos, node)
		end
	end,
	--Handle node drops due to node level.
	on_dig = function(pos, node, digger)
		local level = minetest.get_node_level(pos)
		minetest.node_dig(pos, node, digger)
		if minetest.get_node(pos).name ~= node.name then
			local inv = digger:get_inventory()
			if not inv then
				return
			end
			local left = inv:add_item("main", "default:snow "..tostring(level/7-1))
			if not left:is_empty() then
				minetest.add_item({
					x = pos.x + math.random()/2-0.25,
					y = pos.y + math.random()/2-0.25,
					z = pos.z + math.random()/2-0.25,
				}, left)
			end
		end
	end,
	--Manage snow levels.
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local oldnode_under = minetest.get_node_or_nil(under)
		local above = pointed_thing.above

		if not oldnode_under
		or not above then
			return
		end

		local olddef_under = ItemStack({name=oldnode_under.name}):get_definition()
		olddef_under = olddef_under or minetest.nodedef_default

		local place_to
		-- If node under is buildable_to, place into it instead (eg. snow)
		if olddef_under.buildable_to then
			place_to = under
		else
			-- Place above pointed node
			place_to = above
		end

		local level = minetest.get_node_level(place_to)
		if level == 63 then
			minetest.set_node(place_to, {name="default:snowblock"})
		else
			minetest.set_node_level(place_to, level+7)
		end

		if minetest.get_node(place_to).name ~= "default:snow" then
			local itemstack, placed = minetest.item_place_node(itemstack, placer, pointed_thing)
			return itemstack, placed
		end

		itemstack:take_item()

		return itemstack
	end,
	on_use = snow_shoot_snowball
})



--[[
A note about default torches, melting, and "buildable_to = true" in default snow.

On servers where buckets are disabled, snow and ice stuff is used to set water for crops and
water stuff like fountains, pools, ponds, ect.. It is a common practice to set a default torch on
the snow placed where the players want water to be.

If you place a default torch *on* default snow to melt it, instead of melting the snow is
*replaced* by the torch. Using "buildable_to = false" would fix this but then the snow would no
longer pile-up in layers; the snow would stack like thin shelves in a vertical column.

I tinkered with the default torch's code (see below) to check for snow at the position and one
node above (layered snow logs as the next y position above) but default snow's
"buildable_to = true" always happened first. An interesting exercise to better learn how Minetest
works, but otherwise not worth it. If you set a regular torch near snow, the snow will melt
and disappear leaving you with nearly the same end result anyway. I say "nearly the same"
because if you set a default torch on layered snow, the torch will replace the snow and be
lit on the ground. If you were able to set a default torch *on* layered snow, the snow would
melt and the torch would become a dropped item.

~ LazyJ

--]]


-- Some of the ideas I tried. ~ LazyJ
--[[
local can_place_torch_on_top = function(pos)
			if minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:snow"
			or minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:snow" then
				minetest.override_item("default:snow", {buildable_to = false,})
			end
		end
--]]


--[[
minetest.override_item("default:torch", {
	--on_construct = function(pos)
	on_place = function(itemstack, placer, pointed_thing)
		--if minetest.get_node({x=pos.x, y=pos.y, z=pos.z}).name == "default:snow"
			-- Even though layered snow doesn't look like it's in the next position above (y+1)
			-- it registers in that position. Check the terminal's output to see the coord change.
		--or minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:snow"
		if pointed_thing.name == "default:snow"
		then minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="default:torch"})
		end
	end
})
--]]
