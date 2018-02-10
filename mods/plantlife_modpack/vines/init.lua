vines = {
  name = 'vines',
  recipes = {}
}

-- support for i18n
local S = plantlife_i18n.gettext

dofile( minetest.get_modpath( vines.name ) .. "/functions.lua" )
dofile( minetest.get_modpath( vines.name ) .. "/aliases.lua" )
dofile( minetest.get_modpath( vines.name ) .. "/recipes.lua" )
dofile( minetest.get_modpath( vines.name ) .. "/crafts.lua" )
dofile( minetest.get_modpath( vines.name ) .. "/nodes.lua" )
dofile( minetest.get_modpath( vines.name ) .. "/shear.lua" )
dofile( minetest.get_modpath( vines.name ) .. "/vines.lua" )

minetest.log("action", "[Vines] Loaded!") --MFF
