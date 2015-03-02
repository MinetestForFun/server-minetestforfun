-- Locked Stuff for Home Decor mod, by Kaeza
--
-- The code is mostly copypasta from default:chest_locked, with a few
-- tidbits to ease creation of new items, should need arise.

local S = homedecor.gettext

--[[
  |  create_locked ( name, infotext )
  |
  |  Description:
  |   This function takes a base node name such as "homedecor:refrigerator",
  |   copies the definition from the original item into a new table, modifies
  |   it a bit, and registers a new node with a "_locked" suffix such as
  |   "homedecor:refrigerator_locked". The new node behaves identically to
  |   the base node, except that moving items to/from the node's inventory
  |   is only allowed for the original placer. In addition, it register a new
  |   shapeless recipe for the node, using the base node plus a steel ingot.
  |
  |  Arguments:
  |   name      The base node name
  |   infotext  The infotext description (in case the name is too long).
  |
  |  Example Usage:
  |   create_locked("homedecor:refrigerator", "Locked Fridge")
  |   ^ This generates a new "Locked Refrigerator" node, whose infotext is
  |   "Locked Fridge (owned by <placer>)".
  |
  |  Notes:
  |   If <infotext> is not specified (or is nil), the infotext will be the
  |   base node's description prefixed by "Locked ".
  |
  |   The ABM for the locked oven is defined in oven.lua.
  ]]
local function create_locked ( name, infotext )
	local def = { }
	for k, v in pairs(minetest.registered_nodes[name]) do
		def[k] = v
	end
	def.type = nil
	def.name = nil
	def.description = S("%s (Locked)"):format(def.description)
	local after_place_node = def.after_place_node
	def.after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", S("%s (owned by %s)"):format(infotext,meta:get_string("owner")))
		if (after_place_node) then
			return after_place_node(pos, placer)
		end
	end
	local allow_metadata_inventory_move = def.allow_metadata_inventory_move;
	def.allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if (player:get_player_name() ~= meta:get_string("owner")) then
			minetest.log("action", S("%s tried to access a %s belonging to %s at %s"):format(
				player:get_player_name(),
				infotext,
				meta:get_string("owner"),
				minetest.pos_to_string(pos)
			))
			return 0
		end
		if (allow_metadata_inventory_move) then
			return allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
		else
			return count
		end
	end
	local allow_metadata_inventory_put = def.allow_metadata_inventory_put;
	def.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if (player:get_player_name() ~= meta:get_string("owner")) then
			minetest.log("action", S("%s tried to access a %s belonging to %s at %s"):format(
				player:get_player_name(),
				infotext,
				meta:get_string("owner"),
				minetest.pos_to_string(pos)
			))
			return 0
		end
		if (allow_metadata_inventory_put) then
			return allow_metadata_inventory_put(pos, listname, index, stack, player)
		else
			return stack:get_count()
		end
	end
	local allow_metadata_inventory_take = def.allow_metadata_inventory_take;
	def.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if (player:get_player_name() ~= meta:get_string("owner")) then
			minetest.log("action", S("%s tried to access a %s belonging to %s at %s"):format(
				player:get_player_name(),
				infotext,
				meta:get_string("owner"),
				minetest.pos_to_string(pos)
			))
			return 0
		end
		if (allow_metadata_inventory_take) then
			return allow_metadata_inventory_take(pos, listname, index, stack, player)
		else
			return stack:get_count()
		end
	end
	minetest.register_node(name.."_locked", def)
	minetest.register_craft({
		output = name.."_locked",
		type = "shapeless",
		recipe = {
			name,
			"default:steel_ingot",
		}
	})
end

local items = {
	{ "refrigerator_white_bottom",
	  "Refrigerator" },
	{ "refrigerator_steel_bottom",
	  "Refrigerator (stainless steel)" },
	{ "kitchen_cabinet",
	  "Cabinet" },
	{ "kitchen_cabinet_steel",
	  "Cabinet (stainless steel top)" },
	{ "kitchen_cabinet_granite",
	  "Cabinet (granite top)" },
	{ "kitchen_cabinet_marble",
	  "Cabinet (marble top)" },
	{ "kitchen_cabinet_half",
	  "Cabinet" },
	{ "kitchen_cabinet_with_sink",
	  "Cabinet" },
	{ "nightstand_oak_one_drawer",
	  "Nightstand" },
	{ "nightstand_oak_two_drawers",
	  "Nightstand" },
	{ "nightstand_mahogany_one_drawer",
	  "Nightstand" },
	{ "nightstand_mahogany_two_drawers",
	  "Nightstand" },
	{ "filing_cabinet",
	  "Filing cabinet" },
	{ "oven",
	  "Oven" },
	{ "oven_active",
	  "Oven (active)" },
	{ "oven_steel",
	  "Oven (stainless steel)" },
	{ "oven_steel_active",
	  "Oven (stainless steel, active)" },
	{ "microwave_oven",
	  "Microwave Oven" },
	{ "microwave_oven_active",
	  "Microwave Oven (active)" },
}

for _,item in ipairs(items) do
	local name, info = item[1], item[2];
	create_locked("homedecor:"..name, S("Locked "..info));
end
