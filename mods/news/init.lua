local news = {}
local caracteres_max = 5000
local pages_players = {}

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
	local nb = 1
	news[nb] = ""
	local commit = string.split(content, "\n\n")

	for i,line in ipairs(commit) do
		if string.len(news[nb]) < caracteres_max then
			news[nb] = news[nb]..minetest.formspec_escape(line.."\n\n\n")
		else
			nb = nb + 1
			news[nb] = minetest.formspec_escape(line.."\n\n\n")
		end
	end
end

load_news()


local function show_formspec(player, page)
	local name = player:get_player_name()
	if not name then return end
	local nb_pages = #news
	local formspec = "size[12,10;]"
	formspec = formspec.."background[-0.22,-0.25;13,11;background.jpg]"

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
	if minetest.get_player_privs(player:get_player_name()).interact == true then
		minetest.after(6,show_formspec,player, 1)
	end
end)
