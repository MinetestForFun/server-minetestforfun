This mod creates a customizable compass with user settable bookmarks and shared and admin bookmarks in multiplayer.

**Compass GPS version 2.6**

Echo created a compass mod back in 2012: [https://forum.minetest.net/viewtopic.php?id=3785](https://forum.minetest.net/viewtopic.php?id=3785)<p>
PilzAdams made a modification of it, which I can not find the source to, I don't know how much of PilzAdams changes made it into the later versions of Echo's mod.<p>
Then in 2013 TeTpaAka made a fork of the compass mod that he called compass+ [https://forum.minetest.net/viewtopic.php?id=8117](https://forum.minetest.net/viewtopic.php?id=8117)<p>
This fork added the ability to "bookmark" specific places, and a gui so you could choose what point the compass should point to.

This is my fork of TeTpaAka's fork of Echo's mod. :)

The compass mod as it was is REALLY cool  I love the way Echo managed to make the compass in your inventory actually change it's image to point in the direction of it's target

![alt text](http://i59.tinypic.com/a15ls0.png "image")

And TeTpaAka's gui, file io, and coding for multiplayer games was simply amazing.  But as I was learning from their awesome code, I saw some changes I'd like to make using these new ideas, as well as some things I learned while looking at other mods.  So, with complete and total respect for the original awesome mods, and hopefully in the same spirit as theirs, I present my own fork of the fork.  CompassGPS

The crafting recipe for a compass is unchanged:<p>
```
     , steel        ,
steel, mese fragment, steel
     , steel        ,
```
![alt text](http://i59.tinypic.com/14ad2qw.png "image")

Compass GPS introduces several other changes though.  First of all, this mod adds a heads up display that indicates your current position, and the name of the bookmark the compass is pointing at, that bookmarks pos, as well as the distance to that bookmark.

![alt text](http://i60.tinypic.com/facwea.png "image")

The hud updates constantly as long as the compass is in one of your active inventory slots, so you can always know where you are in relation to the target node, and how far away it is.

There is a GUI that pops up whenever you wield the compass and left click.  I never played with a GUI in minetest before, so this was a new experience for me, I learned a lot and made quite a few changes:

![alt text](http://i61.tinypic.com/29zzgy1.png "image")

To create a new bookmark, type the name into the "bookmark:" field and click "Create Bookmark" (or just hit enter).  To remove a bookmark, select it from the list and click "Remove Bookmark." A confirmation dialog will appear and the bookmark will only be removed if you click "YES".

The bookmark list has been expanded from a dropdown into a textlist to improve visibility.  Select any bookmark in the list by clicking on it, and then click "Find Selected Bookmark" to make the compass (and hud) point at that location.  "default" is always at the top of the list and will point to (0,0,0) or your bed from PilzAdams bed-mod, or home location as defined in the sethome-mod.  (Setting default to your bed or sethome is old code, I modified it to make it work with my new version, but I cant take credit for the idea or basic structure.)  The rest of the list are bookmarked locations that you have set and named

Just click in the "Sort by" box to change whether the bookmarks are sorted by name, or by distance from your current location.  ("default" will still always be the first item in the list no matter which way you sort it)

Click in the "Dist" box to change whether the distance is calculated in 3d (including your distance in the vertical direction) or in 2d (x and z coords only, ignore vertical distance)

Down at the lower right of the screen, I'm certain you noticed the "Teleport to bookmark" button.  *That button appears if, and ONLY IF the player has teleport privileges.*  If they do, then they can select any bookmark out of the list, click on teleport, and be instantly transported to the location of that bookmark.  Since the user already had teleport privileges, this just saved them some typing, it's not adding any new abilities.

If you click the "Settings" button in the upper right hand corner it brings up a screen where you can customize the appearance of your compass gps:

![alt text](http://i59.tinypic.com/aahqa8.png "image")<p>
(The two awesome new compass images are by Bas080 and Spootonium)

I figured the position of the hud text was likely to be something that people would want to customize, so here in the settings gui are the x and y coords for the hud text.  Just enter the new coords where you want the hud text to appear and click "Change Hud"<p>
The cords must be between 0 and 1 and represent a percentage of the screen, so x=0 would put the text at the far left of the screen, and y=0.98 would put the text almost at the bottom of the screen.  The default is x=0.4 and y=0.01, and that is displayed right over the input boxes so the user can easily set them back to the default if they are having trouble placing the hud. If you change either the x or y coord to a number that is out of range (less than 0 or greater than 1) then the hud will not be displayed.  That makes it easy to turn the hud off if you wish.<p>
You can also change the color of the hud text by changing the value in the "Color" field here.  Again, click "Change Hud" to make the update appear.

AND, there are three buttons here that allow you to select from 3 different styles of compass images.  The basic compass image by Echo.  A nice wooden compass image by Bas080.  And a high resolution compass image by spootonium.

In Multiplayer, there are now shared and admin bookmarks!<p>
![alt text](http://i61.tinypic.com/a5b7li.png "image")<p>
If a player has the new "shared_bookmarks" privilege, then they will get the "Create Shared Bookmark" button and be able to create bookmarks that all players on the server can see and use.  Shared bookmarks are preceded by *shared* and the name of the player that created them.  There is a variable near the top of the init.lua called max_shared.  This controls the maximum number of shared bookmarks that an individual player can create.  It is set to 10 by default, but the server admin can change it to whatever they want.  A player can delete their own shared bookmarks, but they can not delete anyone else's (unless they are an admin, then they can delete anyone's shared bookmarks)

If a player has the "privs" privilege, then they will get the "Create Admin Bookmark" button.  Admin bookmarks are intended to allow the admins to mark important places in their world that they want everyone to be able to find.  There are no limits on how many admin bookmarks can be created.  Only Admins can delete admin bookmarks.

In a multiplayer game, all players get the "Show: Private, Shared, Admin" checkboxes.  You can use these checkboxes to toggle which type of bookmarks show in your list.  If you uncheck all three the system will automatically recheck "Private" for you.

The bookmark list is saved any time a user changes it.  All of your other settings, the currently selected bookmark, sort order, distance function, and hud position and color, and compass type, are saved whenever a user leaves the game, and on game shutdown.  So if you move the hud down to the lower right hand corner of the screen, and then quit, the hud will still be in the place you put it when you restart the game later.

The Chat Commands from the orignal compass mod still work, but only on private bookmarks.  Chat commands available are:<p>
list_bookmarks<p>
set_bookmark <bookmark name><p>
find_bookmark <bookmark name><p>
remove_bookmark <bookmark name>

I also fixed a few bugs while I was working on this.  There was a problem in the mod that caused compass to jump around in inventory if there were empty slots above it, that is fixed now.  And there was also a problem with the bookmark list not being saved after you removed a bookmark if you didn't add a new bookmark afterwards.  Now the bookmark list is saved whenever you change it, either adding or removing.

I tried to follow Echo and TeTpaAka's examples of how to properly code for multiplayer games, and all of the new settings should work just fine in a multiplayer game.

----** MAPS! **----

Thanks to a great idea and initial code from TeTpaAka CompassGPS now includes MAPS!<p>
Maps allow you to store a bookmark that you can then give to another player and they can use the map to put that bookmark into their own list.  They also enhance role playing/story possibilities since you can hide maps for players to find that will give them bookmarks they need to find their next goal.

Craft a blank map by putting 5 papers in an X pattern:<p>
```
paper,     ,paper
     ,paper,
paper,     ,paper
```
![alt text](http://i57.tinypic.com/20z5wmr.png "image")

To place a bookmark into a map, just right click while wielding the map, select any bookmark from your list, and click the "write to cgpsmap" button.  You can also put your current position into the map (without having to first create a bookmark in your compassGPS)

The map icon now changes to have a red X on it, so you can tell it is a marked map.  This map can be given to another player.  To transfer the bookmark to their own compassgps, they right click while wielding the marked map and a formspec like this pops up:<p>
![alt text](http://i61.tinypic.com/jakj9v.png "image")<p>
You can change the name of the bookmark to whatever you wish, click the "copy bookmark to your compassgps" button and the new bookmark is now available in your compassgps list.

To turn a marked map back into a blank map, just put it into the crafting grid.

Thanks to some nice code by Miner59 you can now mount a map on a wall!  If you can dig on the position where the map is placed, you can take the map, otherwise you can add the bookmark saved in the map in your compassgps.  This will make it possible on a multiplayer server to mount maps that everyone can use.

---------------------

The code is kinda a mess, because I was learning a lot of new things while working on it.  I hope to do a clean up on it sometime in the near future, but I wanted to release it now so some people could start testing it.  Please do not hesitate to offer critiques, criticism, or coding advice.  I'm new to lua and minetest and could use the help.

And above all, if you run into a bug, please let me know!

**Credits:**<p>
Original mod is by Echo and TeTpaAka, and probably PilzAdam.  Cactuz_pl clockmod showed me how to write the hud to the screen.  My son offered a lot of advice and suggested several changes.  I got an example of how to sort lists in lua from Michal Kottman on StackOverflow.  Big thanks to Bas080 and spootonium for providing some very nice alternate images for the compass gps mod!  Also thanks to Topywo for the shared bookmarks idea, and to my son for several ideas, corrections, and testing help.<p>
Map idea, image, and initial code by TeTpaAka.  Store current position in map code contributed by Miner95<p>
intllib support by TeTpaAka<p>
Wall mounted maps by Miner59

**License:**<p>
Original code by Echo, PilzAdam, and TeTpaAka is WTFPL.  My changes are CC0 (No rights reserved)<p>
textures: original compass textures: CC BY-SA by Echo<p>
          compass b textures: CC BY-SA by Bas080 (slight modifications by Kilarin)<p>
          compass c textures: CC BY-SA by Andre Goble mailto:spootonium@gmail.com<p>
                              (slight modifications by Kilarin)<p>
          map texture: CC BY-SA by TeTpaAka (slight modifications by Kilarin for blank map)

**Dependencies:**<p>
default is the only requirement.<p>
PilzAdams Beds mod and the sethome-mod are supported if you have them.

**Incompatibilities:**<p>
This mod will clash with both the original compass and compass+ mods.  They should not be installed and enabled at the same time as compassgps.  HOWEVER, compassgps is 100% compatible with the bookmarks file from the compass+ mod.  So if you were using compass+ and switch to compassgps you will NOT lose your previous bookmarks.

**github source:**<p>
[https://github.com/Kilarin/compassgps](https://github.com/Kilarin/compassgps)

**Download:**<p>
[https://github.com/Kilarin/compassgps/archive/master.zip](https://github.com/Kilarin/compassgps/archive/master.zip)

**To install:**<p>
Simply unzip the file into your mods folder, then rename the resulting folder from compassgps-master to compassgps<p>
OR, simply install it directly from minetest using the online mod repository.

**Mod Database:**<p>
If you use this mod, please consider reviewing it on the MineTest Mod Database.<p>
[https://forum.minetest.net/mmdb/mod/compassgps/](https://forum.minetest.net/mmdb/mod/compassgps/)

**Changelog:**<p>
2.6 bug fix from myoung008, type causing crashes when entering bad color.<p>
2.5 bug fix from TeTpaAka fix bug when static_spawnpoint is invalid<p>
2.4 wall mounted maps by Miner59<p>
2.3 intllib support by TeTpaTka so CompassGPS will work with different languages now!<p>
2.2 current position option in bookmark list when writing to map (Miner95 contribution)<p>
2.1 cgpsmap_marked notincreative and defaults to default on /giveme<p>
2.0 maps so you can exchange bookmarks between players (TeTpaAka initial contribution)<p>
1.9 corrected undeclared global variables to avoid warnings.<p>
1.8 changed register_craft to compassgps:0 for unified inventory compatibility<p>
1.7 fixed bug causing crash on first load of formspec in multiplayer<p>
1.6 fixed compass point_to not saving<p>
1.5 shared/admin bookmarks.  confirm dialog for remove.<p>
1.4 corrected teleport button priv<p>
1.3 multiple compass types<p>
1.2 rounding of position corrected<p>
1.1 switched core to minetest<p>
1.0 Initial release<p>
