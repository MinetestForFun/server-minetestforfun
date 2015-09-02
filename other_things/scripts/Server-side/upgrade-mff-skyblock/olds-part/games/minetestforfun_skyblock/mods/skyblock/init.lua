--[[

Skyblock for Minetest

Copyright (c) 2015 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-skyblock
License: GPLv3

]]--


minetest.log('action', '         __         __    __           __  ')
minetest.log('action', '   _____/ /____  __/ /_  / /___  _____/ /__')
minetest.log('action', '  / ___/ //_/ / / / __ \\/ / __ \\/ ___/ //_/')
minetest.log('action', ' (__  ) ,< / /_/ / /_/ / / /_/ / /__/ ,<   ')
minetest.log('action', '/____/_/|_|\\__, /_.___/_/\\____/\\___/_/|_|  ')
minetest.log('action', '          /____/                           ')


local modpath = minetest.get_modpath('skyblock')

-- load apis
dofile(modpath..'/skyblock.lua')

-- register entities
dofile(modpath..'/register_node.lua')
dofile(modpath..'/register_misc.lua')

-- log that we started
skyblock.log('[MOD]'..minetest.get_current_modname()..' -- loaded from '..minetest.get_modpath(minetest.get_current_modname()))