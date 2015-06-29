-- Fails mod By Mg <mg[dot]minetest[at]gmail[dot]com>
--[[

     /-----\-\
    /  /--] \-\
    |  |-]  |-|
    \  |    /-/
     \-----/-/

    "Congratulation, you win a failpoint."

License GPLv2

]]--

-- The FailPoint mod by Mg.
-- The principal purpose of this mod is to allow FailPoints give, and the storage of them

data = {}

data.fp_file = minetest.get_worldpath().."/failpoints"
data.failpoints = {}
data.fp_version = 0.2

-- fp_create priv to create failpoints
minetest.register_privilege("fp_create","Is able to create FailPoints and give them to anybody else")

-- Check configuration fields

data.PUB_MSG = false
data.STRICT_PLAYER_CHECK = true

if minetest.setting_getbool("fp_pubmsg") ~= nil then
	data.PUB_MSG = minetest.setting_getbool("fp_pubmsg")
end
if minetest.setting_getbool("fp_strict_checking") ~= nil then
	data.STRICT_PLAYER_CHECK = minetest.setting_getbool("fp_strict_checking")
end

-- Configuration application

data.send_func = function(name, msg) minetest.chat_send_player(name, msg) end

if data.PUB_MSG then
	data.send_func = function (name, msg)
		if minetest.get_modpath("irc") then
			irc:say(msg)
		end
		minetest.chat_send_all(msg)
	end
end

data.is_player_available = minetest.get_player_by_name

if data.STRICT_PLAYER_CHECK == false then
	data.is_player_available = function (name)
		return (io.open(minetest.get_worldpath().."/players/"..name) ~= nil)
	end
end

-- Loading failpoints
pntf = io.open(data.fp_file,"r")
if pntf == nil then
    pntf = io.open(data.fp_file,"w")
else
	repeat
		local line = pntf:read()
		if line == nil or line == "" then break end
		data.failpoints[line:split(" ")[1]] = line:split(" ")[2]+0
	until 1 == 0 -- Ok, not the best way to create a loop..
end
minetest.log("action","[FailPoints] Loaded")

-- Global callbacks
minetest.register_on_shutdown(function()
    -- Saving failpoints
    pntf = io.open(data.fp_file,"w")
    for i,v in pairs(data.failpoints) do
		if v ~= 0 then
			pntf:write(i.." "..v.."\n")
		end
    end
    io.close(pntf)
end)

minetest.register_chatcommand("fail", {
	params = "<subcommand> <subcommandparam> | <playername>",
	description = "Fail command",
	privs = {shout = true},
	func = function(name, parameters)
		local paramlist = parameters:split(" ")
		local param = paramlist[1]
		local param2 = paramlist[2]
		if param == "version" then
			minetest.chat_send_player(name,"-FP- Fail mod version: "..data.fp_version)
			return true
		elseif param == "help" or param == nil then
			minetest.chat_send_player(name,"Failpoints available help :")
			minetest.chat_send_player(name,"/fail <subcommand> | <playername>")
			minetest.chat_send_player(name,"Available subcommands :")
			minetest.chat_send_player(name,"  - help : show this help")
			minetest.chat_send_player(name,"  - version : show actual fail version")
			minetest.chat_send_player(name,"  - view | view <playername> : View player's failpoints amount")
			return
		elseif param == "settings" then
			if not minetest.get_player_privs(name)["server"] then
				minetest.chat_send_player(name,"You're not allowed to perform this command. (Missing privilege : server)")
				return
			end

			minetest.chat_send_player(name,"=== FP_DEBUG_LINES SENT ===")
			print("=== FP_DEBUG_LINES ===")
			local send_admin = function(msg)
				minetest.chat_send_player(name,msg)
			end

			send_admin("FP File")
			if pntf ~= nil then
				send_admin("Found")
			else
				send_admin("Missing!")
			end
			table.foreach(data,print)

			return
		elseif param == "view" then
			if param2 == "" or param2 == nil then
				local ownfail = 0
				if data.failpoints[name] then
					ownfail = data.failpoints[name]
				end
				minetest.chat_send_player(name,"-FP- You own "..ownfail.." FailPoints.")
				return true
			end

			if data.failpoints[param2] ~= nil and data.failpoints[param2] > 0 then
				minetest.chat_send_player(name,"-FP- Player "..param2.." owns "..data.failpoints[param2].." FailPoints.")
			else
				minetest.chat_send_player(name,"-FP- Player "..param2.." doesn't seem to own any FailPoint.")
			end
		else

			-- If not any known command
			if name == param then
				if minetest.get_player_privs(name)["fp_create"] == true then
					minetest.log("error",name.." tried to create a failpoint by giving to himself")
					data.send_func(name,"-FP- Congratulation, you failed " .. name .. " . Don't try to give to yourself :p")
				else
					minetest.log("action",name.."gave himself a FailPoint")
					data.send_func(name,"-FP- You failed " .. name .. " : It appears the name you entered is yours")
					data.send_func(name,"Don't try to give yourself failpoints, it's useless :p")
				end
				return false
			end

			if param == "" then
				minetest.chat_send_player(name,"-FP- You failed: Not enough parameters given, type /fail help for help")
				return false
			end

			if not data.is_player_available(param) then
				minetest.chat_send_player(name,"-FP- You failed: Sorry, "..param.." isn't online.")
				return false
			end

			-- Take, or not, failpoints from name's account to give them to param
			if minetest.get_player_privs(name)["fp_create"] ~= true then
				if data.failpoints[name] == nil or data.failpoints[name] == 0 then
					minetest.chat_send_player(name,"You failed: You don't have enough failpoints..")
					return false
				elseif data.failpoints[name] > 0 then
					data.failpoints[name] = data.failpoints[name] -1
				end
			else
				minetest.log("action","[FailPoints] "..name.." has created a FailPoint.")
			end

			-- Give/Add the failpoint to param' account
			if data.failpoints[param] == nil then
				data.failpoints[param] = 1
			else
				data.failpoints[param] = data.failpoints[param]+1
			end

			minetest.log("action","[FailPoints] "..name.." has given a failpoint to "..param)
			minetest.log("action","[FailPoints] "..param.." now own "..data.failpoints[param].."FPs")
			minetest.log("action","[FailPoints] "..name.." now own "..(data.failpoints[name] or 0).."FPs")
			local message_reason = "."
			if param2 ~= nil then
				local m_table = paramlist
				table.remove(m_table,1)
				message_reason = " because "
				for _,k in ipairs(m_table) do
					message_reason = message_reason..k.." "
				end
			end
			data.send_func(param,"Congratulations "..param..", you win a failpoint" .. message_reason)
			minetest.sound_play({
				name = "failpoint",
				to_player = param,
				gain = 1.0
			})
			minetest.chat_send_player(name,"FP sent.")
		end
	end
})

-- Create the same things for cookies
dofile(minetest.get_modpath("fail").."/cookie.lua")
