# player_physics
A minetest mod to centralize the management of player's stats(sprint, jump, gravity)
Because many mods (sprint, 3d_armor and others) rewrite the stats in their corner and it cancel


***API***

 - player_physics.set_stats(player, "uniq_name", table)

 - player_physics.remove_stats(player, "uniq_name")

**Exemple**
 
 - player_physics.set_stats(player, "potion_speedlvl1", {speed=0.35})
 
 - player_physics.set_stats(player, "sprint_mod", {speed=0.35, jump=0.1})
 
 - player_physics.remove_stats(player, "potion_speedlvl1")

**Temporary effect**

 - player_physics.add_effect(player, "uniq_name", time, stats)
 - player_physics.remove_effect(player, "uniq_name")

**Exemple**
You make a potion that adds speed for 10 seconds.

    on_use = function(itemstack, user, pointed_thing)
       player_physics.add_effect(user, "potion_speedlvl1", 10, {speed=0.6})
       itemstack:take_item()
       return itemstack
    end



