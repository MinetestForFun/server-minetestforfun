interact = {}

-- Which screens to show and in which order.
interact.form_order = {
	"languageselect",
	"welcome",
	"visit",
	"rules",
	"quiz"
}

--The first screen--
--The text at the top.
interact.s1_header = {
	en = "Hello, welcome to this server!",
	fr = "Bonjour et bienvenue sur ce serveur!"
}
--Lines one and two. Make sure each line is less than 70 characters, or they will run off the screen.
interact.s1_l2 = {
	en = "Could you please tell me if you like to grief or not?",
	fr = "Aimez-vous détruire les choses des autres?"
}
interact.s1_l3 = {en="",fr=""}
--The buttons. Each can have 15 characters, max.
interact.s1_b1 = {
	en = "No, I don't.",
	fr = "Non."
}
interact.s1_b2 = {
	en = "Yes, I do!",
	fr = "Oui!"
}

--The message to send kicked griefers.
interact.msg_grief = {
	en = "Try out singleplayer if you like griefing, because then you'll only destroy your own stuff!",
	fr = "Essayez le mode solo si vous aimez détruire des choses, car vous ne détruirez que les votres!"
}

--Ban or kick griefers? Default is kick, set to true for ban.
interact.grief_ban = false

--The second screen--
--Lines one and two. Make sure each line is less than 70 characters, or they will run off the screen.
interact.s2_l1 = {
	en = "So, do you want interact, or do you just want to look around",
	fr = "Donc, voulez-vous interagir ou juste regarder"
}
interact.s2_l2 = {
	en = "the server?",
	fr = "le serveur?"
}
--The buttons. These ones can have a maximum of 26 characters.
interact.s2_b1 = {
	en = "Yes, I want interact!",
	fr = "Oui, je veux interagir!"
}
interact.s2_b2 = {
	en = "I just want to look round.",
	fr = "Je veux juste regarder."
}

--The message the player is sent if s/he is just visiting.
interact.visit_msg = {
	en = "Have a nice time looking round! If you want interact just type /rules, and you can go through the process again!",
	fr = "Bonne contemplation! Si vous voulez interagir, tapez la commande /rules, et vous pourrez recommencer le processus!"
}

--The third screen--
--The header for the rules box, this can have 60 characters, max.
interact.s3_header = {
	en = "Here are the rules:",
	fr = "Voici les règles:"
}

--The buttons. Each can have 15 characters, max.
interact.s3_b1 = {
	en = "I agree",
	fr = "Accepter"
}
interact.s3_b2 = {
	en = "I disagree",
	fr = "Refuser"
}

--The message to send players who disagree when they are kicked for disagring with the rules.
interact.disagree_msg = {
	en = "Bye then! You have to agree to the rules to play on the server.",
	fr = "Au revoir! Vous devez accepter les règles pour jouer sur le serveur."
}

--Kick or ban players who disagree with the rules. False will just kick.
interact.disagree_ban = false

--The fouth screen--
--Should there be a back to rules button?
interact.s4_to_rules_button = true
--The back to rules button. 13 characters, max.
interact.s4_to_rules = {
	en = "Back to rules",
	fr = "<-- Règles"
}

--The header for screen 4. 60 characters max, although this is a bit of a squash. I recomend 55 as a max.
interact.s4_header = {
	en = "Time for a quiz on the rules!",
	fr = "Quizz sur les règles!"
}

--Since the questions are intrinsically connected with the rules, they are to be found in rules.lua
--The trues are limited to 24 characters. The falses can have 36 characters.
interact.s4_question1_true = {en="Yes.",fr="Oui."}
interact.s4_question1_false = {en="No.",fr="Non."}
interact.s4_question2_true = {en="Yes.",fr="Oui."}
interact.s4_question2_false = {en="No.",fr="Non."}
interact.s4_question3_true = {en="Yes.",fr="Oui."}
interact.s4_question3_false = {en="No.",fr="Non."}
interact.s4_question4_true = {en="Yes.",fr="Oui."}
interact.s4_question4_false = {en="No.",fr="Non."}

interact.s4_submit = {
	en = "Submit!",
	fr = "Envoyer!"
}

--What to do on a wrong quiz.
--Options are "kick" "ban", "" (nothing) or another form name (e.g. "rules", or "quiz" to re-show)
interact.on_wrong_quiz = ""
--The message to send the player if reshow is the on_wrong_quiz option.
interact.quiz_try_again_msg = {
	en = "Have another go.",
	fr = "Réessayez."
}
--The message sent to the player if rules is the on_wrong_quiz option.
interact.quiz_rules_msg = {
	en = "Have another look at the rules:",
	fr = "Re-regardez les règles:"
}
--The kick reason if kick is the on_wrong_quiz option.
interact.wrong_quiz_kick_msg = {
	en = "Pay more attention next time!",
	fr = "Lisez mieux la prochaine fois!"
}
--The message sent to the player if nothing is the on_wrong_quiz option.
interact.quiz_fail_msg = {
	en = "You got that wrong.",
	fr = "Vous avez raté le quiz."
}

--The messages send to the player after interact is granted.
interact.interact_msg1 = {
	en = "Thanks for accepting the rules, you now are able to interact with things.",
	fr = "Merci d'avoir accepté les règles, vous pouvez désormais interagir avec les choses."
}
interact.interact_msg2 = {
	en = "Happy building!",
	fr = "Amusez-vous bien!"
}

--The priv required to use the /rules command. If fast is a default priv, I recomend replacing shout with that.
interact.priv = {}
