local load_time_start = os.clock()

local funcs = {}

function funcs.pos_to_string(pos)
	return "("..pos.x.."|"..pos.y.."|"..pos.z..")"
end

local r_corr = 0.25 --remove a bit more nodes (if shooting diagonal) to let it look like a hole (sth like antialiasing)

-- this doesn't need to be calculated every time
local f_1 = 0.5-r_corr
local f_2 = 0.5+r_corr

--returns information about the direction
local function get_used_dir(dir)
	local abs_dir = {x=math.abs(dir.x), y=math.abs(dir.y), z=math.abs(dir.z)}
	local dir_max = math.max(abs_dir.x, abs_dir.y, abs_dir.z)
	if dir_max == abs_dir.x then
		local tab = {"x", {x=1, y=dir.y/dir.x, z=dir.z/dir.x}}
		if dir.x >= 0 then
			tab[3] = "+"
		end
		return tab
	end
	if dir_max == abs_dir.y then
		local tab = {"y", {x=dir.x/dir.y, y=1, z=dir.z/dir.y}}
		if dir.y >= 0 then
			tab[3] = "+"
		end
		return tab
	end
	local tab = {"z", {x=dir.x/dir.z, y=dir.y/dir.z, z=1}}
	if dir.z >= 0 then
		tab[3] = "+"
	end
	return tab
end

local function node_tab(z, d)
	local n1 = math.floor(z*d+f_1)
	local n2 = math.floor(z*d+f_2)
	if n1 == n2 then
		return {n1}
	end
	return {n1, n2}
end

local function return_line(pos, dir, range) --range ~= length
	local tab = {}
	local num = 1
	local t_dir = get_used_dir(dir)
	local dir_typ = t_dir[1]
	if t_dir[3] == "+" then
		f_tab = {0, range, 1}
	else
		f_tab = {0, -range, -1}
	end
	local d_ch = t_dir[2]
	if dir_typ == "x" then
		for d = f_tab[1],f_tab[2],f_tab[3] do
			local x = d
			local ytab = node_tab(d_ch.y, d)
			local ztab = node_tab(d_ch.z, d)
			for _,y in ipairs(ytab) do
				for _,z in ipairs(ztab) do
					tab[num] = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
					num = num+1
				end
			end
		end
	elseif dir_typ == "y" then
		for d = f_tab[1],f_tab[2],f_tab[3] do
			local xtab = node_tab(d_ch.x, d)
			local y = d
			local ztab = node_tab(d_ch.z, d)
			for _,x in ipairs(xtab) do
				for _,z in ipairs(ztab) do
					tab[num] = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
					num = num+1
				end
			end
		end
	else
		for d = f_tab[1],f_tab[2],f_tab[3] do
			local xtab = node_tab(d_ch.x, d)
			local ytab = node_tab(d_ch.y, d)
			local z = d
			for _,x in ipairs(xtab) do
				for _,y in ipairs(ytab) do
					tab[num] = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
					num = num+1
				end
			end
		end
	end
	return tab
end

local function table_contains2(t, v)
	for i = #t, 1, -1 do
		if t[i] == v then
			return true
		end
	end
	return false
end

local function return_fine_line(pos, dir, range, scale)
	local ps1 = return_line(vector.round(vector.multiply(pos, scale)), dir, range*scale)
	local ps2 = {}
	local ps2_num = 1
	for _,p1 in ipairs(ps1) do
		local p2 = vector.round(vector.divide(p1, scale))
		if not table_contains2(ps2, p2) then
			ps2[ps2_num] = p2
			ps2_num = ps2_num+1
		end
	end
	return ps2
end

function funcs.fine_line(pos, dir, range, scale)
	--assert_vector(pos)
	if not range then --dir = pos2
		dir = vector.direction(pos, dir)
		range = vector.distance(pos, dir)
	end
	return return_fine_line(pos, dir, range, scale)
end

function funcs.line(pos, dir, range, alt)
	--assert_vector(pos)
	if alt then
		if not range then --dir = pos2
			dir, range = vector.direction(pos, dir), vector.distance(pos, dir)
		end
		return return_line(pos, dir, range)
	end
	if range then --dir = pos2
		dir = vector.round(vector.multiply(dir, range))
	else
		dir = vector.subtract(dir, pos)
	end
	local line,n = {},1
	for _,i in ipairs(vector.threeline(dir.x, dir.y, dir.z)) do
		line[n] = {x=pos.x+i[1], y=pos.y+i[2], z=pos.z+i[3]}
		n = n+1
	end
	return line
end

local twolines = {}
function funcs.twoline(x, y)
	local pstr = x.." "..y
	local line = twolines[pstr]
	if line then
		return line
	end
	line = {}
	local n = 1
	local dirx = 1
	if x < 0 then
		dirx = -dirx
	end
	local ymin, ymax = 0, y
	if y < 0 then
		ymin, ymax = ymax, ymin
	end
	local m = y/x --y/0 works too
	local dir = 1
	if m < 0 then
		dir = -dir
	end
	for i = 0,x,dirx do
		local p1 = math.max(math.min(math.floor((i-0.5)*m+0.5), ymax), ymin)
		local p2 = math.max(math.min(math.floor((i+0.5)*m+0.5), ymax), ymin)
		for j = p1,p2,dir do
			line[n] = {i, j}
			n = n+1
		end
	end
	twolines[pstr] = line
	return line
end

local threelines = {}
function funcs.threeline(x, y, z)
	local pstr = x.." "..y.." "..z
	local line = threelines[pstr]
	if line then
		return line
	end
	if x ~= math.floor(x) then
		minetest.log("error", "[vector_extras] INFO: The position used for vector.threeline isn't round.")
	end
	local two_line = vector.twoline(x, y)
	line = {}
	local n = 1
	local zmin, zmax = 0, z
	if z < 0 then
		zmin, zmax = zmax, zmin
	end
	local m = z/math.hypot(x, y)
	local dir = 1
	if m < 0 then
		dir = -dir
	end
	for _,i in ipairs(two_line) do
		local px, py = unpack(i)
		local ph = math.hypot(px, py)
		local z1 = math.max(math.min(math.floor((ph-0.5)*m+0.5), zmax), zmin)
		local z2 = math.max(math.min(math.floor((ph+0.5)*m+0.5), zmax), zmin)
		for pz = z1,z2,dir do
			line[n] = {px, py, pz}
			n = n+1
		end
	end
	threelines[pstr] = line
	return line
end

function funcs.sort(ps, preferred_coords)
	preferred_coords = preferred_coords or {"z", "y", "x"}
	local a,b,c = unpack(preferred_coords)
	local function ps_sorting(p1, p2)
		if p1[a] == p2[a] then
			if p1[b] == p2[a] then
				if p1[c] < p2[c] then
					return true
				end
			elseif p1[b] < p2[b] then
				return true
			end
		elseif p1[a] < p2[a] then
			return true
		end
	end
	table.sort(ps, ps_sorting)
end

function funcs.scalar(v1, v2)
	return v1.x*v2.x + v1.y*v2.y + v1.z*v2.z
end

function funcs.cross(v1, v2)
	return {
		x = v1.y*v2.z - v1.z*v2.y,
		y = v1.z*v2.x - v1.x*v2.z,
		z = v1.x*v2.y - v1.y*v2.x
	}
end

--not optimized
--local areas = {}
function funcs.plane(ps)
	-- sort positions and imagine the first one (A) as vector.zero
	ps = vector.sort(ps)
	local pos = ps[1]
	local B = vector.subtract(ps[2], pos)
	local C = vector.subtract(ps[3], pos)

	-- get the positions for the fors
	local cube_p1 = {x=0, y=0, z=0}
	local cube_p2 = {x=0, y=0, z=0}
	for i in pairs(cube_p1) do
		cube_p1[i] = math.min(B[i], C[i], 0)
		cube_p2[i] = math.max(B[i], C[i], 0)
	end
	cube_p1 = vector.apply(cube_p1, math.floor)
	cube_p2 = vector.apply(cube_p2, math.ceil)

	local vn = vector.normalize(vector.cross(B, C))

	local nAB = vector.normalize(B)
	local nAC = vector.normalize(C)
	local angle_BAC = math.acos(vector.scalar(nAB, nAC))

	local nBA = vector.multiply(nAB, -1)
	local nBC = vector.normalize(vector.subtract(C, B))
	local angle_ABC = math.acos(vector.scalar(nBA, nBC))

	for z = cube_p1.z, cube_p2.z do
		for y = cube_p1.y, cube_p2.y do
			for x = cube_p1.x, cube_p2.x do
				local p = {x=x, y=y, z=z}
				local n = -vector.scalar(p, vn)/vector.scalar(vn, vn)
				if math.abs(n) <= 0.5 then
					local ep = vector.add(p, vector.multiply(vn, n))
					local nep = vector.normalize(ep)
					local angle_BAep = math.acos(vector.scalar(nAB, nep))
					local angle_CAep = math.acos(vector.scalar(nAC, nep))
					local angldif = angle_BAC - (angle_BAep+angle_CAep)
					if math.abs(angldif) < 0.001 then
						ep = vector.subtract(ep, B)
						nep = vector.normalize(ep)
						local angle_ABep = math.acos(vector.scalar(nBA, nep))
						local angle_CBep = math.acos(vector.scalar(nBC, nep))
						local angldif = angle_ABC - (angle_ABep+angle_CBep)
						if math.abs(angldif) < 0.001 then
							table.insert(ps, vector.add(pos, p))
						end
					end
				end
			end
		end
	end
	return ps
end

function funcs.straightdelay(s, v, a)
	if not a then
		return s/v
	end
	return (math.sqrt(v*v+2*a*s)-v)/a
end

vector.zero = vector.new()

function funcs.sun_dir(time)
	if not time then
		time = minetest.get_timeofday()
	end
	local t = (time-0.5)*5/6+0.5 --the sun rises at 5 o'clock, not at 6
	if t < 0.25
	or t > 0.75 then
		return
	end
	local tmp = math.cos(math.pi*(2*t-0.5))
	return {x=tmp, y=math.sqrt(1-tmp*tmp), z=0}
end

function funcs.inside(pos, minp, maxp)
	for _,i in pairs({"x", "y", "z"}) do
		if pos[i] < minp[i]
		or pos[i] > maxp[i] then
			return false
		end
	end
	return true
end

function funcs.minmax(p1, p2)
	local p1 = vector.new(p1)
	local p2 = vector.new(p2)
	for _,i in ipairs({"x", "y", "z"}) do
		if p1[i] > p2[i] then
			p1[i], p2[i] = p2[i], p1[i]
		end
	end
	return p1, p2
end

function funcs.move(p1, p2, s)
	return vector.round(
		vector.add(
			vector.multiply(
				vector.direction(
					p1,
					p2
				),
				s
			),
			p1
		)
	)
end

function funcs.from_number(i)
	return {x=i, y=i, z=i}
end

local explosion_tables = {}
function funcs.explosion_table(r)
	local table = explosion_tables[r]
	if table then
		return table
	end

	local t1 = os.clock()
	local tab, n = {}, 1

	local tmp = r*r + r
	for x=-r,r do
		for y=-r,r do
			for z=-r,r do
				local rc = x*x+y*y+z*z
				if rc <= tmp then
					local np={x=x, y=y, z=z}
					if math.floor(math.sqrt(rc) +0.5) > r-1 then
						tab[n] = {np, true}
					else
						tab[n] = {np}
					end
					n = n+1
				end
			end
		end
	end
	explosion_tables[r] = tab
	minetest.log("info", string.format("[vector_extras] table created after ca. %.2fs", os.clock() - t1))
	return tab
end

local default_nparams = {
   offset = 0,
   scale = 1,
   seed = 1337,
   octaves = 6,
   persist = 0.6
}
function funcs.explosion_perlin(rmin, rmax, nparams)
	local t1 = os.clock()

	local r = math.ceil(rmax)
	nparams = nparams or {}
	for i,v in pairs(default_nparams) do
		nparams[i] = nparams[i] or v
	end
	nparams.spread = nparams.spread or vector.from_number(r*5)

	local pos = {x=math.random(-30000, 30000), y=math.random(-30000, 30000), z=math.random(-30000, 30000)}
	local map = minetest.get_perlin_map(nparams, vector.from_number(r+r+1)):get3dMap_flat(pos)

	local id = 1

	local bare_maxdist = rmax*rmax
	local bare_mindist = rmin*rmin

	local mindist = math.sqrt(bare_mindist)
	local dist_diff = math.sqrt(bare_maxdist)-mindist
	mindist = mindist/dist_diff

	local pval_min, pval_max

	local tab, n = {}, 1
	for z=-r,r do
		local bare_dist = z*z
		for y=-r,r do
			local bare_dist = bare_dist+y*y
			for x=-r,r do
				local bare_dist = bare_dist+x*x
				local add = bare_dist < bare_mindist
				local pval, distdiv
				if not add
				and bare_dist <= bare_maxdist then
					distdiv = math.sqrt(bare_dist)/dist_diff-mindist
					pval = math.abs(map[id]) -- strange perlin values…
					if not pval_min then
						pval_min = pval
						pval_max = pval
					else
						pval_min = math.min(pval, pval_min)
						pval_max = math.max(pval, pval_max)
					end
					add = true--distdiv < 1-math.abs(map[id])
				end

				if add then
					tab[n] = {{x=x, y=y, z=z}, pval, distdiv}
					n = n+1
				end
				id = id+1
			end
		end
	end

	-- change strange values
	local pval_diff = pval_max - pval_min
	pval_min = pval_min/pval_diff

	for n,i in pairs(tab) do
		if i[2] then
			local new_pval = math.abs(i[2]/pval_diff - pval_min)
			if i[3]+0.33 < new_pval then
				tab[n] = {i[1]}
			elseif i[3] < new_pval then
				tab[n] = {i[1], true}
			else
				tab[n] = nil
			end
		end
	end

	minetest.log("info", string.format("[vector_extras] table created after ca. %.2fs", os.clock() - t1))
	return tab
end

local circle_tables = {}
function funcs.circle(r)
	local table = circle_tables[r]
	if table then
		return table
	end

	local t1 = os.clock()
	local tab, n = {}, 1

	for i = -r, r do
		for j = -r, r do
			if math.floor(math.sqrt(i*i+j*j)+0.5) == r then
				tab[n] = {x=i, y=0, z=j}
				n = n+1
			end
		end
	end
	circle_tables[r] = tab
	minetest.log("info", string.format("[vector_extras] table created after ca. %.2fs", os.clock() - t1))
	return tab
end

local ring_tables = {}
function funcs.ring(r)
	local table = ring_tables[r]
	if table then
		return table
	end

	local t1 = os.clock()
	local tab, n = {}, 1

	local tmp = r*r
	local p = {x=math.floor(r+0.5), z=0}
	while p.x > 0 do
		tab[n] = p
		n = n+1
		local p1, p2 = {x=p.x-1, z=p.z}, {x=p.x, z=p.z+1}
		local dif1 = math.abs(tmp-p1.x*p1.x-p1.z*p1.z)
		local dif2 = math.abs(tmp-p2.x*p2.x-p2.z*p2.z)
		if dif1 <= dif2 then
			p = p1
		else
			p = p2
		end
	end

	local tab2, n = {}, 1
	for _,i in ipairs(tab) do
		for _,j in ipairs({
			{i.x, i.z},
			{-i.z, i.x},
			{-i.x, -i.z},
			{i.z, -i.x},
		}) do
			tab2[n] = {x=j[1], y=0, z=j[2]}
			n = n+1
		end
	end
	ring_tables[r] = tab2
	minetest.log("info", string.format("[vector_extras] table created after ca. %.2fs", os.clock() - t1))
	return tab2
end

function funcs.chunkcorner(pos)
	return {x=pos.x-pos.x%16, y=pos.y-pos.y%16, z=pos.z-pos.z%16}
end

function funcs.point_distance_minmax(p1, p2)
	local p1 = vector.new(p1)
	local p2 = vector.new(p2)
	local min, max, vmin, vmax, num
	for _,i in ipairs({"x", "y", "z"}) do
		num = math.abs(p1[i] - p2[i])
		if not vmin or num < vmin then
			vmin = num
			min = i
		end
		if not vmax or num > vmax then
			vmax = num
			max = i
		end
	end
	return min, max
end

function funcs.collision(p1, p2)
	local clear, node_pos, collision_pos, max, min, dmax, dcmax, pt
	clear, node_pos = minetest.line_of_sight(p1, p2)
	if clear then
		return false
	end
	collision_pos = {}
	min, max = funcs.point_distance_minmax(node_pos, p2)
	if node_pos[max] > p2[max] then
		collision_pos[max] = node_pos[max] - 0.5
	else
		collision_pos[max] = node_pos[max] + 0.5
	end
	dmax = p2[max] - node_pos[max]
	dcmax = p2[max] - collision_pos[max]
	pt = dcmax/dmax

	for _,i in ipairs({"x", "y", "z"}) do
		collision_pos[i] = p2[i] - (p2[i] - node_pos[i]) * pt
	end
	return true, collision_pos, node_pos
end

function funcs.get_data_from_pos(tab, z,y,x)
	local data = tab[z]
	if data then
		data = data[y]
		if data then
			return data[x]
		end
	end
end

function funcs.set_data_to_pos(tab, z,y,x, data)
	if tab[z] then
		if tab[z][y] then
			tab[z][y][x] = data
			return
		end
		tab[z][y] = {[x] = data}
		return
	end
	tab[z] = {[y] = {[x] = data}}
end

function funcs.set_data_to_pos_optional(tab, z,y,x, data)
	if vector.get_data_from_pos(tab, z,y,x) ~= nil then
		return
	end
	funcs.set_data_to_pos(tab, z,y,x, data)
end

function funcs.remove_data_from_pos(tab, z,y,x)
	if vector.get_data_from_pos(tab, z,y,x) == nil then
		return
	end
	tab[z][y][x] = nil
	if not next(tab[z][y]) then
		tab[z][y] = nil
	end
	if not next(tab[z]) then
		tab[z] = nil
	end
end

function funcs.get_data_pos_table(tab)
	local t,n = {},1
	local minz, miny, minx, maxz, maxy, maxx
	for z,yxs in pairs(tab) do
		if not minz then
			minz = z
			maxz = z
		else
			minz = math.min(minz, z)
			maxz = math.max(maxz, z)
		end
		for y,xs in pairs(yxs) do
			if not miny then
				miny = y
				maxy = y
			else
				miny = math.min(miny, y)
				maxy = math.max(maxy, y)
			end
			for x,v in pairs(xs) do
				if not minx then
					minx = x
					maxx = x
				else
					minx = math.min(minx, x)
					maxx = math.max(maxx, x)
				end
				t[n] = {z,y,x, v}
				n = n+1
			end
		end
	end
	return t, {x=minx, y=miny, z=minz}, {x=maxx, y=maxy, z=maxz}, n-1
end

function funcs.update_minp_maxp(minp, maxp, pos)
	for _,i in pairs({"z", "y", "x"}) do
		minp[i] = math.min(minp[i], pos[i])
		maxp[i] = math.max(maxp[i], pos[i])
	end
end

function funcs.quickadd(pos, z,y,x)
	if z then
		pos.z = pos.z+z
	end
	if y then
		pos.y = pos.y+y
	end
	if x then
		pos.x = pos.x+x
	end
end

function funcs.unpack(pos)
	return pos.z, pos.y, pos.x
end


dofile(minetest.get_modpath("vector_extras").."/vector_meta.lua")

for name,func in pairs(funcs) do
	vector[name] = vector[name] or func
end

minetest.log("info", string.format("[vector_extras] loaded after ca. %.2fs", os.clock() - load_time_start))
