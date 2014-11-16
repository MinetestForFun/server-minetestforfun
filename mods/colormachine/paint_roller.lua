-- This is based upon the paint_roller mod by Krock.

minetest.register_tool("colormachine:paint_roller", {
	description = "Paint roller",
	inventory_image = "paint_roller.png",
	on_use = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		local idx = placer:get_wield_index() + 1
		if idx > 7 then	--copied from explorer tools moo-ha-ha
			return
		end
		if minetest.is_protected(pointed_thing.under, placer:get_player_name()) then
			minetest.record_protection_violation(pointed_thing.under, placer:get_player_name())
			return
		end
		local node      = minetest.get_node(pointed_thing.under);
		local node_name = node.name

		local inv = placer:get_inventory()
		local stack = inv:get_stack("main", idx) --dye
		local stack_name = stack:get_name()

		local res           = colormachine.get_node_name_painted( node_name, stack_name );

		if( not( res) or not( res.possible  ) or #res.possible < 1 or (#res.possible==1 and res.possible[1]==node_name)) then
			return;
		end
		local index = 1;
		for i,v in ipairs( res.possible ) do
			if( v==node_name and i < #res.possible and #res.possible[i+1]) then
				index = i+1;
			end
		end

		-- return the old dye
		if( res.old_dye and res.old_dye ~= stack_name ) then
			inv:add_item( 'main', res.old_dye..' 1' );
		end

		-- consume one dye
		if( stack_name and stack_name ~= '' and (not(res.old_dye) or res.old_dye~=stack_name)) then
			inv:remove_item( 'main', stack_name..' 1');
		end

		-- paint the node
		minetest.set_node(pointed_thing.under, {name=res.possible[ index ], param2=node.param2})

		--itemstack:add_wear( 65535 / 30 );
		return itemstack
	end
})

minetest.register_craft({
	output = "colormachine:paint_roller",
	recipe = {
		{"wool:white",	"wool:white",	"default:steel_ingot"},
		{"",	"default:steel_ingot",	""},
		{"",	"default:steel_ingot",	""},
	}
})
