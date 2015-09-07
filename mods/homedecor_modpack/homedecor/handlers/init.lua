local handlerpath = homedecor.modpath .. "/handlers/"

-- nodebox arithmetics and helpers
-- (please keep non-generic nodeboxes with their node definition)
dofile(handlerpath.."nodeboxes.lua")

-- expand and unexpand decor
dofile(handlerpath.."expansion.lua")

-- register nodes that cook stuff
dofile(handlerpath.."furnaces.lua")

-- inventory related functionality, like initialization, ownership and spawning locked versions
dofile(handlerpath.."inventory.lua")

-- glue it all together into a registration function
dofile(handlerpath.."registration.lua")

-- some nodes have particle spawners
dofile(handlerpath.."water_particles.lua")

dofile(handlerpath.."sit.lua")
