

fishing_setting.prizes["fish"] = {
	{"fishing",  				"fish_raw",			0,			"a Fish."},
	{"fishing",  				"clownfish_raw",			0,			"a Clownfish."},
	{"fishing",  				"bluewhite_raw",			0,			"a Bluewhite."}
}

fishing_setting.prizes["shark"] = {
	{"fishing",  				"shark_raw",			0,			"a small Shark."},
	{"fishing",  				"pike_raw",				0,			"a Northern Pike."}
}


local stuff = {
--	 mod 						item						wear				message ("You caught "..)		nrmin  		chance (1/67)
	{"flowers",					"seaweed",					0,					"some Seaweed.",				1,			5},
	{"farming",					"string",					0,					"a String.",					6,			5},
	{"trunks",					"twig_1",					0,					"a Twig.",						11,			5},
	{"mobs",					"rat",						0,					"a Rat.",						16,			5},
	{"default",					"stick",					0,					"a Twig.",						21,			5},
	{"seaplants",				"kelpgreen",				0,					"a Green Kelp.",				26,			5},
	{"3d_armor",				"boots_steel",				"random",			"some very old Boots.",			31,			2},
	{"3d_armor",				"leggings_gold",			"random",			"some very old Leggings.",		33,			5},
	{"3d_armor",				"chestplate_bronze",		"random",			"a very old ChestPlate.",		38,			5},
	{"fishing",					"pole_wood",				"randomtools",		"an old Fishing Pole.",			43,			10},
	{"3d_armor",				"boots_wood",				"random",			"some very old Boots.",			53,			5},
	{"maptools",				"gold_coin",				0,					"a Gold Coin.",					58,			1},
	{"3d_armor",				"helmet_diamond",			"random",			"a very old Helmet.",			59,			1},
	{"shields",					"shield_enhanced_cactus",	"random",			"a very old Shield.",			60,			2},
	{"default",					"sword_bronze",				"random",			"a very old Sword.",			62,			2},
	{"default",					"sword_mese",				"random",			"a very old Sword.",			64,			2},
	{"default",					"sword_nyan",				"random",			"a very old Sword.",			66,			2},
--	nom mod						nom item					durabilité 			message dans le chat		 				-- fin 67
--															de l'objet
}
fishing_setting.prizes["stuff"] = fishing_setting.func.ignore_mod(stuff)


local treasure = {
	{"default",					"mese",						0,					"a mese block."},
	{"default",					"nyancat",					0,					"a Nyan Cat."},
	{"default",					"diamondblock",				0,					"a Diamond Block."},
}
fishing_setting.prizes["treasure"] = fishing_setting.func.ignore_mod(treasure)

