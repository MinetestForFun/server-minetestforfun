pyramids.saved_chests = {}
pyramids.timer = 0
pyramids.max_time = 30*60

local room = {"a","a","a","a","a","a","a","a","a",
	"a","c","a","c","a","c","a","c","a",
	"a","s","a","s","a","s","a","s","a",
	"a","a","a","a","a","a","a","a","a",
	"a","a","a","a","a","a","a","a","a",
	"a","a","a","a","a","a","a","a","a",
	"a","s","a","s","a","s","a","s","a",
	"a","c","a","c","a","c","a","c","a",
	"a","a","a","a","a","a","a","a","a"}

local trap = {"b","b","b","b","b","b","b","b","b",
	"l","b","l","b","l","b","l","b","b",
	"l","b","l","b","l","b","l","b","b",
	"l","b","l","l","l","b","l","l","b",
	"l","l","b","l","b","l","l","b","b",
	"l","b","l","l","l","l","l","l","b",
	"l","b","l","b","l","b","l","b","b",
	"l","b","l","b","l","b","l","b","b",
	"b","b","b","b","b","b","b","b","b"}

local code = {}
code["s"] = "sandstone"
code["eye"] = "deco_stone1"
code["men"] = "deco_stone2"
code["sun"] = "deco_stone3"
code["c"] = "chest"
code["b"] = "sandstonebrick"
code["a"] = "air"
code["l"] = "lava_source"
code["t"] = "trap"

function loadchests()
	local file = io.open(minetest.get_worldpath().."/pyramids_chests.txt","r")
	if file then
		local saved_chests = minetest.deserialize(file:read())
		io.close(file)
		if saved_chests and type(saved_chests) == "table" then
			minetest.log("action","[tsm_pyramids] Chest loaded")
			return saved_chests
		else
			minetest.log("error","[tsm_pyramids] Loading Chest failed")
		end
	end
	return {}
end


function savechests()
	local file = io.open(minetest.get_worldpath().."/pyramids_chests.txt","w")
	if not file then return end -- should not happen
	file:write(minetest.serialize(pyramids.saved_chests))
	io.close(file)
	minetest.log("action","[tsm_pyramids] Chests saved")
end

pyramids.saved_chests = loadchests()
minetest.register_on_shutdown(function()
	savechests()
end)

minetest.register_globalstep(function(dtime)
	pyramids.timer = pyramids.timer + dtime
	if pyramids.timer < pyramids.max_time then return end
	pyramids.timer = 0
	-- It might happen that chests are not loaded
	if pyramids.saved_chests then
		for _,k in ipairs(pyramids.saved_chests) do
			pyramids.fill_chest(k)
		end
	else
		pyramids.saved_chests = loadchests() or {}
	end
	minetest.log("action","[tsm_pyramids] Chests reloaded")
end)

local function replace(str,iy)
	local out = "default:"
	if iy < 4 and str == "c" then str = "a" end
	if iy == 0 and str == "s" then out = "tsm_pyramids:" str = "sun" end
	if iy == 3 and str == "s" then out = "tsm_pyramids:" str = "men" end
	if str == "a" then out = "" end
	if str == "c" or str == "s" or str == "b" then out = "maptools:" end
	return out..code[str]
end

local function replace2(str,iy)
	local out = "default:"
	if iy == 0 and str == "l" then out = "tsm_pyramids:" str = "t"
	elseif iy < 3 and str == "l" then str = "a" end

	if str == "a" then out = "" end
	return out..code[str]
end

function pyramids.make_room(pos)
 local loch = {x=pos.x+7,y=pos.y+5, z=pos.z+7}
 for iy=0,4,1 do
	for ix=0,8,1 do
		for iz=0,8,1 do
			local n_str = room[tonumber(ix*9+iz+1)]
			local p2 = 0
			if n_str == "c" then
				if ix < 3 then p2 = 1 else p2 = 3 end
				pyramids.fill_chest({x=loch.x+ix,y=loch.y-iy,z=loch.z+iz})
			end
			local node_name = replace(n_str,iy)
			minetest.set_node({x=loch.x+ix,y=loch.y-iy,z=loch.z+iz}, {name=node_name, param2=p2})
			if node_name == "maptools:chest" then
				table.insert(pyramids.saved_chests,1,{x=loch.x+ix,y=loch.y-iy,z=loch.z+iz})
			end
		end
	end
 end
end

function pyramids.make_traps(pos)
 local loch = {x=pos.x+7,y=pos.y, z=pos.z+7}
 for iy=0,4,1 do
	for ix=0,8,1 do
		for iz=0,8,1 do
			local n_str = trap[tonumber(ix*9+iz+1)]
			local p2 = 0
			minetest.set_node({x=loch.x+ix,y=loch.y-iy,z=loch.z+iz}, {name=replace2(n_str,iy), param2=p2})
		end
	end
 end
end
