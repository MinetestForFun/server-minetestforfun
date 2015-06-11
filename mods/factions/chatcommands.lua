-------------------------------------------------------------------------------
-- factions Mod by Sapier
--
-- License WTFPL
--
--! @file chatcommnd.lua
--! @brief factions chat interface
--! @copyright Sapier
--! @author Sapier
--! @date 2013-05-08
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--! @class factions_chat
--! @brief chat interface class
factions_chat = {}

-------------------------------------------------------------------------------
-- name: init()
--
--! @brief initialize chat interface
--! @memberof factions_chat
--! @public
-------------------------------------------------------------------------------
function factions_chat.init()

	minetest.register_privilege("faction_user",
		{
			description = "this user is allowed to interact with faction mod",
			give_to_singleplayer = true,
		}
	)

	minetest.register_privilege("faction_admin",
		{
			description = "this user is allowed to create or delete factions",
			give_to_singleplayer = true,
		}
	)

	minetest.register_chatcommand("factions",
		{
			params = "<cmd> <parameter 1> .. <parameter n>",
			description = "faction administration functions",
			privs = { faction_user=true },
			func = factions_chat.cmdhandler,
		}
	)

	minetest.register_chatcommand("af",
		{
			params = "text",
			description = "send message to all factions",
			privs = { faction_user=true },
			func = factions_chat.allfactions_chathandler,
		}
	)

	minetest.register_chatcommand("f",
		{
			params = "<factionname> text",
			description = "send message to a specific faction",
			privs = { faction_user=true },
			func = factions_chat.chathandler,
		}
	)
end

-------------------------------------------------------------------------------
-- name: cmdhandler(playername,parameter)
--
--! @brief chat command handler
--! @memberof factions_chat
--! @private
--
--! @param playername name
--! @param parameter data supplied to command
-------------------------------------------------------------------------------
function factions_chat.cmdhandler(playername,parameter)

	local player = minetest.get_player_by_name(playername)
	local params = parameter:split(" ")
	local cmd = params[1]

	--handle common commands
	if parameter == nil or
		parameter == "" then

		local playerfactions = factions.get_factions(player)

		local tosend = "Factions: " .. playername .. " factions:"
		for i,v in ipairs(playerfactions) do
			if i ~= #playerfactions then
				tosend = tosend .. " " .. v .. ","
			else
				tosend = tosend .. " " .. v
			end
		end
		minetest.chat_send_player(playername, tosend, false)
		return
	end

	--list all known factions
	if cmd == "list" then
		local list = factions.get_faction_list()
		local tosend = "Factions: current available factions:"

		for i,v in ipairs(list) do
			if i ~= #list then
				tosend = tosend .. " " .. v .. ","
			else
				tosend = tosend .. " " .. v
			end
		end
		minetest.chat_send_player(playername, tosend, false)
		return
	end

	--show factions mod version
	if cmd == "version" then
		minetest.chat_send_player(playername, "Factions: version " .. factions_version , false)
		return
	end

	--show description  of faction
	if cmd == "info" then
		if params[2] ~= nil then
			minetest.chat_send_player(playername,
				"Factions: " .. params[2] .. ": " ..
				factions.get_description(params[2]), false)
			return
		end
	end

	if cmd == "leave" then
		if params[2] ~= nil then
			if params[3] ~= nil then
				local toremove = minetest.get_player_by_name(params[3])
				--allowed if faction_admin, admin of faction or player itself
				if minetest.check_player_privs(playername,{ faction_admin=true }) or
					factions.is_admin(params[2],playername) and
					toremove ~= nil then

					factions.member_remove(params[2],toremove)
					minetest.chat_send_player(playername,
						"Factions: " .. params[3] .. " has been removed from "
						.. params[2], false)
					return
				end
			else
				factions.member_remove(params[2],player)
				minetest.chat_send_player(playername,
						"Factions: You have left " .. params[2], false)
				return
			end
		end
	end

	--handle superadmin only commands
	if minetest.check_player_privs(playername,{ faction_admin=true }) then
		--create new faction
		if cmd == "create" then
			if params[2] ~= nil then
				if factions.add_faction(params[2]) then
					minetest.chat_send_player(playername,
						"Factions: created faction " .. params[2],
						false)
					return
				else
					minetest.chat_send_player(playername,
						"Factions: FAILED to created faction " .. params[2],
						false)
					return
				end
			end
		end
	end

	if cmd == "join" then
		if params[2] ~= nil then
			if params[3] ~= nil and
				minetest.check_player_privs(playername,{ faction_admin=true }) then

				local toadd = minetest.get_player_by_name(params[3])

				if toadd ~= nil then
					if factions.member_add(params[2],toadd) then
						minetest.chat_send_player(playername,
							"Factions: " .. params[3] .. " joined faction " ..
							params[2],
							false)
						return
					end
				end
				minetest.chat_send_player(playername,
					"Factions: " .. params[3] .. " FAILED to join faction " ..
					params[2],
					false)
				return
			else
				--check for invitation
				if factions.is_invited(params[2],playername) then
					if factions.member_add(params[2],player) then
						minetest.chat_send_player(playername,
							"Factions: joined faction " ..
							params[2],
							false)
						return
					else
						minetest.chat_send_player(playername,
							"Factions: FAILED to join faction " ..
							params[2],
							false)
						return
					end
				else
					minetest.chat_send_player(playername,
						"Factions: you are not allowed to join " .. params[2],
						false)
					return
				end
			end
		end
	end

	--all following commands require at least two parameters
	if params[2] ~= nil then
		if minetest.check_player_privs(playername,{ faction_admin=true }) or
			factions.is_admin(params[2],playername) then

			--delete faction
			if cmd == "delete" then
				if factions.delete_faction(params[2]) then
					minetest.chat_send_player(playername,
						"Factions: deleted faction " .. params[2],
						false)
					return
				else
					minetest.chat_send_player(playername,
						"Factions: FAILED to deleted faction " .. params[2],
						false)
					return
				end
			end

			if cmd == "set_free" then
				if params[3] ~= nil  and
					(params[3] == "true" or params[3] == "false")then

					local value = false
					if params[3] == "true" then
						value = true
					end

					if factions.set_free(params[2],value) then
						minetest.chat_send_player(playername,
							"Factions: free to join for " .. params[2] ..
							" has been set to " .. params[3],
							false)
					else
						minetest.chat_send_player(playername,
							"Factions: FAILED to set free to join for " ..
							params[2],
							false)
					end
				end
			end

			--set player admin status
			if cmd == "admin" then
				if params[3] ~= nil and params[4] ~= nil and
					(params[4] == "true" or params[4] == "false") then

					local value = false
					if params[4] == "true" then
						value = true
					end

					if factions.set_admin(params[2],params[3],value) then
						minetest.chat_send_player(playername,
							"Factions: adminstate of " .. params[3] ..
							" has been set to " .. params[4],
							false)
					else
						minetest.chat_send_player(playername,
							"Factions: FAILED to set admin privileges for " ..
							params[3],
							false)
					end
				end
				return
			end

			if cmd == "description" and
				params[2] ~= nil and
				params[3] ~= nil then

				local desc = params[3]
				for i=4, #params, 1 do
					desc = desc .. " " .. params[i]
				end
				if factions.set_description(params[2],desc) then
					minetest.chat_send_player(playername,
							"Factions: updated description of faction " ..
							params[2],
							false)
					return
				else
					minetest.chat_send_player(playername,
							"Factions: FAILED to update description of faction " ..
							params[2],
							false)
					return
				end
			end

			if cmd == "invite" and
				params[2] ~= nil and
				params[3] ~= nil then
				if factions.member_invite(params[2],params[3]) then
					minetest.chat_send_player(params[3],
							"Factions: " .. params[3] ..
							" you have been invited to join faction " .. params[2],
							false)
					minetest.chat_send_player(playername,
							"Factions: " .. params[3] ..
							" has been invited to join faction " .. params[2],
							false)
					return
				else
					minetest.chat_send_player(playername,
							"Factions: FAILED to invite " .. params[3] ..
							" to join faction " .. params[2],
							false)
					return
				end
			end
		end
	end

	factions_chat.show_help(playername)
end

-------------------------------------------------------------------------------
-- name: allfactions_chathandler(playername,parameter)
--
--! @brief chat handler
--! @memberof factions_chat
--! @private
--
--! @param playername name
--! @param parameter data supplied to command
-------------------------------------------------------------------------------
function factions_chat.allfactions_chathandler(playername,parameter)

	local player = minetest.get_player_by_name(playername)

	if player ~= nil then
	  local recipients = {}

	  for faction,value in pairs(factions.get_factions(player)) do
		  for name,value in pairs(factions.dynamic_data.membertable[faction]) do
			  local object_to_check = minetest.get_player_by_name(name)

			  if object_to_check ~= nil then
				  recipients[name] = true
			  end
		  end
	  end

	  for recipient,value in pairs(recipients) do
		  if recipient ~= playername then
			  minetest.chat_send_player(recipient,playername ..": " .. parameter,false)
		  end
	  end
	  return
	end
	factions_chat.show_help(playername)
end

-------------------------------------------------------------------------------
-- name: chathandler(playername,parameter)
--
--! @brief chat handler
--! @memberof factions_chat
--! @private
--
--! @param playername name
--! @param parameter data supplied to command
-------------------------------------------------------------------------------
function factions_chat.chathandler(playername,parameter)

	local player = minetest.get_player_by_name(playername)

	if player ~= nil then
	  local line = parameter:split(" ")
	  local target_faction = line[1]

	  local text = line[2]
	  for i=3,#line,1 do
		  text = text .. " " .. line[i]
	  end

	  local valid_faction = false

	  for faction,value in pairs(factions.get_factions(player)) do
		  if target_faction == faction then
			  valid_faction = true
		  end
	  end

	  if faction ~= nil and valid_faction and
	      factions.dynamic_data.membertable[faction] ~= nil then
		  for name,value in pairs(factions.dynamic_data.membertable[faction]) do
			  local object_to_check = minetest.get_player_by_name(name)
			  factions_chat.show_help(playername)
			  if object_to_check ~= nil and
				  name ~= playername then
				  minetest.chat_send_player(name,playername ..": " .. text,false)
			  end
		  end
	  else
		  minetest.chat_send_player(playername,
			  "Factions: you're not a member of " .. dump(faction),false)
	  end
	  return
	end
	factions_chat.show_help(playername)
end

-------------------------------------------------------------------------------
-- name: show_help(playername,parameter)
--
--! @brief send help message to player
--! @memberof factions_chat
--! @private
--
--! @param playername name
-------------------------------------------------------------------------------
function factions_chat.show_help(playername)

	local MSG = function(text)
		minetest.chat_send_player(playername,text,false)
	end

	MSG("Factions mod")
	MSG("Usage:")
	MSG("\tUser commands:")
	MSG("\t\t/factions                      -> info on your current factions")
	MSG("\t\t/factions info <factionname>   -> show description of faction")
	MSG("\t\t/factions list                 -> show list of factions")
	MSG("\t\t/factions leave <factionname>  -> leave specified faction")
	MSG("\t\t/factions join <factionname>   -> join specified faction")
	MSG("\t\t/factions version              -> show version number of mod")

	MSG("\tAdmin commands:")
	MSG("\t\t/factions create <factionname> -> create a new faction")
	MSG("\t\t/factions delete <factionname> -> delete a faction faction")
	MSG("\t\t/factions leave <factionname> <playername> -> remove player from faction")
	MSG("\t\t/factions invite <factionname> <playername> -> invite player to faction")
	MSG("\t\t/factions set_free <factionname> <value> -> set faction free to join")
	MSG("\t\t/factions admin <factionname> <playername> <value> -> make player admin of faction")
	MSG("\t\t/factions description <factionname> <text> -> set description for faction")
end
