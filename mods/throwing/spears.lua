function throwing_register_spear_standard (kind, desc, eq, toughness, craft)
	minetest.register_tool("throwing:spear_" .. kind, {
		description = desc .. " spear",
		inventory_image = "throwing_spear_" .. kind .. ".png",
		wield_scale= {x=2,y=1.5,z=1.5};
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type == "object" then
				local damage = ((eq + 20)^1.2)/10
				pointed_thing.ref:punch(user, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, nil)
				if not minetest.setting_getbool("creative_mode") then
					itemstack:add_wear(65535/toughness)
				end
			else
				throwing_shoot_spear(itemstack, user)
				if not minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				end
			end
			return itemstack
		end,
	})
	
	minetest.register_node("throwing:spear_" .. kind .. "_box", {
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				-- Shaft
				{-60/16, -2/16, 2/16, 4, 1/16, -1/16},
				--Spitze
				{-4, -1/16, 1/16, -62/16, 0, 0},
				{-62/16, -1.5/16, 1.5/16, -60/16, 0.5/16, -0.5/16},
			}
		},
		tiles = {"throwing_spear_box.png"},
		groups = {not_in_creative_inventory=1},
	})
	
	local THROWING_SPEAR_ENTITY={
		physical = false,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"throwing:spear_" .. kind .. "_box"},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
		player = "",
		wear = 0,
	}
	
	THROWING_SPEAR_ENTITY.on_step = function(self, dtime)
		if not self.wear then
			self.object:remove()
			return
		end
		local newpos = self.object:getpos()
		if self.lastpos.x ~= nil then
			for _, pos in pairs(throwing_get_trajectoire(self, newpos)) do
				local node = minetest.get_node(pos)
				local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
				for k, obj in pairs(objs) do
					local objpos = obj:getpos()
					if throwing_is_player(self.player, obj) or throwing_is_entity(obj) then
						if (pos.x - objpos.x < 0.5 and pos.x - objpos.x > -0.5) and (pos.z - objpos.z < 0.5 and pos.z - objpos.z > -0.5) then
							local speed = vector.length(self.object:getvelocity())
							local damage = ((speed + eq +5)^1.2)/10					
							obj:punch(self.object, 1.0, {
								full_punch_interval=1.0,
								damage_groups={fleshy=damage},
							}, nil)
							minetest.add_item(self.lastpos, {name='throwing:spear_' .. kind, count=1, wear=self.wear+65535/toughness, metadata=""})
							--if math.random() < toughness then
								--minetest.add_item(self.lastpos, 'throwing:spear_' .. kind)
							--else
								--minetest.add_item(self.lastpos, 'default:stick')
							--end
							self.object:remove()
							return
						end
					end
				end
				if node.name ~= "air" and not string.find(node.name, 'flowers:') and not string.find(node.name, 'fire:') and (node.drawtype and not string.find(node.drawtype, 'plantlike')) then
					minetest.add_item(self.lastpos, {name='throwing:spear_' .. kind, count=1, wear=self.wear+65535/toughness, metadata=""})
					--if math.random() < toughness then
						--minetest.add_item(self.lastpos, 'throwing:spear_' .. kind)
					--else
						--minetest.add_item(self.lastpos, 'default:stick')
					--end
					self.object:remove()
					return
				end								
				self.lastpos={x=pos.x, y=pos.y, z=pos.z}
			end
		end
		self.lastpos={x=newpos.x, y=newpos.y, z=newpos.z}
	end

	minetest.register_entity("throwing:spear_" .. kind .. "_entity", THROWING_SPEAR_ENTITY)

	minetest.register_craft({
		output = 'throwing:spear_' .. kind,
		recipe = {
			{'group:wood', 'group:wood', craft},
		}
	})
	
	minetest.register_craft({
		output = 'throwing:spear_' .. kind,
		recipe = {
			{craft, 'group:wood', 'group:wood'},
		}
	})
end

if not DISABLE_STONE_SPEAR then
	throwing_register_spear_standard ('stone', 'Stone (Hunter)', 0, 20, 'group:stone')
end

if not DISABLE_STEEL_SPEAR then
	throwing_register_spear_standard ('steel', 'Steel (Hunter)', 5, 30, 'default:steel_ingot')
end

if not DISABLE_DIAMOND_SPEAR then
	throwing_register_spear_standard ('diamond', 'Diamond (Hunter)', 10, 40, 'default:diamond')
end

if not DISABLE_OBSIDIAN_SPEAR then
	throwing_register_spear_standard ('obsidian', 'Obsidian (Hunter)', 15, 30, 'default:obsidian')
end

if not DISABLE_MITHRIL_SPEAR then
	throwing_register_spear_standard ('mithril', 'Mithril (Hunter)', 20, 50, 'moreores:mithril_ingot')
end

