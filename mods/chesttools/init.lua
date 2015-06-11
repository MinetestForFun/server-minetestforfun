
chesttools = {}

chesttools.chest_add = {};
chesttools.chest_add.tiles  = {
		"chesttools_blue_chest_top.png", "chesttools_blue_chest_top.png", "chesttools_blue_chest_side.png",
		"chesttools_blue_chest_side.png", "chesttools_blue_chest_side.png", "chesttools_blue_chest_lock.png"};
chesttools.chest_add.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2};
chesttools.chest_add.tube   = {};

-- additional/changed definitions for pipeworks;
-- taken from pipeworks/compat.lua
if( minetest.get_modpath( 'pipeworks' )) then
	chesttools.chest_add.tiles = {
		"chesttools_blue_chest_top.png^pipeworks_tube_connection_wooden.png",
		"chesttools_blue_chest_top.png^pipeworks_tube_connection_wooden.png",
		"chesttools_blue_chest_side.png^pipeworks_tube_connection_wooden.png",
		"chesttools_blue_chest_side.png^pipeworks_tube_connection_wooden.png",
		"chesttools_blue_chest_side.png^pipeworks_tube_connection_wooden.png"};
	chesttools.chest_add.groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,
			tubedevice = 1, tubedevice_receiver = 1 };
	chesttools.chest_add.tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("main", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("main", stack)
		end,
		input_inventory = "main",
		connect_sides = {left=1, right=1, back=1, front=1, bottom=1, top=1}
	};
end

chesttools.formspec = "size[9,10]"..
			"list[current_name;main;0.5,0.3;8,4;]"..
			"label[0.0,4.4;Main]"..
			"button[1.0,4.5;1,0.5;craft;Craft]"..
			"button[7.0,4.5;0.5,0.5;drop_all;DA]"..
			"button[7.5,4.5;0.5,0.5;take_all;TA]"..
			"button[8.0,4.5;0.5,0.5;swap_all;SA]"..
			"button[8.5,4.5;0.5,0.5;filter_all;FA]";

if( minetest.get_modpath( 'unified_inventory')) then
	chesttools.formspec = chesttools.formspec..
			"button[2.0,4.5;1,0.5;bag1;Bag 1]"..
			"button[3.0,4.5;1,0.5;bag2;Bag 2]"..
			"button[4.0,4.5;1,0.5;bag3;Bag 3]"..
			"button[5.0,4.5;1,0.5;bag4;Bag 4]";
end


chesttools.may_use = function( pos, player )
	local name = player:get_player_name();
	local meta = minetest.get_meta( pos );
	local owner = meta:get_string( 'owner' )
	-- the owner can access the chest
	if( owner == name or owner == "" ) then
		return true;
	end
	-- the shared function only kicks in if the area is protected
	if(   not( minetest.is_protected(pos, player:get_player_name()))
	      and  minetest.is_protected(pos, ' _DUMMY_PLAYER_ ')) then
		return true;
	end
	return true;
end


chesttools.on_receive_fields = function(pos, formname, fields, player)
	if( fields.quit ) then
		return;
	end
	local formspec = "size[9,10]"..
			"list[current_name;main;0.5,0.3;8,4;]"..
			"button[7.0,4.5;0.5,0.5;drop_all;DA]"..
			"button[7.5,4.5;0.5,0.5;take_all;TA]"..
			"button[8.0,4.5;0.5,0.5;swap_all;SA]"..
			"button[8.5,4.5;0.5,0.5;filter_all;FA]";
	local bm = "button[0.0,4.5;1,0.5;main;Main]";
	local bc = "button[1.0,4.5;1,0.5;craft;Craft]";
	local b1 = "button[2.0,4.5;1,0.5;bag1;Bag 1]";
	local b2 = "button[3.0,4.5;1,0.5;bag2;Bag 2]";
	local b3 = "button[4.0,4.5;1,0.5;bag3;Bag 3]";
	local b4 = "button[5.0,4.5;1,0.5;bag4;Bag 4]";

	local selected = '';
	if( fields.drop_all or fields.take_all or fields.swap_all or fields.filter_all ) then
		-- check if the player has sufficient access to the chest
		local node = minetest.get_node( pos );
		local meta = minetest.get_meta( pos );
		-- deny access for unsupported chests
		if( not( node )
		    or (node.name == 'chesttools:shared_chest' and not( chesttools.may_use( pos, player )))
		    or (node.name == 'default:chest_locked'and player:get_player_name() ~= meta:get_string('owner' ))) then
			if( node.name ~= 'default:chest' ) then
				minetest.chat_send_player( player:get_player_name(), 'Sorry, you do not have access to the content of this chest.');
				return;
			end
		end
		selected = fields.selected;
		if( not( selected ) or selected == '' ) then
			selected = 'main';
		end
		local inv_list = 'main';
		if(     selected == 'main' ) then
			inv_list = 'main';
		elseif( selected == 'craft' ) then
			inv_list = 'craft';
		elseif( selected == 'bag1' or selected == 'bag2' or selected == 'bag3' or selected=='bag4') then
			inv_list = selected.."contents";
		end

		local player_inv = player:get_inventory();
		local chest_inv  = meta:get_inventory();

		if( fields.drop_all ) then
			for i,v in ipairs( player_inv:get_list( inv_list ) or {}) do
				if( chest_inv and chest_inv:room_for_item('main', v)) then
					local leftover = chest_inv:add_item( 'main', v );
					player_inv:remove_item( inv_list, v );
					if( leftover and not( leftover:is_empty() )) then
						player_inv:add_item( inv_list, v );
					end
				end
			end
		elseif( fields.take_all ) then
			for i,v in ipairs( chest_inv:get_list( 'main' ) or {}) do
				if( player_inv:room_for_item( inv_list, v)) then
					local leftover = player_inv:add_item( inv_list, v );
					chest_inv:remove_item( 'main', v );
					if( leftover and not( leftover:is_empty() )) then
						chest_inv:add_item( 'main', v );
					end
				end
			end

		elseif( fields.swap_all ) then
			for i,v in ipairs( player_inv:get_list( inv_list ) or {}) do
				if( chest_inv ) then
					local tmp = player_inv:get_stack( inv_list, i );
					player_inv:set_stack(   inv_list, i, chest_inv:get_stack( 'main', i ));
					chest_inv:set_stack(    'main',   i, v );
				end
			end

		elseif( fields.filter_all ) then
			for i,v in ipairs( player_inv:get_list( inv_list ) or {}) do
				if( chest_inv and chest_inv:room_for_item('main', v) and chest_inv:contains_item( 'main', v:get_name())) then
					local leftover = chest_inv:add_item( 'main', v );
					player_inv:remove_item( inv_list, v );
					if( leftover and not( leftover:is_empty() )) then
						player_inv:add_item( inv_list, v );
					end
				end
			end
		end
	end

	local meta = minetest.get_meta( pos );
	local bag_nr = 0;
	if(     fields[ 'main'] or selected=='main') then
		bag_nr = 0;
		formspec = formspec..
			"list[current_player;main;0.5,5.5;8,4;]";
		bm = "label[0.0,4.4;Main]";
		selected = 'main';

	elseif( fields[ 'craft'] or selected=='craft') then
		bag_nr = 0;
		formspec = formspec..
			"label[0,5.5;Crafting]"..
			"list[current_player;craftpreview;6.5,6.5;1,1;]"..
			"list[current_player;craft;2.5,6.5;3,3;]";
		bc = "label[1.0,4.4;Craft]";
		selected = 'craft';

	elseif( fields[ 'bag1' ] or selected=='bag1') then
		bag_nr = 1;
		b1     = "label[2.0,4.4;Bag 1]";
		selected = 'bag1';
	elseif( fields[ 'bag2' ] or selected=='bag2') then
		bag_nr = 2;
		b2     = "label[3.0,4.4;Bag 2]";
		selected = 'bag2';
	elseif( fields[ 'bag3' ] or selected=='bag3') then
		bag_nr = 3;
		b3     = "label[4.0,4.4;Bag 3]";
		selected = 'bag3';
	elseif( fields[ 'bag4' ] or selected=='bag4') then
		bag_nr = 4;
		b4     = "label[5.0,4.4;Bag 4]";
		selected = 'bag4';
	end

	if( bag_nr >= 1 and bag_nr <= 4 ) then
		formspec = formspec..
			"label[0.5,5.5;Bag "..bag_nr.."]";
		local stack = player:get_inventory():get_stack( "bag"..bag_nr, 1)
		if( stack and not( stack:is_empty())) then
			local image = stack:get_definition().inventory_image
			if( image ) then
				formspec = formspec..
					"image[7.5,5.5;1,1;"..image.."]";
			end
			local slots = stack:get_definition().groups.bagslots
			if( slots and slots>0 ) then -- no bag present?
				formspec = formspec..
					"list[current_player;bag"..bag_nr.."contents;0.5,6.5;8,"..tostring(slots/8)..";]";
			end
		end
	end


	formspec = formspec..bm..bc..b1..b2..b3..b4..
		-- provide the position of the chest
		"field[20,20;0.1,0.1;pos2str;Pos;"..minetest.pos_to_string( pos ).."]"..
		-- which inventory was selected?
		"field[20,20;0.1,0.1;selected;selected;"..selected.."]";

	-- instead of updating the formspec of the chest - which would be slow - we display
	-- the new formspec directly to the player who asked for it;
	-- this is also necessary because players may have bags with diffrent sizes
	minetest.show_formspec( player:get_player_name(), "chesttools:shared_chest", formspec );
end


chesttools.update_chest = function(pos, formname, fields, player)
	local pname = player:get_player_name();
	if( not( pos ) or not( pos.x ) or not( pos.y ) or not( pos.z )) then
		return;
	end
	local node = minetest.get_node( pos );

	local price = 1;
	if(     node.name=='default:chest' ) then
		if( fields.normal) then
			return;
		end
		if( fields.locked ) then
			price = 1;
		elseif( fields.shared ) then
			price = 2;
		end
	elseif( node.name=='default:chest_locked' ) then
		if( fields.locked) then
			return;
		end
		if( fields.normal ) then
			price = -1;
		elseif( fields.shared ) then
			price = 1;
		end

	elseif( node.name=='chesttools:shared_chest') then
		if( fields.shared) then
			return;
		end
		if( fields.normal ) then
			price = -2;
		elseif( fields.locked ) then
			price = -1;
		end

	else
		return;
	end

	local player_inv = player:get_inventory();
	if( price>0 and not( player_inv:contains_item( 'main', 'default:steel_ingot '..tostring( price )))) then
		minetest.chat_send_player( pname, 'Sorry. You do not have '..tostring( price )..' steel ingots for the update.');
		return;
	end

	-- only work on chests owned by the player (or unlocked ones)
	local meta = minetest.get_meta( pos );
	if( node.name ~= 'default:chest' and meta:get_string( 'owner' ) ~= pname ) then
		minetest.chat_send_player( pname, 'You can only upgrade your own chests.');
		return;
	end

	-- check if steel ingot is present
	if( minetest.is_protected(pos, pname )) then
		minetest.chat_send_player( pname, 'This chest is protected from digging.');
		return;
	end

	if( price     > 0 ) then
		player_inv:remove_item( 'main', 'default:steel_ingot '..tostring( price ));
	elseif( price < 0 ) then
		price = price * -1;
		player_inv:add_item(    'main', 'default:steel_ingot '..tostring( price ));
	end

	-- set the owner field
	meta:set_string( 'owner', pname );

	target = node.name;
	if( fields.locked ) then
		target = 'default:chest_locked';
		meta:set_string("infotext", "Locked Chest (owned by "..meta:get_string("owner")..")")
	elseif( fields.shared ) then
		target = 'chesttools:shared_chest';
		meta:set_string("infotext", "Shared Chest (owned by "..meta:get_string("owner")..")")
	else
		target = 'default:chest';
		meta:set_string("infotext", "Chest")
	end

	if( not( fields.shared )) then
		meta:set_string("formspec", "size[9,10]"..
				    "list[current_name;main;0.5,0.3;8,4;]"..
				    "list[current_player;main;0.5,5.5;8,4;]");
	else
		meta:set_string("formspec", chesttools.formspec..
				    "list[current_player;main;0.5,5.5;8,4;]");
	end
	minetest.swap_node( pos, { name = target, param2 = node.param2 });

	minetest.chat_send_player( pname, 'Chest changed to '..tostring( minetest.registered_nodes[ target].description )..
			' for '..tostring( price )..' steel ingots.');
end


-- translate general formspec calls back to specific chests/locations
chesttools.form_input_handler = function( player, formname, fields)
	if( (formname == "chesttools:shared_chest" or formname == "chesttools:update") and fields.pos2str ) then
		local pos = minetest.string_to_pos( fields.pos2str );
		if(     formname == "chesttools:shared_chest") then
			chesttools.on_receive_fields(pos, formname, fields, player);
		elseif( formname == "chesttools:update") then
			chesttools.update_chest(     pos, formname, fields, player);
		end

		return;
	end
end


-- establish a callback so that input from the player-specific formspec gets handled
minetest.register_on_player_receive_fields( chesttools.form_input_handler );


minetest.register_node( 'chesttools:shared_chest', {
	description = 'Shared chest which can be used by all who can build at that spot',
	name   = 'shared chest',
	tiles  = chesttools.chest_add.tiles,
        groups = chesttools.chest_add.groups,
	tube   = chesttools.chest_add.tube,
        paramtype2 = "facedir",
        legacy_facedir_simple = true,
        is_ground_content = false,
        sounds = default.node_sound_wood_defaults(),

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Shared Chest (owned by "..meta:get_string("owner")..")")
	end,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Shared Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		meta:set_string("formspec", chesttools.formspec..
					"list[current_player;main;0.5,5.5;8,4;]");
	end,

	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and player:get_player_name() == meta:get_string('owner');
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index,
            to_list, to_index, count, player)

		-- the shared function only kicks in if the area is protected
		if( not( chesttools.may_use( pos, player ))) then
			return 0;
		end
		return count;
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)

		if( not( chesttools.may_use( pos, player ))) then
			return 0;
		end
		return stack:get_count();
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)

		if( not( chesttools.may_use( pos, player ))) then
			return 0;
		end
		return stack:get_count();
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			" puts "..tostring( stack:to_string() ).." to shared chest at "..minetest.pos_to_string(pos))
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
			" takes "..tostring( stack:to_string() ).." from shared chest at "..minetest.pos_to_string(pos))
	end,


	on_receive_fields = function(pos, formname, fields, sender)

		if( not( chesttools.may_use( pos, sender ))) then
			return;
		end
		chesttools.on_receive_fields( pos, formname, fields, sender);
	end,

	on_use = function(itemstack, user, pointed_thing)
		if( user == nil or pointed_thing == nil or pointed_thing.type ~= 'node') then
			return nil;
		end
		local name = user:get_player_name();

		local pos  = minetest.get_pointed_thing_position( pointed_thing, mode );
		local node = minetest.get_node_or_nil( pos );

		if( node == nil or not( node.name )) then
			return nil;
		end

		if(    node.name=='default:chest'
		    or node.name=='default:chest_locked'
		    or node.name=='chesttools:shared_chest') then

			local formspec = "size[8,4]"..
					 "label[2,0.4;Change chest type:]"..
					 "field[20,20;0.1,0.1;pos2str;Pos;"..minetest.pos_to_string( pos ).."]"..
					 "button_exit[2,3.5;1.5,0.5;abort;Abort]";
			if( node.name ~= 'default:chest' ) then
				formspec = formspec..'item_image_button[1,1;1.5,1.5;default:chest;normal;]'..
					   'button_exit[1,2.5;1.5,0.5;normal;normal]';
			else
				formspec = formspec..'item_image[1,1;1.5,1.5;default:chest]'..
					   'label[1,2.5;normal]';
			end
			if( node.name ~= 'default:chest_locked' ) then
				formspec = formspec..'item_image_button[3,1;1.5,1.5;default:chest_locked;locked;]'..
					   'button_exit[3,2.5;1.5,0.5;locked;locked]';
			else
				formspec = formspec..'item_image[3,1;1.5,1.5;default:chest_locked]'..
					   'label[3,2.5;locked]';
			end
			if( node.name ~= 'chesttools:shared_chest' ) then
				formspec = formspec..'item_image_button[5,1;1.5,1.5;chesttools:shared_chest;shared;]'..
					   'button_exit[5,2.5;1.5,0.5;shared;shared]';
			else
				formspec = formspec..'item_image[5,1;1.5,1.5;chesttools:shared_chest]'..
					   'label[5,2.5;shared]';
			end
			minetest.show_formspec( name, "chesttools:update", formspec );
		end
		return nil;
	end,
})

minetest.register_craft({
	output = 'chesttools:shared_chest',
	type   = 'shapeless',
	recipe = { 'default:steel_ingot', 'default:chest_locked' },
})
