minetest.register_craftitem("throwing:arrow_dig", {
	description = "Dig Arrow",
	inventory_image = "throwing_arrow_dig.png",
})

minetest.register_node("throwing:arrow_dig_box", {
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
	tiles = {"throwing_arrow_dig.png", "throwing_arrow_dig.png", "throwing_arrow_dig_back.png", "throwing_arrow_dig_front.png", "throwing_arrow_dig_2.png", "throwing_arrow_dig.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"throwing:arrow_dig_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	player = "",
	bow_damage = 0,
}


THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	local newpos = self.object:getpos()
	if self.lastpos.x ~= nil then
		for _, pos in pairs(throwing_get_trajectoire(self, newpos)) do
			local node = minetest.get_node(pos)
			local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
			for k, obj in pairs(objs) do
				if throwing_is_player(self.player, obj) or throwing_is_entity(obj) then
					if throwing_touch(pos, obj:getpos()) then
						local puncher = self.object
						if self.player and minetest.get_player_by_name(self.player) then
							puncher = minetest.get_player_by_name(self.player)
						end
						local damage = 1.5
						if self.bow_damage and self.bow_damage > 0 then
							damage = damage + (self.bow_damage/12)
						end
						obj:punch(puncher, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, nil)
						if math.random(0,100) % 2 == 0 then -- 50% of chance to drop //MFF (Mg|07/27/15)
							minetest.add_item(pos, "throwing:arrow_dig")
						end
						self.object:remove()
						return
					end
				end
			end
			if node.name ~= "air"
			and not string.find(node.name, "water_")
			and not (string.find(node.name, 'grass') and not string.find(node.name, 'dirt'))
			and not (string.find(node.name, 'farming:') and not string.find(node.name, 'soil'))
			and not string.find(node.name, 'flowers:')
			and not string.find(node.name, 'fire:') then
				if node.name ~= "ignore" and minetest.get_item_group(node.name, "unbreakable") == 0
					and not minetest.is_protected(pos, self.player)
					and node.diggable ~= false then
					minetest.set_node(pos, {name = "air"})
					minetest.add_item(pos, node.name)
				end
				self.object:remove()
				return
			end
			self.lastpos={x=pos.x, y=pos.y, z=pos.z}
		end
	end
	self.lastpos={x=newpos.x, y=newpos.y, z=newpos.z}
end

minetest.register_entity("throwing:arrow_dig_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = 'throwing:arrow_dig',
	recipe = {
		{'default:stick', 'default:stick', 'default:pick_steel'},
	}
})

minetest.register_craft({
	output = 'throwing:arrow_dig',
	recipe = {
		{'default:pick_steel', 'default:stick', 'default:stick'},
	}
})
