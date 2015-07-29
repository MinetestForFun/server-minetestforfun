mff.quests = {}
mff.QPREFIX = "mff_quests:"
mff.QNOPREFIX = function(s) return s:sub(mff.QPREFIX:len()+1) end

mff.quests.quests = {
	still_testing_quests = {
		title = "Stone digger",
		description = "TEST QUEST!\nGet a Super Apple at the end!",
		repeating = 60*60*24,
		awards = {["maptools:superapple"] = 1},
		tasks = {
			diggy = {
				title = "Dig 99 stone",
				description = "Show you can dig through stone",
				max = 99,
				objective = {
					dig = {"default:stone"}
				}
			},
			diggysrevenge = {
				title = "Dig the last stone",
				description = "You really thought 99 was a good number? Dig the last one.",
				requires = {"diggy"},
				max = 1,
				objective = {
					dig = {"default:stone"}
				}
			}
		}
	},
	still_testing_quests2 = {
		title = "Coal digger",
		description = "TEST QUEST!\nGet a Diamond at the end!",
		repeating = 60*60*24,
		awards = {["default:diamond"] = 1},
		tasks = {
			diggy = {
				title = "Dig 19 coal",
				description = "Get the fire mineral",
				max = 19,
				objective = {
					dig = {"default:stone_with_coal"}
				}
			},
			diggysrevenge = {
				title = "Dig the last one",
				description = "I do this because of a technical issue, sorry",
				requires = {"diggy"},
				max = 1,
				objective = {
					dig = {"default:stone_with_coal"}
				}
			}
		}
	},
	still_testing_quests3 = {
		title = "Shiny diamonds",
		description = "TEST QUEST!\nGet a mithril ingot at the end!",
		repeating = 60*60*24,
		awards = {["moreores:mithril_ingot"] = 1},
		tasks = {
			diggy = {
				title = "Dig 4 diamond",
				description = "Yarr harr fiddle dee-dee, being a pirate is alright with me! Do what you want 'cause a pirate is free, you are a pirate! Go get the precious booty... underground. Mine it :/",
				max = 4,
				objective = {
					dig = {"default:stone_with_diamond"}
				}
			},
			diggysrevenge = {
				title = "Ultimate calbon atom alignement",
				description = "Really, we must fix this",
				requires = {"diggy"},
				max = 1,
				objective = {
					dig = {"default:stone_with_diamond"}
				}
			}
		}
	}
}

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
		return true
		end
	end
	return false
end

function mff.quests.start_quest(playername, qname, meta)
	quests.start_quest(playername, mff.QPREFIX .. qname, meta)
end

function mff.quests.handle_quest_end(playername, questname, metadata)
	for item, count in pairs(mff.quests.quests[mff.QNOPREFIX(questname)].awards) do
		minetest.add_item(minetest.get_player_by_name(playername):getpos(), {name=item, count=count, wear=0, metadata=""})
	end
end

-- Register the quests defined above
for qname, quest in pairs(mff.quests.quests) do
	quest.completecallback = mff.quests.handle_quest_end
	local ret = quests.register_quest(mff.QPREFIX .. qname, quest)
end

-- TODO
-- implement magical iterator, going through BOTH the simple quests
-- AND tasked quests objectives, returning a tuple like this:
-- questname, questdef, taskname (nil?), taskdef (nil?), objective_container (that is, either questdef or taskdef), pointer_to_function_to_update_the_objective_progress_with_only_one_parameter_the_others_being_automagically_passed_to_the_quests_API_so_that_we_dont_have_to_write_ifs_and_elses_everywhere_to_handle_both_quest_and_tasks_cases_because_it_would_give_crap_code

minetest.register_on_dignode(function(pos, oldnode, digger)
	if not digger then return end
	local pname = digger:get_player_name()
	for qname, quest in pairs(mff.quests.quests) do
		if quest.tasks then
			for tname, task in pairs(quest.tasks) do
				if quests.is_task_visible(pname, mff.QPREFIX .. qname, tname)
					and not quests.is_task_disabled(pname, mff.QPREFIX .. qname, tname)
					and task.objective.dig then
					if table.contains(task.objective.dig, oldnode.name) then
						quests.update_quest_task(pname, mff.QPREFIX .. qname, tname, 1)
					end
				end
			end
		end
	end
end)

minetest.register_on_joinplayer(function (player)
	local playername = player:get_player_name()
	for _, qname in ipairs({"still_testing_quests", "still_testing_quests2", "still_testing_quests3"}) do
		if not quests.quest_restarting_in(playername, mff.QPREFIX .. qname) then
			mff.quests.start_quest(playername, qname)
		end
	end
end)
