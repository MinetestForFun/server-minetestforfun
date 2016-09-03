dofile(minetest.get_modpath("profnsched").."/queue.lua")

local jobs = {}
local scheduler = scheduler

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


-- redefine core.after function
function minetest.after(after, func, ...)
	assert(type(func) == "function", "Invalid core.after invocation")
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
