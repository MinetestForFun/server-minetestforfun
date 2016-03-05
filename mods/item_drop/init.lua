item_drop = {}
local enable_damage = minetest.setting_getbool("enable_damage")
local creative_mode = minetest.setting_getbool("creative_mode")
local TICK_UPDATE = 0.1


-- Following edits by gravgun

item_drop.drop_callbacks = {}
item_drop.pickup_callbacks = {}

-- on_drop(dropper, drop_entity, itemstack)
function item_drop.add_drop_callback(on_drop)
	table.insert(item_drop.drop_callbacks, on_drop)
end

-- on_pickup(picker, itemstack)
function item_drop.add_pickup_callback(on_pickup)
	table.insert(item_drop.pickup_callbacks, on_pickup)
end

-- Idea is to have a radius pickup range around the player, whatever the height
-- We need to have a radius that will at least contain 1 node distance at the player's feet
-- Using simple trigonometry, we get that we need a radius of
--  sqrt(pickup_range² + player_half_height²)
local pickup_range = 1.3
local pickup_range_squared = pickup_range*pickup_range
local player_half_height = 0.9
local scan_range = math.sqrt(player_half_height*player_half_height + pickup_range_squared)
-- Node drops are insta-pickup, everything else (player drops) are not
local delay_before_playerdrop_pickup = 1
-- Time in which the node comes to the player
local pickup_duration = 0.1
-- Little treshold so the items aren't already on the player's middle
local pickup_inv_duration = 1/pickup_duration*0.7

local function tick()
	local tstamp = minetest.get_us_time()
	for _,player in ipairs(minetest.get_connected_players()) do
		if player:get_hp() > 0 or not enable_damage then
			local pos = player:getpos()
			pos.y = pos.y + player_half_height
			local inv = player:get_inventory()

			if inv then
				for _,object in ipairs(minetest.get_objects_inside_radius(pos, scan_range)) do
					local luaEnt = object:get_luaentity()
					if luaEnt and luaEnt.name == "__builtin:item" then
						local ticky = luaEnt.item_drop_min_tstamp
						if ticky then
							if tstamp >= ticky then
								luaEnt.item_drop_min_tstamp = nil
							end
						elseif not luaEnt.item_drop_nopickup then
							-- Point-line distance computation, heavily simplified since the wanted line,
							-- being the player, is completely upright (no variation on X or Z)
							local pos2 = object:getpos()
							-- No sqrt, avoid useless computation
							-- (just take the radius, compare it to the square of what you want)
							-- Pos order doesn't really matter, we're squaring the result
							-- (but don't change it, we use the cached values afterwards)
							local dX = pos.x-pos2.x
							local dZ = pos.z-pos2.z
							local playerDistance = dX*dX+dZ*dZ
							if playerDistance <= pickup_range_squared then
								local itemStack = ItemStack(luaEnt.itemstring)
								if inv:room_for_item("main", itemStack) then
									local vec = {x=dX, y=pos.y-pos2.y, z=dZ}
									vec.x = vec.x*pickup_inv_duration
									vec.y = vec.y*pickup_inv_duration
									vec.z = vec.z*pickup_inv_duration
									object:setvelocity(vec)
									luaEnt.physical_state = false
									luaEnt.object:set_properties({
										physical = false
									})
									-- Mark the object as already picking up
									luaEnt.item_drop_nopickup = true

									minetest.after(pickup_duration, function()
										local lua = luaEnt
										if object == nil or lua == nil or lua.itemstring == nil then
											return
										end
										if inv:room_for_item("main", itemStack) then
											inv:add_item("main", itemStack)
											if luaEnt.itemstring ~= "" then
												minetest.sound_play("item_drop_pickup", {pos = pos, gain = 0.3, max_hear_distance = 8})
											end
											luaEnt.itemstring = ""
											object:remove()
											for i, cb in ipairs(item_drop.pickup_callbacks) do
												cb(player, itemstack)
											end
										else
											object:setvelocity({x = 0,y = 0,z = 0})
											luaEnt.physical_state = true
											luaEnt.object:set_properties({
												physical = true
											})
											luaEnt.item_drop_nopickup = nil
										end
									end)
								end
							end
						end
					end
				end
			end
		end
	end
	minetest.after(TICK_UPDATE, tick)
end

local mt_handle_node_drops = minetest.handle_node_drops
function minetest.handle_node_drops(pos, drops, digger)
	if digger and digger.is_fake_player then -- Pipeworks' wielders
		mt_handle_node_drops(pos, drops, digger)
		return
	end
	local inv
	if creative_mode and digger and digger:is_player() then
		inv = digger:get_inventory()
	end
	for _,item in ipairs(drops) do
		local count, name
		if type(item) == "string" then
			count = 1
			name = item
		else
			count = item:get_count()
			name = item:get_name()
		end
		if not inv or not inv:contains_item("main", ItemStack(name)) then
			for i=1,count do
				local obj
				local x = math.random(1, 5)
				if math.random(1,2) == 1 then x = -x end

				local z = math.random(1, 5)
				if math.random(1,2) == 1 then z = -z end

				obj = minetest.spawn_item(pos, name)
				if obj ~= nil then
					obj:setvelocity({x=1/x, y=obj:getvelocity().y, z=1/z})
				end
			end
		end
	end
end

local mt_item_drop = minetest.item_drop
function minetest.item_drop(itemstack, dropper, pos)
	if dropper and dropper.is_player then
		local v = dropper:get_look_dir()
		local p = {x=pos.x, y=pos.y+1.2, z=pos.z}
		local cs = itemstack:get_count()
		if dropper:get_player_control().sneak then
			cs = 1
		end
		local item = itemstack:take_item(cs)
		local obj = core.add_item(p, item)
		if obj then
			v.x = v.x*2
			v.y = v.y*2 + 2
			v.z = v.z*2
			obj:setvelocity(v)
			obj:get_luaentity().item_drop_min_tstamp = minetest.get_us_time() + delay_before_playerdrop_pickup * 1000000
			for i, cb in ipairs(item_drop.drop_callbacks) do
				cb(dropper, obj, itemstack)
			end
		end
	else
		core.add_item(pos, itemstack)
	end
	return itemstack
end

if minetest.setting_getbool("log_mods") then
	minetest.log("action", "[item_drop] item_drop overriden: " .. tostring(mt_item_drop) .. " " .. tostring(minetest.item_drop))
	minetest.log("action", "[item_drop] loaded.")
end

tick()
