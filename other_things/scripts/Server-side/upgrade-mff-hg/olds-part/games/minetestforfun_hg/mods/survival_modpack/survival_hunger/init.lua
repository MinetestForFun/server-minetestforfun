
local START_HUNGER_TIME = survival.conf_getnum("hunger.damage_start_time", 720);
local HUNGER_TIME = survival.conf_getnum("hunger.damage_interval", 30);
local HUNGER_DAMAGE = survival.conf_getnum("hunger.damage", 4);

-- Boilerplate to support localized strings if intllib mod is installed.
local S;
if (minetest.get_modpath("intllib")) then
    dofile(minetest.get_modpath("intllib").."/intllib.lua");
    S = intllib.Getter(minetest.get_current_modname());
else
    S = function ( s ) return s; end
end

local timer = 0;

local player_state = { };

-- Known food items (more suggestions are welcome)
local known_foods = {

    -- Default game --
    "default:apple",

    -- PilzAdam's farming[_plus] --
    "farming:bread",
    "farming:pumpkin_bread",
    "farming_plus:orange_item",
    "farming_plus:tomato_item",
    "farming_plus:strawberry_item",
    "farming_plus:carrot_item",
    "farming_plus:banana",

    -- rubenwardy's food --
    "food:cheese", "food:chocolate_dark", "food:chocolate_milk",
    "food:coffee", "food:hotchoco", "food:ms_chocolate", "food:bread_slice",
    "food:bun", "food:sw_meat", "food:sw_cheese", "food:cake",
    "food:cake_chocolate", "food:cake_carrot", "food:crumble_rhubarb",
    "food:banana_split", "food:bread", "food:strawberry", "food:carrot",
    "food:banana", "food:meat_raw", "food:milk",
    -- These will be better for thirst
    --"food:apple_juice", "food:cactus_juice",

    -- GloopMaster's gloopores --
    -- "gloopores:kalite_lump", -- TODO: Should this be considered "food"?

    -- Sapier's animals_modpack (MOB Framework) --
    "animalmaterials:meat_pork", "animalmaterials:meat_beef",
    "animalmaterials:meat_chicken", "animalmaterials:meat_lamb",
    "animalmaterials:meat_venison", "animalmaterials:meat_toxic",
    "animalmaterials:meat_ostrich", "animalmaterials:meat_undead",
    "animalmaterials:fish_bluewhite", "animalmaterials:fish_clownfish",
    "animalmaterials:milk",

    -- The following list of foods was compiled by onpon4:

    -- Simple Mobs (mobs)
    "mobs:meat", "mobs:rat_cooked",

    -- My Mobs (my_mobs)
    "my_mobs:rabbit_cooked", "my_mobs:milk_bucket",
    "my_mobs:milk_bottle_glass", "my_mobs:milk_glass_cup",
    "my_mobs:milk_bottle_steel",

    -- Fishing Mod (fishing)
    "fishing:fish_raw", "fishing:fish", "fishing:sushi",

    -- Cactus Mod (cactusmod)
    "cactusmod:cactus_fruit",
};

-- Special sounds, in case the default one is too silly.
local known_foods_special_sounds = {
    ["food:coffee"] = "survival_hunger_sip";
    ["food:milk"] = "survival_hunger_sip";
    ["food:chocolate_milk"] = "survival_hunger_sip";
    ["food:hotchoco"] = "survival_hunger_sip";
    ["food:ms_chocolate"] = "survival_hunger_sip";
    ["animalmaterials:milk"] = "survival_hunger_sip";
};

local function override_on_use ( def )
    local on_use = def.on_use;
    def.on_use = function ( itemstack, user, pointed_thing )
        local state = survival.get_player_state(user:get_player_name(), "hunger");
        if (not survival.post_event("hunger.eat", user, state)) then
            survival.reset_player_state(user:get_player_name(), "hunger");
            local soundname;
            if (known_foods_special_sounds[itemstack:get_name()]) then
                soundname = known_foods_special_sounds[itemstack:get_name()];
            else
                soundname = "survival_hunger_eat";
            end
            minetest.sound_play({ name=soundname }, {
                pos = user:getpos();
                max_hear_distance = 16;
                gain = 1.0;
            });
            if (on_use) then
                return on_use(itemstack, user, pointed_thing);
            else
                itemstack:take_item(1);
                return itemstack;
            end
        end
    end
end

-- Try to override the on_use callback of as many food items as possible.
minetest.after(1, function ( )

    for _,name in ipairs(known_foods) do
        local def = minetest.registered_items[name] or minetest.registered_nodes[name];
        if (def) then
            if ((not def.groups.survival_no_override) or (def.groups.survival_no_override == 0)) then
                override_on_use(def);
            end
        end
    end

    for name, def in pairs(minetest.registered_items) do
        if (def.groups and def.groups.food and (def.groups.food > 0)) then
            if ((not def.groups.survival_no_override) or (def.groups.survival_no_override == 0)) then
                override_on_use(def);
            end
        end
    end

end);

survival.register_state("hunger", {
    label = S("Hunger");
    hud = {
        pos = {x=0.5, y=0.9};
        offset = {x=-175, y=-15};
        image = "survival_hunger_hud_apple.png";
        bar = "survival_hunger_hud_bar.png";
    };
    get_default = function ( hudidn )
        return {
            hudid = hudidn;
            count = 0;
            flag = false;
        };
    end;
    default_scaled_value = 0;
    get_scaled_value = function ( state )
        if (state.flag) then
            return 100;
        else
            return 100 - (100 * (START_HUNGER_TIME - state.count) / START_HUNGER_TIME);
        end
    end;
    on_update = function ( dtime, player, state )
        local name = player:get_player_name();
        local privs = minetest.get_player_privs(name)
		if privs.ingame then
		    state.count = state.count + dtime;
		    if (state.flag and (state.count >= HUNGER_TIME)) then
		        local hp = player:get_hp();
		        state.count = 0;
		        if ((hp > 0) and ((hp - HUNGER_DAMAGE) <= 0)) then
		            minetest.chat_send_player(name, S("You died from starvation."));
		            state.count = 0;
		            state.flag = false;
		        end
		        player:set_hp(hp - HUNGER_DAMAGE);
		        minetest.sound_play({ name="survival_hunger_stomach" }, {
		            pos = player:getpos();
		            gain = 1.0;
		            max_hear_distance = 16;
		        });
		    elseif ((not state.flag) and (state.count >= START_HUNGER_TIME)) then
		        state.count = 0;
		        state.flag = true;
		        minetest.chat_send_player(name, S("You are hungry."));
		        minetest.sound_play({ name="survival_hunger_stomach" }, {
		            pos = player:getpos();
		            gain = 1.0;
		            max_hear_distance = 16;
		        });
		    end
	   end
    end;
});

minetest.register_on_dieplayer(function ( player )
    survival.reset_player_state(player:get_player_name(), "hunger");
end);
