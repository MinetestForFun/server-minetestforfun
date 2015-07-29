function throwing_register_arrow_standard (kind, desc, eq, toughness, craft)
	minetest.register_craftitem("throwing:arrow_" .. kind, {
		description = desc .. " arrow",
		inventory_image = "throwing_arrow_" .. kind .. ".png",
	})

	minetest.register_node("throwing:arrow_" .. kind .. "_box", {
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				-- Shaft
				{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
				--Spitze
				{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
				{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
				--Federn
				{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
				{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
				{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
				{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},

				{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
				{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
				{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
				{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
			}
		},
		tiles = {"throwing_arrow_" .. kind .. ".png", "throwing_arrow_" .. kind .. ".png", "throwing_arrow_" .. kind .. "_back.png", "throwing_arrow_" .. kind .. "_front.png", "throwing_arrow_" .. kind .. "_2.png", "throwing_arrow_" .. kind .. ".png"},
		groups = {not_in_creative_inventory=1},
	})

	local THROWING_ARROW_ENTITY={
		physical = false,
		timer=0,
		visual = "wielditem",
		visual_size = {x=0.1, y=0.1},
		textures = {"throwing:arrow_" .. kind .. "_box"},
		lastpos={},
		collisionbox = {0,0,0,0,0,0},
		player = "",
	}

	THROWING_ARROW_ENTITY.on_step = function(self, dtime)
		self.timer=self.timer+dtime
		local pos = self.object:getpos()
		local node = minetest.get_node(pos)

		if self.timer>0.2 then
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "throwing:arrow_" .. kind .. "_entity" and obj:get_luaentity().name ~= "__builtin:item" then
						local speed = vector.length(self.object:getvelocity())
						local damage = ((speed + eq)^1.2)/10 -- Modif MFF, damage tweakable here
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, nil)
						if math.random() < toughness then
							if math.random(0,100) % 2 == 0 then
								minetest.add_item(self.lastpos, 'throwing:arrow_' .. kind)
							end
						else
							minetest.add_item(self.lastpos, 'default:stick')
						end
						self.object:remove()
						return
					end
				end
			end
		end

		if self.lastpos.x~=nil then
			if node.name ~= "air" and not string.find(node.name, 'water') and not string.find(node.name, 'default:grass') and not string.find(node.name, 'default:junglegrass') and not string.find(node.name, 'flowers:') and not string.find(node.name, 'farming:') then
				if math.random() < toughness then
					minetest.add_item(self.lastpos, 'throwing:arrow_' .. kind)
				else
					minetest.add_item(self.lastpos, 'default:stick')
				end
				self.object:remove()
				return
			end
		end
		self.lastpos={x=pos.x, y=pos.y, z=pos.z}
	end

	minetest.register_entity("throwing:arrow_" .. kind .. "_entity", THROWING_ARROW_ENTITY)

	minetest.register_craft({
		output = 'throwing:arrow_' .. kind .. ' 16',
		recipe = {
			{'default:stick', 'default:stick', craft},
		}
	})

	minetest.register_craft({
		output = 'throwing:arrow_' .. kind .. ' 16',
		recipe = {
			{craft, 'default:stick', 'default:stick'},
		}
	})
end

if not DISABLE_STONE_ARROW then
	throwing_register_arrow_standard ('stone', 'Stone', 0, 0.25, 'group:stone')
end

if not DISABLE_STEEL_ARROW then
	throwing_register_arrow_standard ('steel', 'Steel', 4, 0.33, 'default:steel_ingot')
end

if not DISABLE_OBSIDIAN_ARROW then
	throwing_register_arrow_standard ('obsidian', 'Obsidian', 8, 0.50, 'default:obsidian')
end

if not DISABLE_DIAMOND_ARROW then
	throwing_register_arrow_standard ('diamond', 'Diamond', 12, 0.57, 'default:diamond')
end

if not DISABLE_MITHRIL_ARROW then
	throwing_register_arrow_standard ('mithril', 'Mithril', 12, 0.66, 'moreores:mithril_ingot')
end
