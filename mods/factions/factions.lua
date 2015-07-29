-------------------------------------------------------------------------------
-- factions Mod by Sapier
--
-- License WTFPL
--
--! @file factions.lua
--! @brief factions core file containing datastorage
--! @copyright Sapier
--! @author Sapier
--! @date 2013-05-08
--
-- Contact sapier a t gmx net
-------------------------------------------------------------------------------

--read some basic information
local factions_worldid = minetest.get_worldpath()

--! @class factions
--! @brief main class for factions
factions = {}

--! @brief runtime data
factions.data = {}
factions.data.factions = {}
factions.data.objects = {}
factions.dynamic_data = {}
factions.dynamic_data.membertable = {}

factions.print = function(text)
	print("Factions: " .. dump(text))
end

factions.dbg_lvl1 = function() end --factions.print  -- errors
factions.dbg_lvl2 = function() end --factions.print  -- non cyclic trace
factions.dbg_lvl3 = function() end --factions.print  -- cyclic trace

-------------------------------------------------------------------------------
-- name: add_faction(name)
--
--! @brief add a faction
--! @memberof factions
--! @public
--
--! @param name of faction to add
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.add_faction(name)

	if factions.data.factions[name] == nil then
		factions.data.factions[name] = {}
		factions.data.factions[name].reputation = {}
		factions.data.factions[name].base_reputation = {}
		factions.data.factions[name].adminlist = {}
		factions.data.factions[name].invitations = {}

		factions.dynamic_data.membertable[name] = {}

		factions.save()

		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: set_base_reputation(faction1,faction2,value)
--
--! @brief set base reputation between two factions
--! @memberof factions
--! @public
--
--! @param faction1 first faction
--! @param faction2 second faction
--! @param value value to use
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.set_base_reputation(faction1,faction2,value)

	if factions.data.factions[faction1] ~= nil and
		factions.data.factions[faction2] ~= nil then

		factions.data.factions[faction1].base_reputation[faction2] = value
		factions.data.factions[faction2].base_reputation[faction1] = value
		factions.save()
		return true
	end
	return false
end

-------------------------------------------------------------------------------
-- name: get_base_reputation(faction1,faction2)
--
--! @brief get base reputation between two factions
--! @memberof factions
--! @public
--
--! @param faction1 first faction
--! @param faction2 second faction
--!
--! @return reputation/0 if none set
-------------------------------------------------------------------------------
function factions.get_base_reputation(faction1,faction2)
	factions.dbg_lvl3("get_base_reputation: "  .. faction1 .. "<-->" .. faction2)
	if factions.data.factions[faction1] ~= nil and
		factions.data.factions[faction2] ~= nil then
		if factions.data.factions[faction1].base_reputation[faction2] ~= nil then
			return factions.data.factions[faction1].base_reputation[faction2]
		end
	end
	return 0
end

-------------------------------------------------------------------------------
-- name: set_description(name,description)
--
--! @brief set description for a faction
--! @memberof factions
--! @public
--
--! @param name of faction
--! @param description text describing a faction
--!
--! @return true/false (succesfully set description)
-------------------------------------------------------------------------------
function factions.set_description(name,description)

	if factions.data.factions[name] ~= nil then
		factions.data.factions[name].description = description
		factions.save()
		return true
	end
	return false
end

-------------------------------------------------------------------------------
-- name: get_description(name)
--
--! @brief get description for a faction
--! @memberof factions
--! @public
--
--! @param name of faction
--!
--! @return description or ""
-------------------------------------------------------------------------------
function factions.get_description(name)

	if factions.data.factions[name] ~= nil and
		factions.data.factions[name].description ~= nil then
		return factions.data.factions[name].description
	end
	return ""
end

-------------------------------------------------------------------------------
-- name: exists(name)
--
--! @brief check if a faction exists
--! @memberof factions
--! @public
--! @param name name to check
--!
--! @return true/false
-------------------------------------------------------------------------------
function factions.exists(name)

	for key,value in pairs(factions.data.factions) do
		if key == name then
			return true
		end
	end

	return false
end

-------------------------------------------------------------------------------
-- name: get_faction_list()
--
--! @brief get list of factions
--! @memberof factions
--! @public
--!
--! @return list of factions
-------------------------------------------------------------------------------
function factions.get_faction_list()

	local retval = {}

	for key,value in pairs(factions.data.factions) do
		table.insert(retval,key)
	end

	return retval
end

-------------------------------------------------------------------------------
-- name: delete_faction(name)
--
--! @brief delete a faction
--! @memberof factions
--! @public
--
--! @param name of faction to delete
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.delete_faction(name)

	factions.data.factions[name] = nil

	factions.save()

	if factions.data.factions[name] == nil then
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: member_add(name,object)
--
--! @brief add an entity or player to a faction
--! @memberof factions
--! @public
--
--! @param name of faction to add object to
--! @param object to add to faction
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.member_add(name, object)
	local new_entry = {}
	new_entry.factions = {}

	if object.object ~= nil then
		object = object.object
	end

	if not factions.exists(name) then
		print("Unable to add to NON existant faction >" .. name .. "<")
		return false
	end

	new_entry.name,new_entry.temporary = factions.get_name(object)

	factions.dbg_lvl2("Adding name=" .. dump(new_entry.name) .. " to faction: " .. name )

	if new_entry.name ~= nil then
		if factions.data.objects[new_entry.name] == nil then
			factions.data.objects[new_entry.name] = new_entry
		end

		if factions.data.objects[new_entry.name].factions[name] == nil then
			factions.data.objects[new_entry.name].factions[name] = true
			factions.dynamic_data.membertable[name][new_entry.name] = true
			factions.data.factions[name].invitations[new_entry.name] = nil
			factions.save()
			return true
		end
	end

	--return false if no valid object or already member
	return false
end

-------------------------------------------------------------------------------
-- name: member_invite(name,playername)
--
--! @brief invite a player for joining a faction
--! @memberof factions
--! @public
--
--! @param name of faction to add object to
--! @param name of player to invite
--!
--! @return true/false (succesfully added invitation or not)
-------------------------------------------------------------------------------
function factions.member_invite(name, playername)

	if factions.data.factions[name] ~= nil and
		factions.data.factions[name].invitations[playername] == nil then
		factions.data.factions[name].invitations[playername] = true
		factions.save()
		return true
	end

	--return false if not a valid faction or player already invited
	return false
end

-------------------------------------------------------------------------------
-- name: member_remove(name,object)
--
--! @brief remove an entity or player to a faction
--! @memberof factions
--! @public
--
--! @param name of faction to add object to
--! @param object to add to faction
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.member_remove(name,object)

	local id,type = factions.get_name(object)

	factions.dbg_lvl2("removing name=" .. dump(id) .. " to faction: " .. name )

	if id ~= nil and
		factions.data.objects[id] ~= nil and
		factions.data.objects[id].factions[name] ~= nil then
		factions.data.objects[id].factions[name] = nil
		factions.dynamic_data.membertable[name][id] = nil
		factions.save()
		return true
	end

	if id ~= nil and
		factions.data.factions[name].invitations[id] ~= nil then
		factions.data.factions[name].invitations[id] = nil
		factions.save()
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: set_admin(name,playername,value)
--
--! @brief set admin priviles for a playername
--! @memberof factions
--! @public
--
--! @param name of faction to add object to
--! @param playername to change rights
--! @param value true/false has or has not admin privileges
--!
--! @return true/false (succesfully changed privileges)
-------------------------------------------------------------------------------
function factions.set_admin(name,playername,value)
	--mobf_assert_backtrace(type(playername) == "string")
	if factions.data.factions[name] ~= nil then
		if value then
			factions.data.factions[name].adminlist[playername] = true
			factions.save()
			return true
		else
			factions.data.factions[name].adminlist[playername] = nil
			factions.save()
			return true
		end
	else
		print("FACTIONS: no faction >" .. name .. "< found")
	end

	return false
end

-------------------------------------------------------------------------------
-- name: set_free(name,value)
--
--! @brief set faction to be joinable by everyone
--! @memberof factions
--! @public
--
--! @param name of faction to add object to
--! @param value true/false has or has not admin privileges
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.set_free(name,value)

	if factions.data.factions[name] ~= nil then
		if value then
			if factions.data.factions[name].open == nil then
				factions.data.factions[name].open = true
				factions.save()
				return true
			else
				return false
			end
		else
			if factions.data.factions[name].open == nil then
				return false
			else
				factions.data.factions[name].open = nil
				factions.save()
				return true
			end
		end
	end

	return false
end

-------------------------------------------------------------------------------
-- name: is_free(name)
--
--! @brief check if a fraction is free to join
--! @memberof factions
--! @public
--
--! @param name of faction to add object to
--
--! @return true/false (free or not)
-------------------------------------------------------------------------------
function factions.is_free(name)
	if factions.data.factions[name] ~= nil and
		factions.data.factions[name].open then
			return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: is_admin(name,playername)
--
--! @brief read admin privilege of player
--! @memberof factions
--! @public
--
--! @param name of faction to check rights
--! @param playername to change rights
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.is_admin(name,playername)

	if factions.data.factions[name] ~= nil and
		factions.data.factions[name].adminlist[playername] == true then
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: is_invited(name,playername)
--
--! @brief read invitation status of player
--! @memberof factions
--! @public
--
--! @param name of faction to check for invitation
--! @param playername to change rights
--!
--! @return true/false (succesfully added faction or not)
-------------------------------------------------------------------------------
function factions.is_invited(name,playername)

	if factions.data.factions[name] ~= nil and
		( factions.data.factions[name].invitations[playername] == true or
		factions.data.factions[name].open == true) then
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: get_factions(object)
--
--! @brief get list of factions for an object
--! @memberof factions
--! @public
--
--! @param object to get list for
--!
--! @return list of factions
-------------------------------------------------------------------------------
function factions.get_factions(object)

	local id,type = factions.get_name(object)

	local retval = {}
	if id ~= nil and
		factions.data.objects[id] ~= nil then
		for key,value in pairs(factions.data.objects[id].factions) do
			table.insert(retval,key)
		end
	end

	return retval
end

-------------------------------------------------------------------------------
-- name: is_member(name,object)
--
--! @brief check if object is member of name
--! @memberof factions
--! @public
--
--! @param name of faction to check
--! @param object to check
--!
--! @return true/false
-------------------------------------------------------------------------------
function factions.is_member(name,object)

	local retval = false

	local id,type = factions.get_name(object)

	if id ~= nil and
		factions.data.objects[id] ~= nil then
		for key,value in pairs(factions.data.objects[id].factions) do
			if key == name then
				retval = true
				break
			end
		end
	end

	return retval
end


-------------------------------------------------------------------------------
-- name: get_reputation(name,object)
--
--! @brief get reputation of an object
--! @memberof factions
--! @public
--
--! @param name name of faction to check for reputation
--! @param object object to get reputation for
--!
--! @return number value -100 to 100 0 being neutral, -100 beeing enemy 100 friend
-------------------------------------------------------------------------------
function factions.get_reputation(name,object)

	local id,type = factions.get_name(object)

	factions.dbg_lvl3("get_reputation: "  .. name .. "<-->" .. dump(id))

	if id ~= nil and
		factions.data.factions[name] ~= nil then

		factions.dbg_lvl3("get_reputation: object reputation: "  .. dump(factions.data.factions[name].reputation[id]))

		if factions.data.factions[name].reputation[id] == nil then
			factions.data.factions[name].reputation[id]
				= factions.calc_base_reputation(name,object)
		end

		return factions.data.factions[name].reputation[id]
	else
		factions.dbg_lvl3("get_reputation: didn't find any factions for: "  .. name)
	end

	return 0
end

-------------------------------------------------------------------------------
-- name: modify_reputation(name,object,delta)
--
--! @brief modify reputation of an object for a faction
--! @memberof factions
--! @public
--
--! @param name name of faction to modify reputation
--! @param object object to change reputation
--! @param delta value to change reputation
--!
--! @return true/false
-------------------------------------------------------------------------------
function factions.modify_reputation(name,object,delta)

	local id,type = factions.get_name(object)

	if factions.data.factions[name] ~= nil then
		if factions.data.factions[name].reputation[id] == nil then
			factions.data.factions[name].reputation[id]
				= factions.calc_base_reputation(name,object)
		end

		factions.data.factions[name].reputation[id]
			= factions.data.factions[name].reputation[id] + delta
		factions.save()
		return true
	end

	return false
end

-------------------------------------------------------------------------------
-- name: get_name(object)
--
--! @brief get textual name of object
--! @memberof factions
--! @private
--
--! @param object fetch name for this
--!
--! @return name or nil,is temporary element
-------------------------------------------------------------------------------
function factions.get_name(object)
	if object == nil then
		return nil,true
	end

	if object.object ~= nil then
		object = object.object
	end

	if object:is_player() then
		return object:get_player_name(),false
	else
		local luaentity = object:get_luaentity()

		if luaentity ~= nil then
			return tostring(luaentity),true
		end
	end

	return nil,true
end

-------------------------------------------------------------------------------
-- name: calc_base_reputation(name,object)
--
--! @brief calculate initial reputation of object within a faction
--! @memberof factions
--! @private
--
--! @param name name of faction
--! @param object calc reputation for this
--!
--! @return reputation value
-------------------------------------------------------------------------------
function factions.calc_base_reputation(name,object)

	--calculate initial reputation based uppon all groups
	local object_factions = factions.get_factions(object)
	local rep_value = 0

	factions.dbg_lvl3("calc_base_reputation: " .. name .. " <--> " .. tostring(object))

	if object_factions ~= nil then
		factions.dbg_lvl3("calc_base_reputation: " .. tostring(object) .. " is in " .. #object_factions .. " factions")
		for k,v in pairs(object_factions) do
			if factions.data.factions[v] == nil then
				print("FACTIONS: warning object is member of faction " .. v .. " which doesn't exist")
			else
				factions.dbg_lvl3("calc_base_reputation: " .. name .. " <--> " .. v .. " rep=" .. dump(factions.data.factions[v].base_reputation[name]))
				if factions.data.factions[v].base_reputation[name] ~= nil then
				rep_value =
					rep_value + factions.data.factions[v].base_reputation[name]
				end
			end
		end

		rep_value = rep_value / #object_factions
	end

	return rep_value
end

-------------------------------------------------------------------------------
-- name: save()
--
--! @brief save data to file
--! @memberof factions
--! @private
-------------------------------------------------------------------------------
function factions.save()

	--saving is done much more often than reading data to avoid delay
	--due to figuring out which data to save and which is temporary only
	--all data is saved here
	--this implies data needs to be cleant up on load

	local file,error = io.open(factions_worldid .. "/" .. "factions.conf","w")

	if file ~= nil then
		file:write(minetest.serialize(factions.data))
		file:close()
	else
		minetest.log("error","MOD factions: unable to save factions world specific data!: " .. error)
	end

end

-------------------------------------------------------------------------------
-- name: load()
--
--! @brief load data from file
--! @memberof factions
--! @private
--
--! @return true/false
-------------------------------------------------------------------------------
function factions.load()
	local file,error = io.open(factions_worldid .. "/" .. "factions.conf","r")

	if file ~= nil then
		local raw_data = file:read("*a")
		file:close()

		if raw_data ~= nil and
			raw_data ~= "" then

			local raw_table = minetest.deserialize(raw_data)


			--read object data
			local temp_objects = {}

			if raw_table.objects ~= nil then
				for key,value in pairs(raw_table.objects) do

					if value.temporary == false then
						factions.data.objects[key] = value
					else
						temp_objects[key] = true
					end
				end
			end

			if raw_table.factions ~= nil then
				for key,value in pairs(raw_table.factions) do
					factions.data.factions[key] = {}
					factions.data.factions[key].base_reputation = value.base_reputation
					factions.data.factions[key].adminlist = value.adminlist
					factions.data.factions[key].open = value.open
					factions.data.factions[key].invitations = value.invitations

					factions.data.factions[key].reputation = {}
					for repkey,repvalue in pairs(value.reputation) do
						if temp_objects[repkey] == nil then
							factions.data.factions[key].reputation[repkey] = repvalue
						end
					end

					factions.dynamic_data.membertable[key] = {}
				end
			end

			--populate dynamic faction member table
			for id,object in pairs(factions.data.objects) do
				for name,value in pairs(factions.data.objects[id].factions) do
					if value then
						if factions.dynamic_data.membertable[name] then -- One of the indexes above is nil. Which one? No idea. //MFF(Mg|07/29/15)
							factions.dynamic_data.membertable[name][id] = true
						end
					end
				end
			end
		end
	else
		local file,error = io.open(factions_worldid .. "/" .. "factions.conf","w")

		if file ~= nil then
			file:close()
		else
			minetest.log("error","MOD factions: unable to save factions world specific data!: " .. error)
		end
	end

	--create special faction players
	factions.add_faction("players")

	--autojoin players to faction players
	minetest.register_on_joinplayer(
		function(player)
			if player:is_player() then
				factions.member_add("players",player)
			end
		end
	)
end
