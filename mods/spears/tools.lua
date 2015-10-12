function spears_register_spear(kind, desc, eq, toughness, craft)

	minetest.register_tool("spears:spear_" .. kind, {
		description = desc .. " spear",
		inventory_image = "spears_spear_" .. kind .. ".png",
		wield_scale= {x=2,y=1,z=1},

		on_drop = function(itemstack, user, pointed_thing)
			spears_shot(itemstack, user)
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
		on_place = function(itemstack, user, pointed_thing)
			minetest.add_item(pointed_thing.above, itemstack)
			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			return itemstack
		end,
		tool_capabilities = {
			full_punch_interval = 1.5,
			max_drop_level=1,
			groupcaps={
				cracky = {times={[3]=2}, uses=toughness, maxlevel=1},
			},
			damage_groups = {fleshy=eq},
		}
	})

	--minetest.register_node("spears:spear_" .. kind .. "_box", {
		--drawtype = "nodebox",
		--node_box = {
			--type = "fixed",
			--fixed = {
				---- Shaft
				--{-60/16, -2/16, 2/16, 4, 1/16, -1/16},
				----Spitze
				--{-4, -1/16, 1/16, -62/16, 0, 0},
				--{-62/16, -1.5/16, 1.5/16, -60/16, 0.5/16, -0.5/16},
			--}
		--},
		--tiles = {"spears_spear_box.png"},
		--groups = {not_in_creative_inventory=1},
	--})

	local SPEAR_ENTITY={
		physical = false,
		visual = "wielditem",
		visual_size = {x=0.15, y=0.1},
		textures = {"spears:spear_" .. kind},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
		player = "",
		wear = 0,

		on_punch = function(self, puncher)
			if puncher then
				if puncher:is_player() then
					local stack = {name='spears:spear_' .. kind, wear=self.wear+65535/toughness}
					local inv = puncher:get_inventory()
					if inv:room_for_item("main", stack) then
						inv:add_item("main", stack)
						self.object:remove()
					end
				end
			end
		end,
	}

	SPEAR_ENTITY.on_step = function(self, dtime)
		local pos = self.object:getpos()
		local node = minetest.get_node(pos)
		if not self.wear then
			self.object:remove()
			return
		end
		local newpos = self.object:getpos()
		if self.lastpos.x ~= nil then
			for _, pos in pairs(spears_get_trajectoire(self, newpos)) do
				local node = minetest.get_node(pos)
				local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
				for k, obj in pairs(objs) do
					local objpos = obj:getpos()
					if spears_is_player(self.player, obj) or spears_is_entity(obj) then
						if spears_touch(pos, objpos) then
							local puncher = self.object
							if self.player and minetest.get_player_by_name(self.player) then
								puncher = minetest.get_player_by_name(self.player)
							end
							--local speed = vector.length(self.object:getvelocity()) --MFF crabman(28/09/2015) damage valeur equal eq
							local damage = eq --((speed + eq +5)^1.2)/10 --MFF crabman(28/09/2015) damage valeur equal eq
							obj:punch(puncher, 1.0, {
								full_punch_interval=1.0,
								damage_groups={fleshy=damage},
							}, nil)
							minetest.add_item(self.lastpos, {name='spears:spear_' .. kind, wear=self.wear+65535/toughness})
							self.object:remove()
							return
						end
					end
				end
				if node.name ~= "air"
				and not string.find(node.name, 'water_')
				and not (string.find(node.name, 'grass') and not string.find(node.name, 'dirt'))
				and not (string.find(node.name, 'farming:') and not string.find(node.name, 'soil'))
				and not string.find(node.name, 'flowers:')
				and not string.find(node.name, 'fire:') then
					minetest.add_item(self.lastpos, {name='spears:spear_' .. kind, wear=self.wear+65535/toughness})
					self.object:remove()
					return
				end
				self.lastpos={x=pos.x, y=pos.y, z=pos.z}
			end
		end

		self.lastpos={x=newpos.x, y=newpos.y, z=newpos.z}
	end

	minetest.register_entity("spears:spear_" .. kind .. "_entity", SPEAR_ENTITY)

	minetest.register_craft({
		output = 'spears:spear_' .. kind .. ' 4',
		recipe = {
			{'group:wood', 'group:wood', craft},
		}
	})

	minetest.register_craft({
		output = 'spears:spear_' .. kind .. ' 4',
		recipe = {
			{craft, 'group:wood', 'group:wood'},
		}
	})
end

if not DISABLE_STONE_SPEAR then
	spears_register_spear('stone', 'Stone (Hunter)', 3, 25, 'group:stone') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_STEEL_SPEAR then
	spears_register_spear('steel', 'Steel (Hunter)', 4, 30, 'default:steel_ingot') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_DIAMOND_SPEAR then
	spears_register_spear('diamond', 'Diamond (Hunter)', 7, 50, 'default:diamond') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_OBSIDIAN_SPEAR then
	spears_register_spear('obsidian', 'Obsidian (Hunter)', 5, 40, 'default:obsidian') --MFF crabman(28/09/2015) damage and wear
end

if not DISABLE_MITHRIL_SPEAR then
	spears_register_spear('mithril', 'Mithril (Hunter)', 8, 200, 'moreores:mithril_ingot') --MFF crabman(28/09/2015) damage and wear
end

