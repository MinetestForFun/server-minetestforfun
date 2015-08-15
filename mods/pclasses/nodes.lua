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
		print(clicker:get_player_name())
		print(self.class)
		pclasses.api.set_player_class(clicker:get_player_name(), self.class)
	end,
	on_activate = function(self, staticdata)
		self.itemname = staticdata:split("|")[1]
		self.class = staticdata:split("|")[2]
		self.object:set_armor_groups({immortal=1})
		self:set_item(self.itemname)
	end,
	get_staticdata = function(self)
		return self.itemname .. "|" ..  self.class
	end,
})

local classes_items = {
	["hunter"] = "throwing:bow_minotaur_horn_improved",
	["warrior"] = "default:dungeon_master_s_blood_sword",
	["admin"] = "maptools:pick_admin",
	["adventurer"] = "unified_inventory:bag_large"
}

function pclasses.register_class_switch_orb(cname, color)
	color = color or { r = 255, g = 255, b = 255 }
	local txtcolor = string.format("#%02x%02x%02x", color.r, color.g, color.b)
	local overlay = "pclasses_class_switch_orb_overlay.png"
	minetest.register_node(":pclasses:class_switch_" .. cname, {
		description = "Class switch orb (" .. cname .. ")",
		tiles = {overlay .. "^[colorize:" .. txtcolor .. "^" .. overlay},
		drawtype = "nodebox",
		node_box = { type = "fixed", fixed = {
			{-7/16, -8/16, -7/16, 7/16, -7/16, 7/16}, -- bottom plate
			{-6/16, -7/16, -6/16, 6/16, -6/16, 6/16}, -- bottom plate (upper)
			{-0.25, -6/16, -0.25, 0.25, 11/16, 0.25}, -- pillar
			{-7/16, 11/16, -7/16, 7/16, 12/16, 7/16}, -- top plate
		}},
		drop = "",
		can_dig = function() return false end,
		diggable = false,
		sunlight_propagates = true,
		light_source = 10,
		sounds = default.node_sound_glass_defaults(),
		groups = {not_in_creative_inventory=1, cracky = 1},
		after_place_node = function(pos)
			pos.y = pos.y + 1
			local obj = minetest.add_entity(pos, "pclasses:item")
			if obj then
				obj:get_luaentity():set_item(classes_items[cname])
				obj:get_luaentity():set_class(cname)
			end
		end,
	})
end
