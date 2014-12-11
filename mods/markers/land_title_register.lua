

minetest.register_tool( "markers:land_title_register",
{
    description = "Land title register. Left-click with it to get information about who owns the land you clicked on.",
    groups = {}, 
    inventory_image = "default_book.png", -- TODO
    wield_image = "",
    wield_scale = {x=1,y=1,z=1},
    stack_max = 1, -- there is no need to have more than one
    liquids_pointable = true, -- ground with only water on can be owned as well
    -- the tool_capabilities are completely irrelevant here - no need to dig
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level=0,
        groupcaps={
            fleshy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            snappy={times={[2]=0.80, [3]=0.40}, maxwear=0.05, maxlevel=1},
            choppy={times={[3]=0.90}, maxwear=0.05, maxlevel=0}
        }
    },
    node_placement_prediction = nil,

    on_place = function(itemstack, placer, pointed_thing)

       if( placer == nil or pointed_thing == nil) then
          return itemstack; -- nothing consumed
       end
       local name = placer:get_player_name();

       -- the position is what we're actually looking for
       local pos  = minetest.get_pointed_thing_position( pointed_thing, 0 ); --under );
       
       if( not( pos ) or not( pos.x )) then
          minetest.chat_send_player( name, "Position not found.");
          return itemstack;
       end

       -- this function shows the formspec with the information about the area(s)
       markers.show_marker_stone_formspec( placer, pos );

       return itemstack; -- nothing consumed, nothing changed
    end,
     

    on_use = function(itemstack, placer, pointed_thing)

       if( placer == nil or pointed_thing == nil) then
          return itemstack; -- nothing consumed
       end
       local name = placer:get_player_name();

       local pos  = minetest.get_pointed_thing_position( pointed_thing, under );
       
       if( not( pos ) or not( pos.x )) then
          minetest.chat_send_player( name, "Position not found.");
          return itemstack;
       end

       -- this function shows the formspec with the information about the area(s)
       markers.show_marker_stone_formspec( placer, pos );

       return itemstack; -- nothing consumed, nothing changed
    end,
})


minetest.register_craft({
   output = "markers:land_title_register",
   recipe = { { "markers:mark" },
              { "markers:stone" },
              { "default:book"}
             } });

