-- FOOD MOD
-- A mod written by rubenwardy that adds
-- food to the minetest game
-- =====================================
-- >> food/api.lua
-- The supporting api for the mod
-- =====================================

food = {
	modules = {},
	disabled_modules = {},
	debug = false,
	version = 2.3
}

-- Checks for external content, and adds support
function food.support(group, item)
	if type(group) == "table" then
		for i = 1, #group do
			food.support(group[i], item)
		end
		return
	end
	if type(item) == "table" then
		for i = 1, #item do
			food.support(group, item[i])
		end
		return
	end

	local idx = string.find(item, ":")
	if idx <= 1 then
		error("[Food Error] food.support - error in item name ('" .. item .. "')")
	end
	local mod = string.sub(item, 1, idx - 1)

	if not minetest.get_modpath(mod) then
		if food.debug then
			print("[Food Debug] Mod '"..mod.."' is not installed")
		end
		return
	end

	local data = minetest.registered_items[item]
	if not data then
		print("[Food Warning] Item '"..item.."' not found")
		return
	end


	food.disable(group)

	-- Add group
	local g = {}
	if data.groups then
		for k, v in pairs(data.groups) do
			g[k] = v
		end
	end
	g["food_"..group] = 1
	minetest.override_item(item, {groups = g})
end

function food.disable(name)
	if type(name) == "table" then
		for i = 1, #name do
			food.disable(name[i])
		end
		return
	end
	food.disabled_modules[name] = true
end

function food.disable_if(mod, name)
	if minetest.get_modpath(mod) then
		food.disable(name)
	end
end

-- Adds a module
function food.module(name, func, ingred)
	if food.disabled_modules[name] then
		return
	end
	if ingred then
		for name, def in pairs(minetest.registered_items) do
			local g = def.groups and def.groups["food_"..name] or 0
			if g > 0 then
				print("cancelled")
				return
			end
		end

		if food.debug then
			print("[Food Debug] Registering " .. name .. " fallback definition")
		end
	elseif food.debug then
		print("[Food Debug] Module " .. name)
	end
	func()
end

-- Checks for hunger mods to register food on
function food.item_eat(amt)
	if minetest.get_modpath("diet") and diet and diet.item_eat then
		return diet.item_eat(amt)
	elseif minetest.get_modpath("hud") and hud and hud.item_eat then
		return hud.item_eat(amt)
	elseif minetest.get_modpath("hbhunger") then
		if hbhunger and hbhunger.item_eat then -- hbhunger is nil when world is loaded with damage disabled
			return hbhunger.item_eat(amt)
		end
		return function(...) end
	elseif minetest.get_modpath("hunger") and hunger and hunger.item_eat then
		return hunger.item_eat(amt)
	else
		return minetest.item_eat(amt)
	end
end

-- Registers craft item or node depending on settings
function food.register(name, data, mod)
	if (minetest.setting_getbool("food_use_2d") or (mod ~= nil and minetest.setting_getbool("food_"..mod.."_use_2d"))) then
		minetest.register_craftitem(name,{
			description = data.description,
			inventory_image = data.inventory_image,
			groups = data.groups,
			on_use = data.on_use
		})
	else
		local newdata = {
			description = data.description,
			tiles = data.tiles,
			groups = data.groups,
			on_use = data.on_use,
			walkable = false,
			sunlight_propagates = true,
			drawtype = "nodebox",
			paramtype = "light",
			node_box = data.node_box
		}
		if (minetest.setting_getbool("food_2d_inv_image")) then
			newdata.inventory_image = data.inventory_image
		end
		minetest.register_node(name,newdata)
	end
end

-- Allows for overriding in the future
function food.craft(craft)
	minetest.register_craft(craft)
end

