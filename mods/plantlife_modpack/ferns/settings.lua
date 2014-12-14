-- In case you don't wanna have errors:

-- Only change what's behind a "=" (or "--"). 
-- Don't use caps (behind a "=").

-- If there's a "false" (behind a "=") you can change it to "true" (and the other way around).
-- Spelling is important.
-- If "true" or "false" is necessary as setting, everything(!) which is not spelled "true" will be read as if it were "false" (even "1", "True"...)

-- If you wanna comment something (for example to remember the default value), you can do this by putting "--" in front of the comment.
-- You can put "--" at the end of a line with "=" in it, or at the beginning of an empty/new line (minetest will ignore what's behind it then).
-- But don't put "--" in front of a line with "=" in it (or else minetest will ignore the setting and you might get an error).

-- If something is still unclear, don't hesitate to post your question @ https://forum.minetest.net/viewtopic.php?id=6921

abstract_ferns.config = {}

-- Which plants should generate/spawn?
abstract_ferns.config.enable_lady_fern			= true
abstract_ferns.config.enable_horsetails			= true
abstract_ferns.config.enable_treefern			= true
abstract_ferns.config.enable_giant_treefern		= true

-- Where should they generate/spawn? (if they generate/spawn)
--
--  Lady-Fern
abstract_ferns.config.lady_ferns_near_tree = true
abstract_ferns.config.lady_ferns_near_rock = true
abstract_ferns.config.lady_ferns_near_ores = true				-- if there's a bunch of ferns there's ores nearby, this one causes a huge fps drop
abstract_ferns.config.lady_ferns_in_groups = false				-- this one is meant as a replacement of Ferns_near_Ores: ferns tend to generate in groups, less fps drop, no hint for nearby ores
--
--	Horsetails
abstract_ferns.config.enable_horsetails_spawning	= false		-- horsetails will grow in already explored areas, over time, near water or gravel
abstract_ferns.config.enable_horsetails_on_grass 	= true		-- on dirt with grass and swamp (sumpf mod)
abstract_ferns.config.enable_horsetails_on_stones 	= true		-- on gravel, mossy cobble and silex (stoneage mod)
--
-- Tree_Fern
abstract_ferns.config.enable_treeferns_in_jungle	= true
abstract_ferns.config.enable_treeferns_in_oases 	= true		-- for oases and tropical beaches
--
-- Giant_Tree_Fern
abstract_ferns.config.enable_giant_treeferns_in_jungle	= true
abstract_ferns.config.enable_giant_treeferns_in_oases	= true	-- for oases and tropical beaches
