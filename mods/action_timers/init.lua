-------------------------------
-- Action timers
-- Mod handling action timers
--

action_timers = {}
action_timers.timers = {}
action_timers.limits = {}

action_timers.api = {}


function action_timers.api.register_timer(name, limit)
	if action_timers.timers[name] then
		minetest.log("error", "[ACTimers] Cannot register timer " .. name .. " a second time")
		return
	elseif not limit then
		minetest.log("error", "[ACTimers] Cannot register timer " .. name .. " without limit")
		return
	end

	action_timers.timers[name] = limit
	action_timers.limits[name] = limit
	minetest.log("action", "[ACTimers] Timer " .. name .. " registered with time limit " .. limit)
end

function action_timers.api.do_action(name, func, params)
	if not action_timers.timers[name] then
		minetest.log("error", "[ACTimers] Timer " .. name .. " doesn't exist")
		return
	elseif not func then
		minetest.log("error", "[ACTimers] Function passed to time checker for " .. name .. " is nil")
		return
	elseif action_timers.timers[name] > 0 then
		minetest.log("error", "[ACTimers] Timer " .. name .. " is still up to 0")
		return action_timers.timers[name]
	end

	action_timers.timers[name] = action_timers.limits[name]
	if not params then
		return func()
	else
		return func(unpack(params))
	end
end

function action_timers.api.get_timer(name)
	return action_timers.timers[name]
end

minetest.register_globalstep(function(dtime)
	for name, _ in pairs(action_timers.timers) do
		action_timers.timers[name] = action_timers.timers[name] - dtime
		if action_timers.timers[name] < 0 then
			action_timers.timers[name] = 0
		end
	end
end)

minetest.log("action", "[ACTimers] Loaded")


function action_timers.wrapper(pname, name, timername, value, func, params)
	if not action_timers.api.get_timer(timername) then
		action_timers.api.register_timer(timername, value)
		return func(unpack(params))
	else
		local res = action_timers.api.do_action(timername, func, params)
		if tonumber(res) then
			minetest.chat_send_player(pname, "Please retry later, you used " .. name .. " last time less than " .. value .. " seconds ago.")
			minetest.chat_send_player(pname, "Retry in: " .. math.floor(res) .. " seconds.")
			minetest.log("action", "[action_timers] Player " .. pname .. " tried to use'" .. name .. "' within forbidden interval.")
			return false
		elseif res == true then
			return res
		end
	end
end
