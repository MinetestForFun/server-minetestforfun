
-- stores up to 4 marker positions for each player
markers.positions = {}

-- store the positions of that many markers for each player (until server restart)
markers.MAX_MARKERS  = 50;

-- the protection against digging of the marker by other players expires after this time
markers.EXPIRE_AFTER = 60*60*24;

-- self-protected areas can not get higher than 100 blocks
markers.MAX_HEIGHT   = 100;

-- only areas up to this size (in square meters) can be protected
markers.MAX_SIZE     = 1024; -- 32m * 32m = 1024 m^2

-- show only areas withhin this range when showing the list of ALL areas
-- (else it does get too crowded on multiplayer servers)
-- set to something >60000 in order to view all areas; set to a smaller
-- value (i.e. 500) on multiplayer servers with many protected areas

if(     #areas.areas > 1000 ) then
	markers.AREA_RANGE   = 100;
elseif( #areas.areas > 100 ) then
	markers.AREA_RANGE   = 1000;
else
	markers.AREA_RANGE   = 100000;
end

-- for most cases, the default values ought to work
--markers.AREA_RANGE   = 100000;

if( io.open(minetest.get_worldpath().."/markers_settings.txt","r")) then
	io.close()
	dofile(minetest.get_worldpath().."/markers_settings.txt")
end
