
--[[
    color chooser for unifieddyes

    Copyright (C) 2013 Sokomine

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]



-- Version 0.6

-- Changelog: 
-- 17.09.14 Added a modified version of Krocks paintroller from his paint_roller mod.
--          Added additional storage area for dyes (works like a chest for now)
-- 03.09.14 Added a second block type menu.
--          Updated dependency list.
--          Added support for homedecor kitchen chairs, beds and bathroom tiles. Changed sorting order of blocks.
-- 11.06.14 Added support for clstone; see https://forum.minetest.net/viewtopic.php?f=9&t=9257
--          Changed dye source for white dye from stone to clay as stone can now be colored.
--          Added support for colorcubes; see https://forum.minetest.net/viewtopic.php?f=9&t=9486
--          Updated support for new sea modpack; see https://forum.minetest.net/viewtopic.php?f=11&t=4627
--          Adjusted support for hardenedclay; see https://forum.minetest.net/viewtopic.php?f=9&t=8232
--          Added support for new blox blocks; see https://forum.minetest.net/viewtopic.php?id=1960#p24748
--          Made the formspec a bit wider in order to account for all the new blocks.
-- 12.03.14 Added support for colouredstonebricks. See https://forum.minetest.net/viewtopic.php?f=9&t=8784
--          Modified support for hardenedclay due to progress in that mod.
-- 13.02.14 Added support for chests and locked chests from the kerova mod.
--          Added support for hardenedclay mod (to a degree; that mod needs to be fixed first)
--          Added optional obj_postfix support where blocknames are like MODNAME:PREFIX_COLOR_POSTFIX
-- 01.01.14 Added support for plasticbox mod
-- 25.08.13 Added support for framedglass from technic.
--          Added support for shells_dye (lightglass) from the sea mod.
-- 24.08.13 Changed mainmenu so that it hopefully gets more intuitive.
--          Added support for coloredblocks (two-colored blocks).
--          Changed name of superglowglass to super_glow_glass for current moreblocks.
--          Added config option for new stained_glass version.
-- 02.08.13 In creative mode, no dyes are consumed, and an entire stack can be painted at once.
--          Added some more labels in the main menu to make it easier to understand.
-- 22.07.13 Added textures provided by Vanessae
--          fixed a bug concerning normal dyes (when unifieddyes is not installed)
    
-- adds a function to check ownership of a node; taken from VanessaEs homedecor mod
colormachine = {};

colormachine.colors = {
        "red",
        "orange",
        "yellow",
        "lime",
        "green",
        "aqua",
        "cyan",
        "skyblue",
        "blue",
        "violet",
        "magenta",
        "redviolet"
}


-- set this to 0 if you're using that branch of stained_glass where the node names correspond to those of unified_dyes
local stained_glass_exception = 0;

-- the names of suitable sources of that color (note: this does not work by group!);
-- you can add your own color sources here if you want
colormachine.basic_dye_sources  = { "flowers:rose",      "flowers:tulip",         "flowers:dandelion_yellow", 
                                    "",                  "default:cactus",        "",  "",  "", -- no lime, no aqua, no cyan, no skyblue
                                    "flowers:geranium",  "flowers:viola",         "",  "",      -- no magenta, no redviolet
                                    "default:clay_lump", "", "", "", "default:coal_lump" };

-- if flowers is not installed
colormachine.alternate_basic_dye_sources  = { 
                                    "default:apple",     "default:desert_stone",  "default:sand",  
                                    "",                  "default:cactus",        "",  "",  "",
                                    "default:leaves",    "",                      "",  "" ,
                                    "default:clay_lump", "", "", "", "default:coal_lump" };



colormachine.dye_mixes          = { red       = {},      -- base color
                                    orange    = {1,3},   -- red + yellow
                                    yellow    = {},      -- base color
                                    lime      = {3,5},   -- yellow + green
                                    green     = {3,9},   -- yellow + blue
                                    aqua      = {5,7},   -- green + cyan
                                    cyan      = {5,9},   -- green + blue
                                    skyblue   = {7,9},   -- cyan + blue
                                    blue      = {},      -- base color
                                    violet    = {9,11},  -- blue + magenta
                                    magenta   = {9,1},   -- blue + red
                                    redviolet = {11,1},  -- magenta + red

                                    white     = {},      -- base color
                                    lightgrey = {13,15},   -- white + grey
                                    grey      = {13,17},   -- black + white 
                                    darkgrey  = {15,17},   -- grey + black
                                    black     = {},      -- base color
                                  }
                                   


-- construct the formspec for the color selector
colormachine.prefixes     = { 'light_', '', 'medium_', 'dark_' };

-- grey colors are named slightly different
colormachine.grey_names   = { 'white', 'lightgrey', 'grey', 'darkgrey', 'black' };


-- practical for handling of the dyes
colormachine.colors_and_greys = {};
for i,v in ipairs( colormachine.colors ) do
  colormachine.colors_and_greys[ i ] = v;
end
for i,v in ipairs( colormachine.grey_names ) do
  colormachine.colors_and_greys[ #colormachine.colors + i ] = v;
end

-- defines the order in which blocks are shown
--   nr:          the diffrent block types need to be ordered by some system; the number defines that order
--   modname:     some mods define more than one type of colored blocks; the modname is needed 
--                for checking if the mod is installed and for creating colored blocks
--   shades:      some mods (or parts thereof) do not support all possible shades
--   grey_shades: some mods support only some shades of grey (or none at all)
--   u:           if set to 1, use full unifieddyes-colors; if set to 0, use only normal dye/wool colors
--   descr:       short description of nodes of that type for the main menu
--   block:       unpainted basic block
--   add:         item names are formed by <modname>:<add><colorname> (with colorname beeing variable)
--                names for the textures are formed by <index><colorname><png> mostly (see colormachine.translate_color_name(..))

colormachine.data = {
-- the dyes as such
   unifieddyes_              = { nr=1,  modname='unifieddyes',   shades={1,0,1,1,1,1,1,1}, grey_shades={1,1,1,1,1}, u=1, descr="ufdye",  block="dye:white", add="", p=1 },

-- coloredwood: sticks not supported (they are only craftitems)
   coloredwood_wood_         = { nr=2,  modname='coloredwood',   shades={1,0,1,1,1,1,1,1}, grey_shades={1,1,1,1,1}, u=1, descr="planks", block="default:wood", add="wood_", p=2  },
   coloredwood_fence_        = { nr=3,  modname='coloredwood',   shades={1,0,1,1,1,1,1,1}, grey_shades={1,1,1,1,1}, u=1, descr="fence",  block="default:fence_wood", add="fence_", p=2},

-- unifiedbricks: clay lumps and bricks not supported (they are only craftitems)
   unifiedbricks_clayblock_  = { nr=4,  modname='unifiedbricks', shades={1,0,1,1,1,1,1,1}, grey_shades={1,1,1,1,1}, u=1, descr="clay",   block="default:clay",  add="clayblock_",p=1 },
   unifiedbricks_brickblock_ = { nr=5,  modname='unifiedbricks', shades={1,0,1,1,1,1,1,1}, grey_shades={1,1,1,1,1}, u=1, descr="brick",  block="default:brick", add="brickblock_",p=1},
   -- the multicolored bricks come in fewer intensities (only 3 shades) and support only 3 insted of 5 shades of grey
   unifiedbricks_multicolor_ = { nr=6,  modname='unifiedbricks', shades={1,0,0,0,1,0,1,0}, grey_shades={0,1,1,1,0}, u=1, descr="mbrick", block="default:brick", add="multicolor_",p=1},

   hardenedclay_             = { nr=3.5, modname='hardenedclay', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="hclay",  block="hardenedclay:hardened_clay_white", add="hardened_clay_", obj_postfix='',p=16},
   colouredstonebricks_      = { nr=3.6, modname='colouredstonebricks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="cbrick",  block="default:stonebrick", add="", obj_postfix='',p=1},
   
   clstone_stone_            = { nr=3.7, modname='clstone',       shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="clstone",block="default:stone", add="", p=1, obj_postfix='_stone' },

   colorcubes_1_             = { nr=3.8, modname='colorcubes',    shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="ccubes",block="default:stone", add="", p=1, obj_postfix='_single' },
   colorcubes_4_             = { nr=3.9, modname='colorcubes',    shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="ccube4",block="default:stone", add="", p=1, obj_postfix='_tiled' },
   colorcubes_inward_        = { nr=3.91,modname='colorcubes',    shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="ccubei",block="default:stone", add="", p=1, obj_postfix='_inward' },
   colorcubes_window_        = { nr=3.93,modname='colorcubes',    shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="ccubew",block="default:stone", add="", p=1, obj_postfix='_window' },


-- stained_glass: has a "faint" and "pastel" version as well (which are kind of additional shades used only by this mod)

   -- no shades of grey for the glass
   stained_glass_            = { nr=7,  modname='stained_glass', shades={1,0,1,1,1,1,1,1}, grey_shades={0,0,0,0,0}, u=1, descr="glass",  block="moreblocks:super_glow_glass", add="",p=2},
   stained_glass_faint_      = { nr=8,  modname='stained_glass', shades={0,0,1,0,0,0,0,0}, grey_shades={0,0,0,0,0}, u=1, descr="fglass", block="moreblocks:super_glow_glass", add="",p=2},
   stained_glass_pastel_     = { nr=9,  modname='stained_glass', shades={0,0,1,0,0,0,0,0}, grey_shades={0,0,0,0,0}, u=1, descr="pglass", block="moreblocks:super_glow_glass", add="",p=2},

   -- use 9.5 to insert it between stained glass and cotton
   framedglass_              = { nr=9.5, modname='framedglass',  shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="fglass", block="framedglass:steel_framed_obsidian_glass", add="steel_framed_obsidian_glass",p=1},

--   sea-modpack
   shells_dye_               = { nr=9.6, modname='shells_dye',   shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="lglass", block="shells_dye:whitelightglass", add="",p=1 },
-- TODO shells_dye:whitelightglass
   seaglass_seaglass_        = {nr=9.61, modname='seaglass',     shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="seagls", block="seaglass:seaglass", add="seaglass_", p=1},
   seacobble_seacobble_      = {nr=9.62, modname='seacobble',    shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=1, descr="seacob", block="seacobble:seacobble", add="seacobble_", p=1},
   seastone_seastone_        = {nr=9.63, modname='seastone',     shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=1, descr="seasto", block="seastone:seastone", add="seastone_", p=1},
   seastonebrick_seastonebrick_={nr=9.64,modname='seastonebrick',shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=1, descr="seastb", block="seastonebrick:seastonebrick", add="seastonebrick_", p=1},
   seagravel_seagravel_      = {nr=9.65, modname='seagravel',    shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=1, descr="seagrv", block="seagravel:seagravel", add="seagravel_", p=1},

-- cotton:
   cotton_                   = { nr=10, modname='cotton',        shades={1,0,1,1,1,1,1,1}, grey_shades={1,1,1,1,1}, u=1, descr="cotton", block="cotton:white",   add="", p=8  },

-- normal wool (from minetest_gmae) - does not support all colors from unifieddyes
   wool_                     = { nr=11, modname='wool',          shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="wool",   block="wool:white",     add="", p=16  },

-- normal dye mod (from minetest_game) - supports as many colors as the wool mod
   dye_                      = { nr=12, modname='dye',           shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="dye",    block="dye:white",      add="", p=1  },

   beds_bed_top_top_         = { nr=13, modname='beds',          shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,1,0,1}, u=0, descr="beds",   block="beds:bed_white", add="bed_bottom_",p=1},

   lrfurn_armchair_front_    = { nr=14, modname='lrfurn',        shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,1,0,1}, u=0, descr="armchair",block="lrfurn:armchair_white", add="armchair_",p=1 },
   lrfurn_sofa_right_front_  = { nr=15, modname='lrfurn',        shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,1,0,1}, u=0, descr="sofa",    block="lrfurn:longsofa_white", add="sofa_right_",p=1 },
   lrfurn_longsofa_middle_front_= { nr=16, modname='lrfurn',     shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,1,0,1}, u=0, descr="longsofa",block="lrfurn:sofa_white", add="longsofa_right_",p=1 },


   -- grey variants do not seem to exist, even though the textures arethere (perhaps nobody wants a grey flag!)
   flags_                    = { nr=17, modname='flags',         shades={0,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=1, descr="flags",   block="flags:white", add="", p=3 },

   blox_stone_               = { nr=18, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="SnBlox",  block="default:stone", add="stone", p=2 },
   blox_quarter_             = { nr=19, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="S4Blox",  block="default:stone", add="quarter", p=4 },
   blox_checker_             = { nr=20, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="S8Blox",  block="default:stone", add="checker", p=4 },
   blox_diamond_             = { nr=21, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="SDBlox",  block="default:stone", add="diamond", p=3},
   blox_cross_               = { nr=22, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="SXBlox",  block="default:stone", add="cross", p=6 },
   blox_square_              = { nr=23, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="SQBlox",  block="default:stone", add="square", p=4 },
   blox_loop_                = { nr=24, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="SLBlox",  block="default:stone", add="loop", p=4 },
   blox_corner_              = { nr=25, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="SCBlox",  block="default:stone", add="corner", p=6 },

   blox_wood_                = { nr=26, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="WnBlox",  block="default:wood", add="wood", p=2 },
   blox_quarter_wood_        = { nr=27, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="W4Blox",  block="default:wood", add="quarter_wood",p=4 },
   blox_checker_wood_        = { nr=28, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="W8Blox",  block="default:wood", add="checker_wood",p=4},
   blox_diamond_wood_        = { nr=29, modname='blox',          shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="WDBlox",  block="default:wood", add="diamond_wood",p=4},
   blox_cross_wood_          = { nr=29.1, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="WXBlox",  block="default:wood", add="cross_wood",p=4},
   blox_loop_wood_           = { nr=29.3, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="WLBlox",  block="default:wood", add="loop_wood",p=4},
   blox_corner_wood_         = { nr=29.4, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="WCBlox",  block="default:wood", add="corner_wood",p=4},

   blox_cobble_              = { nr=30,   modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="CnBlox",  block="default:cobble", add="cobble",p=2 },
   blox_quarter_cobble_      = { nr=30.1, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="C4Blox",  block="default:cobble", add="quarter_cobble",p=4 },
   blox_checker_cobble_      = { nr=30.2, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="C8Blox",  block="default:cobble", add="checker_cobble",p=4},
   blox_diamond_cobble_      = { nr=30.3, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="CDBlox",  block="default:cobble", add="diamond_cobble",p=4},
   blox_cross_cobble_        = { nr=30.4, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="CXBlox",  block="default:cobble", add="cross_cobble",p=4},
   blox_loop_cobble_         = { nr=30.6, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="CLBlox",  block="default:cobble", add="loop_cobble",p=4},
   blox_corner_cobble_       = { nr=30.7, modname='blox',        shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,1}, u=0, descr="CCBlox",  block="default:cobble", add="corner_cobble",p=4},

   homedecor_window_shutter_ = { nr=16.1, modname='homedecor',     shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="homedec",  block="homedecor:shutter_oak", add="shutter_",p=16},
   forniture_armchair_top_   = { nr=16.2, modname='homedecor',     shades={1,0,1,0,0,0,1,0}, grey_shades={0,0,0,0,1}, u=0, descr="armchair", block="homedecor:armchair_black", add="armchair_",p=1},
   forniture_kitchen_chair_sides_ = {nr=16.3, modname='homedecor',shades={1,0,1,0,0,0,1,0}, grey_shades={0,0,0,0,1}, u=0, descr="kchair",   block="homedecor:chair", add="chair_",p=1},
   homedecor_bed_            = {nr=16.4, modname='homedecor',     shades={1,0,1,0,0,0,1,0}, grey_shades={0,0,0,0,1}, u=0, descr="hbed",     block="homedecor:bed_darkgrey_foot", add="bed_",p=1, obj_postfix='_foot'},
   homedecor_bathroom_tiles_ = {nr=16.5, modname='homedecor',     shades={1,0,1,0,0,0,1,0}, grey_shades={0,0,0,0,1}, u=0, descr="htiles",   block="homedecor:tiles_1", add="tiles_",p=1},
   homedecor_curtain_        = { nr=16.6, modname='homedecor',     shades={1,0,1,0,0,0,0,0}, grey_shades={1,0,0,0,0}, u=0, descr="curtain",  block="homedecor:curtain_white", add="curtain_"},


   plasticbox_               = { nr=16.7, modname='plasticbox',  shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="plastic", block="plasticbox:plasticbox", add="plasticbox_",p=16},


   kerova_chest_front_       = { nr=16.8, modname='kerova',      shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="kerova", block="default:chest",  add="chest_",p=16},
   kerova_chest_lock_        = { nr=16.9, modname='kerova',      shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,1,1,1}, u=0, descr="kerolo", block="default:chest_locked", add="chest_", obj_postfix='_locked',p=16},

   coloredblocks_red_        = { nr=34, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_red", block="coloredblocks:white_white", add="red_",p=1},
   coloredblocks_yellow_     = { nr=35, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_yel", block="coloredblocks:white_white", add="yellow_",p=1},
   coloredblocks_green_      = { nr=36, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_gre", block="coloredblocks:white_white", add="green_",p=1},
   coloredblocks_cyan_       = { nr=37, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_cya", block="coloredblocks:white_white", add="cyan_",p=1},
   coloredblocks_blue_       = { nr=38, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_blu", block="coloredblocks:white_white", add="blue_",p=1},
   coloredblocks_magenta_    = { nr=39, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_mag", block="coloredblocks:white_white", add="magenta_",p=1},
   coloredblocks_brown_      = { nr=40, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_bro", block="coloredblocks:white_white", add="brown_",p=1},
   coloredblocks_white_      = { nr=41, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_whi", block="coloredblocks:white_white", add="white_",p=1},
   coloredblocks_black_      = { nr=42, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_bla", block="coloredblocks:white_white", add="black_",p=1},


--[[
   coloredblocks_red_        = { nr=34, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_red", block="coloredblocks:red", add="red_",p=1},
   coloredblocks_yellow_     = { nr=35, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_yel", block="coloredblocks:yellow", add="yellow_",p=1},
   coloredblocks_green_      = { nr=36, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_gre", block="coloredblocks:green", add="green_",p=1},
   coloredblocks_cyan_       = { nr=37, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_cya", block="coloredblocks:cyan", add="cyan_",p=1},
   coloredblocks_blue_       = { nr=38, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_blu", block="coloredblocks:blue", add="blue_",p=1},
   coloredblocks_magenta_    = { nr=39, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_mag", block="coloredblocks:magenta", add="magenta_",p=1},
   coloredblocks_brown_      = { nr=40, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_bro", block="coloredblocks:brown", add="brown_",p=1},
   coloredblocks_white_      = { nr=41, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_whi", block="coloredblocks:white", add="",p=1},
   coloredblocks_black_      = { nr=42, modname='coloredblocks', shades={1,0,1,0,0,0,1,0}, grey_shades={1,0,0,0,1}, u=0, descr="cb_bla", block="coloredblocks:black", add="black_",p=1},
--]]
}


colormachine.ordered = {}


-- the function that creates the color chooser based on the textures of the nodes offered (texture names have to start with m_prefix)
colormachine.generate_form = function( m_prefix )

   local form = "size["..tostring( #colormachine.colors+2 )..",10]".."label[5,0;Select a color:]"..
         "label[5,8.2;Select a color or]"..
         "button[7,8.2;2,1;abort;abort selection]"..
         "label[0.3,1;light]";

   -- not all mods offer all shades (and some offer even more)
   local supported = colormachine.data[ m_prefix ].shades; 

   if( supported[2]==0 ) then
      form = form..
         "label[0.3,2;normal]"..
         "label[0.3,4;medium]"..
         "label[0.3,6;dark]";
   else
      form = form..
         "label[0.3,3;normal]"..
         "label[0.3,5;medium]"..
         "label[0.3,7;dark]";
   end

   for x,basecolor in ipairs( colormachine.colors ) do
      local p_offset = 1;

      form = form.."label["..tostring(x)..",0.5;"..tostring( basecolor ).."]";


      for y,pre in ipairs( colormachine.prefixes ) do

         if( supported[ y * 2-1 ]==1 ) then
            form = form..colormachine.print_color_image( nil, m_prefix, tostring( pre )..tostring( basecolor ), x, y*2-1, -1, x, p_offset, 0 );
         end

         p_offset = p_offset + 1;

         -- these only exist in unifieddyes and need no translation
         if( supported[ y * 2   ]==1 ) then
            form = form..colormachine.print_color_image( nil, m_prefix, tostring( pre )..tostring( basecolor )..'_s50', x, y*2,   -1, x, p_offset, 0 );
         end

         -- the first row does not always hold all colors
         if( y >1 or supported[ y * 2   ]==1) then
            p_offset = p_offset + 1;
         end
      end
   end

   -- shades of grey
   form = form.. "label["       ..tostring( #colormachine.colors+1 )..",0.5;grey]";
   for i,gname in ipairs( colormachine.grey_names ) do
      if( colormachine.data[ m_prefix ].grey_shades[ i ]==1 ) then

         form = form..colormachine.print_color_image( nil, m_prefix, gname, -1, -1, i, tostring( #colormachine.colors+1 ), tostring( i+1 ), 0 );
      end
   end
   return form;
end



colormachine.decode_color_name = function( meta, new_color )

   -- decode the color codes
   local liste = new_color:split( "_" );
   if( #liste < 1 or #liste > 3 ) then
      liste = {'white'};
   end
   -- perhaps it's one of the grey colors?
   for i,v in ipairs( colormachine.grey_names ) do
      if( v == liste[1] ) then
         if( meta ) then
            meta:set_string('selected_shade',      -1 ); -- grey-shade
            meta:set_string('selected_grey_shade',  i );
            meta:set_string('selected_color',      -1 ); -- we selected grey
            meta:set_string('selected_name',       new_color );
            return new_color;
         else
            return { s=-1, g=i, c=-1 };
         end
      end
   end

   if( #liste < 1 ) then
      if( meta ) then
         return meta:get_string('selected_name');
      else
         return nil;
      end
   end

   local selected_shade = 2; -- if no other shade is selected, use plain color
   local vgl = liste[1]..'_';
   for i,v in ipairs( colormachine.prefixes ) do
      if( v == vgl or v== liste[1]) then
         selected_shade = i;
         table.remove( liste, 1 ); -- this one has been done
      end
   end

   if( #liste < 1 ) then
      if( meta ) then
         return meta:get_string('selected_name');
      else
         return nil;
      end
   end

   local selected_color = -1;
   for i,v in ipairs( colormachine.colors ) do
      if( v == liste[1] ) then
         selected_color = i;
         table.remove( liste, 1 ); -- the color has been selected
      end
   end
 
   -- the color was not found! error! keep the old color
   if( selected_color == -1 ) then
      if( meta ) then
         return meta:get_string('selected_name');
      else
         return nil;
      end
   end

   if( #liste > 0 and liste[1]=='s50') then
      selected_shade = selected_shade * 2;
   else
      selected_shade = selected_shade * 2 - 1;
   end

   if( meta ) then
      meta:set_string('selected_shade',      selected_shade ); -- grey-shade
      meta:set_string('selected_grey_shade', -1 );
      meta:set_string('selected_color',      selected_color ); -- we selected grey
      meta:set_string('selected_name',       new_color );
      return new_color;
   else
      return { s=selected_shade, g=-1, c= selected_color };
   end
end



-- returns "" if the item does not exist;
-- wrapper for colormachine.translate_color_name(..)

colormachine.print_color_image = function( meta, k, new_color, c, s, g, pos_x, pos_y, change_link )

   local translated_color     = colormachine.translate_color_name( meta, k, new_color, c, s, g, 0 );
   if( not( translated_color )) then
      return "";
   end

   local translated_node_name = colormachine.translate_color_name( meta, k, new_color, c, s, g, 1 );
   if( not( translated_node_name )) then
      return "";
   end

   -- a node or craftitem of that name does not exist
   if(    not( minetest.registered_nodes[      translated_node_name ])
      and not( minetest.registered_craftitems[ translated_node_name ])) then

--print("NOT FOUND: "..tostring( translated_node_name ).." image_button["..tostring(pos_x)..","..tostring(pos_y)..";1,1;"..translated_color..";"..tostring(link).."; ]");
      return "";
   end
   -- switch to the color selector for that blocktype
   local link = new_color;
   if( change_link==1 ) then
      link = k;
   end

   return "image_button["..tostring(pos_x)..","..tostring(pos_y)..";1,1;"..translated_color..";"..tostring(link).."; ]";
end


-- returns the translated name of the color if necessary (wool/normal dye is named differently than unifieddyes);
-- either meta or c, s and g together need to be given
-- mode==0: return texture name
-- mode==1: return object name for itemstacks etc
colormachine.translate_color_name = function( meta, k, new_color, c, s, g, as_obj_name )

   if( meta ~= nil ) then
      c = tonumber(meta:get_string('selected_color'));
      s = tonumber(meta:get_string('selected_shade'));   
      g = tonumber(meta:get_string('selected_grey_shade')); 
   end


   -- is this special shade supported at all?
   if(  ( g >   0 and colormachine.data[k].grey_shades[ g ] ~= 1 )
     or ( g == -1 and colormachine.data[k].shades[      s ] ~= 1 )) then
      return nil;
   end

   local k_orig = k;
   -- unifieddyes_ does not supply all colors
   if( k == 'unifieddyes_' 
     and ( (g==-1 and s==3 and (as_obj_name==1 or not(c==4 or c==6 or c==8 or c==12 or c==13 )))
        or (g==-1 and s==1 and c==1 ) -- pink
        or (g==-1 and s==7 and c==5 ) -- dark brown
        or g==1 or g==3 or g==4 or g==5 )) then
      k = 'dye_';
   end

   -- this does break the namescheme...
   if( k=='unifieddyes_' and g==2 and as_obj_name==1 ) then
      return 'dye:light_grey';
   end

   -- beds and sofas are available in less colors
   if( g==-1 
     and (c==7 or c==11) 
     and (k=='beds_bed_top_top_' or k=='lrfurn_sofa_right_front_' or k=='lrfurn_armchair_front_' or k=='lrfurn_longsofa_middle_front_' )) then

      return nil;
   end

   -- blox has its own naming scheme - but at least the colors supported are of a simple kind (no shades, no lower saturation)
   if( colormachine.data[k].modname == 'blox' ) then

      local color_used = "";
      if( s==1 and c==1 ) then
         color_used = 'pink'; -- in blox, this is called "pink"; normally "light_red"
      elseif( g>-1 ) then 
         color_used = colormachine.grey_names[ g ];
      elseif( s ~= 3 ) then
         return nil; -- only normal saturation supported
      elseif( c==10 ) then
         color_used = 'purple'; -- purple and violet are not the same, but what shall we do?
      elseif( c==4 or c==6 or c==8 or c>10 ) then
         return nil; -- these colors are not supported
      elseif( c > 0 ) then
         color_used = colormachine.colors[ c ];
      end

      if( as_obj_name == 1 ) then
         return 'blox:'..( color_used )..( colormachine.data[k].add );
      else
         return 'blox_'..( color_used )..( colormachine.data[k].add )..'.png';
      end
   end
 

   local postfix = '.png';
   local prefix  = k;
   -- we want the object name, i.e. default:brick, and not default_brick.png (all with colors inserted...):
   if( as_obj_name == 1 ) then
      postfix = '';

      prefix = colormachine.data[ k ].modname..":"..colormachine.data[ k ].add;

      -- stained_glass needs an exception here because it uses a slightly different naming scheme
      if( colormachine.data[ k ].modname == 'stained_glass' and stained_glass_exception==1) then

         if( g>0 ) then
            return nil; -- no grey values for them
         end
         local h_trans = {yellow=1, lime=2, green=3, aqua=4, cyan=5, skyblue=6, blue=7, violet=8, magenta=9, redviolet=10, red=11,orange=12};
      
         local h = h_trans[ colormachine.colors[c] ];

         local b   = "";
         local sat = "";
 
         if( k == 'stained_glass_' ) then
            prefix = "stained_glass:"..(colormachine.colors[c]).."_";
            if(     s==1 or s==2) then b = "8"; -- light
            elseif( s==3 or s==4) then b = "5"; -- normal
            elseif( s==5 or s==6) then b = "4"; -- medium
            elseif( s==7 or s==8) then b = "3"; -- dark
            end
            prefix = prefix.."_";
 
            sat = "7";
            if( s==2 or s==4 or s==6 or s==8 ) then -- saturation
               sat = "6";
            end
            if( s==1 ) then
               sat = "";
            end
            return "stained_glass:" .. (h) .. "_" .. (b) .. "_" .. (sat);

         elseif( k == 'stained_glass_faint_' ) then
            return "stained_glass:"..(h).."_91";

         elseif(     k == 'stained_glass_pastel_' ) then
            return "stained_glass:"..(h).."_9";
         end
      end
   end

   -- homedecors names are slightly different....
   if( k == 'homedecor_window_shutter_' ) then

      if( s==1 and new_color=='light_blue' ) then -- only light blue is supported
         return prefix..'light_blue'..postfix;
 
      elseif( new_color=='dark_green' ) then
         return prefix..'forest_green'..postfix;

      -- no more light colors, no more cyan or mangenta available; no normal green or blue
      elseif( s==1 or c==7 or c==11 or c==5 or c==9 ) then
         return nil;

      elseif( new_color=='dark_orange' ) then
         return prefix..'mahogany'..postfix;

      elseif( new_color=='orange' ) then
         return prefix..'oak'..postfix;
 
      end
   end

   if( k=='cotton_' and new_color=='grey') then
      new_color = 'mediumgrey';
   end
  

   if( k=='framedglass_' and as_obj_name ~= 1) then
      postfix = 'glass.png';
   end

   if( k=='shells_dye_' ) then
      if( as_obj_name == 1 ) then
        postfix = 'lightglass';
      else
        postfix = 'lightglass.png';
      end
   end


   if( k=='homedecor_bed_' ) then
      if( as_obj_name == 1 ) then
        --postfix = '_foot';
      else
        postfix = '_inv.png';
      end
   end

   -- those have split textures...
   if( colormachine.data[k].modname == 'coloredblocks') then 



      -- we are looking for the image name
      if( prefix==k ) then

         if( new_color == 'dark_orange') then
            new_color = 'brown';
         end

         -- show the top of the blocks in the individual formspec
         if( not(meta) ) then
            return 'coloredblocks_'..new_color..postfix;
      end
      -- show the side view in the main menu
         return string.sub(k, 1, string.len( k )-1)..'half'..postfix;
-- TODO

--[[

         if( new_color == 'dark_orange') then
            new_color = 'brown';
         end

         return 'coloredblocks_'..new_color..postfix;

      elseif( new_color..'_' == colormachine.data[k].add ) then 

         prefix = 'coloredblocks:';
--]]
      end

   end

   if( colormachine.data[k].modname == 'plasticbox'
       and new_color == 'dark_green') then 
      return prefix..'darkgreen'..postfix;
   end

   -- some mods need additional data be added after the color name
   if( as_obj_name == 1 and colormachine.data[k].obj_postfix ) then
	postfix = (colormachine.data[k].obj_postfix) ..postfix;
   end
	
   -- normal dyes (also used for wool) use a diffrent naming scheme
   if( colormachine.data[k].u == 0) then
      if(     new_color == 'darkgrey' and k ~= 'framedglass_') then
         return prefix..'dark_grey'..postfix;  
      elseif( new_color == 'dark_orange' ) then
         return prefix..'brown'..postfix;
      elseif( new_color == 'dark_green'  ) then
         return prefix..new_color..postfix;
      elseif( new_color == 'light_red'   ) then
         return prefix..'pink'..postfix;
      -- lime, aqua, skyblue and redviolet do not exist as standard wool/dye colors
      elseif( g == -1 and (c==4 or c==6 or c==8 or c==12) and k_orig ~= 'unifieddyes_') then 
         return nil;
      -- all other colors of normal dye/wool exist only in normal shade
      elseif( g == -1 and s~= 3  and k_orig ~= 'unifieddyes_') then
         return nil;
      -- colors that are the same in both systems and need no special treatment
      else
         return prefix..new_color..postfix;
      end
   end

   return prefix..new_color..postfix;
end


-- if a block is inserted, the name of its color is very intresting (for removing color or for setting that color)
-- (kind of the inverse of translate_color_name)
colormachine.get_color_from_blockname = function( mod_name, block_name )

   local bname = mod_name..":"..block_name;
   local found = {};
   for k,v in pairs( colormachine.data ) do
      if( mod_name == v.modname ) then
         table.insert( found, k );
      end
   end 

   if( #found < 1 ) then
      return { error_code ="Sorry, this block is not supported by the spray booth.",
               found_name = "",
               blocktype  = ""};
   end
     
   -- another case of special treatment needed; at least the color is given in the tiles 
   if( mod_name =='stained_glass' and stained_glass_exception==1) then 

      local original_node = minetest.registered_nodes[ bname ];
      if( original_node ~= nil ) then
         local tile   = original_node.tiles[1];
         local liste2 = string.split( tile, "%.");
         block_name = liste2[1];
      end
   end

   -- this mod does not seperate modname and objectname well enough :-( Naming scheme:- steel_framed_obsidian_glassCOLOR 
   if( mod_name =='framedglass' ) then
      block_name = string.sub( block_name, 28 );
   end

   if( mod_name =='shells_dye' ) then
      block_name = string.sub( block_name, 1, string.len( block_name )-string.len( 'lightglass') );
   end

   -- blox uses its own naming scheme
   if( mod_name =='blox' ) then
      -- the color can be found in the description
      local original_node = minetest.registered_nodes[ bname ];
      if( original_node ~= nil ) then

         local bloxdescr = original_node.description;
         -- bloxparts[1] will be filled with the name of the color:
         local bloxparts = string.split( bloxdescr, " ");
         -- now extract the blocktype information         
         if( bloxparts ~= nil and #bloxparts > 0 ) then

            -- we split with the color name
            local found_name      = bloxparts[1];
            local blocktype       = 'blox_'..string.sub( block_name, string.len( found_name )+1 )..'_';
               
            -- handle pink and purple
            if(     found_name == 'pink' ) then
               found_name = 'light_red';
            elseif( found_name == 'purple' ) then
               found_name = 'violet';
            end

            return { error_code = nil,
                     found_name = found_name, -- the name of the color
                     blocktype  = blocktype }; -- the blocktype
         end
      end
      -- if this point is reached, the decoding of the blox-block-name has failed
      return { error_code = "Error: Failed to decode color of this blox-block.",
               found_name = "",
               blocktype  = "" }; 

   end

   -- homedecors names are slightly different....
   if( mod_name == 'homedecor' ) then

      -- change the blockname to the expected color
      if(     block_name == 'shutter_forest_green' ) then
         block_name = 'shutter_dark_green';

      elseif( block_name == 'shutter_mahogany' ) then
         block_name = 'shutter_dark_orange';
 
      -- this is the default, unpainted one..which can also be considered as "orange" in the menu
--      elseif( blockname == 'shutter_oak' ) then 
--         block_name = 'shutter_orange';
      end
   end

   if( mod_name == 'plasticbox' and block_name == 'plasticbox_darkgreen' ) then
      block_name = 'plasticbox_dark_green';
   end

   -- even cotton needs an exception...
   if( mod_name == 'cotton' and block_name=='mediumgrey' ) then
      block_name = 'grey';
   end



   local blocktype  = '';
   -- some mods may have a postfix to their modname (which is pretty annoying)
   for _,k in ipairs( found ) do
      if( colormachine.data[k].obj_postfix ) then

         local l = string.len( colormachine.data[k].obj_postfix);
         if( string.len( block_name ) > l 
         and string.sub( block_name, -1*l ) == colormachine.data[k].obj_postfix ) then

            block_name = string.sub( block_name, 1, (-1*l)-1 );
            blocktype  = k;
         end
      end
   end

   -- try to analyze the name of this color; this works only if the block follows the color scheme
   local liste = string.split( block_name, "_" );
   local curr_index = #liste;

   -- handle some special wool- and dye color names
   -- dark_grey <-> darkgrey
   if(     #liste > 1 and liste[ curr_index ]=='grey' and liste[ curr_index - 1 ] == 'dark' ) then
      curr_index = curr_index - 1;
      liste[ curr_index ] = 'darkgrey';

   -- brown <=> dark_orange
   elseif( #liste > 0 and liste[ curr_index ]=='brown' ) then
      liste[ curr_index ] = 'dark';
      table.insert( liste, 'orange' );
      curr_index = curr_index + 1;
  
   -- pink <=> light_red
   elseif( #liste > 0 and liste[ curr_index ]=='pink' ) then
      liste[ curr_index ] = 'light';
      table.insert( liste, 'red' );
      curr_index = curr_index + 1;
   end
 
   -- find out the saturation - either "s50" or omitted
   local sat = 0;
   if( curr_index > 1 and liste[ curr_index ] == "s50" ) then
      sat = 1;
      curr_index = curr_index - 1;
   end

   -- the next value will be the color
   local c = 0;
   if( curr_index > 0 ) then
      for i,v in ipairs( colormachine.colors ) do
         if( c==0  and curr_index > 0 and v == liste[ curr_index ] ) then
            c = i;
            curr_index = curr_index - 1;
         end
      end
   end

   local g = -1;
   -- perhaps we are dealing with a grey value
   if( curr_index > 0 and c==0 ) then
      for i,v in ipairs(colormachine.grey_names ) do
         if( g==-1 and curr_index > 0 and v == liste[ curr_index ] ) then
            g = i;
            c = -1;
            curr_index = curr_index - 1;
         end
      end
   end

   -- determine the real shade; 3 stands for normal
   local s = 3;
   if( curr_index > 0 and g==-1 and c~=0) then
      if(     liste[ curr_index ] == 'light' ) then
        s = 1;
        curr_index = curr_index - 1;
      elseif( liste[ curr_index ] == 'medium' ) then
        s = 5;
        curr_index = curr_index - 1;
      elseif( liste[ curr_index ] == 'dark'   ) then
        s = 7;
        curr_index = curr_index - 1;
      end
   end

   local found_name = "";
   if(     g ~= -1 ) then
      found_name = colormachine.grey_names[ g ];
   elseif( c  >  0 ) then

      found_name = colormachine.prefixes[ math.floor((s+1)/2) ] .. colormachine.colors[ c ];

      if( sat==1 ) then
         s = s+1;
         found_name = found_name.."_s50";
      end
   end

   -- for blocks that do not follow the naming scheme - the color cannot be decoded
   if( g==-1 and c==0 ) then
      return { error_code ="This is a colored block: "..tostring( bname )..".", 
               found_name = "",
               blocktype  = ""};
   end

   -- identify the block type/subname
   local add       = "";
   if( not( blocktype ) or blocktype == '' ) then

      blocktype = found[1];
   end

   if( curr_index > 0 ) then

      for k,v in pairs( colormachine.data ) do
         -- prefix and postfix have to fit
         if( curr_index > 0 and add=="" and mod_name == v.modname and (liste[ curr_index ].."_") == v.add  
         -- if a postfix exists, we did check for that before and set blocktype accordingly
            and( not( blocktype ) or blocktype=='' or blocktype==k)) then
            add        = v.add;
            blocktype  = k;
            curr_index = curr_index - 1;
         end
      end
   end

   if( curr_index > 0 and #liste>0 and liste[1]=='chair' and blocktype == 'homedecor_bed_' ) then
      return { error_code = nil,
               found_name = found_name,
               blocktype  = 'forniture_kitchen_chair_sides_'};
   end

   if( curr_index > 0 ) then
      print( 'colormachine: ERROR: leftover name parts for '..tostring( bname )..": "..minetest.serialize( liste ));
   end

   return { error_code = nil,
            found_name = found_name,
            blocktype  = blocktype};
end



-- if the player has selected a color, show all blocks in that color
colormachine.blocktype_menu = function( meta, new_color, start_at_offset )

   new_color = colormachine.decode_color_name( meta, new_color );

   -- keep the same size as with the color selector
   local form = "size["..tostring( #colormachine.colors+2 )..",10]".."label[5,0;Select a blocktype:]"..
                "label[0.2,1.2;name]"..
                "label[0.2,2.2;unpainted]"..
                "label[0.2,3.2;colored]"..
                "button[1,0.5;4,1;dye_management;Manage stored dyes]"..
                "button[5,0.5;4,1;main_menu;Back to main menu]";
   local x = 1;
   local y = 2;

   for i,k in ipairs( colormachine.ordered ) do

      -- only installed mods are of intrest
      if( k ~= nil and colormachine.data[ k ].installed == 1 and i > start_at_offset and i <= (start_at_offset + 3*13)) then 

         -- that particular mod may not offer this color
         form = form.."button["..tostring(x)..","..tostring(y-0.8)..  ";1,1;"..k..";"..colormachine.data[k].descr.."]"..
                  "item_image["..tostring(x)..","..tostring(y    )..";1,1;"..colormachine.data[k].block.."]"; 

         local button = colormachine.print_color_image( meta, k, new_color, nil, nil, nil, tostring(x), tostring(y+1), 1);-- translated_color as return value for button
         if( button ~= "" ) then
            form = form..button;
         else
            form = form.."button["..      tostring(x)..","..tostring(y+1)..";1,1;"..k..";n/a]";
         end

         x = x+1;
         if( x>13 ) then
            x = 1;
            y = y+3;
            form = form..
                "label[0.2,"..tostring(y-1)..".2;name]"..
                "label[0.2,"..tostring(y  )..".2;unpainted]"..
                "label[0.2,"..tostring(y+1)..".2;colored]";
            if( y>3 ) then
                if( start_at_offset == 0 ) then
                   form = form.."button[9,0.5;4,1;blocktype_menu2;Show further blocks]";
                else
                   form = form.."button[9,0.5;4,1;blocktype_menu;Back to first page]";
                end
            end
         end
      end
   end
   return form;
end



-- this function tries to figure out which block type was inserted and how the color can be decoded
colormachine.main_menu_formspec = function( pos, option )

   local i = 0;
   local k = 0;
   local v = 0;

   local form = "size[14.5,9]"..
                "list[current_player;main;1,5;8,4;]"..
-- TODO
--                "label[3,0.2;Spray booth main menu]"..
                "button[6.5,0.25;3,1;dye_management;Manage stored dyes]"..
                "button[6.5,0.75;3,1;blocktype_menu;Show supported blocks]"..

                "label[3,0.0;1. Input - Insert material to paint:]"..
                "list[current_name;input;4.5,0.5;1,1;]"..
		
		"label[9.3,-0.5;Additional storage for dyes:]"..
		"list[current_name;extrastore;9.3,0;5,9]";

   if( minetest.setting_getbool("creative_mode") ) then
      form = form.."label[0.5,0.25;CREATIVE MODE:]".."label[0.5,0.75;no dyes or input consumed]";
   end

   local meta = minetest.get_meta(pos);
   local inv  = meta:get_inventory();

   -- display the name of the color the machine is set to
   form = form.."label[1.0,4.3;Current painting color:]"..
                "label[3.5,4.3;"..(meta:get_string('selected_name') or "?" ).."]"..
   -- display the owner name
                "label[7,4.3;Owner: "..(meta:get_string('owner') or "?" ).."]";

   if( inv:is_empty( "input" )) then
      form = form.."label[2.2,3.0;Insert block to be analyzed.]";
      return form;
   end

   local stack = inv:get_stack( "input", 1);
   local bname = stack:get_name();
   -- lets find out if this block is one of the unpainted basic blocks calling for paint
   local found = {};
   for k,v in pairs( colormachine.data ) do
      if( bname == v.block and colormachine.data[ k ].installed==1) then
         table.insert( found, k );
      end
   end 

   -- make sure all output fields are empty
   for i = 1, inv:get_size( "output" ) do
      inv:set_stack( "output", i, "" );
   end

   local anz_blocks = stack:get_count();

   -- a block that can be colored
   if( #found > 0 ) then

      local out_offset = 3.5-math.floor( #found / 2 );
      if( out_offset < 0 ) then
         out_offset = 0;
      end

      local anz_found  = 0;
      local p_values   = {}; -- how many blocks can be colored with one pigment?
      for i,v in ipairs( found ) do
         if( i <= inv:get_size( "output" )) then

            -- offer the description-link
            form = form.."button["..tostring(out_offset+i)..","..tostring(1.45)..";1,1;"..v..";"..colormachine.data[v].descr.."]";

            -- when clicking here, the color selection menu for that blocktype is presented
            local button = colormachine.print_color_image( meta, v, meta:get_string('selected_name'), nil, nil, nil, tostring(out_offset+i), tostring(2.0),1 );

            if( button ~= "" ) then

               local block_name = colormachine.translate_color_name( meta, v, meta:get_string('selected_name'), nil, nil, nil, 1 );
               -- one pigment is enough for factor blocks:
               local factor         = colormachine.data[ v ].p;
               -- how many of these blocks can we actually paint?

               local can_be_painted = 0;
               if( not( minetest.setting_getbool("creative_mode") )) then
                  can_be_painted = colormachine.calc_dyes_needed( meta, inv, math.ceil( anz_blocks / factor ), 0 );
               else
                  can_be_painted = 99; -- an entire stack can be painted in creative mode
               end
               inv:set_stack( "output", i, block_name.." "..tostring( math.min( can_be_painted * factor, anz_blocks )));

               p_values[ i ] = factor;

               form = form..button;
            else
               inv:set_stack( "output", i, "" );

--               form = form.."button["      ..tostring(2+i)..","..tostring(2.5)..";1,1;"..v..";"..colormachine.data[v].descr.."]";
               form = form.."button["..      tostring(out_offset+i)..","..tostring(2.0)..";1,1;"..v..";n/a]";
            end
            anz_found = anz_found + 1;
         end
      end
      -- so that we can determine the factor when taking blocks from the output slots
      meta:set_string('p_values', minetest.serialize( p_values ));
      
      -- this color was not supported
      if( anz_found == 0 ) then
         form = form.."label[2.2,3.0;Block is not available in that color.]";
         return form;
      end
      
      form = form.."label[3.0,1.2;2. Select color for any style:]"..
                   "label[3.0,2.9;3. Take output (determines style):]"..
                   "list[current_name;output;"..tostring(out_offset+1)..",3.5;"..tostring( anz_found )..",1;]";
      return form;
   end -- end of handling of blocks that can be colored


   -- get the modname
   local parts = string.split(bname,":");
   if( #parts < 2 ) then
      form = form.."label[2.2,3.0;ERROR! Failed to analyze the name of this node: "..tostring(bname).."]";
      return form;
   end
      

   -- it may be a dye source
   for i,v in ipairs( colormachine.basic_dye_sources ) do
      -- we have found the right color!
      if( bname == v ) then
         form = form.."label[2.2,3.0;This is a dye source.]"..
                   "button[6,3.0;3,1;turn_into_dye;Add to internal dye storage]";
         return form;
      end
   end


   -- it is possible that we are dealing with an already painted block - in that case we have to dertermie the color
   local found_color_data = colormachine.get_color_from_blockname( parts[1], parts[2] );
   if( found_color_data.error_code ~= nil ) then
      form = form.."label[2.2,3.0;"..found_color_data.error_code..".]";
      return form;
   end

   -- the previous analyse was necessary in order to determine which block we ought to use
   if( option == 'remove_paint' ) then
      -- actually remove the paint from the 
      inv:set_stack( "input", 1, colormachine.data[ found_color_data.blocktype ].block.." "..tostring( anz_blocks ));
      -- update display (we changed the input!)
      return colormachine.main_menu_formspec(pos, "analyze");
   end


   if( option == 'adapt_color' ) then
      -- actually change the color
      colormachine.decode_color_name( meta, found_color_data.found_name );
      -- default color changed - update the menu
      return colormachine.main_menu_formspec(pos, "analyze");
   end

   -- print color name; select as input color / remove paint
   form = form.."label[2.2,3.0;This is: "..tostring( found_color_data.found_name )..".]"..
                "button[6,3.5;3,1;remove_paint;Remove paint]";

   if( found_color_data.found_name ~= meta:get_string( 'selected_name' )) then
      form = form.."button[6,2.6;3,1;adapt_color;Set as new color]";
   else
      form = form.."label[5.5,2.0;This is the selected color.]";
   end
 
   return form;
end


-- returns a list of all blocks that can be created by applying dye_node_name to the basic node of old_node_name
colormachine.get_node_name_painted = function( old_node_name, dye_node_name )
	local possible_blocks = {};
	local unpainted_block = "";
	local old_dye         = "";
	for k,v in pairs( colormachine.data ) do
		if( old_node_name == v.block and colormachine.data[ k ].installed==1) then
			table.insert( possible_blocks, k );
			unpainted_block = old_node_name;
		end
	end 

	if( unpainted_block == "" ) then
		local parts = string.split(old_node_name,":");
		if( #parts < 2 ) then
			return;
		end
		found_color_data_block = colormachine.get_color_from_blockname( parts[1], parts[2] );
		if( found_color_data_block.error_code ~= nil ) then
			return;
		end
		unpainted_block = colormachine.data[ found_color_data_block.blocktype ].block;
		old_dye         = found_color_data_block.found_name;

		-- figure out how the dye this block was painted with was called
		local cdata = colormachine.decode_color_name( nil, old_dye );
		if( cdata ) then
			old_dye = colormachine.translate_color_name( nil, 'unifieddyes_', old_dye, cdata.c, cdata.s, cdata.g, 1 );
			if( not( old_dye ) or old_dye == '' ) then
				old_dye = colormachine.translate_color_name( nil, 'dye_', old_dye, cdata.c, cdata.s, cdata.g, 1 );
			end
		else
			old_dye = '';
		end
	end
	if( unpainted_block ~= "" and #possible_blocks < 1 ) then
		for k,v in pairs( colormachine.data ) do
			if( unpainted_block == v.block and colormachine.data[ k ].installed==1) then
				table.insert( possible_blocks, k );
			end
		end
	end 

	-- remove paint
	if( not( dye_node_name ) or dye_node_name == "") then
		return {possible={unpainted_block},old_dye = old_dye};
	end

	-- decode dye name
	parts = string.split(dye_node_name,":");
	if( #parts < 2 ) then
		return;
	end
	local found_color_data_color = colormachine.get_color_from_blockname( parts[1], parts[2] );

	if( found_color_data_color.error_code ~= nil ) then
		return;
	end
	local dye_name = found_color_data_color.found_name;

	local cdata = colormachine.decode_color_name( nil, dye_name );
	if( not( cdata )) then
		return;
	end

	-- find out for which block types/patterns this unpainted block is the basic one
	local found = {};
	for _,k in ipairs( possible_blocks ) do

		local new_block_name = colormachine.translate_color_name( nil, k, dye_name, cdata.c, cdata.s, cdata.g, 1 );
		table.insert( found, new_block_name );
	end 
	if( #found < 1 ) then
		return;
	end
	return { possible=found, old_dye = old_dye };
end


colormachine.check_owner = function( pos, player )
   -- only the owner can put something in
   local meta = minetest.get_meta(pos);

   if( meta:get_string('owner') ~= player:get_player_name() ) then
      minetest.chat_send_player( player:get_player_name(),
                 "This spray booth belongs to "..tostring( meta:get_string("owner"))..
                 ". If you want to use one, build your own!");
      return 0;
   end
   return 1;
end


colormachine.allow_inventory_access = function(pos, listname, index, stack, player, mode)

   -- only specific slots accept input or output
   if(  (mode=="put"  and listname ~= "input" and listname ~= "refill" and listname ~= "dyes" )
     or (mode=="take" and listname ~= "input" and listname ~= "refill" and listname ~= "dyes" and listname ~= "output" and listname ~= "paintless" )) then

      if( listname == "extrastore" ) then
         local parts = string.split(stack:get_name(),":");
         if( #parts > 1 and (parts[1]=='unifieddyes' or parts[1]=='dye')) then
            return stack:get_count();
         end
      end
      return 0;
   end

   local stack_name = stack:get_name();
   -- the dyes are a bit special - they accept only powder of the correct name
   if( listname == "dyes" 
       and stack_name ~= ("dye:"..        colormachine.colors_and_greys[ index ])
       and stack_name ~= ("unifieddyes:"..colormachine.colors_and_greys[ index ])
       and (stack_name ~= "dye:light_grey" or colormachine.colors_and_greys[ index ]~="lightgrey" )
       and (stack_name ~= "dye:dark_grey"  or colormachine.colors_and_greys[ index ]~="darkgrey" )
       ) then

      minetest.chat_send_player( player:get_player_name(), 'You can only store dye powders of the correct color here.');
      return 0;
   end

   if( not( colormachine.check_owner( pos, player ))) then
      return 0;
   end

   -- let's check if that type of input is allowed here
   if( listname == "refill" ) then
      local str = stack:get_name();
      for i,v in ipairs( colormachine.basic_dye_sources ) do
         if( str == v and v ~= "") then
            return stack:get_count();
         end
      end
      minetest.chat_send_player( player:get_player_name(), 'Please insert dye sources as listed below here (usually plants)!');
      return 0;
   end

   return stack:get_count();
end


colormachine.on_metadata_inventory_put = function( pos, listname, index, stack, player )
  
   local meta = minetest.get_meta(pos);
   local inv  = meta:get_inventory();

   -- nothing to do if onnly a dye was inserted
   if( listname == "dyes" ) then
      return;
   end

   -- an unprocessed color pigment was inserted
   if( listname == "refill" ) then
      local str = stack:get_name();
      for i,v in ipairs( colormachine.basic_dye_sources ) do
         -- we have found the right color!
         if( str == v ) then
            local count = stack:get_count();

            -- how much free space do we have in the destination stack?
            local dye_stack = inv:get_stack( "dyes", i);
            local free      = math.floor(dye_stack:get_free_space()/4);
            if( free < 1 ) then
               minetest.chat_send_player( player:get_player_name(), 'Sorry, the storage for that dye is already full.');
               return 0;
            end
            if( count < free ) then
               free = count;
            end

            -- consume the inserted material - no more than the input slot can handle
            inv:remove_item(listname, stack:get_name().." "..tostring( free ));

            color_name = colormachine.colors_and_greys[ i ];
            -- add four times that much to the storage
            if( i==4 or i==6 or i==8 or i==12 or i==14 ) then

               if( colormachine.data[ 'unifieddyes_' ].installed == 0 ) then
                  minetest.chat_send_player( player:get_player_name(), 'Sorry, this color requires unifieddyes (which is not installed).');
                  return 0;
               end
               inv:set_stack( "dyes", i, ("unifieddyes:"..color_name).." "..tostring( free*4 + dye_stack:get_count()) );
            else
               inv:set_stack( "dyes", i, ("dye:"        ..color_name).." "..tostring( free*4 + dye_stack:get_count()) );
            end
         end
      end
      minetest.chat_send_player( player:get_player_name(), 'Please insert dye sources as listed below here (usually plants)!');
      return 0;
   end

   if( listname == "input" ) then
      -- update the main menu accordingly
      meta:set_string( 'formspec', colormachine.main_menu_formspec( pos, "analyze" ));
      return;
   end
end


colormachine.on_metadata_inventory_take = function( pos, listname, index, stack, player )
  
   local meta = minetest.get_meta(pos);
   local inv  = meta:get_inventory();


   if( listname == "output" ) then

      -- in creative mode, no pigments are consumed
      if( minetest.setting_getbool("creative_mode") ) then
         -- update the main menu
         meta:set_string( 'formspec', colormachine.main_menu_formspec( pos, "analyze" ));
         return;
      end

      -- consume color for painted blocks
      local str      = meta:get_string( 'p_values' );
      local p = 1;  -- color more than one block with one pigment
      if( str and str ~= "" ) then
         local p_values = minetest.deserialize( str );
         if( index and p_values[ index ] ) then
            p = p_values[ index ];
         end
      end

      local amount_needed = math.ceil( stack:get_count() / p );
      local amount_done   = colormachine.calc_dyes_needed( meta, inv, amount_needed, 1 );
--print( ' NEEDED: '..tostring( amount_needed )..' DONE: '..tostring( amount_done )); -- TODO
      if( amount_done > amount_needed ) then
-- TODO: leftover color - how to handle?
      end

      -- calculate how much was taken
      local anz_taken   = stack:get_count();
      local anz_present = inv:get_stack("input",1):get_count();
      anz_present = anz_present - anz_taken;
      if( anz_present <= 0 ) then
         inv:set_stack( "input", 1, "" ); -- everything used up
      else
         inv:set_stack( "input", 1, inv:get_stack("input",1):get_name().." "..tostring( anz_present ));
      end
        
      -- the main menu needs to be updated as well
      meta:set_string( 'formspec', colormachine.main_menu_formspec( pos, "analyze" ));
      return;
   end


   if( listname == "input" ) then
      -- update the main menu accordingly
      meta:set_string( 'formspec', colormachine.main_menu_formspec( pos, "analyze" ));
      return;
   end
end


-- calculate which dyes are needed
colormachine.calc_dyes_needed = function( meta, inv, amount_needed, do_consume )

   local form = "";

   -- display the name of the currently selected color
   form = form.."label[8,0.2;"..( meta:get_string( "selected_name" ) or "?" ).."]";

   local s = tonumber(meta:get_string('selected_shade' ));
   local g = tonumber(meta:get_string('selected_grey_shade' ));
   local c = tonumber(meta:get_string('selected_color' ));


   local needed = {};
   -- we are dealing with a grey value
   if( g > -1 ) then
      needed[ colormachine.grey_names[ g ]] = 1;

   -- we are dealing with a normal color
   else
      -- one pigment of the selected color (to get started)
      needed[ colormachine.colors[ c ]] = 1;
      -- handle saturation
      if(     s==1 ) then needed[ "white" ]=1;                       -- light
--      elseif( s==3 ) then                                          -- normal color - no changes needed 
      elseif( s==4 ) then needed[ "white" ]=2; needed[ "black" ] =1; -- normal, low saturation
      elseif( s==5 ) then                      needed[ "black" ] =1; -- medium dark
      elseif( s==6 ) then needed[ "white" ]=1; needed[ "black" ] =1; -- medium dark, low saturation
      elseif( s==7 ) then                      needed[ "black" ] =2; -- dark
      elseif( s==8 ) then needed[ "white" ]=1; needed[ "black" ] =2; -- dark, low saturation
      end
   end

   local anz_pigments = 0;
   for i,v in pairs( needed ) do
      anz_pigments = anz_pigments + v;
   end

   
   -- n: portions of *mixtures* needed
   local n = 1;
   -- if the colors are to be consumed, we need to calculate how many we actually need
   -- (one mixutre consists of anz_pigments pigments each)
   if( amount_needed > 0) then
      n = math.ceil( amount_needed / anz_pigments );

      local min_found = 10000; -- high number that cannot be reached
      -- now we need to check how many pigments of each color we have
      for i,v in ipairs( colormachine.colors_and_greys ) do

         if( needed[ v ] and needed[ v ]> 0 ) then 

            -- find out how many blocks of this type we can actually color
            local stack = inv:get_stack( "dyes", i );
            local found = math.floor( stack:get_count() / needed[ v ]);
            if( found < min_found  ) then
               min_found = found;  -- save the new minimum
            end
         end
      end

      -- we do not have enough pigments
      if( min_found < n ) then
         n = min_found;
      end
   end

 
   -- return how many *could* be colored
   if( amount_needed > 0 and do_consume ~= 1 ) then
      return n*anz_pigments;
   end



   for i,v in ipairs( colormachine.colors_and_greys ) do

      if( needed[ v ] and needed[ v ]> 0 ) then 
  
         -- show how many pigments of this color are needed for the selected mixture
         -- normal color
         if( i <= #colormachine.colors ) then
            form = form.."label["..tostring(i+0.2)..",2.2;"  ..needed[ v ].."x]"..
                         "label["..tostring(i+0.2)..",0.6;"  ..needed[ v ].."x]";
         -- grey value
         else
            form = form.."label[11.3,"..tostring(i-#colormachine.colors+4.2)..";"..needed[ v ].."x]"..
                         "label[13.3,"..tostring(i-#colormachine.colors+4.2)..";"..needed[ v ].."x]";
         end

         -- actually consume the color pigment
         if( amount_needed > 0 and n > 0 ) then
            local stack = inv:get_stack( "dyes", i );
            local found = stack:get_count();
            --print( ' CONSUMED '..math.floor( n * needed[ v ] )..' of '..tostring( stack:get_name())); 
            inv:set_stack( "dyes", i, stack:get_name()..' '..tostring( found - math.floor( n * needed[ v ] ))); 
         end
      end
   end


   -- in case pigments where consumed, return how many blocks where colored successfully
   if( amount_needed > 0 and n > 0 ) then
--print('Successfully colored: '..tostring( n*anz_pigments )); 
      return n*anz_pigments;
   end

   -- else return the formspec  addition with the information how many of which pigment is needed
   return form;
end


-- this adds the name of the current color and the amount of needed dyes to the formspec
colormachine.get_individual_dye_management_formspec = function( meta, inv )

   local form = colormachine.dye_management_formspec;

   -- just add information how many pigments of each color are needed
   form = form .. colormachine.calc_dyes_needed( meta, inv, 0, 0 )
   return form;
end


-- mix two colors
colormachine.mix_colors = function( inv, i, sender )

   local farbe = colormachine.colors_and_greys[ i ];
   local mix   = colormachine.dye_mixes[ farbe ];
   -- in case the color cannot be mixed
   if( not( mix ) or #mix < 2 ) then
      return;
   end

   local stack1 = inv:get_stack( "dyes", mix[1] );
   local stack2 = inv:get_stack( "dyes", mix[2] );
   local stack3 = inv:get_stack( "dyes", i );
  

   if(     stack3:get_free_space() > 1 -- we need space for two 
       and stack1:get_count() > 0
       and stack2:get_count() > 0 ) then

      inv:set_stack( "dyes", mix[1], stack1:get_name()..' '..( stack1:get_count()-1));
      inv:set_stack( "dyes", mix[2], stack2:get_name()..' '..( stack2:get_count()-1));

      -- handle light/dark grey
      if(     farbe=='lightgrey' ) then
         farbe = 'light_grey';
      elseif( farbe=='darkgrey' ) then
         farbe = 'dark_grey';
      end

      -- dye or unifieddyes?
      local name = 'dye:'..farbe;
      if( not( minetest.registered_craftitems[ name ])) then
         name = 'unifieddyes:'..farbe;
      end

      -- print errormessage or add the mixed dye pigment
      if( not( minetest.registered_craftitems[ name ])) then
         minetest.chat_send_player( sender:get_player_name(), '[colormachine] ERROR: color '..tostring( farbe )..' could not be mixed (craftitem '..tostring(name)..' not found)');
      else
         inv:set_stack( "dyes", i, name..' '..( stack3:get_count() + 2 )); -- two pigments mixed -> we get two pigments result
      end

   elseif( stack3:get_free_space() > 1 ) then
      minetest.chat_send_player( sender:get_player_name(), 'Need '..colormachine.colors_and_greys[ mix[1] ]..' and '..
                                                                    colormachine.colors_and_greys[ mix[2] ]..' in order to mix '..farbe..'.'); 
   end
end


-- this generates the formspec for all supported mods and the general colormachine.dye_management_formspec 
colormachine.init = function()
   local liste = {};
   -- create formspecs for all machines
   for k,v in pairs( colormachine.data ) do

      if( minetest.get_modpath( colormachine.data[ k ].modname ) ~= nil ) then

         -- generate the formspec for that machine
         colormachine.data[ k ].formspec = colormachine.generate_form( k );
         -- remember that the mod is installed
         colormachine.data[ k ].installed = 1;
         -- this is helpful for getting an ordered list later
--         liste[ colormachine.data[ k ].nr ] = k;
         table.insert( liste, k );
      else
         -- the mod is not installed
         colormachine.data[ k ].installed = 0;
      end
   end

   table.sort( liste, function(a,b) return colormachine.data[a].nr < colormachine.data[b].nr end); 
   colormachine.ordered = liste;

   -- if no flowers are present, take dye sources from default (so we only have to depend on dyes)
   if( minetest.get_modpath( "flowers") == nil ) then
      for i,v in ipairs( colormachine.alternate_basic_dye_sources ) do
         colormachine.basic_dye_sources[ i ]  = colormachine.alternate_basic_dye_sources[ i ];
      end
   end

   local form = "size[14,10]"..
                "list[current_player;main;1,5;8,4;]"..
                "label[1,0.2;"..minetest.formspec_escape('Insert dye sources here -->').."]"..
                "list[current_name;refill;4,0;1,1;]"..
                "label[6,0.2;Selected color:]"..
                "label[0.1,1;sources:]"..
                "label[0.1,2;dyes:]"..
                "label[0.1,3;storage:]"..
                "button[1,4;4,1;main_menu;Back to main menu]"..
                "button[5,4;4,1;blocktype_menu;Show supported blocks]"..
                "list[current_name;dyes;1,3;"..tostring(#colormachine.colors)..",1;]"..  -- normal colors

                -- remaining fields of the dyes inventory: grey colors, arranged vertically
                -- (not enough space for the "dyes" label)
                "label[0.1,0.6;need:]"..
                "label[9.3,4.5;need:]"..
                "label[10,4.5;sources:]"..
                "label[12,4.5;storage:]"..
                "list[current_name;dyes;12,5;1,"..tostring(#colormachine.grey_names)..";"..tostring(#colormachine.colors).."]";

   local needed = {};

   -- align colors horizontal
   for i,k in ipairs( colormachine.colors ) do
   
      local prefix = 'dye:';
      if( i==4 or i==6 or i==8 or i==12 or i==14 ) then
         if( colormachine.data[ 'unifieddyes_' ].installed == 1 ) then
            prefix = 'unifieddyes:';
         else
            prefix = "";
         end
      end

      if( prefix ~= "" ) then

         local source = colormachine.basic_dye_sources[ i ];
         if(     source ~= "" ) then
            form = form.."item_image["..tostring(i)..",1;1,1;"..source.."]";

            -- even those colors may be additionally mixed
            if(  #colormachine.dye_mixes[         colormachine.colors_and_greys[ i ] ] == 2 ) then 
               form = form.. "button["..tostring(i-0.1)..",1.9;0.8,0.2;mix_"..colormachine.colors_and_greys[ i ]..";mix]";
            end

         -- a color that can be mixed
         elseif( #colormachine.dye_mixes[         colormachine.colors_and_greys[ i ] ] == 2 ) then 

            local mixes = colormachine.dye_mixes[ colormachine.colors_and_greys[ i ] ];
   
            local source1 = 'dye:'..colormachine.colors_and_greys[ mixes[1] ];
            local source2 = 'dye:'..colormachine.colors_and_greys[ mixes[2] ];

            form = form.."item_image["..tostring(i    )..",1.0;1,1;"..source1.."]"..
                         "item_image["..tostring(i+0.3)..",1.3;1,1;"..source2.."]"..
                             "button["..tostring(i-0.1)..",1.9;0.8,0.2;mix_"..colormachine.colors_and_greys[ i ]..";mix]";
         end
      
         form = form.. "item_image["..tostring(i)..",2;1,1;"..tostring( prefix..colormachine.colors[ i ] ).."]"..
                            "label["..tostring(i)..",3.6;"  ..tostring( colormachine.colors_and_greys[ i ] ).."]";
      else
         form = form.."label["..tostring(i+0.2)..",3;n/a]";
      end
   end

   -- align grey-values vertical
   for i,k in ipairs( colormachine.grey_names ) do
   
      if( i ~= 2 or colormachine.data[ 'unifieddyes_' ].installed == 1 ) then

         local source = colormachine.basic_dye_sources[ #colormachine.colors + i ];
         if( source and source ~= "" ) then
            form = form.."item_image[10,"..tostring(i+4)..";1,1;"..source.."]";

         elseif( #colormachine.dye_mixes[         colormachine.colors_and_greys[ #colormachine.colors + i ] ] == 2 ) then 

            local mixes = colormachine.dye_mixes[ colormachine.colors_and_greys[ #colormachine.colors + i ] ];

            local source1 = 'dye:'..colormachine.colors_and_greys[ mixes[1] ];
            local source2 = 'dye:'..colormachine.colors_and_greys[ mixes[2] ];

            form = form.."item_image[10.0,"..tostring(i+4.0)..";1,1;"..source1.."]"..
                         "item_image[10.3,"..tostring(i+4.3)..";1,1;"..source2.."]"..
                             "button[9.8," ..tostring(i+4.9)..";0.8,0.2;mix_"..colormachine.colors_and_greys[ #colormachine.colors + i ]..";mix]";
         end
      
         local dye_name = 'dye:'..k;

         -- lightgrey exists only in unifieddyes
         if( i== 2 ) then
            if( colormachine.data[ 'unifieddyes_' ].installed == 1 ) then
               dye_name = 'unifieddyes:lightgrey_paint'; --'unifieddyes:'..k;
            else
               dye_name = '';
            end

         -- darkgrey is called slightly diffrent
         elseif( i==4 ) then
            dye_name = 'dye:dark_grey';
         end
       
         if( dye_name ~= "" ) then
            form = form.. "item_image[11,"..tostring(i+4)..";1,1;"..tostring( dye_name ).."]"..
                          "label[   12.9,"..tostring(i+4)..";"    ..tostring( colormachine.colors_and_greys[ #colormachine.colors + i ] ).."]";
         end
      else
         form = form.."label[12.2,"..tostring(i+4)..";n/a]";
      end
   end
  
 
   colormachine.dye_management_formspec = form;

end



-- delay initialization so that modules are hopefully loaded
minetest.after( 0, colormachine.init );


--    flowers:       6 basic colors + black + white
--  unifieddyes:   dye pulver
--  coloredwood:   wood, fence - skip sticks!
--  unifiedbricks: clay blocks, brick blocks (skip individual clay lumps and bricks!)
--                 multicolor: 3 shades, usual amount of colors
--  cotton:        (by jordach) probably the same as coloredwood
--   
--  stained_glass: 9 shades/intensities


minetest.register_node("colormachine:colormachine", {
        description = "spray booth",

        tiles = {
		"colormachine_top.png",
		"colormachine_bottom.png",
		"colormachine_side.png",
		"colormachine_side.png",
		"colormachine_side.png",
		"colormachine_front.png",
	},

        paramtype2 = "facedir",
        groups = {cracky=2},
        legacy_facedir_simple = true,

        on_construct = function(pos)

           local meta = minetest.get_meta(pos);

           meta:set_string('selected_shade',       3 ); -- grey-shade
           meta:set_string('selected_grey_shade',  1 );
           meta:set_string('selected_color',      -1 ); -- we selected grey
           meta:set_string('selected_name',       'white' );

           meta:set_string('owner', '' ); -- protect input from getting stolen

           local inv = meta:get_inventory();
           inv:set_size("input",     1);  -- input slot for blocks that are to be painted
           inv:set_size("refill",    1);  -- input slot for plants and other sources of dye pigments
           inv:set_size("output",   14);  -- output slot for painted blocks - up to 8 alternate coloring schems supported (blox has 8 for stone!)
           inv:set_size("paintless", 1);  -- output slot for blocks with paint scratched off
           inv:set_size("dyes",     18);  -- internal storage for the dye powders
           inv:set_size("extrastore",5*9); -- additional storage for dyes

           --meta:set_string( 'formspec', colormachine.blocktype_menu( meta, 'white' ));
           meta:set_string( 'formspec', colormachine.main_menu_formspec(pos, "analyze") );
        end,

        after_place_node = function(pos, placer)
           local meta = minetest.get_meta(pos);

           meta:set_string( "owner", ( placer:get_player_name() or "" ));
           meta:set_string( "infotext", "Spray booth (owned by "..( meta:get_string( "owner" ) or "" )..")");
        end,

        on_receive_fields = function(pos, formname, fields, sender)

           if( not( colormachine.check_owner( pos, sender ))) then
              return 0;
           end

           local meta = minetest.get_meta(pos);
           for k,v in pairs( fields ) do
              if( k == 'main_menu' ) then
                 meta:set_string( 'formspec', colormachine.main_menu_formspec(pos, "analyze") );
                 return;
              elseif( k == 'remove_paint' ) then
                 meta:set_string( 'formspec', colormachine.main_menu_formspec(pos, "remove_paint") );
                 return;
              elseif( k == 'adapt_color' ) then
                 meta:set_string( 'formspec', colormachine.main_menu_formspec(pos, "adapt_color") );
                 return;

              elseif( k == 'turn_into_dye' ) then
                 local inv = meta:get_inventory();

                 local stack = inv:get_stack( 'input', 1 );
                 -- move into refill slot
                 inv:set_stack( 'refill', 1, stack );
                 -- empty input slot
                 inv:set_stack( 'input', 1, '' );
                 -- process the dye
                 colormachine.on_metadata_inventory_put( pos, 'refill', 1, stack, sender )
                 -- call dye management forpsec to show result
                 meta:set_string( 'formspec', colormachine.get_individual_dye_management_formspec( meta, inv ));
                 return;

              elseif( k == 'dye_management' ) then
                 local inv = meta:get_inventory();

                 meta:set_string( 'formspec', colormachine.get_individual_dye_management_formspec( meta, inv ));
                 return;
              elseif( colormachine.data[ k ] ) then
                 meta:set_string( 'formspec', colormachine.data[ k ].formspec );
                 return;
              elseif( k=='key_escape') then
                 -- nothing to do
              else
                 local inv = meta:get_inventory();
                 
                 -- perhaps we ought to mix colors 
                 for i,f in ipairs( colormachine.colors_and_greys ) do
                    if( k==("mix_"..f )) then
                       colormachine.mix_colors( inv, i, sender );
                       return; -- formspec remains the dye-management one
                    end
                 end

                 -- if no input is present, show the block selection menu
                 if(     k=="blocktype_menu2" ) then
                    meta:set_string( 'formspec', colormachine.blocktype_menu( meta, k, 3*13 )); 
                 elseif( k=="blocktype_menu" or inv:is_empty( "input" )) then
                    meta:set_string( 'formspec', colormachine.blocktype_menu( meta, k, 0 )); 

                 else

                    -- else set the selected color and go back to the main menu
                    colormachine.decode_color_name( meta, k );
                    meta:set_string( 'formspec', colormachine.main_menu_formspec(pos, "analyze") );
                 end
              end
           end
        end,

        -- there is no point in moving inventory around
        allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
           return 0;
        end,

        
        allow_metadata_inventory_put = function(pos, listname, index, stack, player)
           return colormachine.allow_inventory_access(pos, listname, index, stack, player, "put" );
        end,


        allow_metadata_inventory_take = function(pos, listname, index, stack, player)
           return colormachine.allow_inventory_access(pos, listname, index, stack, player, "take" );
        end,

        on_metadata_inventory_put = function(pos, listname, index, stack, player)
           return colormachine.on_metadata_inventory_put( pos, listname, index, stack, player );
        end,

        on_metadata_inventory_take = function(pos, listname, index, stack, player)
           return colormachine.on_metadata_inventory_take( pos, listname, index, stack, player );
        end,

        can_dig = function(pos,player)

           local meta = minetest.get_meta(pos);
           local inv = meta:get_inventory()

           if( not( colormachine.check_owner( pos, player ))) then
              return 0;
           end

           if(   not( inv:is_empty("input"))
              or not( inv:is_empty("refill")))  then
              minetest.chat_send_player( player:get_player_name(), "Please remove the material in the input- and/or refill slot first!"); 
              meta:set_string( 'formspec', colormachine.blocktype_menu( meta, meta:get_string('selected_name'), 0)); 
              return false;
           end
           if(  not( inv:is_empty("dyes"))) then
              minetest.chat_send_player( player:get_player_name(), "Please remove the stored dyes first!"); 
              meta:set_string( 'formspec', colormachine.blocktype_menu( meta, meta:get_string('selected_name'), 0 )); 
              return false;
           end

           return true
        end
})

minetest.register_craft({
        output = 'colormachine:colormachine',
        recipe = {
                { 'default:gold_ingot',  'default:glass',       'default:gold_ingot', },
                { 'default:mese',        'default:glass',       'default:mese'        },
                { 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' }
        }
})

dofile( minetest.get_modpath('colormachine')..'/paint_roller.lua');
