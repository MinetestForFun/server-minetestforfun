minetest.register_entity("pclasses:item", {
	initial_properties = {
		hp_max = 1,
		physical = false,
		collisionbox = {-0.17,-0.17,-0.17, 0.17,0.17,0.17},
		visual = "sprite",
		visual_size = {x=0.5, y=0.5},
		textures = {""},
		spritediv = {x=1, y=1},
		initial_sprite_basepos = {x=0, y=0},
		is_visible = false,
	},
	itemname = '',
	class = '',
	set_class = function(self, class)
		self.class = class
	end,
	set_item = function(self, itemstring)
		self.itemname = itemstring
		local itemname = itemstring
		local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end
		local prop = {
			is_visible = true,
			visual = "sprite",
			textures = {"unknown_item.png"}
		}
		if item_texture and item_texture ~= "" then
			prop.visual = "sprite"
			prop.textures = {item_texture}
			prop.visual_size = {x=0.50, y=0.50}
		else
			prop.visual = "wielditem"
			prop.textures = {itemname}
			prop.visual_size = {x=0.25, y=0.25}
			prop.automatic_rotate = math.pi * 0.10
		end
		self.object:set_properties(prop)
	end,
	on_rightclick = function(self, clicker)
		action_timers.wrapper(
			clicker:get_player_name(),
			"class switch",
			"class_switch_" .. clicker:get_player_name(),
			3600,
			pclasses.api.set_player_class,
			{clicker:get_player_name(), self.class, true}
		)
	end,
	on_activate = function(self, staticdata)
		local tab = minetest.deserialize(staticdata)
		if tab then
			self.itemname = tab.itemname
			self.class = tab.class
		else
			self.itemname = staticdata:split("|")[1]
			self.class = staticdata:split("|")[2]
		end
		self.object:set_armor_groups({immortal=1})
		self:set_item(self.itemname)
	end,
	get_staticdata = function(self)
		return minetest.serialize({itemname = self.itemname, class = self.class})
	end,
})

function pclasses.register_class_switch(cname, params)
	local color = params.color or { r = 255, g = 255, b = 255 }
	local txtcolor = string.format("#%02x%02x%02x", color.r, color.g, color.b)
	local overlay = "pclasses_class_switch_orb_overlay.png"
	local holo_item = params.holo_item or "default:diamond"
	minetest.register_node(":pclasses:class_switch_" .. cname, {
		description = "Class switch orb (" .. cname .. ")",
		tiles = {(params.tile or overlay) .. "^[colorize:" .. txtcolor .. ":200"},
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {
			{-7/16, -8/16, -7/16, 7/16, -7/16, 7/16}, -- bottom plate
			{-6/16, -7/16, -6/16, 6/16, -6/16, 6/16}, -- bottom plate (upper)
			{-0.25, -6/16, -0.25, 0.25, 11/16, 0.25}, -- pillar
			{-7/16, 11/16, -7/16, 7/16, 12/16, 7/16}, -- top plate
		}},
		can_dig = function(pos, player) return minetest.get_player_privs(player:get_player_name()).server == true end,
		sunlight_propagates = true,
		light_source = 10,
		sounds = default.node_sound_glass_defaults(),
		groups = {unbreakable = 1},
		after_place_node = function(pos)
			pos.y = pos.y + 1

			-- Clean remaining entities
			for _,ref in pairs(minetest.get_objects_inside_radius(pos, 0.3)) do
				local e = ref:get_luaentity()
				if e and e.name == "pclasses:item" then
					ref:remove()
				end
			end

			local obj = minetest.add_entity(pos, "pclasses:item")
			if obj then
				obj:get_luaentity():set_item(holo_item)
				obj:get_luaentity():set_class(cname)
			end
			pos.y = pos.y - 1
			local timer = minetest.get_node_timer(pos)
			timer:start(3)
		end,
		on_timer = function(pos)
			pos.y = pos.y + 1
			for _,ref in pairs(minetest.get_objects_inside_radius(pos, 0.3)) do
				local e = ref:get_luaentity()
				if e and e.name == "pclasses:item" then
					return true
				end
			end

			local obj = minetest.add_entity(pos, "pclasses:item")
			if obj then
				obj:get_luaentity():set_item(holo_item)
				obj:get_luaentity():set_class(cname)
			end
			return true
		end,
		on_destruct = function(pos)
			pos.y = pos.y + 1
			for _,ref in pairs(minetest.get_objects_inside_radius(pos, 0.3)) do
				local e = ref:get_luaentity()
				if e and e.name == "pclasses:item" then
					ref:remove()
				end
			end
		end,
	})
end
