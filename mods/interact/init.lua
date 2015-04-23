dofile(minetest.get_modpath("interact") .. "/config.lua")
dofile(minetest.get_modpath("interact") .. "/rules.lua") --I put the rules in their own file so that they don't get lost/overlooked!

local rule1 = 0
local rule2 = 0
local rule3 = 0
local rule4 = 0
local multi = 0

local function make_formspec(player)
	local name = player:get_player_name()
	local size = { "size[10,4]" }
	table.insert(size, "label[0.5,0.5;" ..interact.s1_header.. "]")
	table.insert(size, "label[0.5,1.5;" ..interact.s1_l2.. "]")
	table.insert(size, "label[0.5,2;" ..interact.s1_l3.. "]")
	table.insert(size, "button_exit[5.5,3.4;2,0.5;no;" ..interact.s1_b1.. "]")
	table.insert(size, "button[7.5,3.4;2,0.5;yes;" ..interact.s1_b2.. "]")
	return table.concat(size)
end

local function make_formspec2(player)
	local name = player:get_player_name()
	local size = { "size[10,4]" }
	table.insert(size, "label[0.5,0.5;" ..interact.s2_l1.. "]")
	table.insert(size, "label[0.5,1;" ..interact.s2_l2.. "]")
	table.insert(size, "button_exit[2.5,3.4;3.5,0.5;interact;" ..interact.s2_b1.. "]")
	table.insert(size, "button_exit[6.4,3.4;3.6,0.5;visit;" ..interact.s2_b2.. "]")
	return table.concat(size)
end

local function make_formspec3(player)
	local size = { "size[10,8]" }
	table.insert(size, "textarea[0.5,0.5;9.5,7.5;TOS;" ..interact.s3_header.. ";" ..interact.rules.. "]")
	table.insert(size, "button[5.5,7.4;2,0.5;decline;" ..interact.s3_b2.. "]")
	table.insert(size, "button_exit[7.5,7.4;2,0.5;accept;" ..interact.s3_b1.. "]")
	return table.concat(size)
end

local function make_formspec4(player)
	local name = player:get_player_name()
	local size = { "size[10,9]" }
	if interact.s4_to_rules_button == true then
		table.insert(size, "button_exit[7.75,0.25;2.1,0.1;rules;" ..interact.s4_to_rules.. "]")
	end
	table.insert(size, "label[0.25,0;" ..interact.s4_header.."]")
	table.insert(size, "label[0.5,0.5;" ..interact.s4_question1.."]")
	table.insert(size, "checkbox[0.25,1;rule1_true;" ..interact.s4_question1_true.."]")
	table.insert(size, "checkbox[4,1;rule1_false;" ..interact.s4_question1_false.. "]")
	table.insert(size, "label[0.5,2;" ..interact.s4_question2.. "]")
	table.insert(size, "checkbox[0.25,2.5;rule2_true;" ..interact.s4_question2_true.. "]")
	table.insert(size, "checkbox[4,2.5;rule2_false;" ..interact.s4_question2_false.. "]")
	table.insert(size, "label[0.5,3.5;" ..interact.s4_question3.. "]")
	table.insert(size, "checkbox[0.25,4;rule3_true;" ..interact.s4_question3_true.. "]")
	table.insert(size, "checkbox[4,4;rule3_false;" ..interact.s4_question3_false.. "]")
	table.insert(size, "label[0.5,5;" ..interact.s4_question4.. "]")
	table.insert(size, "checkbox[0.25,5.5;rule4_true;" ..interact.s4_question4_true.. "]")
	table.insert(size, "checkbox[4,5.5;rule4_false;" ..interact.s4_question4_false.."]")
	table.insert(size, "label[0.5,6.5;" ..interact.s4_multi_question.. "]")
	table.insert(size, "checkbox[4.75,6.25;multi_choice1;" ..interact.s4_multi1.. "]")
	table.insert(size, "checkbox[0.25,7;multi_choice2;" ..interact.s4_multi2.. "]")
	table.insert(size, "checkbox[4.75,7;multi_choice3;" ..interact.s4_multi3.."]")
	table.insert(size, "button_exit[3,8.4;3.5,0.5;submit;" ..interact.s4_submit.."]")
	return table.concat(size)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "welcome" then return end
	local name = player:get_player_name()
	if fields.no then
		if interact.screen2 == false then
			minetest.after(1, function()
				minetest.show_formspec(name, "rules", make_formspec3(player))
			end)
		else
			minetest.after(1, function()
				minetest.show_formspec(name, "visit", make_formspec2(player))
			end)
		end
		return
	elseif fields.yes then
		if interact.grief_ban ~= true then
			minetest.kick_player(name, interact.msg_grief)
		else
			minetest.ban_player(name)
		end
	return
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "visit" then return end
	local name = player:get_player_name()
	if fields.interact then
		minetest.after(1, function()
			minetest.show_formspec(name, "rules", make_formspec3(player))
		end)
		return
	elseif fields.visit then
		minetest.chat_send_player(name, interact.visit_msg)
		minetest.log("action", name.. " is just visiting.")
	return
	end
end)


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "rules" then return end
	local name = player:get_player_name()
	if fields.accept then
		if interact.screen4 == false then
			if minetest.check_player_privs(name, interact.priv) then
				minetest.chat_send_player(name, interact.interact_msg1)
				minetest.chat_send_player(name, interact.interact_msg2)
				local privs = minetest.get_player_privs(name)
				privs.interact = true
				minetest.set_player_privs(name, privs)
				minetest.log("action", "Granted " ..name.. " interact.")
			end
		else
			minetest.after(1, function()
				minetest.show_formspec(name, "quiz", make_formspec4(player))
			end)
		end
		return
	elseif fields.decline then
		if interact.disagree_ban ~= true then
			minetest.kick_player(name, interact.disagree_msg)
		else
			minetest.ban_player(name)
		end
	return
	end
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "quiz" then return end
	local name = player:get_player_name()
	if fields.rules then
		minetest.after(1, function()
			minetest.show_formspec(name, "rules", make_formspec3(player))
		end)
		return
	end
	if fields.rule1_true then rule1 = true
	elseif fields.rule1_false then rule1 = false
	elseif fields.rule2_true then rule2 = true
	elseif fields.rule2_false then rule2 = false
	elseif fields.rule3_true then rule3 = true
	elseif fields.rule3_false then rule3 = false
	elseif fields.rule4_true then rule4 = true
	elseif fields.rule4_false then rule4 = false
	elseif fields.multi_choice1 then multi = 1
	elseif fields.multi_choice2 then multi = 2
	elseif fields.multi_choice3 then multi = 3 end
	if fields.submit and rule1 == interact.quiz1 and rule2 == interact.quiz2 and
	rule3 == interact.quiz3 and rule4 == interact.quiz4 and multi == interact.quiz_multi then
		rule1 = 0
		rule2 = 0
		rule3 = 0
		rule4 = 0
		multi = 0
		if minetest.check_player_privs(name, interact.priv) then
			minetest.chat_send_player(name, interact.interact_msg1)
			minetest.chat_send_player(name, interact.interact_msg2)
			local privs = minetest.get_player_privs(name)
			privs.interact = true
			minetest.set_player_privs(name, privs)
			minetest.log("action", "Granted " ..name.. " interact.")
		end
	elseif fields.submit then
		rule1 = 0
		rule2 = 0
		rule3 = 0
		rule4 = 0
		multi = 0
		if interact.on_wrong_quiz == "kick" then
			minetest.kick_player(name, interact.wrong_quiz_kick_msg)
		elseif interact.on_wrong_quiz == "ban" then
			minetest.ban_player(name)
		elseif interact.on_wrong_quiz == "reshow" then
			minetest.chat_send_player(name, interact.quiz_try_again_msg)
			minetest.after(1, function()
				minetest.show_formspec(name, "quiz", make_formspec4(player))
			end)
		elseif interact.on_wrong_quiz == "rules" then
			minetest.chat_send_player(name, interact.quiz_rules_msg)
			minetest.after(1, function()
				minetest.show_formspec(name, "rules", make_formspec3(player))
			end)
		else
			minetest.chat_send_player(name, interact.quiz_fail_msg)
		end
	end
end)

minetest.register_chatcommand("rules",{
	params = "",
	description = "Shows the server rules",
	privs = interact.priv,
	func = function (name,params)
	local player = minetest.get_player_by_name(name)
		if interact.screen1 ~= false then
			minetest.after(1, function()
				minetest.show_formspec(name, "welcome", make_formspec(player))
			end)
		elseif interact.screen2 ~= false then
			minetest.after(1, function()
				minetest.show_formspec(name, "visit", make_formspec2(player))
			end)
		else
			minetest.after(1, function()
				minetest.show_formspec(name, "rules", make_formspec3(player))
			end)
		end
	end
})

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not minetest.get_player_privs(name).interact then
		if interact.screen1 ~= false then
			minetest.show_formspec(name, "welcome", make_formspec(player))
		elseif interact.screen2 ~= false then
			minetest.show_formspec(name, "visit", make_formspec2(player))
		else
			minetest.show_formspec(name, "rules", make_formspec3(player))
		end
	else
		end
	end
)
