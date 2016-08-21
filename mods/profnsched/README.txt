[profnsched] : Profile and schedule mod (fr)
============================================

Buts : 
======
 * Objectif principal : maintenir le temps d'exécution du pas (step) au plus près du tick rate (dedicated_server_step)
 * analyser en temps réel les temps d'execution de certaines fonctions de module
   (actuellement uniquement globalstep et minetest.after)
 * Décaler, de façon adaptative, l'exécution des modules qui l'autorisent explicitement en cas de surcharge
 * (WIP) Indiquer à chaque module le temps dont il dispose pour s'exécuter (utile pour les modules qui adaptent leurs calculs)
 

Concepts :
==========
 * Les travaux en attentes sont placés dans des files d'executions priorisées
 * La première file est toujours exécutée, même en cas de surcharge
 * Les autres files sont traitées tant qu'il reste du temps (< tick rate)
 * En cas d'arrêt prématuré (surcharge), chaque classe de priorité est transférée dans la précédente (ainsi en cas de surcharge on est certain que le travail sera executé)
 * Il peut y avoir autant de files que souhaités (rester raisonnable cependant)
 * Concrêtement :
    - Dans l'idéal, toutes les files sont exécutées à chaque pas (step) ! 
    - En cas de surcharge, on a la garantie que les travaux de la file n seront exécutés au pas (step) n ou n+1
    - Mais on a aucune garantie de temps (à cause de la surcharge, les pas (step) dépassent le tick rate, parfois de plusieurs secondes...)
    - Ne pas oublier que de toute façon en cas de surcharge, ni globalstep.after ni minetest.after ne peuvent garantir le temps écoulé
 * En cas de surcharge une trace des travaux exécutés est transcrite dans le log du serveur (pour analyse des goulots d'étranglement)


Fonctions utiles :
==================
 * scheduler.add(class, job) -- ajoute le travail 'job' dans la file n° 'class' (job = {mod_name, func_id, func_code[, args]})
 * scheduler.asap(class, func_code) -- ajoute une fonction à exécuter dans la file n° 'class'
 
Comparaisons :
==============
 * minetest.globalstep
   - Pour les traitements qui *nécessitent* une exécution à chaque pas (step)
   - Peut être remplacé par minetest.after(0, *) ou scheduler.asap(0, *) mais cela ajoute du temps de traitement inutile.
 * minetest.after
   - Pour les traitements qui doivent s'exécuter après un certain temps écoulé
   - Dans l'idéal c'est fiable, mais en cas de surcharge le temps peut être largement dépassé (inévitable)
 * scheduler.add/asap
   - Pour les traitements qui souhaitent être fréquemment exécutés
   - mais qui n'ont pas besoin d'une fréquence fixe (tick)
   - ni d'une durée précise entre chaque execution
   - en bref qui acceptent de sacrifier de leur temps au profit de traitements plus importants qu'eux
 
 
Exemples possibles :
====================
 * Les calculs capitaux en file 1
 * Les traitements d'UI pourraient être en file 2 ou 3
 * Les traitements encore moins importants en file supérieure (génération des plantes, ...)

 
Hack actuel :
=============
 * La boucle minetest.after qui vérifie les travaux expirés est classée en faible priorité (file 4)
   (dans le meilleur des cas la vérification a lieu à chaque pas (step), sinon on reporte)
 * Les travaux eux-mêmes issus de minetest.after sont en file 4
   (dans le meilleur des cas ils seront exécutés au prochain pas (step), sinon on reporte)
 

TODO :
======
 * fournir en paramètre au module appelé le temps d'execution souhaité/maximum
 * mettre d'autres appels en surveillance (on_step, ...)
 * nettoyer/optimiser le code ;)

