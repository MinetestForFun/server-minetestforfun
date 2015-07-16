local cube = minetest.inventorycube

-- the content of the guide
local guide_infos = {
	{
		description = "mushroom",
		{"text", "You can find the nether mushroom on the ground of the nether and on netherrack soil, it can be dug by hand."},
		{"y", -0.3},
		{"image", {1, 1, "riesenpilz_nether_shroom_side.png"}},
		{"y", 0.2},
		{"text", "If you drop it without holding aux1 (the fast key), you can split it into its stem and head:"},
		{"image", {1, 1, "nether_shroom_top.png", 1}},
		{"image", {1, 1, "nether_shroom_stem.png"}},
		{"y", 0.2},
		{"text", "You can get more mushrooms by using a netherrack soil:\n"..
			"1. search a dark place and, if necessary, place netherrack with air about it\n"..
			"2. right click with cooked blood onto the netherrack to make it soiled\n"..
			"3. right click onto the netherrack soil with a nether mushroom head to add some spores\n"..
			"4. dig the mushroom which grew after some time to make place for another one"},
		{"image", {1, 1, "riesenpilz_nether_shroom_side.png", 6, 0.12}},
		{"y", 1},
		{"image", {1, 1, "nether_netherrack.png^nether_netherrack_soil.png", 1.8}},
		{"image", {1, 1, "nether_hotbed.png", 1.3, -0.4}},
		{"image", {1, 1, "nether_netherrack.png^nether_netherrack_soil.png", 3.6}},
		{"image", {1, 1, "nether_shroom_top.png", 3.1, -0.5}},
		{"image", {1, 1, "nether_netherrack.png^nether_netherrack_soil.png", 6}},
		{"image", {1, 1, "nether_netherrack.png"}},
	},
	{
		description = "tools",
		{"text", "You can craft 5 types of tools in the nether, which (except the mushroom pick) require sticks to be crafted:"},
		{"y", 0.4},
		{"image", {1, 1, "nether_pick_mushroom.png"}},
		{"text", "strength: 1\n"..
			"The mushroom pick needs mushroom stems and heads to be crafted."},
		{"y", 0.2},
		{"image", {1, 1, "nether_pick_wood.png"}},
		{"text", "strength: 2\n"..
			"The nether wood pick can be crafted with cooked nether blood wood."},
		{"y", 0.2},
		{"image", {1, 1, "nether_axe_netherrack.png", 1}},
		{"image", {1, 1, "nether_shovel_netherrack.png", 2}},
		{"image", {1, 1, "nether_sword_netherrack.png", 3}},
		{"image", {1, 1, "nether_pick_netherrack.png"}},
		{"text", "strength: 3\n"..
			"The red netherrack tools can be crafted with usual netherrack."},
		{"y", 0.2},
		{"image", {1, 1, "nether_axe_netherrack_blue.png", 1}},
		{"image", {1, 1, "nether_shovel_netherrack_blue.png", 2}},
		{"image", {1, 1, "nether_sword_netherrack_blue.png", 3}},
		{"image", {1, 1, "nether_pick_netherrack_blue.png"}},
		{"text", "strength: 3\n"..
			"The blue netherrack tools can be crafted with blue netherrack."},
		{"y", 0.2},
		{"image", {1, 1, "nether_axe_white.png", 1}},
		{"image", {1, 1, "nether_shovel_white.png", 2}},
		{"image", {1, 1, "nether_sword_white.png", 3}},
		{"image", {1, 1, "nether_pick_white.png"}},
		{"text", "strength: 3\n"..
			"The siwtonic tools can be crafted with the siwtonic ore."},
	},
	{
		description = "blood structures",
		{"text", "You can find blood structures on the ground and dig their nodes even with the bare hand."},
		{"y", 0.2},
		{"text", "One contains 4 kinds of blocks:"},
		{"image", {1, 1, cube("nether_blood.png"), 1}},
		{"image", {1, 1,
			cube("nether_blood_top.png", "nether_blood.png^nether_blood_side.png", "nether_blood.png^nether_blood_side.png"),
			2}},
		{"image", {1, 1, "nether_fruit.png", 3}},
		{"image", {1, 1, cube("nether_blood_stem_top.png", "nether_blood_stem.png", "nether_blood_stem.png")}},
		{"text", "the blood stem, blood, blood head and nether fruit"},
		{"y", 0.2},
		{"text", "You can craft the stem to 4 blood wood:"},
		{"image", {1, 1, cube("nether_wood.png")}},
		{"y", 0.2},
		{"text", "The 4 blood nodes can be cooked and, except blood wood, their blood can be extracted."},
	},
	{
		description = "fruit",
		{"text", "You can find the nether fruit at blood structures and dig it even with the bare hand."},
		{"y", 0.05},
		{"image", {1, 1, "nether_fruit.png"}},
		{"text", "You can eat it to get a bit blood because of its acid effect:"},
		{"image", {1, 1, "nether_blood_extracted.png"}},
		{"y", 0.2},
		{"text", "If you eat it at the right place inside a portal, you teleport instead of getting blood."},
		{"y", 0.2},
		{"text", "If you drop it without holding aux1 (the fast key), you can split it into its fruit and leaf:"},
		{"image", {1, 1, "nether_fruit_leaf.png", 1}},
		{"image", {1, 1, "nether_fruit_no_leaf.png"}},
		{"y", 0.2},
		{"text", "9 fruit leaves can be crafted to a fruit leaves block and the fruit without leaf can be used for crafting a nether pearl."},
		{"y", 0.2},
		{"image", {1, 1, cube("nether_fruit_leaves.png")}},
		{"text", "fruit leaves block"},
	},
	{
		description = "cooking",
		{"text", "To get a furnace you need to dig at least 8 netherrack bricks.\n"..
			"They can be found at pyramid like constructions and require at least a strength 1 nether pick to be dug.\n"..
			"For crafting the furnace, use the netherrack bricks like cobble:"},
		{"y", 0.2},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png"), 0.5}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png"), 1}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png")}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png"), 1}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png")}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png"), 0.5}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png"), 1}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png")}},
		{"y", 0.2},
		{"text", "To begin cooking stuff, you can use a mushroom or fruit.\n"..
			"After that it's recommended to use cooked blood nodes."},
		{"y", 0.2},
		{"text", "Some nether items can be cooked:"},
		{"y", 0.1},
		{"image", {1, 1, cube("nether_blood_stem_top_cooked.png", "nether_blood_stem_cooked.png", "nether_blood_stem_cooked.png"), 0.35}},
		{"image", {1, 1, cube("nether_blood_cooked.png"), 1.6}},
		{"image", {1, 1,
			cube("nether_blood_top_cooked.png", "nether_blood_cooked.png^nether_blood_side_cooked.png", "nether_blood_cooked.png^nether_blood_side_cooked.png"),
			2.9}},
		{"image", {1, 1, cube("nether_wood_cooked.png"), 4.3}},
		{"y", 1},
		{"text", "cooked blood stem, cooked blood, cooked blood head, cooked blood wood,"},
		{"y", 0.2},
		{"image", {1, 1, "nether_hotbed.png", 0.3}},
		{"image", {1, 1, "nether_pearl.png", 2}},
		{"y", 1},
		{"text", "cooked extracted blood and nether pearl"},
	},
	{
		description = "extractor",
		{"text", "Here you can find out information about the nether extractor."},
		{"y", 0.4},
		{"text", "Here you can see its craft recipe:"},
		{"y", 0.2},
		{"image", {0.5, 0.5, cube("nether_blood_top_cooked.png", "nether_blood_cooked.png^nether_blood_side_cooked.png", "nether_blood_cooked.png^nether_blood_side_cooked.png"), 0.5}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png"), 1}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png")}},
		{"image", {0.5, 0.5, cube("nether_blood_extractor.png"), 2.5}},
		{"image", {0.5, 0.5, "nether_shroom_stem.png", 0.5}},
		{"image", {0.5, 0.5, cube("nether_blood_cooked.png"), 1}},
		{"image", {0.5, 0.5, cube("nether_blood_cooked.png")}},
		{"image", {0.5, 0.5, cube("nether_blood_stem_top_cooked.png", "nether_blood_stem_cooked.png", "nether_blood_stem_cooked.png"), 0.5}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png"), 1}},
		{"image", {0.5, 0.5, cube("nether_netherrack_brick.png")}},
		{"y", 0.2},
		{"text", "You can extract blood from the blood nodes you get from the blood structure.\n"..
			"You can also get blood with a nether fruit."},
		{"y", 0.2},
		{"text", "So you can use it:\n"..
			"1. place it somewhere\n"..
			"2. place blood blocks next to it (4 or less)\n"..
			"3. right click with extracted blood onto it to power it\n"..
			"4. take the new extracted blood and dig the extracted nodes"},
		{"y", 0.2},
		{"text", "Example (view from the top):"},
		{"y", 0.88},
		{"image", {1, 1, "nether_blood_stem_top.png", 0.82, -0.88}},
		{"image", {1, 1, "nether_blood.png", 1.63}},
		{"image", {1, 1, "nether_blood_extractor.png", 0.82}},
		{"image", {1, 1, "nether_blood_stem_top_empty.png", 3.82, -0.88}},
		{"image", {1, 1, "nether_blood_empty.png", 4.63}},
		{"image", {1, 1, "nether_blood_empty.png", 3.001}},
		{"image", {1, 1, "nether_blood_extractor.png", 3.82}},
		{"image", {1, 1, "nether_blood.png"}},
		{"image", {1, 1, "nether_blood.png", 0.82, -0.12}},
		{"image", {1, 1, "nether_blood_empty.png", 3.82, -0.12}},
		{"y", 1.2},
		{"text", "The empty blood stem can be crafted to empty nether wood, which can be crafted to nether sticks."},
	},
	{
		description = "ores",
		{"text", "You can find 5 types of ores:"},
		{"y", 0.4},
		{"image", {1, 1, cube("nether_netherrack_black.png"), 4}},
		{"image", {1, 1, cube("nether_netherrack.png")}},
		{"text", "The red netherrack is generated like stone and the black netherrack is generated like gravel.\n"..
			"Both require at least a strength 2 nether pick to be dug."},
		{"y", 0.2},
		{"image", {1, 1, cube("nether_white.png"), 4}},
		{"image", {1, 1, cube("nether_netherrack_blue.png")}},
		{"text", "The blue netherrack is generated like diamond ore and the siwtonic ore is generated like mese blocks.\n"..
			"Both require at least a strength 3 nether pick to be dug."},
		{"y", 0.2},
		{"image", {1, 1, cube("nether_netherrack_tiled.png"), 4}},
		{"image", {1, 1, cube("glow_stone.png")}},
		{"text", "The glow stone can be used for lighting and the tiled netherrack is generated like coal ore.\n"..
			"Glow stone requires at least a strength 1 pick to be dug.\n"..
			"Tiled netherrack requires at least a strength 2 nether pick to be dug."},
	},
	{
		description = "vines",
		{"text", "The nether vines can be fed with blood.\n"..
			"They can be dug by hand and drop nether children."},
		{"image", {1, 1, "nether_vine.png"}},
		{"y", 0.2},
		{"text", "To let a nether child grow to a blood structure, place it at a dark place onto a blood structure head node."},
		{"image", {1, 1, "nether_sapling.png"}},
		{"y", -0.11},
		{"image", {1, 1, "nether_blood.png^nether_blood_side.png"}},
	},
	{
		description = "pearl",
		{"text", "The nether pearl can be thrown for teleporting.\n"..
			"So cou can get one:"},
		{"y", 0.4},
		{"text", "At first you need to craft 2 mushroom heads and 1 nether fruit without leaf together:"},
		{"image", {1, 1, "nether_shroom_top.png"}},
		{"image", {1, 1, "nether_fim.png", 3}},
		{"image", {1, 1, "nether_fruit_no_leaf.png"}},
		{"image", {1, 1, "nether_shroom_top.png"}},
		{"y", 0.2},
		{"text", "Then you need to put the result into the furnance to cook it to a nether pearl:"},
		{"image", {1, 1, "nether_pearl.png"}},
	},
	{
		description = "bricks",
		{"text", "You can craft bricks of red, black and blue netherrack."},
		{"y", 0.4},
		{"image", {1, 1, cube("nether_netherrack_brick_black.png"), 1}},
		{"image", {1, 1, cube("nether_netherrack_brick_blue.png"), 2}},
		{"image", {1, 1, cube("nether_netherrack_brick.png")}},
		{"y", 0.2},
		{"text", "These bricks require at least a strength 1 nether pick to be dug."},
		{"y", 0.2},
		{"text", "Because the crafing recipe of bricks is well known, it's not shown here."},
	},
	{
		description = "portal",
		{"text", "Here you can find out how to built the nether portal."},
		{"y", 0.4},
		{"text", "A nether portal requires following nodes:"},
		{"y", 0.05},
		{"text", "21 empty nether wooden planks\n"..
			"12 blue netherrack bricks\n"..
			"12 black netherrack\n"..
			"8 red netherrack\n"..
			"8 cooked nether wood\n"..
			"4 nether fruits\n"..
			"2 siwtonic blocks"},
		{"y", 0.2},
		{"text", "It should look approximately like this one:"},
		{"image", {5.625, 6, "nether_teleporter.png", 0, -1.5}},
		{"y", 5.5},
		{"text", "You can activate it by standing in the middle on a siwtonic block and eating a nether fruit.\n"..
			"Don't forget to take enough stuff with you to be able to build a portal back."},
	},
	{
		description = "nether forest",
		{"text", "The nether forest is generated in caves above the usual nether."},
		{"y", 0.2},
		{"text", "There you can find some plants:"},
		{"y", 0.2},
		{"image", {1, 1, "nether_grass_middle.png", 1}},
		{"image", {1, 1, "nether_grass_big.png", 2}},
		{"image", {1, 1, "nether_grass_small.png"}},
		{"y", 0.2},
		{"text", "The nether forest grass can be used to get paper.\n"..
			"Just dig it, put the grass into the furnace and craft paper out of the dried grass.\n"..
			"The recipe is similar to the one of crafting paper with papyrus."},
		{"y", 0.2},
		{"image", {1, 1, cube("nether_tree_top.png", "nether_tree.png", "nether_tree.png")}},
		{"text", "Nether trunks can be found at nether trees, you can craft nether wood out of them."},
		{"y", 0.2},
		{"image", {1, 1, "nether_glowflower.png"}},
		{"text", "Currently this flower can be used for lighting and decoration."},
	},
}

-- the size of guide pages
local guide_size = {x=15, y=10, cx=0.1, cy=-0.2}

-- informations about settings and ...
local formspec_offset = {x=0.25, y=0.55}
local font_size
if minetest.is_singleplayer() then
	font_size = tonumber(minetest.setting_get("font_size")) or 13
else
	font_size = 13
end
guide_size.fx = math.floor((guide_size.x-2*(guide_size.cx+formspec_offset.x))*font_size)
guide_size.fy = font_size/65

-- the default guide formspecs
local guide_forms = {
	contents = "size[3,"..(#guide_infos+1)*0.5 ..";]label["..guide_size.cx+0.8 ..","..guide_size.cy..";Contents:]",
}

-- change the infos to formspecs
for n,data in ipairs(guide_infos) do
	local form = ""
	local y = 0
	local x = guide_size.cx
	for _,i in ipairs(data) do
		local typ, content = unpack(i)
		if typ == "y" then
			y = y+content
		elseif typ == "x" then
			x = math.max(x, content)
		elseif typ == "text" then
			local tab = minetest.splittext(content, guide_size.fx)
			local l = guide_size.cx
			for _,str in ipairs(tab) do
				form = form.."label["..guide_size.cx..","..guide_size.cy+y..";"..str.."]"
				y = y+guide_size.fy
				l = math.max(l, #str)
			end
			x = math.max(x, l/font_size)
		elseif typ == "image" then
			local w, h, texture_name, px, py = unpack(content)
			if not px then
				form = form.."image["..guide_size.cx..","..guide_size.cy+y+h*0.3 ..";"..w..","..h..";"..texture_name.."]"
				y = y+h
			else
				px = guide_size.cx+px
				py = py or 0
				form = form.."image["..px..","..
					guide_size.cy+y+h*0.3+py ..";"..w..","..h..";"..texture_name.."]"
				x = math.max(x, px+w)
			end
		end
	end
	form = "size["..x..","..y+1 ..";]"..form.."button["..x/2-0.5 ..","..y ..";1,2;quit;back]"
	guide_forms[n] = {data.description, form}
end

local desc_tab = {}
for n,i in ipairs(guide_forms) do
	desc_tab[i[1]] = n
end

-- creates contents formspec
local y = 0
for y,i in ipairs(guide_forms) do
	local desc, form = unpack(i)
	local s = #desc*1.3/font_size+0.3
	guide_forms.contents = guide_forms.contents.."button["..guide_size.cx+math.random()..","..guide_size.cy+y/2 ..";"..s..",1;name;"..desc.."]"
end

-- shows the contents of the formspec
local function show_guide(pname)
	minetest.show_formspec(pname, "nether_guide_contents", guide_forms["contents"])
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "nether_guide_contents" then
		local fname = fields.name
		local pname = player:get_player_name()
		if fname
		and pname then
			minetest.show_formspec(pname, "nether_guide", guide_forms[desc_tab[fname]][2])
		end
	elseif formname == "nether_guide" then
		local fname = fields.quit
		local pname = player:get_player_name()
		if fname
		and pname then
			minetest.show_formspec(pname, "nether_guide_contents", guide_forms["contents"])
		end
	end
end)

minetest.register_chatcommand("nether_help", {
	params = "",
	description = "Shows a nether guide",
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			minetest.chat_send_player(name, "Something went wrong.")
			return false
		end
--[[		if player:getpos().y > nether.start then
			minetest.chat_send_player(name, "Usually you don't neet this guide here. You can view it in the nether.")
			return false
		end --]]
		minetest.chat_send_player(name, "Showing guide...")
		show_guide(name)
		return true
	end
})
