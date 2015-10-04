#mapfix

Fix some map errors (flow and light problems)

![Before](http://i.imgur.com/T3csYME.png)
![After](http://i.imgur.com/d0V0aO7.png)
Look at the water and the jungle trunk at the center.


##minetest.conf settings
* mapfix_default_size (by default 40) : size used when omitted
* mapfix_max_size (by default 50) : maximum size allowed for players
* mapfix_delay (by default 15) : minimal delay in seconds between 2 "/mapfix" (to avoid server freezing)