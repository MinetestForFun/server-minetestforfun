minetestforfun_game subgame and mods
===================

You can find here the subgame and the mods of the server MinetestForFun.

If you want help us, don't hesitate and take a look at our ToDoList [here](https://lite5.framapad.org/p/r.446ce575dd27b3c3e8a8efb34f28ac2d).

Contributors
===================
- Ombridride - Darcidride - MinetestForFun
  > Server hoster, reposity owner.
- LeMagnesium - Mg
  > Debugging, mod maintenance and global variables annihilator.
- crabman77 - crabman - guillaume
  > Debugging, mod maintenance and global variables annihilator.
- mgl512
  > Helper for debugging, and leaves very useful comments.
- Ataron
  > Occasionnal debogger, texture creater.
- Gael-de-Sailly
  > Kittens carer, debogger and Mapgen creator.
- davedevils
  > Gardener, creepers' father and chickens' friend.
- Obani
  > Audio bit king.
- gravgun
  > Database warrior and mod maintenancer.

minetestforfun_game sous-jeu et mods
===================

Vous pouvez trouver ici le sous-jeu et les mods du serveur MinetestForFun.

Si vous voulez nous aider, n'hésitez pas et jetez un coup d'oeil à notre ToDoList [ici](https://lite5.framapad.org/p/r.446ce575dd27b3c3e8a8efb34f28ac2d).

Contributeurs
===================
- Ombridride - Darcidride - MinetestForFun
  > Hébergeur du serveur, possesseur du dépôt.
- LeMagnesium - Mg
  > Deboggueur, entretien des mods et annihilateur de variables globales.
- crabman77 - crabman - guillaume
  > Deboggueur, entretien des mods et annihilateur de variables globales.
- mgl512
  > Aide au déboggage, et laisse des commentaires très utiles.
- Ataron
  > Déboggueur occasionnel, créateur de textures
- Gael-de-Sailly
  > Soigneur, deboggueur de chatons et créateur de générateur de carte.
- davedevils
  > Jardinier, père des creeper et ami des poulets.
- Obani
  > Roi du bit audio.
- gravgun
  > Guerrier des base de données et entretienneur de mods.

Note to developpers
===================

Recently many changes have been made in the repository. New methods have been
adopted for pushing/pulling from the repository. You will find here the most
importants

### When you are pushing
After committing, you will need to reproduce your changes on parallel branches.
For example, if you commit on master :

    > git format-patch HEAD~<amount of commits to reproduce> --stdout > patch_for_branch.patch
    > # Created a .patch file to apply commits on the other branch
    > git checkout <parallel branch>
    > git am ./patch_for_branch.patch # Apply the patch
    > git push origin <parallel branch>

If you want to see which files are being modified, or how many lines are added :

    > git apply --stat < patch_for_branch.patch
    another_file.txt |    0
    another_file.txt |    0
    2 files changed, 0 insertions(+), 0 deletions(-)
    >

If you want to check whether or not you will have to resolve merge conflicts :

    > git apply --check < patch_for_branch.patch

If you get errors, then git am will require you to solve merge conflicts.

### When a parallel branch cannot be pulled
WIP works are often put on parallel branch to not disturb simple
updates or fixes for mods (even if they should be reproduced on these
branches as shown above). However, there might be problems, requiring
devs to 'forcepush' on the branches.
__*Note:*__ It will never happen on `master`

If you cannot pull, then, here is what to do :

    > git checkout master
    > git branch -D <parallel branch>
    > git checkout -b <parallel branch>
    > git branch --set-upstream-to=origin/<parallel branch>
    > git pull origin <parallel branch>

This will delete your copy of the branch, create a new one, and replace
it with the remote content. You can also :

    > git pull --force
