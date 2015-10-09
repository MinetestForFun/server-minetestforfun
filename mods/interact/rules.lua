interact.languages = {
	en = "English",
	fr = "Français"
}
--The actual rules.
interact.rules = {
	en = [[1) No intentional try to disturb the server's stability will be tolerated. (lag, crash, bug exploit, ...)
2) Cheating (hack, modified client, ...) is forbidden on this server. Be fair-play and learn to play according to the rules.
3) On the server, PVP is authorized and theft/grief as well, to the exception of public buildings. (remember to use the areas mod to protect your buildings)
4) Please do not spam or flood.
5) Each player is responsible of his/her own account, we can't be held liable for any illegitimate use of it.
6) Try to avoid 1x1 towers and overall destroying the environment, anywhere that is. This way the server will stay as beautiful, wild and natural as possible.
7) Do not ask to be a member of the server staff.
8) Swearing, racism, hate speech and the like is strictly prohibited.

Click on the "I accept" button to get the permission to build and interact with the server.]],
	fr = [[1) Aucune atteinte intentionnelle au bon fonctionnement du serveur ne sera admise. (lag, crash, exploit de bug, etc...)
2) La triche (hack, client modifie, etc...) n'est pas toleree sur le serveur. Soyez fair-play et apprenez a jouer selon les regles.
3) Sur le serveur, le PVP est autorise, le vole/grief est aussi autorise, le grief n'est pas autorise sur les constructions publics. (pensez au mod areas pour proteger vos biens)
4) Merci de ne pas spammer ou flooder.
5) Chaque joueur a l'entiere responsabilite de son compte, nous ne sommes en aucun cas responsable d'une utilisation frauduleuse de votre compte dans le jeu.
6) Si possible, evitez les constructions de tours en 1x1 mais aussi, de poser des blocs gachant le decor, n'importe ou. Ceci pour que le serveur reste le plus beau, sauvage et naturel possible.
7) Ne demandez pas a etre membre de l'equipe du serveur.
8) Aucune forme d'insulte ou de racisme n'est admise.

Cliquez sur le bouton "Accepter" pour pouvoir construire et interagir sur le serveur.]]
}

--The questions on the rules, if the quiz is used.
--The checkboxes for the first 4 questions are in config.lua
interact.s4_question1 = {
	en = "Can I use a bug to crash the server so it restarts?",
	fr = "Puis-je utiliser un bug pour faire crasher le serveur afin qu'il redémarre ?"
}
interact.s4_question2 = {
	en = "Can I ask to be a member of the staff ?",
	fr = "Puis-je demander à faire partie de l'équipe d'administration ?"
}
interact.s4_question3 = {
	en = "Are the spam and flood forbidden?",
	fr = "Le spam et flood sont ils interdit ?"
}
interact.s4_question4 = {
	en = "Can I freely join the IRC channel?",
	fr = "Puis-je joindre librement l'IRC ?"
}
interact.s4_multi_question = {
	en = "Which of these is a rule?",
	fr = "Laquelle des affirmations est une règle ?"
}

--The answers to the multiple choice questions. Only one of these should be true.
interact.s4_multi1 = {
	en = "Cheating allowed",
	fr = "Triche autorisé"
}
interact.s4_multi2 = {
	en = "PvP forbidden",
	fr = "PvP interdit"
}
interact.s4_multi3 = {
	en = "Swearing/racism forbidden",
	fr = "Insulte/racisme interdit"
}

--Which answer is needed for the quiz questions. interact.quiz1-4 takes true or false.
--True is left, false is right.
--Please, please spell true and false right!!! If you spell it wrong it won't work!
--interact.quiz can be 1, 2 or 3.
--1 is the top one by the question, 2 is the bottom left one, 3 is the bottom right one.
--Make sure these agree with your answers!
interact.quiz1 = false
interact.quiz2 = false
interact.quiz3 = true
interact.quiz4 = true
interact.quiz_multi = 3
