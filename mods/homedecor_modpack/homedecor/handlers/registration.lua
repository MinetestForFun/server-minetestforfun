homedecor = homedecor or {}
local S = homedecor.gettext

local default_can_dig = function(pos,player)
	local meta = minetest.get_meta(pos)
	return meta:get_inventory():is_empty("main")
end

local default_inventory_size = 32
local default_inventory_formspecs = {
	["4"]="size[8,6]"..
	"list[context;main;2,0;4,1;]"..
	"list[current_player;main;0,2;8,4;]",

	["6"]="size[8,6]"..
	"list[context;main;1,0;6,1;]"..
	"list[current_player;main;0,2;8,4;]",

	["8"]="size[8,6]"..
	"list[context;main;0,0;8,1;]"..
	"list[current_player;main;0,2;8,4;]",

	["12"]="size[8,7]"..
	"list[context;main;1,0;6,2;]"..
	"list[current_player;main;0,3;8,4;]",

	["16"]="size[8,7]"..
	"list[context;main;0,0;8,2;]"..
	"list[current_player;main;0,3;8,4;]",

	["24"]="size[8,8]"..
	"list[context;main;0,0;8,3;]"..
	"list[current_player;main;0,4;8,4;]",

	["32"]="size[8,9]".. default.gui_bg .. default.gui_bg_img .. default.gui_slots ..
	"list[context;main;0,0.3;8,4;]"..
	"list[current_player;main;0,4.85;8,1;]"..
	"list[current_player;main;0,6.08;8,3;8]"..
	default.get_hotbar_bg(0,4.85),

	["50"]="size[10,10]"..
	"list[context;main;0,0;10,5;]"..
	"list[current_player;main;1,6;8,4;]",
}

local function get_formspec_by_size(size)
	--TODO heuristic to use the "next best size"
	local formspec = default_inventory_formspecs[tostring(size)]
	return formspec or default_inventory_formspecs
end

--wrapper around minetest.register_node that sets sane defaults and interprets some specialized settings
function homedecor.register(name, def)
	def.paramtype = def.paramtype or "light"
	def.paramtype2 = def.paramtype2 or "facedir"

	def.drawtype = def.drawtype
			or (def.mesh and "mesh")
			or (def.node_box and "nodebox")

	local infotext = def.infotext
	--def.infotext = nil -- currently used to set locked refrigerator infotexts

	-- handle inventory setting
	-- inventory = {
	--	size = 16
	--	formspec = …
	-- }
	local inventory = def.inventory
	def.inventory = nil

	if inventory then
		def.on_construct = def.on_construct or function(pos)
			local meta = minetest.get_meta(pos)
			if infotext then
				meta:set_string("infotext", infotext)
			end
			local size = inventory.size or default_inventory_size
			meta:get_inventory():set_size("main", size)
			meta:set_string("formspec", inventory.formspec or get_formspec_by_size(size))
		end

		def.can_dig = def.can_dig or default_can_dig
		def.on_metadata_inventory_move = def.on_metadata_inventory_move or function(pos, from_list, from_index, to_list, to_index, count, player)
			minetest.log("action", S("%s moves stuff in %s at %s"):format(
				player:get_player_name(), name, minetest.pos_to_string(pos)
			))
		end
		def.on_metadata_inventory_put = def.on_metadata_inventory_put or function(pos, listname, index, stack, player)
			minetest.log("action", S("%s moves stuff to %s at %s"):format(
				player:get_player_name(), name, minetest.pos_to_string(pos)
			))
		end
		def.on_metadata_inventory_take = def.on_metadata_inventory_take or function(pos, listname, index, stack, player)
			minetest.log("action", S("%s takes stuff from %s at %s"):format(
				player:get_player_name(), name, minetest.pos_to_string(pos)
			))
		end
	elseif infotext and not def.on_construct then
		def.on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", infotext)
		end
	end

	local expand  = def.expand
	def.expand = nil
	local after_unexpand = def.after_unexpand
	def.after_unexpand = nil

	if expand then
		def.on_place = def.on_place or function(itemstack, placer, pointed_thing)
			if expand.top then
				return homedecor.stack_vertically(itemstack, placer, pointed_thing, itemstack:get_name(), expand.top)
			elseif expand.right then
				return homedecor.stack_sideways(itemstack, placer, pointed_thing, itemstack:get_name(), expand.right, true)
			elseif expand.forward then
				return homedecor.stack_sideways(itemstack, placer, pointed_thing, itemstack:get_name(), expand.forward, false)
			end
		end
		def.after_dig_node = def.after_dig_node or function(pos, oldnode, oldmetadata, digger)
			if expand.top and expand.forward ~= "air" then
				local top_pos = { x=pos.x, y=pos.y+1, z=pos.z }
				if minetest.get_node(top_pos).name == expand.top then
					minetest.remove_node(top_pos)
				end
			end

			local fdir = oldnode.param2
			if not fdir or fdir > 3 then return end

			if expand.right and expand.forward ~= "air" then
				local right_pos = { x=pos.x+homedecor.fdir_to_right[fdir+1][1], y=pos.y, z=pos.z+homedecor.fdir_to_right[fdir+1][2] }
				if minetest.get_node(right_pos).name == expand.right then
					minetest.remove_node(right_pos)
				end
			end
			if expand.forward and expand.forward ~= "air" then
				local forward_pos = { x=pos.x+homedecor.fdir_to_fwd[fdir+1][1], y=pos.y, z=pos.z+homedecor.fdir_to_fwd[fdir+1][2] }
				if minetest.get_node(forward_pos).name == expand.forward then
					minetest.remove_node(forward_pos)
				end
			end

			if after_unexpand then
				after_unexpand(pos)
			end
		end
	end

	-- register the actual minetest node
	minetest.register_node("homedecor:" .. name, def)
end
