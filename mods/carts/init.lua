
carts = {}
carts.modpath = minetest.get_modpath("carts")

-- Maximal speed of the cart in m/s
carts.speed_max = minetest.setting_get("movement_speed_walk")*3*0.9
-- Minimal speed of the cart on brake rail
carts.brake_speed_min = minetest.setting_get("movement_speed_walk")/2
-- Set to nil to disable punching the cart from inside (min = -1)
carts.punch_speed_min = 7
-- 1 disable mesecons / 0 enable mesecons
carts.mesecon_disabled = 1


if not carts.modpath then
	error("\nWrong mod directory name! Please change it to 'carts'.\n" ..
			"See also: http://dev.minetest.net/Installing_Mods")
end

function vector.floor(v)
	return {
		x = math.floor(v.x),
		y = math.floor(v.y),
		z = math.floor(v.z)
	}
end

dofile(carts.modpath.."/functions.lua")
dofile(carts.modpath.."/rails.lua")

if not carts.mesecon_disabled and mesecon then
	dofile(carts.modpath.."/detector.lua")
end

-- Support for non-default games
if not default.player_attached then
	default.player_attached = {}
end

carts.cart = {
	physical = false,
	collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	visual = "mesh",
	mesh = "cart.x",
	visual_size = {x=1, y=1},
	textures = {"cart.png"},

	driver = nil,
	punched = false, -- used to re-send velocity and position
	velocity = {x=0, y=0, z=0}, -- only used on punch
	old_dir = {x=1, y=0, z=0}, -- random value to start the cart on punch
	old_pos = nil,
	old_switch = 0,
	railtype = nil,
	attached_items = {}
}

function carts.cart:on_rightclick(clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local player_name = clicker:get_player_name()
	if self.driver and player_name == self.driver then
		self.driver = nil
		carts:manage_attachment(clicker, false)
		self.object:setacceleration({x=0, y=0, z=0}) -- Stops the cart when we leave it
		self.object:setvelocity({x=0, y=0, z=0})
	elseif not self.driver then
		self.driver = player_name
		carts:manage_attachment(clicker, true, self.object)
	end
end

function carts.cart:on_activate(staticdata, dtime_s)
	self.object:set_armor_groups({immortal=1})
	if string.sub(staticdata, 1, string.len("return")) ~= "return" then
		return
	end
	local data = minetest.deserialize(staticdata)
	if not data or type(data) ~= "table" then
		return
	end
	self.railtype = data.railtype
	if data.old_dir then
		self.old_dir = data.old_dir
	end
end

function carts.cart:get_staticdata()
	return minetest.serialize({
		railtype = self.railtype,
		old_dir = self.old_dir
	})
end

function carts.cart:on_punch(puncher, time_from_last_punch, tool_capabilities, direction)
	local pos = self.object:getpos()
	if not self.railtype then
		local bar = vector.floor(vector.add(pos, 0.1))
		local node = minetest.get_node(bar).name
		self.railtype = minetest.get_item_group(node, "connect_to_raillike")
	end

	if not puncher or not puncher:is_player() then
		local cart_dir = carts:get_rail_direction(pos, self.old_dir, nil, nil, self.railtype)
		if vector.equals(cart_dir, {x=0, y=0, z=0}) then
			return
		end
		self.velocity = vector.multiply(cart_dir, 3)
		self.old_pos = nil
		self.punched = true
		return
	end

	if puncher:get_player_control().sneak then
		-- Pick up cart: Drop all attachments
		if self.driver then
			if self.old_pos then
				self.object:setpos(self.old_pos)
			end
			local player = minetest.get_player_by_name(self.driver)
			carts:manage_attachment(player, false)
		end
		for _,obj_ in ipairs(self.attached_items) do
			if obj_ then
				obj_:set_detach()
			end
		end

		local leftover = puncher:get_inventory():add_item("main", "carts:cart")
		if not leftover:is_empty() then
			minetest.add_item(self.object:getpos(), leftover)
		end
		self.object:remove()
		return
	end

	local vel = self.object:getvelocity()
	if puncher:get_player_name() == self.driver then
		if math.abs(vel.x + vel.z) > carts.punch_speed_min then
			return
		end
	--end --Only the driver can punch

	local punch_dir = carts:velocity_to_dir(puncher:get_look_dir())
	punch_dir.y = 0
	local cart_dir = carts:get_rail_direction(pos, punch_dir, nil, nil, self.railtype)
	if vector.equals(cart_dir, {x=0, y=0, z=0}) then
		return
	end

	local punch_interval = 1
	if tool_capabilities and tool_capabilities.full_punch_interval then
		punch_interval = tool_capabilities.full_punch_interval
	end
	time_from_last_punch = math.min(time_from_last_punch or punch_interval, punch_interval)
	local f = 3 * (time_from_last_punch / punch_interval)

	self.velocity = vector.multiply(cart_dir, f)
	self.old_dir = cart_dir
	self.old_pos = nil
	self.punched = true
	end
end

function carts.cart:on_step(dtime)
	local vel = self.object:getvelocity()
	local update = {}
	if self.punched then
		vel = vector.add(vel, self.velocity)
		self.object:setvelocity(vel)
		self.old_dir.y = 0
	elseif vector.equals(vel, {x=0, y=0, z=0}) then
		return
	end

	-- dir:         New moving direction of the cart
	-- last_switch: Currently pressed L/R key, used to ignore the key on the next rail node
	local dir, last_switch
	local pos = self.object:getpos()
	local is_slow = ((vel.x ~= 0 and math.abs(vel.x) <= carts.brake_speed_min) or
						(vel.y ~= 0 and math.abs(vel.y) <= carts.brake_speed_min) or
						(vel.z ~= 0 and math.abs(vel.z) <= carts.brake_speed_min)) and
						string.match(minetest.get_node(pos).name, "brake")
		
	if self.old_pos and not self.punched then
		local flo_pos = vector.round(pos)
		local flo_old = vector.round(self.old_pos)
		if vector.equals(flo_pos, flo_old) and not is_slow then -- Do not check one node multiple times (but check if low speed)
			return
		end
	end


	local ctrl, player

	-- Get player controls
	if self.driver then
		player = minetest.get_player_by_name(self.driver)
		if player then
			ctrl = player:get_player_control()
		end
	end

	if self.old_pos then
		-- Detection for "skipping" nodes
		local expected_pos = vector.add(self.old_pos, self.old_dir)
		local found_path = carts:pathfinder(
			pos, expected_pos, self.old_dir, ctrl, self.old_switch, self.railtype
		)

		if not found_path and not is_slow then
			-- No rail found: reset back to the expected position
			pos = expected_pos
			update.pos = true
		end
	end

	local cart_dir = carts:velocity_to_dir(vel)
	local max_vel = carts.speed_max
	if not dir then
		dir, last_switch = carts:get_rail_direction(
			pos, cart_dir, ctrl, self.old_switch, self.railtype
		)
	end

	local new_acc = {x=0, y=0, z=0}
	local speed_mod = 0
	if vector.equals(dir, {x=0, y=0, z=0}) then
		vel = {x=0, y=0, z=0}
		pos = vector.round(pos)
		update.pos = true
		update.vel = true
	else
		-- If the direction changed
		if dir.x ~= 0 and self.old_dir.z ~= 0 then
			vel.x = dir.x * math.abs(vel.z)
			vel.z = 0
			pos.z = math.floor(pos.z + 0.5)
			update.pos = true
		end
		if dir.z ~= 0 and self.old_dir.x ~= 0 then
			vel.z = dir.z * math.abs(vel.x)
			vel.x = 0
			pos.x = math.floor(pos.x + 0.5)
			update.pos = true
		end
		-- Up, down?
		if dir.y ~= self.old_dir.y then
			vel.y = dir.y * math.abs(vel.x + vel.z)
			pos = vector.round(pos)
			update.pos = true
		end

		-- Slow down or speed up in slopes..
		local acc = dir.y * -1.8

		-- MFF : Some rails have bad acceleration property, reinit them !
		-- this code would be commented when all rails will be corrected
		local rail = minetest.get_node(pos)
		if string.match(rail.name, "power") 
			then minetest.get_meta(pos):set_string("cart_acceleration", "1")
			elseif string.match(rail.name, "brake") then minetest.get_meta(pos):set_string("cart_acceleration", "-1")
			else minetest.get_meta(pos):set_string("cart_acceleration", "0")
		end		
			
		-- Change acceleration by rail (power/brake)
		local speed_mod_string = minetest.get_meta(pos):get_string("cart_acceleration")
		if speed_mod_string and speed_mod_string ~= ""
			then speed_mod = tonumber(speed_mod_string)
			else speed_mod = 0
		end
		
		if speed_mod > 0 then speed_mod = 2
		elseif speed_mod < 0 then speed_mod = -2
		else speed_mod = 0
		end
		
		
		--[[if speed_mod_string == "halt" then --stop rail, not used in MFF
			vel = {x=0, y=0, z=0}
			acc = 0
			pos = vector.round(pos)
			update.pos = true
			update.vel = true
		else--]]if speed_mod and speed_mod ~= 0 then
			acc = acc + (speed_mod * 10)
		else
			--acc = acc - 0.4 --No friction (to be set as an option)
			-- Handbrake
			if ctrl and ctrl.down then
				acc = acc - 1.2
			end
		end

		if self.old_dir.y == 0 and not self.punched then
			-- Stop the cart swing between two rail parts (handbrake)
			if vector.equals(vector.multiply(self.old_dir, -1), dir) then
				vel = {x=0, y=0, z=0}
				acc = 0
				if self.old_pos then
					pos = vector.new(self.old_pos)
					update.pos = true
				end
				dir = vector.new(self.old_dir)
				update.vel = true
			end
		end

		new_acc = vector.multiply(dir, acc)
	end

	if not carts.mesecon_disabled and mesecon then
		carts:signal_detector_rail(vector.round(pos))
	end
	

	-- Limits
	for _,v in ipairs({"x","y","z"}) do
		if speed_mod > 0 and math.abs(vel[v]) > max_vel then
			vel[v] = carts:get_sign(vel[v]) * max_vel
			new_acc[v] = 0
			update.vel = true
		elseif speed_mod < 0 and vel[v] ~= 0 and math.abs(vel[v]) <= carts.brake_speed_min then
			vel[v] = carts:get_sign(vel[v]) * carts.brake_speed_min
			new_acc[v] = 0
			update.vel = true
		end
	end

	self.object:setacceleration(new_acc)
	self.old_pos = vector.new(pos)
	if not vector.equals(dir, {x=0, y=0, z=0}) then
		self.old_dir = vector.new(dir)
	end
	self.old_switch = last_switch


	if self.punched then
		-- Collect dropped items
		for _,obj_ in ipairs(minetest.get_objects_inside_radius(pos, 1)) do
			if not obj_:is_player() and
					obj_:get_luaentity() and
					not obj_:get_luaentity().physical_state and
					obj_:get_luaentity().name == "__builtin:item" then

				obj_:set_attach(self.object, "", {x=0, y=0, z=0}, {x=0, y=0, z=0})
				self.attached_items[#self.attached_items + 1] = obj_
			end
		end
		self.punched = false
		update.vel = true -- update player animation
	end

	if not (update.vel or update.pos) then
		return
	end

	local yaw = 0
	if self.old_dir.x < 0 then
		yaw = 0.5
	elseif self.old_dir.x > 0 then
		yaw = 1.5
	elseif self.old_dir.z < 0 then
		yaw = 1
	end
	self.object:setyaw(yaw * math.pi)

	local anim = {x=0, y=0}
	if dir.y == -1 then
		anim = {x=1, y=1}
	elseif dir.y == 1 then
		anim = {x=2, y=2}
	end
	self.object:set_animation(anim, 1, 0)

	self.object:setvelocity(vel)
	if update.pos then
		self.object:setpos(pos)
	end
	update = nil
end

minetest.register_entity(":carts:cart", carts.cart)
minetest.register_craftitem(":carts:cart", {
	description = "Cart (Sneak+Click to pick up)",
	inventory_image = minetest.inventorycube("cart_top.png", "cart_side.png", "cart_side.png"),
	wield_image = "cart_side.png",
	on_place = function(itemstack, placer, pointed_thing)
		if not pointed_thing.type == "node" then
			return
		end
		if carts:is_rail(pointed_thing.under) then
			minetest.add_entity(pointed_thing.under, "carts:cart")
		elseif carts:is_rail(pointed_thing.above) then
			minetest.add_entity(pointed_thing.above, "carts:cart")
		else return end

		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_craft({
	output = "carts:cart",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	},
})
