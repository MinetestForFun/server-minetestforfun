local modpath = minetest.get_modpath("news")
local md5 = dofile(modpath .. "/md5.lua")

local news = {}
local checksum
local caracteres_max = 5000
local pages_players = {}

local seen_checksum

function load_news()
	local newsfile = io.open(minetest.get_worldpath().."/news.txt","r")
	local content
	if newsfile ~= nil then
		content = newsfile:read("*a")
		newsfile:close()
	end

	if content == nil or string.len(content) == 0 then
		return
	end
	checksum = md5.sumhexa(content)
	minetest.log("verbose", "[news] checksum is " .. checksum)

	local nb = 1
	news[nb] = ""
	local commit = string.split(content, "\n\n")

	for i,line in ipairs(commit) do
		if string.len(news[nb]) < caracteres_max then
			news[nb] = news[nb]..minetest.formspec_escape(line.."\n\n")
		else
			nb = nb + 1
			news[nb] = minetest.formspec_escape(line.."\n\n")
		end
	end
end

load_news()

---- Loading/storage of seen news checksums. Write "return nil" into news.seen
---- to disable the feature.
-- Inbefore https://github.com/minetest/minetest/pull/4155
-- Bet this issue won't be fixed before early 2017
do
	local file = io.open(minetest.get_worldpath().."/news.seen","r")
	if file == nil then
		seen_checksum = {}
	else
		local content = file:read("*a")
		file:close()
		seen_checksum = minetest.deserialize(content)
	end
	local type_seen = type(seen_checksum)
	if type_seen ~= 'table' and type_seen ~= 'nil' then
		minetest.log("error", "[news] Loading news.seen returned a " ..
			type_seen .. ", expected table. Disabling \"seen\" feature.")
		seen_checksum = nil
	end
end
minetest.register_on_shutdown(function()
	if seen_checksum then
		local file = io.open(minetest.get_worldpath().."/news.seen", "w")
		file:write(minetest.serialize(seen_checksum))
		file:close()
	end
end)


local function show_formspec(player, page)
	local name = player:get_player_name()
	if not name or (player:get_hp() <= 0) then return end
	local nb_pages = #news
	local formspec = "size[12,10;]"
	formspec = formspec.."background[-0.22,-0.60;13,11.3;news_background.jpg]"

	if page > nb_pages then
		page = nb_pages
	elseif page < 1 then
		page = 1
	end
	pages_players[name] = page

	if news[page] ~= nil then
		formspec = formspec.."textarea[.50,.50;12,10;news;;"..news[page].."]"
	else
		formspec = formspec.."label[.50,.50;Pas d'article pour le moment]"
	end

	formspec = formspec.."button_exit[2,9.25;2,1;exit;Fermer]"..
						 "button[6,9.25;1,1;page;<<]"..
						 "button[7,9.25;1,1;page;<]"..
						 "button[8,9.25;1,1;none;"..page.."/"..nb_pages.."]"..
						 "button[9,9.25;1,1;page;>]"..
						 "button[10,9.25;1,1;page;>>]"

	minetest.show_formspec(name,"news:news",formspec)
	--minetest.log('action','Showing formspec to '..name.."page "..page)
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "news:news" then
		local name = player:get_player_name()
		if not name then return end
		local page = (pages_players[name] or 1)
		if fields["quit"] then
			pages_players[name] = nil
			return
		elseif fields["page"] == "<<" then
			page = page - 2
		elseif fields["page"] == "<" then
			page = page - 1
		elseif fields["page"] == ">" then
			page = page + 1
		elseif fields["page"] == ">>" then
			page = page + 2
		end
		show_formspec(player,page)
	end
end)


minetest.register_chatcommand("news",{
	params = "<page>",
	description="Montre les news du serveur",
	func = function (name,params)
		local player = minetest.get_player_by_name(name)
		local page
		if tonumber(params) then
			page = tonumber(params)
		else
			page = 1
		end
		show_formspec(player, page)
	end,
})


minetest.register_on_joinplayer(function (player)
	local name = player:get_player_name()
	if minetest.get_player_privs(name).interact then
		if seen_checksum and seen_checksum[name] ~= checksum then
			seen_checksum[name] = checksum
			minetest.after(6,show_formspec,player, 1)
		end
	end
end)
