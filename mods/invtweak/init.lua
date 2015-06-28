local auto_refill = minetest.setting_getbool("invtweak_auto_refill") or true

local tweak = {}
tweak.formspec = {}

tweak.buttons = {
--sort_asc
"0.8,0.6;sort_asc;^]".."tooltip[sort_asc;sort Items asc.;#30434C;#FFF]",
--sort_desc
"0.8,0.6;sort_desc;v]".."tooltip[sort_desc;sort Items desc.;#30434C;#FFF]",
--concatenate
"0.8,0.6;sort;·»]".."tooltip[sort;stack Items and sort asc.;#30434C;#FFF]"
}

local function get_formspec_size(formspec)
	local w = 8
	local h = 7.5
	if not formspec then return end
	local sstring = string.find(formspec,"size[",1,true)
	if sstring ~= nil then
		sstring = string.sub(formspec, sstring+5)
		local p = string.find(sstring,",")
		w = string.sub(sstring,1,p-1)
		sstring = string.sub(sstring,p+1,string.find(sstring,"]")+2)
		p = string.find(sstring,",")
		if p == nil then p = string.find(sstring,"]") end
		h = string.sub(sstring,1,p-1)
	end
	return w,h
end

local function add_buttons(player, formspec)
	local name = player:get_player_name()
	if not formspec then
		formspec = player:get_inventory_formspec()
	end
	local w,h = get_formspec_size(formspec)
	if not w or not h then
		return
	end
	for i=1,#tweak.buttons do
		formspec = formspec .. "button["..w-(0.8+(i*0.8))..",0.2;" .. tweak.buttons[i]
	end
	player:set_inventory_formspec(formspec)
	return formspec
end

local armor_mod = minetest.get_modpath("3d_armor")
local ui_mod = minetest.get_modpath("unified_inventory")
-- override mods formspec function
if ui_mod then
	local org = unified_inventory.get_formspec
	unified_inventory.get_formspec = function(player, page)
		local formspec = org(player, page)
		return add_buttons(player, formspec)
	end
end
if armor_mod and not ui_mod then
	local org = armor.get_armor_formspec
	armor.get_armor_formspec = function(self, name)
		local formspec = org(self, name)
		return add_buttons(minetest.get_player_by_name(name), formspec)
	end
end

minetest.register_on_joinplayer(function(player)
	local formspec = nil
	if armor_mod and not ui_mod then
		formspec = armor.get_armor_formspec(self, player:get_player_name())
	end
	minetest.after(0.65,function()
		add_buttons(player, formspec)
	end)
end)


local function comp_asc(w1,w2)
	if w1.name < w2.name then
		return true
	end
end

local function comp_desc(w1,w2)
	if w1.name > w2.name then
		return true
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.sort_asc then
		tweak.sort(player, comp_asc)
	end
	if fields.sort_desc then
		tweak.sort(player, comp_desc)
	end
	if fields.sort then
		tweak.sort(player, comp_asc, true)
	end

	-- player inventory
	if minetest.setting_getbool("creative_mode") then
		add_buttons(player)
	end
end)

-- sort asc without mod prefix
local function comp_in(w1, w2)
	local w11 = string.find(w1.name, ":")
	local w22 = string.find(w2.name, ":")
	if w11 ~= nil then
		w11 = string.sub(w1.name,w11)
	else
		w11 = w1.name
	end
	if w22 ~= nil then
		w22 = string.sub(w2.name,w22)
	else
		w22 = w2.name
	end
	if w11 < w22 then
		return true
	end
end

tweak.concatenate = function(list)
	local last = nil
	local last_cnt = 100
	local refresh = false
	for _,stack in ipairs(list) do
		local i = _
		if refresh then
			refresh = false
			table.sort(list, comp_asc)
			list = tweak.concatenate(list)
			break
		end
		if stack.name ~= "zztmpsortname" and last == stack.name then
			if last_cnt < stack.max then
				local diff = stack.max - last_cnt
				local add = stack.count
				if stack.count > diff then
					stack.count = stack.count - diff
					add = diff
				else
					stack.name = "zztmpsortname"
					refresh = true
				end
				list[i-1].count = list[i-1].count + add
			end
		end
		last = stack.name
		last_cnt = stack.count
	end
	return list
end

tweak.sort = function(player, mode, con)
	local inv = player:get_inventory()
	if inv then
		local list = inv:get_list("main")
		local tmp_list = {}

		--write whole list as table
		for _,stack in ipairs(list) do
			local tbl_stack = stack:to_table()
			if tbl_stack == nil then tbl_stack = {name="zztmpsortname"} end
			tbl_stack.max = stack:get_stack_max()
			tmp_list[_]=tbl_stack
		end

		-- sort asc/desc
		table.sort(tmp_list, mode)

		if con then
			tmp_list = tweak.concatenate(tmp_list)
			table.sort(tmp_list, mode)
		end

		--write back to inventory
		for _,stack in ipairs(tmp_list) do
			stack.max = nil
			if stack.name ~= "zztmpsortname" then
				inv:set_stack("main", _, ItemStack(stack))
			else
				inv:set_stack("main", _, ItemStack(nil))
			end
		end
	end
end


-- tool break sound  + autorefill
function refill(player, stck_name, index)
	local inv = player:get_inventory()
	for i,stack in ipairs(inv:get_list("main")) do
		if stack:get_name() == stck_name then
			inv:set_stack("main", index, stack)
			stack:clear()
			inv:set_stack("main", i, stack)
			minetest.log("action", "Inventory Tweaks: refilled stack("..stck_name..") of "  .. player:get_player_name()  )
			return
		end
	end
end

if auto_refill == true then
	minetest.register_on_placenode(function(pos, newnode, placer, oldnode)
		if not placer then return end
		local index = placer:get_wield_index()
		local cnt = placer:get_wielded_item():get_count()-1
		if minetest.setting_getbool("creative_mode") then
			return
		else
			if cnt == 0 then
				minetest.after(0.01, refill, placer, newnode.name, index)
			end
		end
	end)
end

local wielded = {}
wielded.name = {}
wielded.wear = {}

minetest.register_on_punchnode(function(pos, node, puncher)
	if not puncher or minetest.setting_getbool("creative_mode") then
		return
	end
	local name = puncher:get_player_name()

	local item = puncher:get_wielded_item()
	local tname = item:get_name()
	local def = minetest.registered_tools[tname]

	wielded.name[name] = tname

	if not item or not tname or tname == "" or not def then
		return
	end
	local typ = def.type
	if not typ or typ ~= "tool" then
		return
	end
	wielded.wear[name] = item:get_wear()
	-- TODO: re-add for custom tools like lighter
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
	if not digger then return end

	local name = digger:get_player_name()
	local item = digger:get_wielded_item()
	local index = digger:get_wield_index()
	local tname = item:get_name()
	local def = minetest.registered_tools[tname]


	if not item then
		return
	end
	if tname ~= "" then
		if not def then
			return
		end
	end

	local old_name = wielded.name[name]
	if tname == old_name and tname == "" then
		return
	end

	local old = wielded.wear[name]
	if not old and tname == "" then
		old = 0
	end
	local new = item:get_wear()

	if old ~= new then
		if old and old > 0 and new == 0 then
			wielded.wear[name] = new
			minetest.sound_play("invtweak_tool_break", {
				pos = digger:getpos(),
				gain = 0.9,
				max_hear_distance = 5
			})
			if auto_refill == true then
				minetest.after(0.01, refill, digger, old_name, index)
			end
		end
	end
end)
