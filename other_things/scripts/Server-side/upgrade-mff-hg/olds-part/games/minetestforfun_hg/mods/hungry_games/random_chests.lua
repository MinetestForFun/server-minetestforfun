local random_items = {}
local chest_rarity = 3
local chests_spawn = true
local chests_interval = nil
local chests_boundary = false

local chests = {}
local filling = false
local filepath = minetest.get_worldpath()..'/random_chests'

-- Collision detection function.
-- Checks if a and b overlap.
-- w and h mean width and height.
local function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

--Spawn items in chest
local fill_chest = function(pos)
	--Spawn chest and add random items.
	local invcontent = {}
	local used_groups = {}
	for i,v in pairs(random_items) do
		if not used_groups[v[4]] then
			if math.random(1, v[2]) == 1 then
				table.insert(invcontent, v[1].." "..tostring(math.random(1,v[3])) )
				if v[4] then used_groups[v[4]] = true end
			end
		end
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	for _,itemstring in ipairs(invcontent) do
		inv:add_item('main', itemstring)
	end
end

--API defintions
random_chests = {}

--Register a new item that can be spawned in random chests.
--eg random_chests.register_item('default:torch', 4, 6) #has a 1 in 4 chance of spawning up to 6 torches.
function random_chests.register_item(item, rarity, max, group)
	assert(item and rarity and max)
	table.insert(random_items, {item, rarity, max, group})
end

--Set rarity of the chests. (n = How many per chunk).
function random_chests.set_rarity(n)
	chest_rarity = tonumber(n) or 3
end

--Enable/Disable chests to spawn.
--Disable this if you want to hide your own chests in the world.
function random_chests.enable(b)
	if b == nil then b = true end
	chests_spawn = b
end

--Enable/Disable chests to spawn.
--Disable this if you want to hide your own chests in the world.
function random_chests.set_boundary(n)
	chests_boundary = tonumber(n)/2
end

--Ensure that the positions of placed chests are saved
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	if newnode.name == "default:chest" then
		if not filling then
			table.insert(chests,pos)
			random_chests.save()
		end
	end
end)

--Load chests
local input = io.open(filepath..".chests", "r")
if input then
    while true do
        local nodename = input:read("*l")
        if not nodename then break end
        local parms = {}
        --Catch config.
		flags = nodename
		repeat
			v, p = flags:match("^(%S*) (.*)")
			if p then
				flags = p
			end
			if v then
				table.insert(parms,v)
			else
				v = flags:match("^(%S*)")
				table.insert(parms,v)
				break
			end
		until false
		table.insert(chests,{x=parms[1],y=parms[2],z=parms[3]})
	end
	io.close(input)
end

local clear_chest = function(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_list("main", {})
end

function random_chests.clear()
	local i = 1
	while i <= table.getn(chests) do
		clear_chest(chests[i])
		i = i + 1
	end
end

function random_chests.refill(i)
	filling = true
	if i == nil then i = 1 end
	local s = i
	while i <= table.getn(chests) do
		if chests[i] then
			local n = minetest.get_node(chests[i]).name
			if (not n:match("default:chest")) and n ~= "ignore" then
				print("chest missing! found:")
				print(minetest.get_node(chests[i]).name)
				print("instead")
				table.remove(chests,i)
			else
				fill_chest(chests[i])
			end
			if i > (s+(chests_interval/2)) then
				minetest.after(0.5,random_chests.refill, i)
				return
			end
		end
		i = i + 1
	end
	filling = false
	random_chests.save()
end

function random_chests.save()
	local output = io.open(filepath..".chests", "w")
	for i,v in pairs(chests) do
		output:write(v.x.." "..v.y.." "..v.z.."\n")
	end
	io.close(output)
end

random_chests.setrefillspeed = function(interval)
	chests_interval = interval
end

--Spawning function.
minetest.register_on_generated(function(minp, maxp, seed)
	if chests_spawn then
		local divs = maxp.x - minp.x
		if chests_boundary == 0 or CheckCollision(minp.x,minp.z,divs,divs, -chests_boundary,-chests_boundary,chests_boundary*2,chests_boundary*2) then
			for i=1, chest_rarity do
				local pos = {x=math.random(minp.x,maxp.x),z=math.random(minp.z,maxp.z), y=minp.y}
				if chests_boundary == 0 or CheckCollision(pos.x,pos.z,1,1, -chests_boundary,-chests_boundary,chests_boundary*2,chests_boundary*2) then
					 -- Find ground level (0...15)
					local ground = nil
					for y=maxp.y,minp.y+1,-1 do
						if minetest.get_node({x=pos.x,y=y,z=pos.z}).name ~= "air" and minetest.get_node({x=pos.x,y=y,z=pos.z}).name ~= "default:water_source" and minetest.get_node({x=pos.x,y=y,z=pos.z}).name ~= "snow:snow" then
							ground = y
							break
						end
					end

					if ground then
						table.insert(chests, {x=pos.x,y=ground+1,z=pos.z})
						minetest.set_node({x=pos.x,y=ground+1,z=pos.z}, {name="default:chest"})
					end
				end
			end
		end
	end
	random_chests.save()
end)
