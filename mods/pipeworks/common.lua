----------------------
-- Vector functions --
----------------------

function vector.cross(a, b)
	return {
		x = a.y * b.z - a.z * b.y,
		y = a.z * b.x - a.x * b.z,
		z = a.x * b.y - a.y * b.x
	}
end

function vector.dot(a, b)
	return a.x * b.x + a.y * b.y + a.z * b.z
end

-----------------------
-- Facedir functions --
-----------------------

function minetest.facedir_to_top_dir(facedir)
	return 	({[0] = {x =  0, y =  1, z =  0},
	                {x =  0, y =  0, z =  1},
	                {x =  0, y =  0, z = -1},
	                {x =  1, y =  0, z =  0},
	                {x = -1, y =  0, z =  0},
	                {x =  0, y = -1, z =  0}})
		[math.floor(facedir / 4)]
end

function minetest.facedir_to_right_dir(facedir)
	return vector.cross(
		minetest.facedir_to_top_dir(facedir),
		minetest.facedir_to_dir(facedir)
	)
end

directions = {}
function directions.side_to_dir(side)
	return ({[0] = vector.new(),
		vector.new( 0,  1,  0),
		vector.new( 0, -1,  0),
		vector.new( 1,  0,  0),
		vector.new(-1,  0,  0),
		vector.new( 0,  0,  1),
		vector.new( 0,  0, -1)
	})[side]
end

function directions.dir_to_side(dir)
	local c = vector.dot(dir, vector.new(1, 2, 3)) + 4
	return ({6, 2, 4, 0, 3, 1, 5})[c]
end

----------------------
-- String functions --
----------------------

--[[function string.split(str, sep)
	local fields = {}
	local index = 1
	local expr = "([^"..sep.."])+"
	string.gsub(str, expr, function(substring)
		fields[index] = substring
		index = index + 1
	end)
	return fields
end]]

function string.startswith(str, substr)
	return str:sub(1, substr:len()) == substr
end

---------------------
-- Table functions --
---------------------

function table.contains(tbl, element)
	for _, elt in pairs(tbl) do
		if elt == element then
			return true
		end
	end
	return false
end

function table.extend(tbl, tbl2)
	local index = #tbl + 1
	for _, elt in ipairs(tbl2) do
		tbl[index] = elt
		index = index + 1
	end
end

function table.recursive_replace(tbl, pattern, replace_with)
	if type(tbl) == "table" then
		local tbl2 = {}
		for key, value in pairs(tbl) do
			tbl2[key] = table.recursive_replace(value, pattern, replace_with)
		end
		return tbl2
	elseif type(tbl) == "string" then
		return tbl:gsub(pattern, replace_with)
	else
		return tbl
	end
end

------------------------
-- Formspec functions --
------------------------

fs_helpers = {}
function fs_helpers.on_receive_fields(pos, fields)
	local meta = minetest.get_meta(pos)
	for field, value in pairs(fields) do
		if field:startswith("fs_helpers_cycling:") then
			local l = field:split(":")
			local new_value = tonumber(l[2])
			local meta_name = l[3]
			meta:set_int(meta_name, new_value)
		end
	end
end

function fs_helpers.cycling_button(meta, base, meta_name, values)
	local current_value = meta:get_int(meta_name)
	local new_value = (current_value + 1) % (#values)
	local val = values[current_value + 1]
	local text
	local texture_name = nil
	local addopts = nil
	--when we get a table, we know the caller wants an image_button
	if type(val) == "table" then
		text = val["text"]
		texture_name = val["texture"]
		addopts = val["addopts"]
	else
		text = val
	end
	local field = "fs_helpers_cycling:"..new_value..":"..meta_name
	return base..";"..(texture_name and texture_name..";" or "")..field..";"..minetest.formspec_escape(text)..(addopts and ";"..addopts or "").."]"
end

---------
-- Env --
---------

function minetest.load_position(pos)
	if pos.x < -30912 or pos.y < -30912 or pos.z < -30912 or
	   pos.x >  30927 or pos.y >  30927 or pos.z >  30927 then return end
	if minetest.get_node_or_nil(pos) then
		return
	end
	local vm = minetest.get_voxel_manip()
	vm:read_from_map(pos, pos)
end
