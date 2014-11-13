Sprint Mod For Minetest by GunshipPenguin  

Allows the player to sprint by double tapping w. By default, 
sprinting will make the player travel 50% faster and allow him/her 
to jump 10% higher.
 
Licence: WTFPL (see LICENCE file)


---

This mod can be configured by changing the variables declared in 
the start of init.lua. The following is a brief explanation of each 
one.
 
SPRINT_SPEED (default 1.5)
 
How fast the player will move when sprinting as opposed to normal 
movement speed. 1.0 represents normal speed so 1.5 would mean that a 
sprinting player would travel 50% faster than a walking player and 
2.4 would mean that a sprinting player would travel 140% faster than 
a walking player.

SPRINT_JUMP (default 1.1)

How high the player will jump when sprinting as opposed to normal 
jump height. Same as SPRINT_SPEED, just controls jump height while 
sprinting rather than speed.

SPRINT_STAMINA (default 20)

How long the player can sprint for in seconds. Each player has a 
stamina variable assigned to them, it is initially set to 
SPRINT_STAMINA and can go no higher. When the player is sprinting, 
this variable ticks down once each second, and when it reaches 0, 
the player stops sprinting and may be sent a warning depending on 
the value of SPRINT_WARN. It ticks back up when the player isn't 
sprinting and stops at SPRINT_STAMINA. Set this to a huge value if 
you want unlimited sprinting.

SPRINT_TIMEOUT (default 0.5)

How much time the player has after releasing w, to press w again and 
start sprinting. Setting this too high will result in unwanted 
sprinting and setting it too low will result in it being 
difficult/impossible to sprint.

SPRINT_WARN (default true)

If the player should be warned that his/her stamina has run out via 
the in game chat system. You may want to set this to false if the 
notifications get annoying.
