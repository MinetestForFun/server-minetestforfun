-- Cookies Recipe :

if not rawget(_G,"data") then
	data = {}
end

data.oven = minetest.get_worldpath().."/cookies"
data.cookies = {}

-- cookie_baker priv to create cookie
minetest.register_privilege("baker","Is able to bake CooKies and give them to anybody else")

-- Loading cookies from oven
pntf = io.open(data.oven,"r")
if pntf == nil then
    pntf = io.open(data.oven,"w")
else
	repeat
		local line = pntf:read()
		if line == nil or line == "" then break end
		--print(line)
		data.cookies[line:split(" ")[1]] = line:split(" ")[2]+0
	until 1 == 0 -- Ok, not the best way to create a loop..
end
minetest.log("action","[FailPoints] CooKies baked")

-- Global callbacks
minetest.register_on_shutdown(function() 
    -- Stocking CooKies
    pntf = io.open(data.oven,"w")
    for i,v in pairs(data.cookies) do
		if v ~= 0 then
			pntf:write(i.." "..v.."\n")
		end
	end
end)

minetest.register_chatcommand("cookie", {
	params = "<subcommand> <subcommandparam> | <playername>",
	description = "CooKie baking command",
	privs = {shout = true},
	func = function(name, parameters)
		local paramlist = parameters:split(" ")
		local param = paramlist[1]
		local param2 = paramlist[2]
		if param == "help" or param == nil then
			core.chat_send_player(name,"CooKie recipe's help :")
			core.chat_send_player(name,"/cookie <subcommand> | <playername>")
			core.chat_send_player(name,"Available subcommands :")
			core.chat_send_player(name,"  - help : show this help")
			core.chat_send_player(name,"  - view | view <playername> : View player's CooKies amount") 
			return
		elseif param == "view" then
			if param2 == "" or param2 == nil then
				local owncookies = 0
				if data.cookies[name] then
					owncookies = data.cookies[name]
				end
				core.chat_send_player(name,"-CK- You own "..owncookies.." CooKies.")
				return true
			end
			
			if data.cookies[param2] ~= nil and data.cookies[param2] > 0 then
				core.chat_send_player(name,"-CK- Player "..param2.." owns "..data.cookies[param2].." CooKies.")
			else
				core.chat_send_player(name,"-CK- Player "..param2.." doesn't seem to own any CooKie.")
			end
		else
		
			-- If not any known command
			if name == param then
				if minetest.get_player_privs(name)["baker"] == true then
					minetest.log("error",name.." tried to create a CooKie by giving to himself")
					core.chat_send_player(name,"-CK- Congratulation, you failed. Don't try to cook for yourself, don't be selfish :p")
				else
					minetest.log("action",name.."cooked himself a CooKie")
					core.chat_send_player(name,"-CK- You failed: It appears the name you entered is yours")
					core.chat_send_player(name,"Don't try to cook yourself CooKies, share them :p")
				end
				return false
			end
		
			if param == "" then
				minetest.chat_send_player(name,"-CK- You failed: Not enough parameters given, type /cookie help for help")
				return false
			end

			if not minetest.get_player_by_name(param) then
				core.chat_send_player(name,"-CK- You failed: Sorry, "..param.." isn't online.")
				return false
			end
		
			-- Take, or not, cookies from name's account to give them to param
			if minetest.get_player_privs(name)["baker"] ~= true then
				if data.cookies[name] == nil or data.failpoints[name] == 0 then
					core.chat_send_player(name,"You failed: You don't have enough CooKies.. Cook some!")
					return false
				elseif data.cookies[name] > 0 then
					data.cookies[name] = data.cookies[name] -1
				end
			else
				minetest.log("action","[FailPoints] "..name.." has baked a CooKie.")
			end
		
			-- Give/Add the CooKie to param' account
			if data.cookies[param] == nil then
				data.cookies[param] = 1
			else
				data.cookies[param] = data.cookies[param]+1
			end
		
			minetest.log("action","[FailPoints] "..name.." has given a CooKie to "..param)
			minetest.log("action","[FailPoints] "..param.." now own "..data.cookies[param].."CKs")
			minetest.log("action","[FailPoints] "..name.." now own "..(data.cookies[name] or 0).."CKs")
			core.chat_send_player(param,"Congratulations "..param..", you get a CooKie.")
			core.chat_send_player(name,"CooKie sent.")
		end
	end
})
