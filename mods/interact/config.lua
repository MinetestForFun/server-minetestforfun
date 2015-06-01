interact = {}

--Which screens to show.
interact.screen1 = true --The welcome a first question screen.
interact.screen2 = true --The visit or interact screen.
interact.screen4 = true --The quiz screen.

--The first screen--
--The text at the top.
interact.s1_header = "Hello, welcome to this server!"
--Lines one and two. Make sure each line is less than 70 characters, or they will run off the screen.
interact.s1_l2 = "Could you please tell me if you like to grief or not?"
interact.s1_l3 = ""
--The buttons. Each can have 15 characters, max.
interact.s1_b1 = "No, I don't."
interact.s1_b2 = "Yes, I do!"

--The message to send kicked griefers.
interact.msg_grief = "Try out singleplayer if you like griefing, because then you'll only destroy your own stuff!"

--Ban or kick griefers? Default is kick, set to true for ban.
interact.grief_ban = false

--The second screen--
--Lines one and two. Make sure each line is less than 70 characters, or they will run off the screen.
interact.s2_l1 = "So, do you want interact, or do you just want to look around"
interact.s2_l2 = "the server?"
--The buttons. These ones can have a maximum of 26 characters.
interact.s2_b1 = "Yes, I want interact!"
interact.s2_b2 = "I just want to look round."

--The message the player is sent if s/he is just visiting.
interact.visit_msg = "Have a nice time looking round! If you want interact just type /rules, and you can go through the process again!"

--The third screen--
--The header for the rules box, this can have 60 characters, max.
interact.s3_header = "Here are the rules:"

--The buttons. Each can have 15 characters, max.
interact.s3_b1 = "I agree"
interact.s3_b2 = "I disagree"

--The message to send players who disagree when they are kicked for disagring with the rules.
interact.disagree_msg = "Bye then! You have to agree to the rules to play on the server."

--Kick or ban players who disagree with the rules. False will just kick.
interact.disagree_ban = false

--The fouth screen--
--Should there be a back to rules button?
interact.s4_to_rules_button = true
--The back to rules button. 13 characters, max.
interact.s4_to_rules = "Back to rules"

--The header for screen 4. 60 characters max, although this is a bit of a squash. I recomend 55 as a max.
interact.s4_header = "Time for a quiz on the rules!"

--Since the questions are intrinsically connected with the rules, they are to be found in rules.lua
--The trues are limited to 24 characters. The falses can have 36 characters.
interact.s4_question1_true = "Yes."
interact.s4_question1_false = "No."
interact.s4_question2_true = "Yes."
interact.s4_question2_false = "No."
interact.s4_question3_true = "Yes."
interact.s4_question3_false = "No."
interact.s4_question4_true = "Yes."
interact.s4_question4_false = "No."

interact.s4_submit = "Submit!"

--What to do on a wrong quiz.
--Options are "kick" "ban" "reshow" "rules" and "nothing"
interact.on_wrong_quiz = "nothing"
--The message to send the player if reshow is the on_wrong_quiz option.
interact.quiz_try_again_msg = "Have another go."
--The message sent to the player if rules is the on_wrong_quiz option.
interact.quiz_rules_msg = "Have another look at the rules:"
--The kick reason if kick is the on_wrong_quiz option.
interact.wrong_quiz_kick_msg = "Pay more attention next time!"
--The message sent to the player if nothing is the on_wrong_quiz option.
interact.quiz_fail_msg = "You got that wrong."

--The messages send to the player after interact is granted.
interact.interact_msg1 = "Thanks for accepting the rules, you now are able to interact with things."
interact.interact_msg2 = "Happy building!"

--The priv required to use the /rules command. If fast is a default priv, I recomend replacing shout with that.
interact.priv = {}
