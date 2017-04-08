------------------
-- Hunter class --
------------------

--
-- See https://github.com/Ombridride/minetest-minetestforfun-server/issues/114
--

pclasses.api.register_class("hunter", {
	on_assigned = function(pname, inform)
		if inform then
			minetest.chat_send_player(pname, "You are now a hunter")
			minetest.sound_play("pclasses_full_hunter", {to_player=pname, gain=1})
		end
		pclasses.api.util.on_update(pname)
		minetest.log("action", "[PClasses] Player " .. pname .. " become a hunter")
	end,
	on_unassigned = function(pname)
		sprint.set_default_maxstamina(pname)
	end,
	on_update = function(pname)
		local staminavalue = 30
		local manavalue = 100
		local reinforced = pclasses.api.util.does_wear_full_armor(pname, "reinforcedleather", true)
		if reinforced then
			staminavalue = staminavalue + 20
		else
			staminavalue = staminavalue + 10
		end
		sprint.set_maxstamina(pname, staminavalue)
		mana.setmax(pname, manavalue)
	end,
	switch_params = {
		color = {r = 30, g = 170, b = 00},
		tile = "default_wood.png",
		holo_item = "throwing:bow_minotaur_horn_improved"
	},
	informations = pclasses.api.textify("Being a hunter is mostly being tactical, or just kicking in and firing arrows like madness." ..
		"Being a hunter, you're in the only class which member can use new and exclusive" ..
		"ranged weapons, like spears, arbalests and bows. Your stamina is increased to" ..
		"40, you're a sport person, able to sprint for a long time, which is found to be" ..
		"useful when you hunt down animals and mobs who can't run faster than you walk.." ..
		"and even more when you need to cowardly run away... anyway. The point is, being" ..
		"a hunter is great, since you can access new and exclusive weapons, and leather" ..
		"armors, crafted from leather. Obviously.. Those clothes are pretty strong, and" ..
		"will protect you more than wooden pieces (at least the reinforced one), with the" ..
		"satation consumption of wearing nothing. If you want to risk it and become a" ..
		"hunter, you should look for a green pedestal with a bow so fancy over it that you" ..
		"can already tell that we're gonna make you use loads of ores for it. (actually" ..
		"you need to fight a super strong mob, but it's just details...)") .. "image[2.4,5.6;6,4;pclasses_showcase_hunter.png]"
})


pclasses.api.reserve_item("hunter", "throwing:bow_minotaur_horn")
pclasses.api.reserve_item("hunter", "throwing:bow_minotaur_horn_loaded")
pclasses.api.reserve_item("hunter", "throwing:bow_minotaur_horn_improved")
pclasses.api.reserve_item("hunter", "throwing:bow_minotaur_horn_improved_loaded")
pclasses.api.reserve_item("hunter", "throwing:arrow_mithril")
pclasses.api.reserve_item("hunter", "throwing:arbalest_auto")
pclasses.api.reserve_item("hunter", "throwing:arbalest_auto_loaded")
pclasses.api.reserve_item("hunter", "spears:spear_stone")
pclasses.api.reserve_item("hunter", "spears:spear_steel")
pclasses.api.reserve_item("hunter", "spears:spear_obsidian")
pclasses.api.reserve_item("hunter", "spears:spear_diamond")
pclasses.api.reserve_item("hunter", "spears:spear_mithril")

for _, i in pairs({"helmet", "chestplate", "boots", "leggings"}) do
	pclasses.api.reserve_item("hunter", "3d_armor:" .. i .. "_hardenedleather")
	pclasses.api.reserve_item("hunter", "3d_armor:" .. i .. "_reinforcedleather")
end
