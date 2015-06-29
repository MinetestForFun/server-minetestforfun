-- Keep these for backwards compatibility
function hbhunger.save_hunger(player)
	hbhunger.set_hunger(player)
end
function hbhunger.load_hunger(player)
	hbhunger.get_hunger(player)
end

-- Poison player
local function poisenp(tick, time, time_left, player)
	time_left = time_left + tick
	if time_left < time then
		minetest.after(tick, poisenp, tick, time, time_left, player)
	else
		--reset hud image
	end
	if player:get_hp()-1 > 0 then
		player:set_hp(player:get_hp()-1)
	end

end

function hbhunger.item_eat(hunger_change, replace_with_item, poisen, heal)
	return function(itemstack, user, pointed_thing)
		if itemstack:take_item() ~= nil and user ~= nil then
			local name = user:get_player_name()
			local h = tonumber(hbhunger.hunger[name])
			local hp = user:get_hp()
			minetest.sound_play({name = "hbhunger_eat_generic", gain = 1}, {pos=user:getpos(), max_hear_distance = 16})

			-- Saturation
			if h < 30 and hunger_change then
				h = h + hunger_change
				if h > 30 then h = 30 end
				hbhunger.hunger[name] = h
				hbhunger.set_hunger(user)
			end
			-- Healing
			if hp < 20 and heal then
				hp = hp + heal
				if hp > 20 then hp = 20 end
				user:set_hp(hp)
			end
			-- Poison
			if poisen then
				--set hud-img
				poisenp(1.0, poisen, 0, user)
			end

			--sound:eat
			itemstack:add_item(replace_with_item)
		end
		return itemstack
	end
end

local function overwrite(name, hunger_change, replace_with_item, poisen, heal)
	local tab = minetest.registered_items[name]
	if tab == nil then return end
	tab.on_use = hbhunger.item_eat(hunger_change, replace_with_item, poisen, heal)
	minetest.registered_items[name] = tab
end

if minetest.get_modpath("default") ~= nil then
	overwrite("default:apple", 2)
end
if minetest.get_modpath("farming") ~= nil then
	overwrite("farming:bread", 4)
end

if minetest.get_modpath("mobs") ~= nil then
	if mobs.mod ~= nil and mobs.mod == "redo" then
		overwrite("mobs:cheese", 4)
		overwrite("mobs:meat", 5)
		overwrite("mobs:meat_raw", 3)
		overwrite("mobs:rat_cooked", 5)
		overwrite("mobs:honey", 6)
		overwrite("mobs:pork_raw", 4, "", 3)
		overwrite("mobs:pork_cooked", 7)
		overwrite("mobs:chicken_cooked", 4)
		overwrite("mobs:chicken_raw", 2, "", 3)
		overwrite("mobs:egg", 1)
		overwrite("mobs:chicken_egg_fried", 2)
		if minetest.get_modpath("bucket") then
			overwrite("mobs:bucket_milk", 3, "bucket:bucket_empty")
		end
	else
		overwrite("mobs:meat", 6)
		overwrite("mobs:meat_raw", 3)
		overwrite("mobs:rat_cooked", 5)
	end
end

if minetest.get_modpath("moretrees") ~= nil then
	overwrite("moretrees:coconut_milk", 1)
	overwrite("moretrees:raw_coconut", 2)
	overwrite("moretrees:acorn_muffin", 3)
	overwrite("moretrees:spruce_nuts", 1)
	overwrite("moretrees:pine_nuts", 1)
	overwrite("moretrees:fir_nuts", 1)
end

if minetest.get_modpath("dwarves") ~= nil then
	overwrite("dwarves:beer", 2)
	overwrite("dwarves:apple_cider", 1)
	overwrite("dwarves:midus", 2)
	overwrite("dwarves:tequila", 2)
	overwrite("dwarves:tequila_with_lime", 2)
	overwrite("dwarves:sake", 2)
end

if minetest.get_modpath("animalmaterials") ~= nil then
	overwrite("animalmaterials:milk", 2)
	overwrite("animalmaterials:meat_raw", 3)
	overwrite("animalmaterials:meat_pork", 3)
	overwrite("animalmaterials:meat_beef", 3)
	overwrite("animalmaterials:meat_chicken", 3)
	overwrite("animalmaterials:meat_lamb", 3)
	overwrite("animalmaterials:meat_venison", 3)
	overwrite("animalmaterials:meat_undead", 3, "", 3)
	overwrite("animalmaterials:meat_toxic", 3, "", 5)
	overwrite("animalmaterials:meat_ostrich", 3)
	overwrite("animalmaterials:fish_bluewhite", 2)
	overwrite("animalmaterials:fish_clownfish", 2)
end

if minetest.get_modpath("fishing") ~= nil then
	overwrite("fishing:fish_raw", 2)
	overwrite("fishing:fish_cooked", 4)
	overwrite("fishing:sushi", 6)
	overwrite("fishing:shark", 2)
	overwrite("fishing:shark_cooked", 6)
	overwrite("fishing:pike", 2)
	overwrite("fishing:pike_cooked", 6)
end

if minetest.get_modpath("glooptest") ~= nil then
	overwrite("glooptest:kalite_lump", 1)
end

if minetest.get_modpath("bushes") ~= nil then
	overwrite("bushes:sugar", 1)
	overwrite("bushes:strawberry", 2)
	overwrite("bushes:berry_pie_raw", 3)
	overwrite("bushes:berry_pie_cooked", 4)
	overwrite("bushes:basket_pies", 15)
end

if minetest.get_modpath("bushes_classic") then
	-- bushes_classic mod, as found in the plantlife modpack
	local berries = {
	    "strawberry",
		"blackberry",
		"blueberry",
		"raspberry",
		"gooseberry",
		"mixed_berry"}
	for _, berry in ipairs(berries) do
		if berry ~= "mixed_berry" then
			overwrite("bushes:"..berry, 1)
		end
		overwrite("bushes:"..berry.."_pie_raw", 2)
		overwrite("bushes:"..berry.."_pie_cooked", 5)
		overwrite("bushes:basket_"..berry, 15)
	end
end

if minetest.get_modpath("mushroom") ~= nil then
	overwrite("mushroom:brown", 1)
	overwrite("mushroom:red", 1, "", 3)
	-- mushroom potions: red = strong poison, brown = light restorative
	if minetest.get_modpath("vessels") then
		overwrite("mushroom:brown_essence", 1, "vessels:glass_bottle", nil, 4)
		overwrite("mushroom:poison", 1, "vessels:glass_bottle", 10)
	end
end

if minetest.get_modpath("docfarming") ~= nil then
	overwrite("docfarming:carrot", 3)
	overwrite("docfarming:cucumber", 2)
	overwrite("docfarming:corn", 3)
	overwrite("docfarming:potato", 4)
	overwrite("docfarming:bakedpotato", 5)
	overwrite("docfarming:raspberry", 3)
end

if minetest.get_modpath("farming_plus") ~= nil then
	overwrite("farming_plus:carrot_item", 3)
	overwrite("farming_plus:banana", 2)
	overwrite("farming_plus:orange_item", 2)
	overwrite("farming:pumpkin_bread", 4)
	overwrite("farming_plus:strawberry_item", 2)
	overwrite("farming_plus:tomato_item", 2)
	overwrite("farming_plus:potato_item", 4)
	overwrite("farming_plus:rhubarb_item", 2)
end

if minetest.get_modpath("mtfoods") ~= nil then
	overwrite("mtfoods:dandelion_milk", 1)
	overwrite("mtfoods:sugar", 1)
	overwrite("mtfoods:short_bread", 4)
	overwrite("mtfoods:cream", 1)
	overwrite("mtfoods:chocolate", 2)
	overwrite("mtfoods:cupcake", 2)
	overwrite("mtfoods:strawberry_shortcake", 2)
	overwrite("mtfoods:cake", 3)
	overwrite("mtfoods:chocolate_cake", 3)
	overwrite("mtfoods:carrot_cake", 3)
	overwrite("mtfoods:pie_crust", 3)
	overwrite("mtfoods:apple_pie", 3)
	overwrite("mtfoods:rhubarb_pie", 2)
	overwrite("mtfoods:banana_pie", 3)
	overwrite("mtfoods:pumpkin_pie", 3)
	overwrite("mtfoods:cookies", 2)
	overwrite("mtfoods:mlt_burger", 5)
	overwrite("mtfoods:potato_slices", 2)
	overwrite("mtfoods:potato_chips", 3)
	--mtfoods:medicine
	overwrite("mtfoods:casserole", 3)
	overwrite("mtfoods:glass_flute", 2)
	overwrite("mtfoods:orange_juice", 2)
	overwrite("mtfoods:apple_juice", 2)
	overwrite("mtfoods:apple_cider", 2)
	overwrite("mtfoods:cider_rack", 2)
end

if minetest.get_modpath("fruit") ~= nil then
	overwrite("fruit:apple", 2)
	overwrite("fruit:pear", 2)
	overwrite("fruit:bananna", 3)
	overwrite("fruit:orange", 2)
end

if minetest.get_modpath("mush45") ~= nil then
	overwrite("mush45:meal", 4)
end

if minetest.get_modpath("seaplants") ~= nil then
	overwrite("seaplants:kelpgreen", 1)
	overwrite("seaplants:kelpbrown", 1)
	overwrite("seaplants:seagrassgreen", 1)
	overwrite("seaplants:seagrassred", 1)
	overwrite("seaplants:seasaladmix", 6)
	overwrite("seaplants:kelpgreensalad", 1)
	overwrite("seaplants:kelpbrownsalad", 1)
	overwrite("seaplants:seagrassgreensalad", 1)
	overwrite("seaplants:seagrassgreensalad", 1)
end

if minetest.get_modpath("mobfcooking") ~= nil then
	overwrite("mobfcooking:cooked_pork", 6)
	overwrite("mobfcooking:cooked_ostrich", 6)
	overwrite("mobfcooking:cooked_beef", 6)
	overwrite("mobfcooking:cooked_chicken", 6)
	overwrite("mobfcooking:cooked_lamb", 6)
	overwrite("mobfcooking:cooked_venison", 6)
	overwrite("mobfcooking:cooked_fish", 6)
end

if minetest.get_modpath("creatures") ~= nil then
	overwrite("creatures:meat", 6)
	overwrite("creatures:flesh", 3)
	overwrite("creatures:rotten_flesh", 3, "", 3)
end

if minetest.get_modpath("ethereal") then
   overwrite("ethereal:strawberry", 1)
   overwrite("ethereal:banana", 4)
   overwrite("ethereal:pine_nuts", 1)
   overwrite("ethereal:bamboo_sprout", 0, "", 3)
   overwrite("ethereal:fern_tubers", 1)
   overwrite("ethereal:banana_bread", 7)
   overwrite("ethereal:mushroom_plant", 2)
   overwrite("ethereal:coconut_slice", 2)
   overwrite("ethereal:golden_apple", 4, "", nil, 10)
   overwrite("ethereal:wild_onion_plant", 2)
   overwrite("ethereal:mushroom_soup", 4, "ethereal:bowl")
   overwrite("ethereal:mushroom_soup_cooked", 6, "ethereal:bowl")
   overwrite("ethereal:hearty_stew", 6, "ethereal:bowl", 3)
   overwrite("ethereal:hearty_stew_cooked", 10, "ethereal:bowl")
   if minetest.get_modpath("bucket") then
  	overwrite("ethereal:bucket_cactus", 2, "bucket:bucket_empty")
   end
   overwrite("ethereal:fish_raw", 2)
   overwrite("ethereal:fish_cooked", 4)
   overwrite("ethereal:seaweed", 1)
   overwrite("ethereal:yellowleaves", 1, "", nil, 1)
   overwrite("ethereal:sashimi", 4)
end

if minetest.get_modpath("farming") and farming.mod == "redo" then
   overwrite("farming:bread", 5)
   overwrite("farming:potato", 1)
   overwrite("farming:baked_potato", 5)
   overwrite("farming:cucumber", 3)
   overwrite("farming:tomato", 3)
   overwrite("farming:carrot", 3)
   overwrite("farming:carrot_gold", 6, "", nil, 10)
   overwrite("farming:corn", 3)
   overwrite("farming:corn_cob", 5)
   overwrite("farming:melon_slice", 2)
   overwrite("farming:pumpkin_slice", 1)
   overwrite("farming:pumpkin_bread", 7)
   overwrite("farming:coffee_cup", 2, "farming:drinking_cup")
   overwrite("farming:coffee_cup_hot", 3, "farming:drinking_cup", nil, 2)
   overwrite("farming:cookie", 2)
   overwrite("farming:chocolate_dark", 3)
   overwrite("farming:donut", 4)
   overwrite("farming:donut_chocolate", 5)
   overwrite("farming:donut_apple", 5)
   overwrite("farming:raspberries", 1)
   overwrite("farming:blueberries", 1)
   overwrite("farming:muffin_blueberry", 4)
   overwrite("farming:beans", 1)
   if minetest.get_modpath("vessels") then
	overwrite("farming:smoothie_raspberry", 2, "vessels:drinking_glass")
   end
   overwrite("farming:rhubarb", 1)
   overwrite("farming:rhubarb_pie", 5)
end

if minetest.get_modpath("maptools") then
   overwrite("maptools:superapple", 10, "", nil, 20) -- valeur perso pour "Super Apple" => 10 coeurs, 5 pains
end

if minetest.get_modpath("kpgmobs") ~= nil then
	overwrite("kpgmobs:uley", 3)
	overwrite("kpgmobs:meat", 6)
	overwrite("kpgmobs:rat_cooked", 5)
	overwrite("kpgmobs:med_cooked", 4)
  	if minetest.get_modpath("bucket") then
	   overwrite("kpgmobs:bucket_milk", 4, "bucket:bucket_empty")
	end
end

if minetest.get_modpath("jkfarming") ~= nil then
	overwrite("jkfarming:carrot", 3)
	overwrite("jkfarming:corn", 3)
	overwrite("jkfarming:melon_part", 2)
	overwrite("jkfarming:cake", 3)
end

if minetest.get_modpath("jkanimals") ~= nil then
	overwrite("jkanimals:meat", 6)
end

if minetest.get_modpath("jkwine") ~= nil then
	overwrite("jkwine:grapes", 2)
	overwrite("jkwine:winebottle", 1)
end

if minetest.get_modpath("cooking") ~= nil then
	overwrite("cooking:meat_beef_cooked", 4)
	overwrite("cooking:fish_bluewhite_cooked", 3)
	overwrite("cooking:fish_clownfish_cooked", 1)
	overwrite("cooking:meat_chicken_cooked", 2)
	overwrite("cooking:meat_cooked", 2)
	overwrite("cooking:meat_pork_cooked", 3)
	overwrite("cooking:meat_toxic_cooked", -3)
	overwrite("cooking:meat_venison_cooked", 3)
	overwrite("cooking:meat_undead_cooked", 1)
end

-- ferns mod of plantlife_modpack
if minetest.get_modpath("ferns") ~= nil then
	overwrite("ferns:fiddlehead", 1, "", 1)
	overwrite("ferns:fiddlehead_roasted", 3)
	overwrite("ferns:ferntuber_roasted", 3)
	overwrite("ferns:horsetail_01", 1)
end

-- Food mod by Rubenwardy ( https://github.com/rubenwardy/food )
if minetest.get_modpath("food") ~= nil then
	overwrite("food:apple_juice", 1)
	overwrite("food:rainbow_juice", 6)
	overwrite("food:cheese", 4)
	overwrite("food:cactus_juice", 3)
	overwrite("food:cake", 5)
	overwrite("food:cake_carrot", 6)
	overwrite("food:cake_choco", 7)
	overwrite("food:milk", 3)
	overwrite("food:milk_chocolate", 4)
	overwrite("food:pasta_bake", 7)
	overwrite("food:soup_chicken", 4)
	overwrite("food:soup_tomato", 4)
end

-- player-action based hunger changes
function hbhunger.handle_node_actions(pos, oldnode, player, ext)
	if not player or not player:is_player() then
		return
	end
	local name = player:get_player_name()
	local exhaus = hbhunger.exhaustion[name]
	if exhaus == nil then return end -- fix for nodebreaker, if owner has not logged in since the launch of the server, hunger stat is nil,then crash
	local new = HUNGER_EXHAUST_PLACE
	-- placenode event
	if not ext then
		new = HUNGER_EXHAUST_DIG
	end
	-- assume its send by main timer when movement detected
	if not pos and not oldnode then
		new = HUNGER_EXHAUST_MOVE
	end
	exhaus = exhaus + new
	if exhaus > HUNGER_EXHAUST_LVL then
		exhaus = 0
		local h = tonumber(hbhunger.hunger[name])
		h = h - 1
		if h < 0 then h = 0 end
		hbhunger.hunger[name] = h
		hbhunger.set_hunger(player)
	end
	hbhunger.exhaustion[name] = exhaus
end

minetest.register_on_placenode(hbhunger.handle_node_actions)
minetest.register_on_dignode(hbhunger.handle_node_actions)
