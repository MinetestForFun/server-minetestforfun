-- Interval between movement checks (in seconds).
local INTERVAL = 5

-- Minimum distance to move to register as not AFK (in blocks).
local MINDIST = 0.2

-- If player does not move within this time, kick player (in seconds).
local TIMEOUT = 3600 -- 60 minutes

local time_afk = { }
local last_pos = { }

local function check_moved()
   for _, p in ipairs(minetest.get_connected_players()) do
      local plname = p:get_player_name()
      local pos = p:getpos()
      local kicked
      if last_pos[plname] then
         local d = vector.distance(last_pos[plname], pos)
         --print("Player: "..plname..", Dist: "..d)
         if d < MINDIST then
            time_afk[plname] = (time_afk[plname] or 0) + INTERVAL
            if time_afk[plname] >= TIMEOUT then
               minetest.kick_player(plname,
                     "Inactive for "..TIMEOUT.." seconds.")
               kicked = true
            end
         else
            time_afk[plname] = 0
         end
      end
      if not kicked then
         last_pos[plname] = pos
      end
   end
   minetest.after(INTERVAL, check_moved)
end
minetest.after(INTERVAL, check_moved)

minetest.register_on_leaveplayer(function(player)
   local plname = player:get_player_name()
   time_afk[plname] = nil
   last_pos[plname] = nil
end)
