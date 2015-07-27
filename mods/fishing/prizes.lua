

fishing_setting.prizes["fish"] = {
	{"fishing",  				"fish_raw",			0,			"a Fish."},
	{"fishing",  				"clownfish_raw",			0,			"a Clownfish."},
	{"fishing",  				"bluewhite_raw",			0,			"a Bluewhite."}
}

fishing_setting.prizes["shark"] = {
	{"fishing",  				"shark_raw",			0,			"a small Shark."},
	{"fishing",  				"pike_raw",				0,			"a Northern Pike."}
}


-- Here's what you can prizes
local plants = {
--	  MoD 						 iTeM				WeaR		 MeSSaGe ("You caught "..)
	{"default",					"stick",			0,			"a Twig."},
	{"mobs",					"rat",				0,			"a Rat."},
	{"flowers",					"seaweed",			0,			"some Seaweed."},
	{"seaplants",				"kelpgreen",		0,			"a Green Kelp."},
	{"farming",					"string",			0,			"a String."},
	{"trunks",					"twig_1",			0,			"a Twig."}
}
fishing_setting.prizes["plants"] = fishing_setting.func.ignore_mod(plants)

local stuff = {
	{"fishing",					"pole_wood",				"randomtools",		"an old Fishing Pole."},
	{"3d_armor",				"boots_wood",				"random",			"some very old Boots."},
	{"maptools",				"gold_coin",				0,					"a Gold Coin."},
	{"3d_armor",				"helmet_diamond",			"random",			"a very old Helmet."},
	{"shields",					"shield_enhanced_cactus",	"random",			"a very old Shield."},
	{"default",					"sword_bronze",				"random",			"a very old Sword."},
	{"default",					"sword_mese",				"random",			"a very old Sword."},
	{"default",					"sword_nyan",				"random",			"a very old Sword."}	
}
fishing_setting.prizes["stuff"] = fishing_setting.func.ignore_mod(stuff)


local treasure = {
	{"default",					"mese",						0,					"a mese block."},
	{"default",					"nyancat",					0,					"a Nyan Cat."},
	{"default",					"diamondblock",				0,					"a Diamond Block."},
}
fishing_setting.prizes["treasure"] = fishing_setting.func.ignore_mod(treasure)

