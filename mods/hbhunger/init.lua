if minetest.setting_getbool("enable_damage") then

hbhunger = {}

-- HUD statbar values
hbhunger.hunger = {}
hbhunger.hunger_out = {}

-- HUD item ids
local hunger_hud = {}

HUNGER_HUD_TICK = 1.0

--Some hunger settings
hbhunger.exhaustion = {} -- Exhaustion is experimental!

HUNGER_HUNGER_TICK = 800 -- time in seconds after that 1 hunger point is taken
HUNGER_EXHAUST_DIG = 3  -- exhaustion increased this value after digged node
HUNGER_EXHAUST_PLACE = 1 -- exhaustion increased this value after placed
HUNGER_EXHAUST_MOVE = 0.3 -- exhaustion increased this value if player movement detected
HUNGER_EXHAUST_LVL = 160 -- at what exhaustion player satiation gets lowerd


--load custom settings
local set = io.open(minetest.get_modpath("hbhunger").."/hbhunger.conf", "r")
if set then
	dofile(minetest.get_modpath("hbhunger").."/hbhunger.conf")
	set:close()
end

local function custom_hud(player)
	hb.init_hudbar(player, "satiation", hbhunger.get_hunger(player))
end

dofile(minetest.get_modpath("hbhunger").."/hunger.lua")

-- register satiation hudbar
hb.register_hudbar("satiation", 0xFFFFFF, "Satiation", { icon = "hbhunger_icon.png", bar = "hbhunger_bar.png" }, 20, 30, false)

-- update hud elemtens if value has changed
local function update_hud(player)
	local name = player:get_player_name()
 --hunger
	local h_out = tonumber(hbhunger.hunger_out[name])
	local h = tonumber(hbhunger.hunger[name])
	if h_out ~= h then
		hbhunger.hunger_out[name] = h
		hb.change_hudbar(player, "satiation", h)
	end
end

hbhunger.get_hunger = function(player)
	local inv = player:get_inventory()
	if not inv then return nil end
	local hgp = inv:get_stack("hunger", 1):get_count()
	if hgp == 0 then
		hgp = 21
		inv:set_stack("hunger", 1, ItemStack({name=":", count=hgp}))
	else
		hgp = hgp
	end
	return hgp-1
end

hbhunger.set_hunger = function(player)
	local inv = player:get_inventory()
	local name = player:get_player_name()
	local value = hbhunger.hunger[name]
	if not inv  or not value then return nil end
	if value > 30 then value = 30 end
	if value < 0 then value = 0 end

	inv:set_stack("hunger", 1, ItemStack({name=":", count=value+1}))

	return true
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local inv = player:get_inventory()
	inv:set_size("hunger",1)
	hbhunger.hunger[name] = hbhunger.get_hunger(player)
	hbhunger.hunger_out[name] = hbhunger.hunger[name]
	hbhunger.exhaustion[name] = 0
	custom_hud(player)
	hbhunger.set_hunger(player)
end)

minetest.register_on_respawnplayer(function(player)
	-- reset hunger (and save)
	local name = player:get_player_name()
	hbhunger.hunger[name] = 20
	hbhunger.set_hunger(player)
	hbhunger.exhaustion[name] = 0
end)

local timer = 0
local timer2 = 0
local function hunger_step()
	timer = timer + HUNGER_HUD_TICK
	timer2 = timer2 + HUNGER_HUD_TICK
		for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()

		local h = tonumber(hbhunger.hunger[name])
		local hp = player:get_hp()
		local timerquot = 1			-- By default regen 0.5 hearth every 10sec

		if pclasses.api.get_player_class(name) == "warrior" then
			timerquot = 1.42		-- Black_Mithril armor = 0.5 hearth every 7.0sec
		elseif pclasses.api.util.does_wear_full_armor(name, "mithril", false) then
			timerquot = 1.17		-- Mithril armor = 0.5 hearth every 8.5sec
		end


		if timer > 10/timerquot then
			-- heal player by 1 hp if not dead and satiation is > 15 (of 30)
			if h > 15 and hp > 0 and player:get_breath() > 0 then
				player:set_hp(hp+1)
				-- or damage player by 1 hp if satiation is < 2 (of 30)
				elseif h <= 1 then
					if hp-1 >= 0 then player:set_hp(hp-1) end
				end
			end
			-- lower satiation by 1 point after xx seconds
			if timer2 > HUNGER_HUNGER_TICK then
				if h > 0 then
					h = h-1
					hbhunger.hunger[name] = h
					hbhunger.set_hunger(player)
				end
			end

			-- update all hud elements
			update_hud(player)

			local controls = player:get_player_control()
			-- Determine if the player is walking
			if controls.up or controls.down or controls.left or controls.right then
				hbhunger.handle_node_actions(nil, nil, player)
			end
		end
	--end
	if timer > 10 then timer = 0 end
	if timer2 > HUNGER_HUNGER_TICK then timer2 = 0 end
	minetest.after(HUNGER_HUD_TICK, hunger_step)
end
minetest.after(0, hunger_step)

end
