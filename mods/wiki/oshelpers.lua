
local WIN32, DIR_SEP

if os.getenv("WINDIR") then
	WIN32 = true
	DIR_SEP = "\\"
else
	WIN32 = false
	DIR_SEP = "/"
end

function os.mkdir(dir)
	local f = io.open(dir..DIR_SEP..".dummy")
	if f then
		f:close()
	else
		if WIN32 then
			dir = dir:gsub("/", "\\")
		else
			dir = dir:gsub("\\", "/")
		end
		os.execute("mkdir \""..dir.."\"")
		local f = io.open(dir..DIR_SEP..".dummy", "w")
		if f then
			f:write("DO NOT DELETE!!!\n")
			f:close()
		end
	end
end
