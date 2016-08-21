scheduler = {}
scheduler.queue = {[1]={first=1, last=2, groups={[1]={}, [2]={}}}}

function scheduler.add(priority, job)
	-- get asked class
	local class = scheduler.queue[priority]
	local p = priority
	while not class do -- create all classes under 'priority'
		scheduler.queue[p] = {first=1, last=2, groups={[1]={}, [2]={}}}
		p = p-1
		class = scheduler.queue[p]
	end
	class = scheduler.queue[priority]
	-- get last group
	local grp = class.groups[class.last]
	-- add job into last group
	grp[#grp+1] = job
end

function scheduler.asap(priority, func)
	scheduler.add(priority, {
		mod_name = core.get_last_run_mod(),
		func_id = "todo",
		func_code = func,
		arg = {},
	})
end

function scheduler.mdebug(s)
	minetest.debug("[Profnsched] "..s)
end

function scheduler.shift()
	local nb = scheduler.waitingjobs()
	local tsrc = nil
	local tdst = nil
	for class,q in ipairs(scheduler.queue) do
		q.groups[q.first] = q.groups[q.last]
		q.groups[q.last] = {}
		local tnext = class+1
		tnext = scheduler.queue[tnext]
		if tnext then
			tsrc = tnext.groups[tnext.first]
			tdst = q.groups[q.first]
			for i,j in pairs(tsrc) do
				tdst[#tdst+1] = j
				tsrc[i] = nil
			end
		end
	end
	if nb ~= scheduler.waitingjobs() then --This should never happen, left because it was used during debug phase
		mdebug("ERROR, This should never happen ! Lost jobs, some mod may not work from now, please restart the server.")
	end
	--
end

function scheduler.fulldebug()
	minetest.log("[Profnsched]"..table.getn(scheduler.queue).." classes")
	for class,q in pairs(scheduler.queue) do
		minetest.log("[Profnsched]    class "..class..":")
		minetest.log("[Profnsched]        "..q.first.." "..q.last.." ("..q.last-q.first+1 .." groups)")
		for i,grp in pairs(q.groups) do
			local n = 0
			for j,jb in pairs(grp) do
				n = n+1
			end
			minetest.log("[Profnsched]           group "..i..", "..n.." jobs")
		end		
	end
	minetest.log("[Profnsched] end")
end

function scheduler.waitingjobs()
	local n = 0
	for class, q in pairs(scheduler.queue) do
		for i,grp in pairs(q.groups) do
			for j,jb in pairs(grp) do
				n = n+1
			end
		end
	end
	return n
end
