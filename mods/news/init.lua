local news = {}

local path = minetest.get_worldpath()

local function formspec(player,article)
	
	--if ( article == "" or article == nil ) then 
		article = "news.txt" -- vu qu'il s'en sert pas
	--else
	--	article = "news_"..article..".txt"
	--end
	
	local newsfile = io.open(path.."/"..article,"r")
	
	local formspec = "size[12,10;]"
	formspec = formspec.."background[-0.22,-0.25;13,11;background.jpg]"

	if newsfile ~= nil then
		local newscontent = newsfile:read("*a")
		formspec = formspec.."textarea[.50,.50;12,10;news;;"..minetest.formspec_escape(newscontent).."]"
	else		
		formspec = formspec.."label[.50,.50;Pas d'article pour le moment]"
	end		
	formspec = formspec.."button_exit[5,9.25;2,1;exit;Fermer"
	if ( newsfile ~= nil ) then
		newsfile:close()
	end
	return formspec
end

local function show_formspec(player)
	local name = player:get_player_name()
	minetest.show_formspec(name,"news",formspec(player))
	minetest.log('action','Showing formspec to '..name)
end


minetest.register_chatcommand("news",{
	params = "<article>",
	description="Montre les news du serveur",
	func = function (name,params)
		local player = minetest.get_player_by_name(name)
		minetest.show_formspec(name,"news",formspec(player,params))	
	end,
})

minetest.register_on_joinplayer(function (player)
	if minetest.get_player_privs(player:get_player_name()).interact == true then
		minetest.after(6,show_formspec,player)
	end
end)
