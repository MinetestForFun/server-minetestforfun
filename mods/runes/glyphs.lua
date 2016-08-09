-- A stylus to inscribe glyphs
-- Part of a Rune Mod Redo
-- By Mg, 2016
-- License : WTFPL
--

runes.glyphs = {}

minetest.register_tool("runes:stylus", {
	description = "Stylus",
	inventory_image = "runes_stylus.png",
	on_use = function(itemstack, user, pointed_thing)
		if not user or pointed_thing.type ~= "node" then return end

		local node = minetest.get_node_or_nil(pointed_thing.under)
		if not node or not minetest.registered_nodes[node.name].walkable then
			return
		end

		node = minetest.get_node_or_nil(pointed_thing.above)
		if not node or node.name ~= "air" then
			return
		end

		local main_inv = user:get_inventory():get_list("main")
		local scroll = main_inv[user:get_wield_index()-1]
		if not scroll then
			minetest.chat_send_player(user:get_player_name(), "There is no scroll before the stylus in your inventory!")
			return
		elseif minetest.get_item_group(scroll:get_name(), "scroll") == 0 then
			minetest.chat_send_player(user:get_player_name(), "The item before your stylus is not a scroll of knowledge!")
			return
		end

		local name = scroll:get_name():gsub("runes:scroll_", "")
		if not runes.scrolls[name] then return end
		local glyph = runes.scrolls[name].glyph
		if not glyph then return end

		if mana.get(user:get_player_name()) < runes.glyphs[name].mana_cost then
			minetest.chat_send_player(user:get_player_name(), "You need " .. runes.glyphs[name].mana_cost .. " of mana to inscribe that glyph")
			return
		end

		-- Calculate param2 manually since MineTest doesn't even do it
		local diff = vector.subtract(pointed_thing.under, pointed_thing.above)

		minetest.add_node(pointed_thing.above, {name = glyph, param2 = minetest.dir_to_wallmounted(diff)})
		minetest.get_meta(pointed_thing.above):set_string("master", user:get_player_name())

		itemstack:add_wear(65535 / 30)
		mana.subtract(user:get_player_name(), runes.glyphs[name].mana_cost)
		return itemstack
	end,
})

minetest.register_craft({
	output = "runes:stylus",
	recipe = {
		{"", "default:obsidian_shard", "default:mithril_ingot"},
		{"default:obsidian_shard", "default:nyancat_rainbow", "default:obsidian_shard"},
		{"default:obsidian_shard", "default:obsidian_shard", ""},
	},
})

minetest.register_craftitem("runes:recharge_wand", {
	description = "Recharge wand",
	inventory_image = "runes_recharge_wand.png",
	on_use = function(itemstack, user, pointed_thing)
		if not pointed_thing.type == "node" or not pointed_thing.under then
			return
		end

		local node = minetest.get_node_or_nil(pointed_thing.under)
		if not node or not minetest.registered_nodes[node.name]
			or minetest.get_item_group(node.name, "glyph") == 0 then
			return
		end

		local meta = minetest.get_meta(pointed_thing.under)
		local charge = meta:get_int("charge")
		local rname = node.name:sub(13)
		local msg = "Rune already charged at maximum capacity"

		if charge < runes.glyphs[rname].max_charge then
			local pmana = mana.get(user:get_player_name())
			-- Lower the index of pmana if it is higher than 20 (to simplify calculations)
			if pmana > 20 then
				pmana = 20
			end
			local delta = runes.glyphs[rname].max_charge - charge

			if delta < pmana then
				meta:set_int("charge", runes.glyphs[rname].max_charge)
				mana.subtract(user:get_player_name(), delta)
				msg = "Rune recharged at maximum capacity"
			else
				meta:set_int("charge", charge + pmana)
				mana.subtract(user:get_player_name(), 20)
				msg = "Rune recharged"
			end
		end
		minetest.chat_send_player(user:get_player_name(), msg)
	end,
})

minetest.register_craft({
	output = "runes:recharge_wand",
	recipe = {
		{"", "", "default:diamond"},
		{"", "default:mese_crystal_fragment", ""},
		{"default:stick", "", ""},
	},
})

minetest.register_craftitem("runes:info_wand", {
			       description = "Information wand",
			       inventory_image = "runes_info_wand.png",
			       on_use = function(itemstack, user, pointed_thing)
				  if not pointed_thing.type == "node" then
				     return
				  end

				  local node = minetest.get_node_or_nil(pointed_thing.under)
				  if not node or not minetest.registered_nodes[node.name]
				  or minetest.get_item_group(node.name, "glyph") == 0 then
				     return
				  end

				  local meta = minetest.get_meta(pointed_thing.under)
				  local metas = meta:to_table().fields
				  local owner = meta:get_string("master")
				  if owner == "" then
				     owner = "nobody"
				  end
				  local rname = node.name:sub(13)

				  local formspec = "size[7,7]" ..
				     "label[0,0; Rune informations :]" ..
				     "button_exit[3, 6.6; 1, 0.6; rune_info_exit; Exit]" ..
				     "textlist[0, 0.5; 6.8, 5.9; runes_info;" ..
				     "Rune : " .. rname .. "," ..
				     "Charge : " .. metas["charge"] .. "/" .. runes.glyphs[rname].max_charge .. "," ..
				     "Owner : " .. owner
				  local i = 4
				  for field, value in pairs(metas) do
				     if field ~= "master" and field ~= "charge" then
					formspec = formspec .. "," .. field .. " (meta) : " .. value
					i = i + 1
				     end
				  end

				  formspec = formspec .. ";]"

				  minetest.show_formspec(user:get_player_name(), "runes:glyph_info", formspec)
			       end,
})

minetest.register_craft({
	output = "runes:info_wand",
	recipe = {
		{"", "", "default:grass"},
		{"", "default:mithril_ingot", ""},
		{"default:stick", "", ""},
	},
})

function register_glyph(name, basics, tab)
	--[[ Basics can contain :
		- texture = "runes_glyph_unknown.png",
		- description = "Mysterious Glyph",
		- initial_charge = 0
		- mana_cost = 0
	--]]

	runes.glyphs[name] = {}
	runes.glyphs[name].mana_cost = basics.mana_cost or 0
	runes.glyphs[name].max_charge = basics.maximum_charge or 100

	local def = table.copy(tab)
	def.groups.glyph = 1

	def.description = basics.description or "Mysterious Glyph"
	def.inventory_image = basics.texture or "runes_glyph_unknown.png"
	def.tiles = {basics.texture or "default_stone.png"}
	def.on_construct = function(pos)
		minetest.get_meta(pos):set_int("charge", (basics.initial_charge or 0))
		tab.on_construct(pos)
	end

	def.drawtype = "signlike"
	def.paramtype = "light"
	def.paramtype2 = "wallmounted"
	def.selection_box = {
		type = "wallmounted",
		wall_top = {-0.5, 0.4, -0.5, 0.5, 0.5, 0.5},
		wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5},
		wall_side = {-0.5, -0.5, -0.5, -0.4, 0.5, 0.5},
	}
	def.walkable = false

	minetest.register_node("runes:glyph_" .. name, def)
end


register_glyph("watchdog", {
		description = "Watch Dog Glyph",
		texture = "runes_glyph_watchdog.png",
		initial_charge = 300,
		maximum_charge = 300,
		mana_cost = 10,
	}, {
		light_source = 8,
		groups = {snappy = 1},
		on_construct = function(pos)
			minetest.get_node_timer(pos):start(0.2)
		end,
		on_timer = function(pos, elapsed)
			local meta = minetest.get_meta(pos)

			for _, ref in pairs(minetest.get_objects_inside_radius(pos, 3)) do
				if ref and not ref:get_armor_groups().immortal then
					if not ref:is_player() or ref.is_fake_player or not meta:get_string("master") or meta:get_string("master") == "" or ref:get_player_name() ~= meta:get_string("master") then
						ref:set_hp(ref:get_hp() - 1)
						meta:set_int("charge", (meta:get_int("charge") or 1) - 1)
						local collisionbox = ref:get_properties().collisionbox
						local refpos = ref:getpos()
						refpos.y = refpos.y + (((collisionbox[4] or 0) - (collisionbox[3] or 0)) / 2)

						local vel = vector.subtract(refpos, pos)
						minetest.add_particlespawner({
							amount = 30,
							minpos = pos, maxpos = pos,
							minvel = vel, maxvel = vector.multiply(vel, 3),
							minacc = 0, maxacc = 0,--vector.multiply(vel, 3),
							minexptime = 1, maxexptime = 1,
							minsize = 2, maxsize = 5,
							collisiondetection = false,
							vertical = false,
							texture = "runes_glyph_watchdog.png",
						})
					end
				end
			end
			return true
		end
	}
)

register_glyph("manasucker", {
		description = "Mana Sucker Glyph",
		texture = "runes_glyph_manasucker.png",
		initial_charge = 100,
		maximum_charge = 100,
		mana_cost = 20,
	}, {
		groups = {snappy = 1},
		on_construct = function(pos)
			minetest.get_node_timer(pos):start(3)
			minetest.get_meta(pos):set_int("mana", 0)
		end,
		on_punch = function(pos, _, puncher)
			local meta = minetest.get_meta(pos)
			if meta:get_string("master") and puncher:is_player() and not puncher.is_fake_player and puncher:get_player_name() == meta:get_string("master") then
				local k = meta:get_int("mana")
				local name = puncher:get_player_name()
				local o = mana.getmax(name) - mana.get(name)
				local u = 0

				if k > o then
					u = k - mana.getmax(name)
					mana.set(name, o)
				else
					mana.add(name, k)
				end

				meta:set_int("mana", u)
			end
		end,
		on_timer = function(pos, elapsed)
			local meta = minetest.get_meta(pos)
			if meta:get_int("charge") <= 0 then
				return true
			end

			local more_mana = 0
			for _, ref in pairs(minetest.get_objects_inside_radius(pos, 5)) do
				if ref and ref:is_player() and not ref.is_fake_player and (not meta:get_string("master") or meta:get_string("master") == "" or meta:get_string("master") ~= ref:get_player_name()) then
					local burst = math.random(10, 40)
					local manalevel = mana.get(ref:get_player_name())

					if manalevel > 0 then
						if manalevel < burst then
							mana.set(ref:get_player_name(), 0)
							more_mana = more_mana + manalevel
						else
							mana.subtract(ref:get_player_name(), burst)
							more_mana = more_mana + burst
						end

						local collisionbox = ref:get_properties().collisionbox
						local refpos = ref:getpos()
						refpos.y = refpos.y + (((collisionbox[4] or 0) - (collisionbox[3] or 0)) / 2)

						local vel = vector.subtract(pos, refpos)
						minetest.add_particlespawner({
							amount = 30,
							minpos = refpos, maxpos = refpos,
							minvel = vel, maxvel = vel,
							minacc = 0, maxacc = 0,--vector.multiply(vel, 3),
							minexptime = 1, maxexptime = 1,
							minsize = 1, maxsize = 1,
							collisiondetection = false,
							vertical = false,
							texture = "runes_glyph_manasucker.png",
						})
						meta:set_int("charge", meta:get_int("charge") - 1)
					end
				end
			end
			meta:set_int("mana", meta:get_int("mana") + more_mana)
			return true
		end
	}
)

register_glyph("spontafire", {
		  description = "Spontaneous Fire Glyph",
		  texture = "runes_glyph_spontafire.png",
		  initial_charge = 0,
		  maximum_charge = 500,
		  mana_cost = 20,
		}, {
		  groups = {snappy = 1},
		  on_construct = function(pos)
		     minetest.get_node_timer(pos):start(1)
		  end,
		  on_timer = function(pos, elapsed)
		     local meta = minetest.get_meta(pos)
		     local charge = meta:get_int("charge")

		     for _, ref in pairs(minetest.get_objects_inside_radius(pos, 10)) do
			if ((not ref:is_player()) and ref:get_entity_name() ~= "gauges:hp_bar")
			or (ref:get_player_name() ~= "" and ref:get_player_name() ~= meta:get_string("master")) then
			   local rpos = vector.round(ref:getpos())
			   rpos.y = rpos.y - 1
			   local node = minetest.get_node(rpos)
			   if node.name == "air" and (not minetest.is_protected(rpos, meta:get_string("master")))
			   and charge >= runes.glyphs["spontafire"].mana_cost then
			      minetest.add_node(rpos, {name = "fire:basic_flame"})
			      charge = charge - runes.glyphs["spontafire"].mana_cost
			   end
			end
		     end
		     meta:set_int("charge", charge)
		     return true
		  end,
})

register_glyph("prankster", {
	description = "Prankster Glyph",
	texture = "runes_glyph_prankster.png",
	initial_charge = 600,
	maximum_charge = 1200,
	mana_cost = 20,
},{
	groups = {snappy = 1},
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(5)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local charge = meta:get_int("charge")

		for _, ref in pairs(minetest.get_objects_inside_radius(pos, 10)) do
			if charge >= runes.glyphs["prankster"].mana_cost and ref:is_player() and ref:get_player_name() ~= meta:get_string("master") then
				local thieff = math.random(1,32)
				local inv = ref:get_inventory()
				if inv then
					local stolen = inv:get_stack("main", thieff)
					inv:set_stack("main", thieff, nil)
					if stolen:get_count() > 0 then
						local pos = ref:getpos()
						local obj = minetest.add_item({x = pos.x, y = pos.y + 2.5, z = pos.z}, stolen)
						if obj then
							obj:setvelocity({x = math.random(-5,5), y = math.random(3,5), z = math.random(-5,5)})
						end
						charge = charge - runes.glyphs["prankster"].mana_cost
						minetest.chat_send_player(ref:get_player_name(), "The Prankster attacked you and stole " .. stolen:get_count() .. " "
							.. (minetest.registered_items[stolen:get_name()].description or " of something")
						)
					else
						minetest.chat_send_player(ref:get_player_name(), "The Prankster attacked you but failed at stealing from you..")
					end
				else
					minetest.log("Inventory retrieval failed")
				end
			end
		end
		meta:set_int("charge", charge)
		return true
	end,
})
