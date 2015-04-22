dofile(minetest.get_modpath("builtin_falling") .. "/func.lua") -- Not EDIT THAT
--
-- Config
--

-- Protect in realtime the lava flowing (can be slow)
PROTECT_LAVA_REALTIME = 0 -- 0 for OFF , 1 for ON
-- Protect in realtime the water flowing (can be very slow, because some water in this world :p)
PROTECT_WATER_REALTIME = 0 -- 0 for OFF , 1 for ON

add_protected_bukket_liquid("bucket:bucket_lava","default:lava_source") -- lava bukket
add_protected_bukket_liquid("bucket:bucket_water","default:water_source") -- water bukket

 -- Not EDIT AFTER
dofile(minetest.get_modpath("builtin_falling") .. "/rewirting.lua") -- Not EDIT THAT
