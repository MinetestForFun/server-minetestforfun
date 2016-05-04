minetest.register_craftitem("throwing:arrow_torch", {
	description = "Torch Arrow",
	inventory_image = "throwing_arrow_torch.png",
})

minetest.register_node("throwing:arrow_torch_box", {
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
	tiles = {"throwing_arrow_torch.png", "throwing_arrow_torch.png", "throwing_arrow_torch_back.png", "throwing_arrow_torch_front.png", "throwing_arrow_torch_2.png", "throwing_arrow_torch.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY={
	physical = false,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"throwing:arrow_torch_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	node = "",
	player = "",
	bow_damage = 0,
}

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	local newpos = self.object:getpos()
	if self.lastpos.x~= nil then
		for _, pos in pairs(throwing_get_trajectoire(self, newpos)) do
			local node = minetest.get_node(pos)
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 0.5)
			for k, obj in pairs(objs) do
				local objpos = obj:getpos()
				if throwing_is_player(self.player, obj) or throwing_is_entity(obj) then
					if throwing_touch(pos, objpos) then
						local puncher = self.object
						if self.player and minetest.get_player_by_name(self.player) then
							puncher = minetest.get_player_by_name(self.player)
						end
						local damage = 0.5
						if self.bow_damage and self.bow_damage > 0 then
							damage = damage + (self.bow_damage/12)
						end
						obj:punch(puncher, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, nil)
						local toughness = 0.9
						if math.random() < toughness then
							if math.random(0,100) % 2 == 0 then -- 50% of chance to drop //MFF (Mg|07/27/15)
								minetest.add_item(pos, 'throwing:arrow_torch')
							end
						else
							minetest.add_item(pos, 'default:stick')
						end
						self.object:remove()
						return
					end
				end
			end


			if node.name == 'air' then
				minetest.add_node(pos, {name="throwing:torch_trail"})
				minetest.get_node_timer(pos):start(0.1)
			elseif node.name ~= "air"
			and not string.find(node.name, "trail")
			and not (string.find(node.name, 'grass') and not string.find(node.name, 'dirt'))
			and not (string.find(node.name, 'farming:') and not string.find(node.name, 'soil'))
			and not string.find(node.name, 'flowers:')
			and not string.find(node.name, 'fire:') then
				local player = minetest.get_player_by_name(self.player)
				if not player then self.object:remove() return end
				if node.name ~= "ignore" and not string.find(node.name, "water_") and not string.find(node.name, "lava")
				 and not string.find(node.name, "torch") and minetest.get_item_group(node.name, "unbreakable") == 0
				 and not minetest.is_protected(self.lastpos, self.player) and node.diggable ~= false then
					local dir=vector.direction(self.lastpos, pos)
					local wall=minetest.dir_to_wallmounted(dir)
					minetest.add_node(self.lastpos, {name="default:torch", param2 = wall})
				else
					local toughness = 0.9
					if math.random() < toughness then
						minetest.add_item(self.lastpos, 'throwing:arrow_torch')
					else
						minetest.add_item(self.lastpos, 'default:stick')
					end
				end
				self.object:remove()
				return
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end
	end
	self.lastpos={x=newpos.x, y=newpos.y, z=newpos.z}
end

minetest.register_entity("throwing:arrow_torch_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = 'throwing:arrow_torch 4',
	recipe = {
		{'default:stick', 'default:stick', 'group:coal'},
	}
})

minetest.register_craft({
	output = 'throwing:arrow_torch 4',
	recipe = {
		{'group:coal', 'default:stick', 'default:stick'},
	}
})

minetest.register_node("throwing:torch_trail", {
	drawtype = "airlike",
	light_source = default.LIGHT_MAX-1,
	walkable = false,
	drop = "",
	groups = {dig_immediate=3},
	on_timer = function(pos, elapsed)
		minetest.remove_node(pos)
	end,
})
