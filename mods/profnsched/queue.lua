scheduler = {}
-- scheduler.queue = {[1]={first=1, last=2, groups={[1]={}, [2]={}}}}
scheduler.queue = {[1]={cur={}, nxt={}, ncur=1, nnxt=1}}

function scheduler.add(priority, job)
	-- get asked class
	local class = scheduler.queue[priority]
	local p = priority
	while not class do -- create all classes under 'priority'
		--scheduler.queue[p] = {first=1, last=2, groups={[1]={}, [2]={}}}
		scheduler.queue[p] = {cur={}, nxt={}, ncur=1, nnxt=1}
		p = p-1
		class = scheduler.queue[p]
	end
	class = scheduler.queue[priority]
	class.nxt[class.nnxt] = job
	class.nnxt = class.nnxt+1
	-- get last group
	--local grp = class.groups[class.last]
	-- add job into last group
	--grp[#grp+1] = job
end

function scheduler.asap(priority, func)
	scheduler.add(priority, {
		mod_name = core.get_last_run_mod(),
		func_id = "#"..debug.getinfo(2, "S").linedefined, --imprecis
		func_code = func,
		arg = {},
	})
end

function scheduler.mdebug(s)
	minetest.debug("[Profnsched] "..s)
end

function scheduler.shift()
	local nb = scheduler.waitingjobs()
	local qnext = nil
	for class,q in ipairs(scheduler.queue) do
		q.cur = q.nxt
		q.nxt = {}
		q.ncur = q.nnxt
		q.nnxt = 1
		
		--local tnext = class+1
		qnext = scheduler.queue[class+1]
		if qnext then
			local src = qnext.cur
			for i,j in pairs(src) do
				q.cur[q.ncur] = j
				q.ncur = q.ncur+1
				src[i] = nil
			end
			qnext.cur = {}
			qnext.ncur = 1			
		end
	end
	--[[
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
	end]]
	if nb ~= scheduler.waitingjobs() then --This should never happen, left because it was used during debug phase
		mdebug("ERROR, This should never happen ! Lost jobs, some mod may not work from now, please restart the server.")
	end
	--
end

function scheduler.fulldebug()
	minetest.log("[Profnsched]"..#scheduler.queue.." classes")
	for class,q in pairs(scheduler.queue) do
		minetest.log("[Profnsched]    class "..class..":")
		minetest.log("[Profnsched]         current "..q.ncur)
		minetest.log("[Profnsched]         next "..q.nnxt)		
	end
	minetest.log("[Profnsched] end")
end


function scheduler.waitingjobs()
	local n = 0
	for class, q in pairs(scheduler.queue) do
		for i,grp in pairs(q.cur) do
			n = n+1			
		end
		for i,grp in pairs(q.nxt) do
			n = n+1			
		end
	end
	return n
end
