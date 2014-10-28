
local function repr(x)
	if type(x) == "string" then
		return ("%q"):format(x)
	else
		return tostring(x)
	end
end

local function my_serialize_2(t, level)
	level = level or 0
	local lines = { }
	local indent = ("\t"):rep(level)
	for k, v in pairs(t) do
		local typ = type(v)
		if typ == "table" then
			table.insert(lines,
			  indent..("[%s] = {\n"):format(repr(k))
			  ..my_serialize_2(v, level + 1).."\n"
			  ..indent.."},")
		else
			table.insert(lines,
			  indent..("[%s] = %s,"):format(repr(k), repr(v)))
		end
	end
	return table.concat(lines, "\n")
end

function xban.serialize(t)
	return "return {\n"..my_serialize_2(t, 1).."\n}"
end
