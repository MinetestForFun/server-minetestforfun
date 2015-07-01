money.hud = {}

function money.get_money_string(name)
	return "Account : " .. CURRENCY_PREFIX .. money.get_money(name) -- use CURRENCY_POSTFIX for the lettered currency
end

function money.hud_add(name)
	local player = minetest.get_player_by_name(name)

	money.hud[name] = player:hud_add({
		hud_elem_type = "text",
		name = "Current money",
		number = 0xFFFFFF,
		position = {x=1, y=1},
		offset = {x=-8, y=-8},
		text = money.get_money_string(name),
		scale = {x=200, y=60},
		alignment = {x=-1.2, y=-1},
	})
end

function money.hud_change(name)
	local player = minetest.get_player_by_name(name)
	player:hud_change(money.hud[name], "text", money.get_money_string(name))
end
