
-- Npc by TenPlus1

mobs.npc_drops = { 	"farming:meat", "farming:donut", "farming:bread", "default:apple", "default:sapling", "default:junglesapling", 
					"shields:shield_enhanced_wood", "3d_armor:chestplate_cactus", "3d_armor:boots_bronze", 
					"default:sword_steel", "default:sword_gold", "default:pick_steel", "default:shovel_steel", 
					"default:bronze_ingot", "bucket:bucket_water" }

mobs.npc_max_hp = 20

mobs:register_mob("mobs:npc", {
	-- animal, monster, npc
	type = "npc",
	-- aggressive, deals 6 damage to player/monster when hit
	passive = false,
	damage = 6,					-- 4 damages if tamed
	attack_type = "dogfight",
	attacks_monsters = true,
	-- health & armor
	hp_min = 20, hp_max = 20, armor = 100,
	-- textures and model
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	mesh = "character.b3d",
	drawtype = "front",
	textures = {
		{"mobs_npc.png"},
	},
	visual_size = {x=1, y=1},
	-- sounds
	makes_footstep_sound = true,
	sounds = {},
	-- speed and jump
	walk_velocity = 3,
	run_velocity = 3,
	jump = true,
	-- drops wood and chance of apples when dead
	drops = {
		{name = "default:wood",
		chance = 1, min = 1, max = 3},
		{name = "default:apple",
		chance = 2, min = 1, max = 2},
		{name = "default:axe_stone",
		chance = 3, min = 1, max = 1},
		{name = "maptools:silver_coin",
		chance = 10, min = 1, max = 1,},
	},
	-- damaged by
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	-- follow diamond
	follow = "default:diamond",
	view_range = 16,
	-- set owner and order
	owner = "",
	order = "follow",
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
		local name = clicker:get_player_name()

		-- heal npc
		if item:get_name() == "mobs:meat"
		or item:get_name() == "farming:bread" then
			-- feed and add health
			local hp = self.object:get_hp()
			if hp + 4 > self.hp_max then return end
			self.object:set_hp(hp+4)
			-- take item
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:set_hp(hp + 4)
		-- right clicking with gold lump drops random item from mobs.npc_drops
		elseif item:get_name() == "default:gold_lump" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			local pos = self.object:getpos()
			pos.y = pos.y + 0.5
			minetest.add_item(pos, {name = mobs.npc_drops[math.random(1,#mobs.npc_drops)]})
		elseif item:get_name() == "default:diamond" then
			self.diamond_count = (self.diamond_count or 0) + 1
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
		-- pick up npc
		elseif item:get_name() == "mobs:magic_lasso"
		and clicker:is_player()
		and clicker:get_inventory()
		and self.child == false
		and clicker:get_inventory():room_for_item("main", "mobs:npc") then

			-- pick up if owner
			if self.owner == name then
				clicker:get_inventory():add_item("main", "mobs:npc")
				self.object:remove()
				item:add_wear(3000) -- 22 uses
				clicker:set_wielded_item(item)
			-- cannot pick up if not tamed
			elseif not self.owner or self.owner == "" then
				minetest.chat_send_player(name, "Not tamed!")
			-- cannot pick up if not tamed
			elseif self.owner ~= name then
				minetest.chat_send_player(name, "Not owner!")
			end
			if self.diamond_count < 4 then return end

		else
			-- if owner switch between follow and stand
			if self.owner and self.owner == clicker:get_player_name() then
				self.damages = 4
			else
				if self.order == "follow" then
					self.order = "stand"
				else
					self.order = "follow"
				end
			else
				self.owner = clicker:get_player_name()
			end
		end
	end,
})
-- spawning enable for now
mobs:register_spawn("mobs:npc", {"default:dirt_with_grass"}, 20, -1, 20000, 1, 31000)
-- register spawn egg
mobs:register_egg("mobs:npc", "Npc", "default_brick.png", 1)
