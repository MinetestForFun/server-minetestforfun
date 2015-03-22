
-- Npc by TenPlus1

mobs.npc_drops = { 	"farming:meat", "farming:donut", "farming:bread", "default:apple", "default:sapling", "default:junglesapling", 
					"shields:shield_enhanced_wood", "3d_armor:chestplate_cactus", "3d_armor:boots_bronze", 
					"default:sword_steel", "default:sword_gold", "default:pick_steel", "default:shovel_steel", 
					"default:bronze_ingot", "bucket:bucket_water" }

mobs:register_mob("mobs:npc", {
	-- animal, monster, npc
	type = "npc",
	-- aggressive, deals 4 damage to player/monster when hit
	passive = false,
	damage = 4,
	attack_type = "dogfight",
	attacks_monsters = true,
	-- health & armor
	hp_min = 20, hp_max = 20, armor = 100,
	-- textures and model
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	drawtype = "front",
	available_textures = {
		total = 1,
		texture_1 = {"mobs_npc.png"},
	},
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {},
	-- speed and jump
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	-- drops wood and chance of apples when dead
	drops = {
		{name = "default:wood",
		chance = 1, min = 1, max = 3},
		{name = "default:apple",
		chance = 2, min = 1, max = 2},
		{name = "default:axe_stone",
		chance = 3, min = 1, max = 1},
		{name = "maptools:copper_coin",
		chance = 2, min = 2, max = 4,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	-- follow diamond
	follow = "default:diamond",
	view_range = 16,
	-- model animation
	animation = {
		speed_normal = 30,		speed_run = 30,
		stand_start = 0,		stand_end = 79,
		walk_start = 168,		walk_end = 187,
		run_start = 168,		run_end = 187,
		punch_start = 200,		punch_end = 219,
	},
	-- right clicking with "cooked meat" or "bread" will give npc more health
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "mobs:meat" or item:get_name() == "farming:bread" then
			local hp = self.object:get_hp()
			if hp + 4 > self.hp_max then return end
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:set_hp(hp+4)
		-- right clicking with gold lump drops random item from mobs.npc_drops
		elseif item:get_name() == "default:gold_lump" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			local pos = self.object:getpos()
			pos.y = pos.y + 0.5
			minetest.add_item(pos, {name = mobs.npc_drops[math.random(1,#mobs.npc_drops)]})
		end
	end,
})
-- spawning enable for now
mobs:register_spawn("mobs:npc", {"default:dirt_with_grass"}, 20, -1, 21000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:npc", "Npc", "default_brick.png", 1)
