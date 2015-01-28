
computer = { };

computer.register = function ( name, def )
	local nodename = name;
	if (name:sub(1, 1) == ":") then name = name:sub(2); end
	local modname, basename = name:match("^([^:]+):(.*)");
	local TEXPFX = modname.."_"..basename.."_";
	local ONSTATE = modname..":"..basename;
	local OFFSTATE = modname..":"..basename.."_off";
	local def = def;
	minetest.register_node(ONSTATE, {
		drawtype = "nodebox";
		paramtype = "light";
		paramtype2 = "facedir";
		description = def.description;
		groups = { snappy=2, choppy=2, oddly_breakable_by_hand=2 };
		tiles = {
			TEXPFX.."tp.png",
			TEXPFX.."bt.png",
			TEXPFX.."rt.png",
			TEXPFX.."lt.png",
			TEXPFX.."bk.png",
			TEXPFX.."ft.png",
		};
		node_box = def.node_box;
		selection_box = def.node_box;
		on_rightclick = function ( pos, node, clicker, itemstack)
			if (def.on_turn_off) then
				if (def.on_turn_off(pos, node, clicker, itemstack)) then return; end
			end
			node.name = OFFSTATE;
			minetest.set_node(pos, node);
		end;
	});
	minetest.register_node(OFFSTATE, {
		drawtype = "nodebox";
		paramtype = "light";
		paramtype2 = "facedir";
		groups = { snappy=2, choppy=2, oddly_breakable_by_hand=2,
			not_in_creative_inventory=1 };
		tiles = {
			(TEXPFX.."tp"..(def.tiles_off.top    and "_off" or "")..".png"),
			(TEXPFX.."bt"..(def.tiles_off.bottom and "_off" or "")..".png"),
			(TEXPFX.."rt"..(def.tiles_off.right  and "_off" or "")..".png"),
			(TEXPFX.."lt"..(def.tiles_off.left   and "_off" or "")..".png"),
			(TEXPFX.."bk"..(def.tiles_off.back   and "_off" or "")..".png"),
			(TEXPFX.."ft"..(def.tiles_off.front  and "_off" or "")..".png"),
		};
		node_box = def.node_box_off or def.node_box;
		selection_box = def.node_box_off or def.node_box;
		on_rightclick = function ( pos, node, clicker, itemstack)
			if (def.on_turn_on) then
				if (def.on_turn_on(pos, node, clicker, itemstack)) then return; end
			end
			node.name = ONSTATE;
			minetest.set_node(pos, node);
		end;
		drop = ONSTATE;
	});
end

computer.register_handheld = function ( name, def )
	local nodename = name;
	if (name:sub(1, 1) == ":") then name = name:sub(2); end
	local modname, basename = name:match("^([^:]+):(.*)");
	local TEXPFX = modname.."_"..basename.."_inv";
	local ONSTATE = modname..":"..basename;
	local OFFSTATE = modname..":"..basename.."_off";
	local on_use = def.on_use;
	minetest.register_craftitem(ONSTATE, {
		description = def.description;
		inventory_image = TEXPFX..".png";
		wield_image = TEXPFX..".png";
	});
end

computer.pixelnodebox = function ( size, boxes )
	local fixed = { };
	local i, box;
	for i, box in ipairs(boxes) do
		local x, y, z, w, h, l = unpack(box);
		fixed[#fixed + 1] = {
			(x / size) - 0.5,
			(y / size) - 0.5,
			(z / size) - 0.5,
			((x + w) / size) - 0.5,
			((y + h) / size) - 0.5,
			((z + l) / size) - 0.5,
		};
	end
	return {
		type = "fixed";
		fixed = fixed;
	};
end

local MODPATH = minetest.get_modpath("computer");
dofile(MODPATH.."/computers.lua");
dofile(MODPATH.."/miscitems.lua");
dofile(MODPATH.."/recipes.lua");


