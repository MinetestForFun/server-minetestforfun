local drop = function(pos, itemstack)

   local it = itemstack:take_item(itemstack:get_count())
   local obj = core.add_item(pos, it)

   if obj then

   obj:setvelocity({x=math.random(-2.5,2.5), y=7, z=math.random(-2.5,2.5)})

   local remi = minetest.setting_get("remove_items")

   if remi and remi == "true" then
      obj:remove()
   end

   end
   return itemstack
end

minetest.register_on_dieplayer(function(player)

   if minetest.setting_getbool("creative_mode") then
      return
   end

   local pos = player:getpos()
   pos.y = math.floor(pos.y + 0.5)

   minetest.chat_send_player(player:get_player_name(), 'at '..math.floor(pos.x)..','..math.floor(pos.y)..','..math.floor(pos.z))

   local player_inv = player:get_inventory()

   for i=1,player_inv:get_size("main") do
      drop(pos, player_inv:get_stack("main", i))
      player_inv:set_stack("main", i, nil)
   end

   for i=1,player_inv:get_size("craft") do
      drop(pos, player_inv:get_stack("craft", i))
      player_inv:set_stack("craft", i, nil)
   end

   -- Drop unified_inventory bags and their contents
   if minetest.get_modpath("unified_inventory") then
      
      local bag_id = {"bag1", "bag2", "bag3", "bag4"}
      local contents_id = ""
      local n = 0

      for n = 1, 4 do
         if player_inv:get_size(bag_id[n]) ~= nil and player_inv:get_size(bag_id[n]) == 1 then
            contents_id = bag_id[n].."contents"
            -- Drop the contents of the bag (but keep the bag itself)
            for i = 1, player_inv:get_size(contents_id) do
               -- Drop a clone of this item's stack and remove the one from the inventory
               drop(pos, player_inv:get_stack(contents_id, i))
               player_inv:set_stack(contents_id, i, nil)
            end
         end
      end

   end

end)
