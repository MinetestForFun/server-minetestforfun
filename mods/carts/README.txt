Minetest mod: carts for MFF
===========================

Based on boost_cart and modified to fully *replace* carts (@Coethium)
 - desactivate mesecons
 - power_rail: accelerate, max_speed set in init.lua
 - brake_rail: deccelerate, min_speed set in init.lua (so the cart doesn't stop and runs at very low speed)
 - default:rail / rail_cooper : no friction, keep the current speed
 - no collision (avoid the "walled_in" bug)



Boost_cart
==========

Based on (and fully compatible with) the mod "carts" by PilzAdam
Target: Run smoothly and do not use too much CPU

License of source code:
-----------------------
WTFPL

License of media (textures, sounds and models):
-----------------------------------------------
CC-0

Authors of media files:
-----------------------
kddekadenz:
  cart_bottom.png
  cart_side.png
  cart_top.png

Zeg9:
  cart.x
  cart.png
