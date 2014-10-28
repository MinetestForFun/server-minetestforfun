local chatlog = minetest.get_worldpath().."/chatlog.txt"
monthfirst = true -- Wheter the 1st of Feb should be 1/2/13(monthfirst = true) or 2/1/13(monthfirst = false)


function playerspeak(name,msg)
	f = io.open(chatlog, "a")
	if monthfirst then
		f:write(os.date("(%m/%d/%y %X) ["..name.."]: "..msg.."\n"))
	else
		f:write(os.date("(%d/%m/%y %X) ["..name.."]: "..msg.."\n"))
	end
	f:close()
end

minetest.register_on_chat_message(playerspeak)