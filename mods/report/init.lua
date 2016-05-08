report = {}

function report.send(sender, message)
	-- Send to online moderators / admins
	-- Get comma separated list of online moderators and admins
	local mods = {}
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		if minetest.check_player_privs(name, {kick = true, ban = true}) then
			table.insert(mods, name)
			minetest.chat_send_player(name, "-!- " .. sender .. " reported: " .. message)
		end
	end

	if #mods > 0 then
		local mod_list = table.concat(mods, ", ")
		email.send_mail(sender, minetest.setting_get("name"),
			"Report: " .. message .. " (mods online: " .. mod_list .. ")")
		return true, "Reported. Moderators currently online: " .. mod_list
	else
		email.send_mail(sender, minetest.setting_get("name"),
			"Report: " .. message .. " (no mods online)")
		return true, "Reported. We'll get back to you."
	end
end


minetest.register_chatcommand("report", {
	func = function(name, param)
		param = param:trim()
		if param == "" then
			return false, "Please add a message to your report. " ..
				"If it's about (a) particular player(s), please also include their name(s)."
		end
		local _, count = string.gsub(param, " ", "")
		if count == 0 then
			minetest.chat_send_player(name, "If you're reporting a player, " ..
				"you should also include a reason why. (Eg: swearing, sabotage)")
		end
		return action_timers.wrapper(name, "report", "report_" .. name, 600, report.send, {name, param})
	end
})

if minetest.get_modpath("unified_inventory") then
	unified_inventory.register_button("report", {
		type = "image",
		-- From http://www.clker.com/cliparts/v/K/Y/P/2/M/warning-sign-bl-bg-hi.png
		image = "report_button.png",
		tooltip = "Report to the moderators/administrator",
	})

	unified_inventory.register_page("report", {
		get_formspec = function(player)
			local form = "label[3,0;Report a Bug/Player]"..
				"label[0,1.5;DO NOT report a player until you have read the rules posted"..
				"\nat the spawn area! Don't report griefing, it's allowed on"..
				"\nour server! You can ask questions to moderators and report"..
				"\nflooding/spam, cheating, etc. Don't abuse/spam Report messages"..
				"\nor you will be punished. LIMIT: One report per 5 minutes.]"..
				"field[2,5;5,1;text;Type report here:;]" ..
				"button[3,6;2,0.5;report;Send]"
			return {formspec = form, draw_inventory = false}
		end
	})

	minetest.register_on_player_receive_fields(function(player, formname, fields)
		if formname ~= "" or not fields.report then
			return
		end

		-- Copied from src/builtin/game/chatcommands.lua (with little tweaks)
		if not fields.text or fields.text == "" then
			return
		end
		local name = player:get_player_name()

		local success, message = action_timers.wrapper(name, "report", "report_" .. name, 600, report.send, {name, fields.text})
		if message then
			core.chat_send_player(name, message)
		end
		return true -- Handled fields reception
	end)
end
