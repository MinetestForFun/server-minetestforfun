-- BobBlocks v0.0.8
-- (Minetest 0.4.5 compatible 20130315)
-- http://forum.minetest.net/viewtopic.php?id=1274
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--          Requirements: Mesecons                                      --
--          http://forum.minetest.net/viewtopic.php?id=628              --
--                                                                      --
--          Does not support jeija or older version of Mesecons         --
--          before 1/20/2013                                            --
--          http://forum.minetest.net/viewtopic.php?pid=64976#p64976    --
--------------------------------------------------------------------------
--------------------------------------------------------------------------
-- Colored Lit Blocks
---- Default state = Solid lit block
---- Secondary state (punch) = transparent unlit block
---- Mesecons activation [CONDUCTOR] 
-- Colored Lit Poles
---- Default state = Solid lit block
---- Secondary state (punch) = unlit block
---- Mesecons activation [CONDUCTOR]
-- Health Kit
---- Default state = health kit inactive
---- Secondary state (punch) = health kit active +10HP when walked through
---- Mesecons activation [CONDUCTOR]
-- Trap
---- Default Grass (walkable off)
---- Spike Minor (1HP per hit)
------ Spikes can be 'set' and activated when walked over
---- Spike Major (100HP per hit)
------ Spikes can be 'set' and activated when walked over

# [ATTRIBUTION]
# Unless otherwise noted, all graphics & sounds
# created by Rabbi Bob
# Licensed under the GPLv2/later

# [GRAPHICS]
# minor & major spikes by Death Dealer
# License: WTFPL 
# http://minetest.net/forum/viewtopic.php?id=1582

# [SOUNDS]
# bobblocks_glass
    # Author: Ch0cchi
    # http://www.freesound.org/people/Ch0cchi/sounds/15285/
    # Edited by rabbibob
# bobblocks_trap_fall & bobblocks_trap_fall_major
    # Author: Rock Savage
    # http://www.freesound.org/people/Rock%20Savage/sounds/65924/#
    # Edited by rabbibob
# bobblocks_health
    # http://hamsterrepublic.com/ohrrpgce/Free_Sound_Effects.html