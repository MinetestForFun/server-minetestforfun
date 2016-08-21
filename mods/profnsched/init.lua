dofile(minetest.get_modpath("profnsched").."/queue.lua")

local jobs = {}
local durations = {}

--------------------------------------------------------------
-- Move olds globalsteps and redefine minetest internal caller

local gs = {} -- global_steps (moved here)

for i,f in ipairs(minetest.registered_globalsteps) do
	gs[#gs+1] = {
		mod_name = "unknown"..i,
		func_id = "unknown(globalstep)",
		func_code = f
	}
	minetest.registered_globalsteps[i] = nil
end

local old_globalstep =  minetest.register_globalstep

function minetest.register_globalstep(func)
	gs[#gs+1] = {
		mod_name = core.get_last_run_mod(),
		func_id = "unknown(globalstep)",
		func_code = func
	}	
end

-- Usefull func

local function update_durations(mod_name, func_id, dtime)
	if not durations[mod_name] then
		durations[mod_name] = {}
	end
	if not durations[mod_name][func_id] then
		durations[mod_name][func_id] = {
			us = 0,
			n = 0,
			cur = 0
		}
	end
	durations[mod_name][func_id].us = durations[mod_name][func_id].us + dtime
	durations[mod_name][func_id].n = durations[mod_name][func_id].n + 1
	durations[mod_name][func_id].cur = dtime
end


-- For minetest.after replacement
local function check_expired_jobs()
	local time = core.get_us_time()
	for i,job in pairs(jobs) do
		if time >= job.expire then
			scheduler.add(1, job)
			jobs[i] = nil
		end
	end
	scheduler.asap(4, check_expired_jobs)
end
scheduler.asap(4, check_expired_jobs)

-- Main code

local last_elapsed_local_dtime = 0
local last_internal_server_dtime = 0
local tick_dtime = minetest.setting_get("dedicated_server_step")*1000000

old_globalstep(function(dtime)
	local begin_time = core.get_us_time()
	last_internal_server_dtime = dtime*1000000 - last_elapsed_local_dtime
	local launch_dtime = begin_time - last_internal_server_dtime
	
	local current_durations = {}
	current_durations[1] = {"Internal SERVER", "& unprofiled", last_internal_server_dtime}

	local tbegin = 0
	-- Globalsteps
	for i,v in pairs(gs) do
		tbegin = core.get_us_time()
		v.func_code(dtime+(core.get_us_time()-tbegin)/1000000)
		current_durations[#current_durations+1] = {v.mod_name, v.func_id, core.get_us_time()-tbegin}
	end
		
	-- Others jobs
	local njb = scheduler.waitingjobs()
	local jbdone = 0
	for class,q in ipairs(scheduler.queue) do
		local grp = q.groups[q.first]
		for i,job in pairs(grp) do
			tbegin = core.get_us_time()
			core.set_last_run_mod(job.mod_name)
			job.func_code(unpack(job.arg))
			jbdone = jbdone+1
			current_durations[#current_durations+1] = {job.mod_name, job.func_id, core.get_us_time()-tbegin}
			grp[i] = nil
			if class > 1 and ((core.get_us_time()-launch_dtime) >  tick_dtime) then --class 1 fully processed even on overload
				break
			end 
		end
		if ((core.get_us_time()-launch_dtime) >  tick_dtime) then
			break
		end 
	end
	scheduler.shift()

	local elapsed = (core.get_us_time()-launch_dtime)
	
	-- update all durations
	for i,v in pairs(current_durations) do
		update_durations(v[1], v[2], v[3])
	end
		
	if (elapsed > tick_dtime) then --overload ?
		local mathfloor = math.floor
		if last_internal_server_dtime < tick_dtime then -- caused by profiled mods ?
			minetest.log("[Profnsched] Overload ! "..mathfloor(elapsed)/1000 .."ms")
			local avg = 0
			local dt = 0
			for i,v in pairs(current_durations) do
				dt = mathfloor(v[3])/1000
				avg = mathfloor(durations[v[1]][v[2]].us/durations[v[1]][v[2]].n)/1000
				minetest.log("[Profnsched] "..dt.."ms (avg: "..avg.." ; "..durations[v[1]][v[2]].n.." calls) "..v[1].." "..v[2])
			end
		else
			minetest.log("[Profnsched] Overload ! Caused by server or not profiled mods : "..mathfloor(last_internal_server_dtime)/1000 .."ms")
		end
	end
	
	for i,v in pairs(current_durations) do
		current_durations[i] = nil
	end
	
	last_elapsed_local_dtime = core.get_us_time() - begin_time
end)


-- redefine core.after function
function minetest.after(after, func, ...)
		assert(type(func) == "function",
			"Invalid core.after invocation")
	local fname = debug.getinfo(2, "S").linedefined --imprecis
	local job = {
		func_code = func,
		expire = core.get_us_time() + after*1000000,
		arg = {...},
		mod_name = core.get_last_run_mod(),
		func_id = "#"..fname
	}
	jobs[#jobs+1] = job
end
