--- Quests core.
-- @module core

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	-- If you don't use insertions (@1, @2, etc) you can use this:
	S = function(s) return s end
end
local empty_callback = function(...) end

local function compute_tasks(playername, questname, nocallback)
	local quest = quests.registered_quests[questname]
	local plr_quest = quests.active_quests[playername][questname]
	for taskname, task in pairs(quest.tasks) do
		local plr_task = plr_quest[taskname]
		if task.requires == nil then
			plr_task.visible = true
		else
			plr_task.visible = false
			local was_visible = task.visible
			local final_enabler = ""
			for _, enabler_name in ipairs(task.requires) do
				if type(enabler_name) == "table" then
					plr_task.visible = true
					for _, subena_name in ipairs(plr_quest[enabler_name]) do
						local plr_subena = plr_task[subena_name]
						if plr_task.visible and plr_subena and (not plr_subena.visible or not plr_subena.finished) then
							plr_task.visible = false
						end
					end
				else
					if plr_quest[enabler_name] then
						plr_task.visible = plr_quest[enabler_name].finished or false
					else
						plr_task.visible = true
					end
				end
				if plr_task.visible then
					final_enabler = enabler_name
					break
				end
			end
			if plr_task.visible and not was_visible and not nocallback then
				task.availablecallback(playername, questname, taskname, final_enabler, quest.metadata)
			end
		end
		if task.disables_on ~= nil then
			local was_disabled = task.disabled
			local final_disabler = ""
			for _, disabler_name in ipairs(task.disables_on) do
				if type(disabler) == "table" then
					plr_task.disabled = true
					for _, subdis_name in ipairs(disabler) do
						local plr_subdis = plr_quest[subdis_name]
						if not plr_task.disabled and plr_subdis.visible and plr_subdis.finished then
							plr_task.disabled = true
						end
					end
				else
					plr_task.disabled = plr_quest[disabler_name].finished
				end
				if plr_task.disabled then
					final_disabler = disabler_name
					break
				end
			end
			if plr_task.disabled and not was_disabled and not nocallback then
				task.disablecallback(playername, questname, taskname, final_disabler, quest.metadata)
			end
		end
	end
end

--- Registers a quest for later use.
-- There are two types of quests: simple and tasked.
--
-- * Simple quests are made of a single objective
-- * Taked quests are made of tasks, allowing simultaneous progress
--   within the quest as well as branching quest objectives
--
-- Both quest types are defined by a table, and they share common information:
--     {
--       title,            -- Self-explanatory. Should describe the objective for simple quests.
--       description,      -- Description/lore of the quest
--       icon,             -- Texture name of the quest's icon. If missing, a default icon is used.
--       startcallback,    -- Called upon quest start.  function(playername, questname, metadata)
--       autoaccept,       -- If true, quest automatically becomes completed if its progress reaches the max.
--                         -- Defaults to true.
--       completecallback, -- If autoaccept is true, gets called at quest completion.
--                         --   function(playername, questname, metadata)
--       abortcallback,    -- Called when a player cancels the quest.  function(playername, questname, metadata)
--       repeating         -- Delay in seconds before the quest becomes available again. If nil, 0 or false, doesn't restart.
--     }
--
-- In addition, simple quests have a number-type `max` element indicating the max progress of the quest.
-- As for tasked quests, they have a table-type `tasks` element which value is like this:
--     tasks = {
--       start = {
--         title,
--         description,
--         icon,
--         max          -- Max task progress
--       },
--       another_task = {
--         [...],
--
--         requires = {"start"},
--         -- Table of task names which one must be completed for this task to unlock.
--         --   To to task completion groups (i.e. where ALL must be compileted), pass said names in a (sub)table.
--
--         availablecallback,
--         -- Called when the task becomes available. Not called when there are no task requirements (i.e. task is available from the start).
--         --   function(playername, questname, taskname, enablingtaskname, metadata)
--         --   enablingtaskname is a string or a table of strings, depending on the condition that unlocked the task
--
--         completecallback,
--         -- Called upon task completion.
--         --   function(playername, questname, taskname, metadata)
--       }
--       something = {
--         [...],
--         requires = {"start"},
--
--         disables_on = {"another_task"},
--         -- Same as `requires`, but *disables* the task (it then does not count towards quest completion)
--
--         disablecallback,
--         -- Called when the task becomes disabled. Not called when the task is disabled upon quest start.
--         --   function(playername, questname, taskname, disablingtaskname, metadata)
--         --   disablingtaskname is a string or a table of strings, depending on the condition that locked the task
--       }
--     }
-- In this previous example the 2 last tasks enables once the `start` one is completed, and the
-- last one disables upon `another_task` completion, effectively making it optional if one
-- completes `another_task` before it.
-- Some task names are reserved and will be ignored:
--
-- * `metadata`
-- * `finished`
-- * `value`
--
-- Note: this function *copies* the `quest` table, keeping only what's needed. This way you can implement custom
--       quest attributes in your mod and register the quest directly without worrying about keyvalue name collision.
-- @param questname Name of the quest. Should follow the naming conventions: `modname:questname`
-- @param quest Quest definition `table`
-- @return `true` when the quest was successfully registered
-- @return `false` when there was already such a quest, or if mandatory info was omitted/corrupt
function quests.register_quest(questname, quest)
	if quests.registered_quests[questname] ~= nil then
		return false -- The quest was not registered since there's already a quest with that name
	end
	quests.registered_quests[questname] = {
		title            = quest.title or S("missing title"),
		description      = quest.description or S("missing description"),
		icon             = quest.icon or "quests_default_quest_icon.png",
		startcallback    = quest.startcallback or empty_callback,
		autoaccept       = not(quest.autoaccept == false),
		completecallback = quest.completecallback or empty_callback,
		abortcallback    = quest.abortcallback or empty_callback,
		repeating        = quest.repeating or 0
	}
	local new_quest = quests.registered_quests[questname]
	if quest.max ~= nil then -- Simple quest
		new_quest.max = quest.max or 1
		new_quest.simple = true
	else
		if quest.tasks == nil or type(quest.tasks) ~= "table" then
			quests.registered_quests[questname] = nil
			return false
		end
		new_quest.tasks = {}
		local tcount = 0
		for tname, task in pairs(quest.tasks) do
			if tname ~= "metadata" and tname ~= "finished" and tname ~= "value" then
				new_quest.tasks[tname] = {
					title             = task.title or S("missing title"),
					description       = task.description or S("missing description"),
					icon              = task.icon or "quests_default_quest_icon.png",
					max               = task.max or 1,
					requires          = task.requires,
					availablecallback = task.availablecallback or empty_callback,
					disables_on       = task.disables_on,
					disablecallback   = task.disablecallback or empty_callback,
					completecallback  = task.completecallback or empty_callback
				}
				tcount = tcount + 1
			end
		end
		if tcount == 0 then -- No tasks!
			quests.registered_quests[questname] = nil
			return false
		end
	end
	return true
end

--- Starts a quest for a specified player.
-- @param playername Name of the player
-- @param questname Name of the quest, which was registered with @{quests.register_quest}
-- @param metadata Optional additional data
-- @return `false` on failure
-- @return `true` if the quest was started
function quests.start_quest(playername, questname, metadata)
	local quest = quests.registered_quests[questname]
	if quest == nil then
		return false
	end
	if quests.active_quests[playername] == nil then
		quests.active_quests[playername] = {}
	end
	if quests.active_quests[playername][questname] ~= nil then
		return false -- the player already has this quest
	end
	if quest.simple then
		quests.active_quests[playername][questname] = {value = 0, metadata = metadata, finished = false}
	else
		quests.active_quests[playername][questname] = {metadata = metadata}
		for tname, task in pairs(quest.tasks) do
			quests.active_quests[playername][questname][tname] = {
				value    = 0,
				visible  = false,
				disabled = false,
				finished = false
			}
		end
		compute_tasks(playername, questname)
	end

	quests.update_hud(playername)
	quests.show_message("new", playername, S("New quest:") .. " " .. quest.title)
	return true
end

local function check_active_quest(playername, questname)
	return not(
		playername == nil or
		questname == nil or
		quests.registered_quests[questname] == nil or -- Quest doesn't exist
		quests.active_quests[playername] == nil or -- Player has no data
		quests.active_quests[playername][questname] == nil -- Quest isn't active
	)
end
local function check_active_quest_task(playername, questname, taskname)
	return not(
		taskname == nil or
		not check_active_quest(playername, questname) or
		quests.registered_quests[questname].simple or -- Quest is simple (i.e. no tasks)
		quests.registered_quests[questname].tasks == nil or -- Who knows? Avoid crash.
		quests.registered_quests[questname].tasks[taskname] == nil or -- No such task
		quests.active_quests[playername][questname][taskname] == nil -- Player quest data has no such task
	)
end

--- Updates a *simple* quest's status.
-- Calls the quest's `completecallback` if autoaccept is `true` and the quest reaches its max value.
-- Has no effect on tasked quests.
-- @param playername Name of the player
-- @param questname Quest which gets updated
-- @param value Value to add to the quest's progress (can be negative)
-- @return `true` if the quest is finished
-- @return `false` if the quest continues
-- @return `nil` if there is no such quest, it is a tasked or non-active one, or no value was given
-- @see quests.update_quest_task
function quests.update_quest(playername, questname, value)
	if not check_active_quest(playername, questname) or not quests.registered_quests[questname].simple
		or value == nil then
		return nil
	end
	local plr_quest = quests.active_quests[playername][questname]
	if plr_quest.finished then
		return true -- The quest is already finished
	end
	local quest = quests.registered_quests[questname]
	plr_quest.value = plr_quest.value + value
	if plr_quest.value >= quest.max then
		plr_quest.value = quest.max
		if quest.autoaccept then
			quest.completecallback(playername, questname, plr_quest.metadata)
			quests.accept_quest(playername,questname)
			quests.update_hud(playername)
		end
		return true -- the quest is finished
	end
	quests.update_hud(playername)
	return false -- the quest continues
end

--- Get a *simple* quest's progress.
-- @param playername Name of the player
-- @param questname Quest to get the progress value from
-- @return `number` of the progress
-- @return `nil` if there is no such quest, it is a tasked or non-active one
-- @see quests.get_task_progress
function quests.get_quest_progress(playername, questname)
	if not check_active_quest(playername, questname) or not quests.registered_quests[questname].simple then
		return nil
	end
	local plr_quest = quests.active_quests[playername][questname]
	if plr_quest.finished then
		return nil
	end
	return plr_quest.value
end

--- Updates a *tasked* quest task's status.
-- Calls the quest's `completecallback` if autoaccept is `true` and all the quest's visible
-- and non-disabled tasks reaches their max value.
-- Also calls the task's `completecallback` it it gets completed.
-- Has no effect on simple quests.
-- @param playername Name of the player
-- @param questname Quest which gets updated
-- @param taskname Task to update
-- @param value Value to add to the task's progress (can be negative)
-- @return `true` if the task is finished
-- @return `false` if it continues
-- @return `nil` if there is no such quest/task, is a simple or non-active quest, or no value was given
-- @see quests.update_quest
function quests.update_quest_task(playername, questname, taskname, value)
	if not check_active_quest_task(playername, questname, taskname) or value == nil then
		return nil
	end
	local plr_quest = quests.active_quests[playername][questname]
	local plr_task = plr_quest[taskname]
	if plr_task.finished then
		return true -- The task is already finished
	end

	local quest = quests.registered_quests[questname]
	local task = quest.tasks[taskname]
	local task_finished = false
	plr_task.value = plr_task.value + value
	if plr_task.value >= task.max then
		plr_task.value = task.max
		plr_task.finished = true
		task.completecallback(playername, questname, taskname, quest.metadata)
		task_finished = true
	end

	compute_tasks(playername, questname)
	-- Check for quest completion
	local all_tasks_finished = true
	for taskname, task in pairs(quest.tasks) do
		local plr_task = plr_quest[taskname]
		if plr_task.visible and not plr_task.disabled and not plr_task.finished then
			all_tasks_finished = false
		end
	end
	if all_tasks_finished then
		if quest.autoaccept then
			quest.completecallback(playername, questname, plr_quest.metadata)
			quests.accept_quest(playername,questname)
			quests.update_hud(playername)
		end
		-- If the update of this task ends the quest, it consequently *is* finished.
		return true
	end
	quests.update_hud(playername)
	return task_finished
end

--- Get a task's progress.
-- Returns the max progress value possible for the given task if it is complete.
-- @param playername Name of the player
-- @param questname Quest the task belongs to
-- @param taskname Task to get the progress value from
-- @return `number` of the progress
-- @return `false` if the task has been disabled by another
-- @return `nil` if there is no such quest/task, or is a simple or non-active quest
-- @see quests.get_quest_progress
function quests.get_task_progress(playername, questname, taskname)
	if not not check_active_quest_task(playername, questname, taskname) then
		return nil
	end
	local plr_quest = quests.active_quests[playername][questname]
	if plr_quest.finished then
		return nil
	end
	local plr_task = plr_quest[taskname]
	if not plr_task then
		return nil
	end
	if plr_task.disabled then
		return false
	end
	return plr_task.value
end

--- Checks if a quest's task is visible to the player.
-- @param playername Name of the player
-- @param questname Quest which contains the task
-- @param taskname Task to check visibility
-- @return `true` if the task is visible
-- @return `false` if it is not
-- @return `nil` if the quest/task doesn't exist, is simple or isn't active
function quests.is_task_visible(playername, questname, taskname)
	if not check_active_quest_task(playername, questname, taskname) then
		return nil
	end
	return quests.active_quests[playername][questname][taskname].visible
end

--- Checks if a quest's task is disabled to the player.
-- @param playername Name of the player
-- @param questname Quest which contains the task
-- @param taskname Task to check if it is disabled
-- @return `true` if the task is disabled
-- @return `false` if it is not
-- @return `nil` if the quest/task doesn't exist, is simple or isn't active
function quests.is_task_disabled(playername, questname, taskname)
	if not check_active_quest_task(playername, questname, taskname) then
		return nil
	end
	return quests.active_quests[playername][questname][taskname].disabled
end

--- Gets the number of active (visible & non-disabled) tasks, and how many of them are completed
-- @param playername Name of the player
-- @param questname Quest name
-- @return `number, number` pair, where the first is the number of active tasks, and the second how many of them are completed
-- @return `nil` if the quest doesn't exist, is simple or isn't active
function quests.get_active_tasks_stats(playername, questname)
	if not check_active_quest(playername, questname) or quests.registered_quests[questname].simple then
		return nil
	end
	local plr_quest = quests.active_quests[playername][questname]
	local active_tasks = 0
	local completed_active = 0
	for taskname, _ in pairs(quests.registered_quests[questname].tasks) do
		local plr_task = plr_quest[taskname]
		if plr_task.visible and not plr_task.disabled then
			active_tasks = active_tasks + 1
			if plr_task.finished then
				completed_active = completed_active + 1
			end
		end
	end
	return active_tasks, completed_active
end

--- Gets number of seconds before a quest can be done again.
-- @param playername Player's name
-- @param questname Quest name
-- @return `number` of seconds before quests becomes available
-- @return `nil` if the quest isn't repeating
function quests.quest_restarting_in(playername, questname)
	if quests.info_quests[playername] and
		quests.info_quests[playername][questname] and
		quests.info_quests[playername][questname].restart_tstamp then
		return quests.info_quests[playername][questname].restart_tstamp - os.time()
	end
	return nil
end

local function restart_periodic_quest(playername, questname)
	quests.start_quest(playername, questname)
	if quests.info_quests[playername] and quests.info_quests[playername][questname] then
		quests.info_quests[playername][questname].restart_tstamp = nil
	end
end

local function start_repeating_timer(playername, questname)
	local delay = quests.quest_restarting_in(playername, questname)
	if delay ~= nil then
		minetest.after(delay, restart_periodic_quest, playername, questname)
	end
end

local function start_all_repeating_timers(playername)
	local qinfos = quests.info_quests[playername]
	if qinfos then
		for questname, qinfo in pairs(qinfos) do
			if qinfo.restart_tstamp then
				start_repeating_timer(playername, questname)
			end
		end
	end
end

-- Restart all stopped repeating quests' timers
for playername, _ in pairs(quests.info_quests) do
	start_all_repeating_timers(playername)
end

local function handle_quest_end(playername, questname)
	local quest = quests.registered_quests[questname]
	if quest.repeating ~= 0 then
		quests.info_quests[playername] = quests.info_quests[playername] or {}
		quests.info_quests[playername][questname] = quests.info_quests[playername][questname] or {}
		local qinfo = quests.info_quests[playername][questname]
		qinfo.restart_tstamp = os.time() + quest.repeating
		start_repeating_timer(playername, questname)
	end
end

--- Confirms quest completion and ends it.
-- When the mod handles the end of quests himself, e.g. you have to talk to somebody to finish the quest,
-- you have to call this method to end a quest
-- @param playername Player's name
-- @param questname Quest name
-- @return `true` when the quest is completed
-- @return `false` when an error occured (the quest is still ongoing if it was)
function quests.accept_quest(playername, questname)
	if check_active_quest(playername, questname) and not quests.active_quests[playername][questname].finished then
		if quests.successfull_quests[playername] == nil then
			quests.successfull_quests[playername] = {}
		end
		if quests.successfull_quests[playername][questname] ~= nil then
			quests.successfull_quests[playername][questname].count = quests.successfull_quests[playername][questname].count + 1
		else
			quests.successfull_quests[playername][questname] = {count = 1}
		end
		quests.active_quests[playername][questname].finished = true
		for _,quest in ipairs(quests.hud[playername].list) do
			if quest.name == questname then
				local player = minetest.get_player_by_name(playername)
				player:hud_change(quest.id, "number", quests.colors.success)
			end
		end
		handle_quest_end(playername, questname)
		quests.show_message("success", playername, S("Quest completed:") .. " " .. quests.registered_quests[questname].title)
		minetest.after(3, function(playername, questname)
			quests.active_quests[playername][questname] = nil
			quests.update_hud(playername)
		end, playername, questname)
		return true -- the quest is finished, the mod can give a reward
	end
	return false -- the quest hasn't finished
end

--- Aborts a quest.
-- Call this method when you want to end a quest even when it was not finished.
-- Example: the player failed.
-- @param playername Player's name
-- @param questname Quest name
-- @return `true` when the quest was aborted
-- @return `false` if there was an error (quest not aborted)
function quests.abort_quest(playername, questname)
	if not check_active_quest(playername, questname) then
		return false
	end
	if quests.failed_quests[playername] == nil then
		quests.failed_quests[playername] = {}
	end
	if quests.failed_quests[playername][questname] ~= nil then
		quests.failed_quests[playername][questname].count = quests.failed_quests[playername][questname].count + 1
	else
		quests.failed_quests[playername][questname] = { count = 1 }
	end

	quests.active_quests[playername][questname].finished = true
	for _,quest in ipairs(quests.hud[playername].list) do
		if quest.name == questname then
			local player = minetest.get_player_by_name(playername)
			player:hud_change(quest.id, "number", quests.colors.failed)
		end
	end

	local quest = quests.registered_quests[questname]
	quest.abortcallback(playername, questname, quests.active_quests[playername][questname].metadata)
	handle_quest_end(playername, questname)
	quests.show_message("failed", playername, S("Quest failed:") .. " " .. quest.title)
	minetest.after(3, function(playername, questname)
		quests.active_quests[playername][questname] = nil
		quests.update_hud(playername)
	end, playername, questname)
	return true
end

--- Set quest HUD visibility.
-- @param playername Player's name
-- @param questname Quest name
-- @param visible `bool` indicating if the quest should be visible
-- @see quests.get_quest_hud_visibility
function quests.set_quest_hud_visibility(playername, questname, visible)
	if not check_active_quest(playername, questname) then
		return
	end
	quests.info_quests[playername] = quests.info_quests[playername] or {}
	quests.info_quests[playername][questname] = quests.info_quests[playername][questname] or {}
	quests.info_quests[playername][questname].hide_from_hud = not visible
	quests.update_hud(playername)
end

--- Get quest HUD visibility.
-- @param playername Player's name
-- @param questname Quest name
-- @return `bool`: quest HUD visibility
-- @see quests.set_quest_hud_visibility
function quests.get_quest_hud_visibility(playername, questname)
	if not check_active_quest(playername, questname) then
		return false
	end
	local plr_qinfos = quests.info_quests[playername]
	return not(plr_qinfos and plr_qinfos[questname] and plr_qinfos[questname].hide_from_hud)
end

--- Get quest metadata.
-- @return Metadata of the quest, `nil` if there is none
-- @return `nil, false` if the quest doesn't exist or isn't active
-- @see quests.set_metadata
function quests.get_metadata(playername, questname)
	if not check_active_quest(playername, questname) then
		return nil, false
	end
	return quests.active_quests[playername][questname].metadata
end

--- Set quest metadata.
-- @return `false` if the quest doesn't exist or isn't active
-- @return `nil` otherwise
-- @see quests.get_metadata
function quests.set_metadata(playername, questname, metadata)
	if not check_active_quest(playername, questname) then
		return false
	end
	quests.active_quests[playername][questname].metadata = metadata
end

