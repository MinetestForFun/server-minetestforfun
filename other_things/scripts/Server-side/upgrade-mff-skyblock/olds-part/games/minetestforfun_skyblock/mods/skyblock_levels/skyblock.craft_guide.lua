--[[
Skyblock for Minetest
Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3
]]--

skyblock.craft_guide = {}

-- some common groups
local group_placeholder = {}
group_placeholder['group:wood'] = 'default:wood'
group_placeholder['group:tree'] = 'default:tree'
group_placeholder['group:flora'] = 'flowers:tulip'
group_placeholder['group:stick'] = 'default:stick'
group_placeholder['group:stone'] = 'default:cobble' -- 'default:stone'  point people to the cheaper cobble
group_placeholder['group:sand'] = 'default:sand'
group_placeholder['group:leaves'] = 'default:leaves'
group_placeholder['group:wood_slab'] = 'stairs:slab_wood'
group_placeholder['group:wool'] = 'wool:white'

-- handle the standard dye color groups
if( dyelocal and dyelocal.dyes ) then
	for i,d in ipairs( dyelocal.dyes ) do
		for k,v in pairs(d[3]) do
			if( k ~= 'dye' ) then
				group_placeholder['group:dye,'..k ] = 'dye:'..d[1]
			end
		end
	end
end

-- render an image button for a formspec
skyblock.craft_guide.image_button_link = function(stack_string)
	local group = ''
	if group_placeholder[stack_string] then
		stack_string = group_placeholder[stack_string]
		group = 'G'
	end		
	local stack = ItemStack(stack_string)
	local new_node_name = stack_string
	if( stack and stack:get_name()) then
		new_node_name = stack:get_name()
	end
	return tostring(stack_string)..';skyblock_craft_guide_'..tostring(new_node_name)..';'..group
end

-- get_formspec
skyblock.craft_guide.get_formspec = function(node_name, fields)
	node_name = node_name:gsub('skyblock_craft_guide_', '')

	local receipe_nr = 1
	if fields.node_name then
		node_name  = fields.node_name
		receipe_nr = tonumber(fields.receipe_nr)
	end

	-- the player may ask for recipe for ingredients to the current receipe
	if fields then
		for k,v in pairs(fields) do
			k = k:gsub('skyblock_craft_guide_', '')
			if (v and (minetest.registered_items[k]
			       or  minetest.registered_nodes[k]
			       or  minetest.registered_craftitems[k]
			       or  minetest.registered_tools[k] )) then
				node_name = k
				receipe_nr = 1
			end
		end
	end

	local res = minetest.get_all_craft_recipes(node_name) or {}

	-- offer all alternate crafting receipes through prev/next buttons
	if fields and fields.skyblock_craft_guide_prev_receipe and receipe_nr > 1 then
		receipe_nr = receipe_nr - 1
	elseif fields and fields.skyblock_craft_guide_next_receipe and receipe_nr < #res then
		receipe_nr = receipe_nr + 1
	end

	local formspec = 'size[5,6]'
		..'label[4,2;Output]'
		..'background[-0.1,0.9;5.2,3.8;craft.png]'
		..'button_exit[3,0;2,0.5;close;Close]'
		--..'button[0,0;2,0.5;main;Back]'
		..'field[20,20;0.1,0.1;node_name;node_name;'..node_name..']' -- invisible field for passing on information
		..'field[21,21;0.1,0.1;receipe_nr;receipe_nr;'..tostring(receipe_nr)..']' -- another invisible field
		..'item_image_button[4,2.5;1.0,1.0;'..tostring(node_name)..';normal;]'

	if not res or receipe_nr > #res or receipe_nr < 1 then
		receipe_nr = 1
	end
	if res and receipe_nr > 1 then
		formspec = formspec..'button[3.8,5.5;1,0.5;skyblock_craft_guide_prev_receipe;prev]'
	end
	if( res and receipe_nr < #res ) then
		formspec = formspec..'button[4.0,5.5;1,0.5;skyblock_craft_guide_next_receipe;next]'
	end
	if( not( res ) or #res<1) then
		formspec = formspec..'label[3,1.5;No receipes.]'
		if(minetest.registered_nodes[ node_name ]
		  and minetest.registered_nodes[ node_name ].drop ) then
			local drop = minetest.registered_nodes[ node_name ].drop
			if( drop and type( drop )=='string' and drop ~= node_name ) then
				formspec = formspec
					..'label[1,1.6;Drops on dig:]'
					..'item_image_button[1,2.5;1.0,1.0;'..skyblock.craft_guide.image_button_link( drop )..']'
			end
		end
	else
		formspec = formspec..'label[1,5.5;Alternate '..tostring( receipe_nr )..'/'..tostring( #res )..']'
		-- reverse order; default receipes (and thus the most interesting ones) are usually the oldest
		local receipe = res[ #res+1-receipe_nr ]
		if (receipe.type=='normal' and receipe.items) then
			for i=1,9 do
				if (receipe.items[i]) then
					formspec = formspec
						..'item_image_button['..((i-1)%receipe.width)..','..(math.floor((i-1)/receipe.width)+1.5)..';1.0,1.0;'
						..skyblock.craft_guide.image_button_link( receipe.items[i] )..']'
				end
			end
		elseif (receipe.type=='cooking' and receipe.items and #receipe.items==1) then
			formspec = formspec
				..'item_image_button[1,3;1,1;'..skyblock.craft_guide.image_button_link('default:furnace')..']' --default_furnace_front.png]'
				..'item_image_button[1,2;1,1;'..skyblock.craft_guide.image_button_link( receipe.items[1] )..']'
		else
			formspec = formspec..'label[0,1.5;Error: Unkown receipe.]'
		end
		-- show how many of the items the receipe will yield
		local outstack = ItemStack(receipe.output)
		if outstack and outstack:get_count() and outstack:get_count()>1 then
			formspec = formspec..'label[4.5,3;'..tostring(outstack:get_count())..']'
		end
		
		if receipe.type=='normal' then
			receipe.type = 'craft'
		elseif receipe.type=='cooking' then
			receipe.type = 'furnace'
		end
		formspec = formspec..'label[0,1; '..receipe.type..' recipe for '..tostring(node_name)..']'
	end

	return formspec
end

-- register_on_player_receive_fields
minetest.register_on_player_receive_fields(function(player, formname, fields)
	for k,v in pairs(fields) do
		if string.match(k, 'skyblock_craft_guide_') then
			minetest.show_formspec(player:get_player_name(),'skyblock_craft_guide',skyblock.craft_guide.get_formspec(k, fields))
			return
		end
	end
end)
