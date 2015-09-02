-- minetest/creative/init.lua

local creative_inventory = {}
creative_inventory.creative_inventory_size = 0

-- Create detached creative inventory after loading all mods
minetest.after(0, function()
	local inv = minetest.create_detached_inventory("creative", {
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return count
		end,
		allow_put = function(inv, listname, index, stack, player)
			return 0
		end,
		allow_take = function(inv, listname, index, stack, player)
			return -1
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
		end,
		on_put = function(inv, listname, index, stack, player)
		end,
		on_take = function(inv, listname, index, stack, player)
			minetest.log("action", player:get_player_name().." takes item from creative inventory; listname="..dump(listname)..", index="..dump(index)..", stack="..dump(stack))
			if stack then
				minetest.log("action", "stack:get_name()="..dump(stack:get_name())..", stack:get_count()="..dump(stack:get_count()))
			end
		end,
	})
	local creative_list = {}
	for name,def in pairs(minetest.registered_items) do
		if (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0)
				and def.description and def.description ~= "" then
			table.insert(creative_list, name)
		end
	end
	table.sort(creative_list)
	inv:set_size("main", #creative_list)
	for _,itemstring in ipairs(creative_list) do
		inv:add_item("main", ItemStack(itemstring.." 99"))
	end
	creative_inventory.creative_inventory_size = #creative_list
	minetest.log("action", "creative inventory size: "..dump(creative_inventory.creative_inventory_size))
end)

-- Create the trash field
local trash = minetest.create_detached_inventory("creative_trash", {
	-- Allow the stack to be placed and remove it in on_put()
	-- This allows the creative inventory to restore the stack
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
trash:set_size("main", 1)


local get_formspec = function(player,start_i, pagenum)
	if not minetest.get_player_privs(player:get_player_name()).hg_maker then
		return "size[13,7.5]"
			.. inventory_plus.get_tabheader(player, "hgmaker")
	end
	pagenum = math.floor(pagenum)
	local pagemax = math.floor((creative_inventory.creative_inventory_size-1) / (6*4) + 1)
	return "size[13,7.5]"..
			--"image[6,0.6;1,2;player.png]"..
			default.inventory_background..
			default.inventory_listcolors..
			inventory_plus.get_tabheader(player, "hgmaker")..
			"list[current_player;main;5,3.5;8,4;]"..
			"list[current_player;craft;8,0;3,3;]"..
			"list[current_player;craftpreview;12,1;1,1;]"..
			"list[detached:creative;main;0.3,0.5;4,6;"..tostring(start_i).."]"..
			"label[2.0,6.55;"..tostring(pagenum).."/"..tostring(pagemax).."]"..
			"button[0.3,6.5;1.6,1;hg_prev;<<]"..
			"button[2.7,6.5;1.6,1;hg_next;>>]"..
			"label[5,1.5;Trash:]"..
			"list[detached:creative_trash;main;5,2;1,1;]"
end
minetest.register_on_joinplayer(function(player)
	-- If in creative mode, modify player's inventory forms
	if not minetest.get_player_privs(player:get_player_name()).hg_maker then
		return
	end
	inventory_plus.register_button(player,"hgmaker","HG Maker")
end)
minetest.register_on_player_receive_fields(function(player, formname, fields)

	-- Figure out current page from formspec
	local current_page = 0
	local formspec = player:get_inventory_formspec()
	local start_i = string.match(formspec, "list%[detached:creative;main;[%d.]+,[%d.]+;[%d.]+,[%d.]+;(%d+)%]")
	start_i = tonumber(start_i) or 0

	local function setformspec()
		if start_i < 0 then
			start_i = start_i + 4*6
		end
		if start_i >= creative_inventory.creative_inventory_size then
			start_i = start_i - 4*6
		end

		if start_i < 0 or start_i >= creative_inventory.creative_inventory_size then
			start_i = 0
		end

		inventory_plus.set_inventory_formspec(player, get_formspec(player, start_i, start_i / (6*4) + 1))
	end

	if fields.hg_prev then
		start_i = start_i - 4*6
		setformspec()
	end
	if fields.hg_next then
		start_i = start_i + 4*6
		setformspec()
	end

	if inventory_plus.is_called(fields, "hgmaker", player) then
		setformspec()
	end

end)


if minetest.setting_getbool("creative_mode") then

	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x=1,y=1,z=2.5},
		tool_capabilities = {
			full_punch_interval = 0.5,
			max_drop_level = 3,
			groupcaps = {
				crumbly = {times={[1]=0.5, [2]=0.5, [3]=0.5}, uses=0, maxlevel=3},
				cracky = {times={[1]=0.5, [2]=0.5, [3]=0.5}, uses=0, maxlevel=3},
				snappy = {times={[1]=0.5, [2]=0.5, [3]=0.5}, uses=0, maxlevel=3},
				choppy = {times={[1]=0.5, [2]=0.5, [3]=0.5}, uses=0, maxlevel=3},
				oddly_breakable_by_hand = {times={[1]=0.5, [2]=0.5, [3]=0.5}, uses=0, maxlevel=3},
				ladder_diggable = {times={[1] = 0.5}, uses=0}
			}
		}
	})

	function minetest.handle_node_drops(pos, drops, digger)
		if not digger or not digger:is_player() then
			return
		end
		local inv = digger:get_inventory()
		if inv then
			for _,item in ipairs(drops) do
				item = ItemStack(item):get_name()
				if not inv:contains_item("main", item) then
					inv:add_item("main", item)
				end
			end
		end
	end

end
