--The actual rules.
interact.rules = [[
Voici les regles :

1)	Aucune atteinte intentionnelle au bon fonctionnement du serveur ne sera admise. (lag, crash, exploit de bug, etc...)
2)	La triche (hack, client modifie, etc...) n'est pas toleree sur le serveur. Soyez fair-play et apprenez a jouer selon les regles.
3)	Sur le serveur, le PVP est autorise, le vole/grief est aussi autorise, le grief n'est pas autorise sur les constructions publics. (pensez au mod areas pour proteger vos biens)
4)	Merci de ne pas spammer ou flooder.
5)	Chaque joueur a l'entiere responsabilite de son compte, nous ne sommes en aucun cas responsable d'une utilisation frauduleuse de votre compte dans le jeu.
6)	Si possible, evitez les constructions de tours en 1x1 mais aussi, de poser des blocs gachant le decor, n'importe ou. Ceci pour que le serveur reste le plus beau, sauvage et naturel possible.
7)	Ne demandez pas a etre membre de l'equipe du serveur.
8)	Aucune forme d'insulte ou de racisme n'est admise.

Cliquez sur le bouton "Accepter" pour pouvoir construire et interagir sur le serveur.
]]

--The questions on the rules, if the quiz is used.
--The checkboxes for the first 4 questions are in config.lua
interact.s4_question1 = "Puis-je utiliser un bug pour faire crasher le serveur afin qu'il redémarre?"
interact.s4_question2 = "Puis-je demander à faire partie de l'équipe d'administration?"
interact.s4_question3 = "Ai-je le droit de grieffer une zone non-protégée?"
interact.s4_question4 = "Puis-je joindre librement l'IRC?"
interact.s4_multi_question = "Which of these is a rule?"

--The answers to the multiple choice questions. Only one of these should be true.
interact.s4_multi1 = "Pas de grieff"
interact.s4_multi2 = "Pas de PvP"
interact.s4_multi3 = "Vole d'objets autorisé"

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
