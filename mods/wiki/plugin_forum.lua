
--os.mkdir(WP.."/plugins")
--os.mkdir(WP.."/plugins/ml")

local posts = { }

local player_states = { }

local BACKLOG = 5

local function get_player_state(name)
	if not player_states[name] then
		player_states[name] = { }
	end
	return player_states[name]
end

wikilib.register_plugin({
	regex = "^/ml/.*",
	description = "Mailing List",
	load_page = function(entry, player) --> text, allow_save
		local state = get_player_state(player)
		local what = entry:match("^/ml/(.*)")
		if not what then
			what = "recent"
		end
		what = what:lower()
		if what == "recent" then
			local text = "Recent Posts:\n\n"
			for i = #posts - BACKLOG, #posts do
				local p = posts[i]
				if p then
					local nl = ((p.text:sub(-1) == "\n") and "" or "\n")
					text = (text
						.. "[/ml/"..i.."] "
						.. p.who..":\n"
						.. p.text..nl
						.. "\n"
					)
				end
			end
			text = text.."\n  * [/ml/Post] a new message"
			text = text.."\n  * Back to [Main]"
			return text, false
		elseif what:match("[0-9]+") then
			local n = tonumber(what)
			local text
			if posts[n] then
				local nl = ((posts[n].text:sub(-1) == "\n") and "" or "\n")
				text = ("Post #"..n.." "
					.. posts[n].who..": [:"..posts[n].who..":profile]\n"
					.. posts[n].text..nl
					.. "\n"
				)
			else
				text = "No such post.\n\n"
			end
			text = text.."\n  * [/ml/Post] a new message"
			text = text.."\n  * View [/ml/Recent] messages"
			text = text.."\n  * Back to [Main]"
			return text, false
		elseif what == "post" then
			return "Subject:\n\n<Edit this message and save to post>", true
		end
		return "Wrong request.", false
	end,
	save_page = function(entry, player, text) --> bool
		local state = get_player_state(player)
		local what = entry:match("^/ml/(.*)")
		if not what then
			what = "post"
		end
		what = what:lower()
		if what == "post" then
			posts[#posts + 1] = {
				who = player,
				text = text,
			}
			return "/ml/recent"
		end
		return true
	end,
})
