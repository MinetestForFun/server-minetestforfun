
-- markers are useful for measuring distances and for marking areas
-- markers are protected from digging by other players for one day
-- (the protection for the *marker* auto-expires then, and it can be digged)

markers = {}

-- stores up to 4 marker positions for each player
markers.positions = {}

-- store the positions of that many markers for each player (until server restart)
markers.MAX_MARKERS  = 10;
 
-- the protection against digging of the marker by other players expires after this time
markers.EXPIRE_AFTER = 60*60*24;

-- self-protected areas can not get higher than 100 blocks
markers.MAX_HEIGHT   = 100;

-- only areas up to this size (in square meters) can be protected
markers.MAX_SIZE     = 1024; -- 32m * 32m = 1024 m^2


dofile(minetest.get_modpath("markers").."/areas.lua");

dofile(minetest.get_modpath("markers").."/marker_stone.lua");

dofile(minetest.get_modpath("markers").."/land_title_register.lua");


-- returns the first area found
markers.get_area_by_pos1_pos2 = function(pos1, pos2)
   for id, area in pairs(areas.areas) do

      if( ((area.pos1.x == pos1.x and area.pos1.z == pos1.z )
        or (area.pos1.x == pos1.x and area.pos1.z == pos2.z )
        or (area.pos1.x == pos2.x and area.pos1.z == pos1.z )
        or (area.pos1.x == pos2.x and area.pos1.z == pos2.z ))

       and((area.pos2.x == pos1.x and area.pos2.z == pos1.z )
        or (area.pos2.x == pos1.x and area.pos2.z == pos2.z )
        or (area.pos2.x == pos2.x and area.pos2.z == pos1.z )
        or (area.pos2.x == pos2.x and area.pos2.z == pos2.z ))) then

          -- at least pos1 needs to have a hight value that fits in
          if(  (area.pos1.y <= pos1.y and area.pos2.y >= pos1.y)
            or (area.pos1.y >= pos1.y and area.pos2.y <= pos1.y)) then

             local found = area;
             found[ 'id' ] = id;
             return found;

          end
      end
   end
   return nil;
end






-- this function is supposed to return a text string describing the price of the land between po1 and pos2
-- You can return somethiing like "for free" or "the promise to build anything good" as well as any
-- real prices in credits or materials - it's really just a text here.
-- Make sure you do not charge the player more than what you ask here.
markers.calculate_area_price_text = function( pos1, pos2, playername )

   local price = ( math.abs( pos1.x - pos2.x )+1 )
               * ( math.abs( pos1.z - pos2.z )+1 );

--               * math.ceil( ( math.abs( pos1.y - pos2.y )+1 )/10);

   return tostring( price )..' credits';
end




markers.marker_placed = function( pos, placer, itemstack )
 
   if( not( pos ) or not( placer )) then
      return;
   end
 
   local meta = minetest.get_meta( pos );
   local name = placer:get_player_name();

   meta:set_string( 'infotext', 'Marker at '..minetest.pos_to_string( pos )..
				' (placed by '..tostring( name )..'). '..
				'Right-click to update.');
   meta:set_string( 'owner',    name );
   -- this allows protection of this particular marker to expire
   meta:set_string( 'time',     tostring( os.time()) );

   local txt = '';

   if( not( markers.positions[ name ] ) or #markers.positions[name]<1) then
      markers.positions[ name ] = {};
      markers.positions[ name ][ 1 ] = pos;
 
      minetest.chat_send_player( name,
		'First marker set to position '..
		minetest.pos_to_string( markers.positions[ name ][ 1 ] )..
		'. Please place a second marker to measure distance. '..
		'Place four markers in a square to define an area.');
   else
      table.insert( markers.positions[ name ], pos );

      local n = #markers.positions[ name ];

      local dx = markers.positions[ name ][ n ].x - markers.positions[ name ][ n-1 ].x;
      local dy = markers.positions[ name ][ n ].y - markers.positions[ name ][ n-1 ].y;
      local dz = markers.positions[ name ][ n ].z - markers.positions[ name ][ n-1 ].z;

      local dir_name = "unknown";
      local d = 0;
      if(     dx == 0 and dz > 0 )             then dir_name = "north"; d = math.abs(dz);
      elseif( dx == 0 and dz < 0 )             then dir_name = "south"; d = math.abs(dz);
      elseif( dz == 0 and dx > 0 )             then dir_name = "east";  d = math.abs(dx);
      elseif( dz == 0 and dx < 0 )             then dir_name = "west";  d = math.abs(dx);
      elseif( dx == 0 and dz == 0 and dy > 0 ) then dir_name = "above"; d = math.abs(dy);
      elseif( dx == 0 and dz == 0 and dy < 0 ) then dir_name = "below"; d = math.abs(dy);
      else

         local area   =        (math.abs( dx )+1)
                             * (math.abs( dz )+1);
         local volume = area * (math.abs( dy )+1);

         minetest.chat_send_player( name, 'This marker is at '..
               minetest.pos_to_string( markers.positions[ name ][ n ] )..', while the last one is at '..
               minetest.pos_to_string( markers.positions[ name ][ n-1 ] )..'. Distance (x/y/z): '..
               tostring(math.abs(dx))..'/'..
               tostring(math.abs(dy))..'/'..
               tostring(math.abs(dz))..
              '. Area: '..tostring( area )..' m^2. Volume: '..tostring( volume )..' m^3.');
      end
     
      -- this marker is aligned to the last one
      if( d > 0 ) then
         minetest.chat_send_player( name, 'Marker placed at '..minetest.pos_to_string( pos )..
				'. Relative to the marker you placed before, this one is '..
 				tostring( d )..' m '..dir_name..'.');
      end

      -- do the last 4 markers placed form an area?
      if( #markers.positions[ name ] > 3 ) then
         local count_x_coord = {};
         local count_z_coord = {};
         local anz_x_coord   = 0;
         local anz_z_coord   = 0;
         local check_failed  = 0;
         for i=0,3 do

            local v = markers.positions[ name ][ n-i ].x;

            if( not( count_x_coord[ v ] )) then
               count_x_coord[       v ] = 1;
               anz_x_coord = anz_x_coord + 1;
            elseif(  count_x_coord[ v ] == 2 ) then               
               check_failed = 1;
            else
               count_x_coord[       v ] = count_x_coord[ v ] + 1;
            end

            v = markers.positions[ name ][ n-i ].z;
            if( not( count_z_coord[ v ] )) then
               count_z_coord[       v ] = 1;
               anz_z_coord = anz_z_coord + 1;
            elseif(  count_z_coord[ v ] == 2 ) then               
               check_failed = 1;
            else
               count_z_coord[       v ] = count_z_coord[ v ] + 1;
            end
         end

         if(     anz_x_coord == 2 
            and  anz_z_coord == 2
            and check_failed == 0 ) then
               
            minetest.chat_send_player( name, 'The last four markers you placed form a rectangle. '..
                   'Right-click on this marker here in order to protect the area.');
         end
      end

      -- make sure the list does not grow too large
      if( n > markers.MAX_MARKERS ) then
         table.remove( markers.positions[ name ], 1 );
      end
   end
end



markers.marker_can_dig = function(pos,player) 

   if( not( pos ) or not( player )) then
      return true;
   end

   local meta  = minetest.get_meta( pos );
   local owner = meta:get_string( 'owner' );
   local time  = meta:get_string( 'time' ); 

   -- can the marker be removed?
   if( not( owner ) 
       or owner==''
       or not( time ) 
       or time==''
       or (os.time() - tonumber( time )) > markers.EXPIRE_AFTER ) then

      return true;

   -- marker whose data got lost anyway
   elseif( not( markers.positions[ owner ] )
            or #markers.positions[ owner ] < 1 ) then
   
     return true;

   -- marker owned by someone else and still in use
   elseif( owner ~= player:get_player_name()) then

      minetest.chat_send_player( player:get_player_name(),
		'Sorry, this marker belongs to '..tostring( owner )..
		'. If you still want to remove it, try again in '..
		( tostring( markers.EXPIRE_AFTER + tonumber( time ) - os.time()))..' seconds.');
      return false;

   end
  
   return true;
end




markers.marker_after_dig_node = function(pos, oldnode, oldmetadata, digger)

   if( not(oldmetadata ) or not(oldmetadata['fields'])) then
      return;
   end

   local owner = oldmetadata['fields']['owner'];
   if( not( owner ) 
       or owner==''
       or not( markers.positions[ owner ] )
       or     #markers.positions[ owner ] < 1 ) then

      return;
   end

   -- remove the markers position from our table of stored positions
   local found = 0;
   for i,v in ipairs( markers.positions[ owner ] ) do
      if(   v.x == pos.x 
        and v.y == pos.y
        and v.z == pos.z ) then
         found = i;
      end
   end
   if( found ~= 0 ) then
      table.remove( markers.positions[ owner ], found );
   end
   return true;
end






markers.get_marker_formspec = function(player, pos, error_msg)
   local formspec = "";

   local meta  = minetest.get_meta( pos );
   local owner = meta:get_string( 'owner' );

   local name  = player:get_player_name();

   local formspec_info = "size[6,4]"..
             "button_exit[2,2.5;1,0.5;abort;OK]"..
             "textarea[1,1;4,2;info;Information;";
   if( owner ~= nil and owner ~= '' and owner ~= name ) then
      return formspec_info.."This marker\ncan only be used by\n"..tostring( owner )..", who\nplaced the markers.]";
   end

   if( not( markers.positions[ name ]) or #markers.positions[name]<1) then
      return formspec_info.."Information about the positions\nof your other markers\ngot lost.\nPlease dig and place\nyour markers again!]";
   end

   local n = #markers.positions[ name ];

   if(    markers.positions[ name ][ n ].x ~= pos.x
      or  markers.positions[ name ][ n ].y ~= pos.y
      or  markers.positions[ name ][ n ].z ~= pos.z ) then

      return formspec_info.."Please use the marker\nyou placed last\n"..
                 "for accessing this menu.\nYou can find said marker at\n"..
                 minetest.pos_to_string( markers.positions[ name ][ n ] )..'.]';
   end

   if( n < 4 ) then
      return formspec_info.."Please place 4 markers\n - one in each corner\n of your area - first.]";
   end


   local coords_raw = meta:get_string( 'coords' );
   local coords      = {};
   if( coords_raw ~= nil and coords_raw ~= '' ) then
      coords = minetest.deserialize( coords_raw );
   end
   

   local opposite = n;
   -- the last 4 markers placed ought to form the area
   if( true or #coords ~= 2 ) then -- TODO
  

      for i=1,3 do

         -- if both coordinates are diffrent, then this may be the opposite marker
         if(   ( markers.positions[ name ][ n-i ].x ~=  
                 markers.positions[ name ][ n   ].x )
           and ( markers.positions[ name ][ n-i ].z ~=  
                 markers.positions[ name ][ n   ].z )) then 

             opposite = n-i;
             coords = { markers.positions[ name ][ n   ],
                        markers.positions[ name ][ n-i ] };
         end
      end

      -- check if they fit
      for i=1,3 do

         if(not( ((n-i) == opposite )
             or not(markers.positions[ name ][ n-i ] )
             or  ( markers.positions[ name ][ n-i ].x == coords[ 1 ].x
               and markers.positions[ name ][ n-i ].z == coords[ 2 ].z )
             or  ( markers.positions[ name ][ n-i ].x == coords[ 2 ].x
               and markers.positions[ name ][ n-i ].z == coords[ 1 ].z ))) then

            return formspec_info.."Error: The last 4 markers\nyou placed do not form\na rectangle.]";
         end

      end

      -- save data     
      meta:set_string( 'coords', minetest.serialize( coords ) );
   end

   -- the coordinates are set; we may present an input form now

    -- has the area already been defined?
    local area = markers.get_area_by_pos1_pos2( coords[1], coords[2] );


    local size = (math.abs( coords[1].x - coords[2].x )+1) 
               * (math.abs( coords[1].z - coords[2].z )+1);

    -- check if area is too large
    if( markers.MAX_SIZE < size ) then
       return formspec_info.."Error: You can only protect\nareas of up to "..tostring( markers.MAX_SIZE ).."m^2.\n"..
                             "Your marked area is "..tostring( size ).." m^2 large.]";
    end

    local formspec = 'size[10,7]'..
               'label[0.5,1;The area you marked extends from]'..
               'label[4.7,1;'..minetest.pos_to_string( coords[ 1 ] )..' to '..minetest.pos_to_string( coords[ 2 ] )..'.]'..
               'label[4.7,1.5;It spans '..tostring( math.abs( coords[1].x - coords[2].x )+1 )..
                               ' x '..tostring( math.abs( coords[1].z - coords[2].z )+1 )..
                               ' = '..tostring( size )..' m^2.]';

    -- display the error message (if there is any)
    if( error_msg ~= nil ) then
       formspec = formspec..
                    'label[0.5,0.0;Error: ]'..
                    'textarea[5.0,0;4,1.5;info;;'..error_msg..']';
    end
      
    if( area and area['id'] ) then
       formspec =   formspec..
                    'label[0.5,2.0;This is area number ]'..
                    'label[4.7,2.0;'..tostring( area['id'] )..'.]'..
                    'label[0.5,2.5;It is owned by ]'..
                    'label[4.7,2.5;'..tostring( area['owner'] )..'.]'..
                    'label[0.5,3.0;The area is called ]'..
                    'label[4.7,3.0;'..tostring( area['name'] )..'.]'..
                    "button_exit[2,6.0;2,0.5;abort;OK]";
    else
       formspec =   formspec..
                    'label[0.5,2.0;Buying this area will cost you ]'..
                    'label[4.7,2.0;'..markers.calculate_area_price_text( coords[1], coords[2], name )..'.]'..

                    'label[0.5,3.0;Your area ought to go..]'..
                    'label[0.5,3.5;this many blocks up:]'..
                    'field[5.0,4.0;1,0.5;add_height;;40]'..
                    'label[6.0,3.5;(relative to this marker)]'..

                    'label[0.5,4.0;and this many blocks down:]'..
                    'field[5.0,4.5;1,0.5;add_depth;;10]'..
                    'label[6.0,4.0;(relative to this marker)]'..

                    'label[0.5,4.5;The area shall be named]'..
                    'field[5.0,5.0;6,0.5;set_area_name;;please enter a name]'..
     
                    "button_exit[2,6.0;2,0.5;abort;Abort]"..
                    -- code the position in the "Buy area" field
                    "button_exit[6,6.0;2,0.5;"..minetest.pos_to_string(pos)..";Buy area]";
    end

   return formspec;
end



-- protect/buy an area
markers.marker_on_receive_fields = function(pos, formname, fields, sender)

   if( not( pos )) then
      minetest.chat_send_player( name, 'Sorry, could not find the marker you where using to access this formspec.' );
      return;
   end


   local meta  = minetest.get_meta( pos );

   local name  = sender:get_player_name();

   local coords_string = meta:get_string( 'coords' );
   if( not( coords_string ) or coords_string == '' ) then
      minetest.chat_send_player( name, 'Could not find marked area. Please dig and place your markers again!');
      return;
   end
   local coords = minetest.deserialize( coords_string );


   -- do not protect areas twice
   local area = markers.get_area_by_pos1_pos2( coords[1], coords[2] );
   if( area ) then

      minetest.chat_send_player( name, 'This area is already protected.');
      return;
   end


   -- check input
   local add_height = tonumber( fields['add_height'] );
   local add_depth  = tonumber( fields['add_depth']  );

   local error_msg = '';
   if(     not( add_height ) or add_height < 0 or add_height > markers.MAX_HEIGHT ) then
      minetest.chat_send_player( name, 'Please enter a number between 0 and '..tostring( markers.MAX_HEIGHT )..
		' in the field where the height of your area is requested. Your area will stretch that many blocks '..
		'up into the sky from the position of this marker onward.');
      error_msg = 'The height value\nhas to be larger than 0\nand smaller than '..tostring( markers.MAX_HEIGHT );
     
   elseif( not( add_depth  ) or add_depth  < 0 or add_depth  > markers.MAX_HEIGHT ) then
      minetest.chat_send_player( name, 'Please enter a number between 0 and '..tostring( markers.MAX_HEIGHT )..
		' in the field where the depth of your area is requested. Your area will stretch that many blocks '..
		'into the ground from the position of this marker onward.');
      error_msg = 'The depth value\nhas to be larger than 0\nand smaller than '..tostring( markers.MAX_HEIGHT );

   elseif( add_height + add_depth > markers.MAX_HEIGHT ) then
      minetest.chat_send_player( name,  'Sorry, your area exceeds the height limit. Height and depth added have to '..
		'be smaller than '..tostring( markers.MAX_HEIGHT )..'.');
      error_msg = 'height + depth has to\nbe smaller than '..tostring( markers.MAX_HEIGHT )..'.'

   elseif( not( fields[ 'set_area_name' ] ) or fields['set_area_name'] == 'please enter a name' ) then
      minetest.chat_send_player( name, 'Please provide a name for your area, i.e. \"'..
		tostring( name )..'s first house\" The name ought to describe what you intend to build here.');
      error_msg = 'Please provide a\nname for your area!';

   else
      error_msg = nil;
   end
 

   if( error_msg ~= nil ) then
      minetest.show_formspec( name, "markers:mark", markers.get_marker_formspec(sender, pos, error_msg));
      return;
   end


   -- those coords lack the height component
   local pos1 = coords[1];
   local pos2 = coords[2];
   -- apply height values from the formspeck
   pos1.y = pos.y + add_height;
   pos2.y = pos.y - add_depth;

   pos1, pos2 = areas:sortPos( pos1, pos2 );

   --minetest.chat_send_player('singleplayer','INPUT: '..minetest.serialize( pos1  )..' pos2: '..minetest.serialize( pos2 ));
   minetest.log("action", "[markers] /protect invoked, owner="..name..
                                " areaname="..fields['set_area_name']..
                                " startpos="..minetest.pos_to_string(pos1)..
                                " endpos="  ..minetest.pos_to_string(pos2));

   local canAdd, errMsg = areas:canPlayerAddArea(pos1, pos2, name)
   if not canAdd then
      minetest.chat_send_player(name, "You can't protect that area: "..errMsg)
      minetest.show_formspec( name, "markers:mark", markers.get_marker_formspec(sender, pos, errMsg));
      return
   end

   local id = areas:add(name, fields['set_area_name'], pos1, pos2, nil)
   areas:save()

   minetest.chat_send_player(name, "Area protected. ID: "..id)

   minetest.show_formspec( name, "markers:mark", markers.get_marker_formspec(sender, pos, nil));
end



-- formspec input needs to be handled diffrently
markers.form_input_handler = function( player, formname, fields)

   if( formname == "markers:mark" ) then


      if( not(fields) or fields['abort']) then
         return true;
      end

      --- decode the position of the marker (which is hidden in the Buy-buttons name
      local pos = {};
      for k, v in pairs( fields ) do
         if( v == 'Buy area' ) then
            pos = minetest.string_to_pos( k );
         end
      end
      if( pos and pos.x and pos.y and pos.z ) then
         markers.marker_on_receive_fields(pos, formname, fields, player);
      end
      return true;


   elseif( formname == "markers:info"
      and player
      and markers.menu_data_by_player[ player:get_player_name() ] ) then

      local res = markers.form_input_handler_areas( player, formname, fields);
      if( res ) then
         return true;
      end
  
      -- TODO
--      minetest.chat_send_player('singleplayer','MARKERS:INFO WITH '..minetest.serialize( fields ));

   else
      -- TODO
--      minetest.chat_send_player('singleplayer','YOU CALLED '..tostring( formname )..' WITH '..minetest.serialize( fields ));

   end
   
   return false;

end

minetest.register_on_player_receive_fields( markers.form_input_handler)




minetest.register_node("markers:mark", {
	description = "Marker",
	tiles = {"markers_mark.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=2,choppy=2,dig_immediate=3},
	light_source = 1,
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.1, -0.5, -0.1, 0.1, 1.5, 0.1 },
			},
		},

        after_place_node = function(pos, placer, itemstack)
           markers.marker_placed( pos, placer, itemstack );
        end,
  
        -- the node is digged immediately, so we may as well do all the work in can_dig (any wrong digs are not that critical)
        can_dig = function(pos,player) 
           return markers.marker_can_dig( pos, player );
        end,

        after_dig_node = function(pos, oldnode, oldmetadata, digger)
           return markers.marker_after_dig_node( pos, oldnode, oldmetadata, digger );
        end,

	on_rightclick = function(pos, node, clicker)

           minetest.show_formspec( clicker:get_player_name(),
				   "markers:mark",
				   markers.get_marker_formspec(clicker, pos, nil)
			);
	end,
})


minetest.register_craft({
   output = "markers:mark 4",
   recipe = { { "group:stick" },
              { "default:apple" },
              { "group:stick" },
             } });

